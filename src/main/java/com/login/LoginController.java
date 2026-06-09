package com.login;

import com.config.DBConfig;
import java.io.File;
import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Locale;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

/**
 * ============================================================
 * LoginController — Central servlet for Login & User management
 *
 * URL Pattern : /login/LoginController
 *
 * Operations (via ?opr= query parameter):
 *   null        → loginHandler  (process login form POST)
 *   dashboard   → show user list
 *   addNew      → show user registration form
 *   save        → insert new user
 *   edit        → load user into edit form
 *   update      → update user record
 *   delete      → delete user by id
 *   view        → view user details
 *   logout      → invalidate session and redirect to login
 *   forgotPwd   → show forgot-password form
 *   resetPwd    → verify OTP + update password
 *   regSuccess  → show registration success page
 *
 * @MultipartConfig is required for profile image file upload.
 * ============================================================
 */
@WebServlet("/login/LoginController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,        // write to disk after 1 MB in memory
    maxFileSize       = 1024 * 1024 * 5,    // max single file: 5 MB
    maxRequestSize    = 1024 * 1024 * 10    // max entire request: 10 MB
)
public class LoginController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String opr = request.getParameter("opr");

        /*
         * No opr parameter means the login form was submitted.
         * We handle both GET and POST in doGet via doPost delegation.
         */
        if (opr == null) {
            loginHandler(request, response);
            return;
        }

        switch (opr) {
            case "dashboard":  showUserDashboard(request, response);  break;
            case "addNew":     showAddUserForm(request, response);     break;
            case "save":       saveUser(request, response);            break;
            case "edit":       editUser(request, response);            break;
            case "update":     updateUser(request, response);          break;
            case "delete":     deleteUser(request, response);          break;
            case "view":       viewUser(request, response);            break;
            case "logout":     logoutUser(request, response);          break;
            case "forgotPwd":  showForgotPassword(request, response);  break;
            case "resetPwd":   resetPassword(request, response);       break;
            case "regSuccess":
                fwd(request, response, "registrationSuccess.jsp"); break;
            default:
                response.sendRedirect(request.getContextPath() + "/login/signIn.jsp");
        }
    }

    /* ============================================================
     * LOGIN HANDLER
     *
     * 1. Validates non-empty input
     * 2. Checks hardcoded admin credentials
     * 3. Falls back to DB lookup via LoginDBService
     * 4. Checks account status (active/inactive)
     * 5. Stores UserDTO in session on success
     * ============================================================ */
    private void loginHandler(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("uname");
        String pwd    = request.getParameter("psw");

        /* Guard: reject blank submissions */
        if (userId == null || pwd == null ||
            userId.trim().isEmpty() || pwd.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            fwd(request, response, "signIn.jsp");
            return;
        }

        userId = userId.trim();

        /*
         * Hardcoded admin check.
         * NOTE: In production, store admin in DB with hashed password.
         */
        if ("admin".equals(userId) && "123".equals(pwd)) {
            UserDTO adminDTO = new UserDTO();
            adminDTO.setUserId("admin");
            adminDTO.setUserName("Administrator");
            adminDTO.setStatus("active");

            HttpSession session = request.getSession();
            session.setAttribute("userDTO", adminDTO);
            response.sendRedirect(request.getContextPath() + "/adminIndex.jsp");
            return;
        }

        /* Normal user — query the database */
        LoginDBService loginDB = new LoginDBService();
        UserDTO dbUser = loginDB.getUserByCredentials(userId, pwd);

        if (dbUser != null) {
            /* Reject inactive accounts */
            if (!"active".equalsIgnoreCase(dbUser.getStatus())) {
                request.setAttribute("errorMessage",
                    "Your account is inactive. Please contact the administrator.");
                fwd(request, response, "signIn.jsp");
                return;
            }
            /* Store authenticated user in session */
            HttpSession session = request.getSession();
            session.setAttribute("userDTO", dbUser);
            showUserDashboard(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            fwd(request, response, "signIn.jsp");
        }
    }

    /* ---- Fetch all users and show dashboard ---- */
    private void showUserDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<UserDTO> userList = new LoginDBService().getAllUsers();
        request.setAttribute("userList", userList);
        fwd(request, response, "userDashboard.jsp");
    }

    /* ---- Show the new-user registration form ---- */
    private void showAddUserForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        fwd(request, response, "userRegistration.jsp");
    }

    /* ---- Save new user with duplicate-userId check ---- */
    private void saveUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        LoginDBService loginDB = new LoginDBService();

        /* Prevent duplicate userIds */
        if (loginDB.userExists(userId)) {
            request.setAttribute("errorMessage",
                "Username '" + userId + "' already exists. Please choose another.");
            fwd(request, response, "userRegistration.jsp");
            return;
        }

        loginDB.insertUser(extractUserFromRequest(request));
        response.sendRedirect("LoginController?opr=regSuccess");
    }

    /* ---- Load user into edit form ---- */
    private void editUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        UserDTO user = new LoginDBService().getUserById(id);
        request.setAttribute("user", user);
        fwd(request, response, "userEdit.jsp");
    }

    /* ---- Update existing user ---- */
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDTO user = extractUserFromRequest(request);
        user.setId(Integer.parseInt(request.getParameter("id")));
        new LoginDBService().updateUser(user);
        response.sendRedirect("LoginController?opr=dashboard");
    }

    /* ---- Delete user by ID and redirect back to dashboard ---- */
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        new LoginDBService().deleteUser(Integer.parseInt(request.getParameter("id")));
        response.sendRedirect("LoginController?opr=dashboard");
    }

    /* ---- View single user details ---- */
    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        request.setAttribute("user", new LoginDBService().getUserById(id));
        fwd(request, response, "viewUser.jsp");
    }

    /* ---- Invalidate session and send user to login page ---- */
    private void logoutUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
        response.sendRedirect(request.getContextPath() + "/login/signIn.jsp");
    }

    /* ---- Show forgot password page ---- */
    private void showForgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        fwd(request, response, "forgetPassword.jsp");
    }

    /*
     * ---- Reset password using OTP ----
     *
     * Flow:
     *   1. User submits userId + OTP + newPassword
     *   2. We look up user WHERE userId=? AND user_otp=?
     *   3. If match found → UPDATE user_pwd = newPwd
     *   4. Redirect to sign-in with success message
     *   5. If no match   → Show error on forgetPassword.jsp
     */
    private void resetPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId = request.getParameter("userId");
        String otp    = request.getParameter("otp");
        String newPwd = request.getParameter("newPwd");

        /* Validate all fields present */
        if (userId == null || otp == null || newPwd == null ||
            userId.isEmpty() || otp.isEmpty() || newPwd.isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            fwd(request, response, "forgetPassword.jsp");
            return;
        }

        String verifySql = "SELECT id FROM user WHERE userId = ? AND user_otp = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(verifySql)) {

            ps.setString(1, userId);
            ps.setString(2, otp);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                /* OTP matched — update the password */
                int id = rs.getInt("id");
                rs.close();

                String updateSql = "UPDATE user SET user_pwd = ? WHERE id = ?";
                try (PreparedStatement upPs = conn.prepareStatement(updateSql)) {
                    upPs.setString(1, newPwd);
                    upPs.setInt   (2, id);
                    upPs.executeUpdate();
                }
                request.setAttribute("successMessage",
                    "Password reset successfully! Please sign in with your new password.");
                fwd(request, response, "signIn.jsp");

            } else {
                rs.close();
                request.setAttribute("errorMessage",
                    "Invalid User ID or OTP. Please check and try again.");
                fwd(request, response, "forgetPassword.jsp");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "A server error occurred. Please try again.");
            fwd(request, response, "forgetPassword.jsp");
        }
    }

    /*
     * ---- Extract UserDTO from multipart HTTP request ----
     *
     * Reads all form fields and handles optional profile image upload.
     * If no new image is uploaded, keeps the existing filename from the
     * hidden field "existingImg".
     */
    private UserDTO extractUserFromRequest(HttpServletRequest request)
            throws IOException, ServletException {

        UserDTO user = new UserDTO();
        user.setUserId   (request.getParameter("userId"));
        user.setUserName (request.getParameter("userName"));
        user.setPwd      (request.getParameter("pwd"));
        user.setEncryptPwd(request.getParameter("encryptPwd"));
        user.setOtp      (request.getParameter("otp"));
        user.setStatus   (request.getParameter("status") != null
                            ? request.getParameter("status") : "active");
        user.setTime     (request.getParameter("time"));
        user.setUpdateBy (request.getParameter("updateBy"));

        /* Safely parse the date field */
        try {
            String dateStr = request.getParameter("updateDate");
            if (dateStr != null && !dateStr.isEmpty()) {
                SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                user.setUpdateDate(new Date(fmt.parse(dateStr).getTime()));
            } else {
                user.setUpdateDate(new Date(System.currentTimeMillis()));
            }
        } catch (Exception e) {
            user.setUpdateDate(new Date(System.currentTimeMillis()));
        }

        /*
         * Profile image upload:
         * Files are written to the /images directory under webapp root.
         * Only the filename (not path) is persisted in the database.
         */
        Part filePart = request.getPart("profileImg");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName  = filePart.getSubmittedFileName();
            String uploadDir = getServletContext().getRealPath("/images");
            File dir = new File(uploadDir);
            if (!dir.exists()) dir.mkdirs();
            filePart.write(uploadDir + File.separator + fileName);
            user.setProfileImg(fileName);
        } else {
            /* Keep existing image when no new one is selected */
            user.setProfileImg(request.getParameter("existingImg"));
        }

        return user;
    }

    /* ---- Convenience forward helper ---- */
    private void fwd(HttpServletRequest req, HttpServletResponse res, String jsp)
            throws ServletException, IOException {
        req.getRequestDispatcher(jsp).forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
