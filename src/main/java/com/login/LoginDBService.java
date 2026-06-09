package com.login;

import com.config.DBConfig;
import java.sql.*;
import java.util.ArrayList;

/**
 * ============================================================
 * LoginDBService — DAO for the User / Login module
 *
 * All queries use PreparedStatement to prevent SQL injection.
 *
 * DB column mapping (actual schema names):
 *   userId, user_name, user_pwd, encrypt_pwd,
 *   user_otp, user_status, update_date, update_time, update_by, profileImg
 * ============================================================
 */
public class LoginDBService {

    /* ---- Authenticate: returns UserDTO if credentials match, null otherwise ---- */
    public UserDTO getUserByCredentials(String userId, String pwd) {
        String sql = "SELECT * FROM user WHERE userId = ? AND user_pwd = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ps.setString(2, pwd);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /* ---- Insert a new user row ---- */
    public void insertUser(UserDTO u) {
        String sql = "INSERT INTO user (userId, user_name, user_pwd, encrypt_pwd, user_otp, " +
                     "user_status, update_date, update_time, update_by, profileImg) " +
                     "VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getUserId());
            ps.setString(2, u.getUserName());
            ps.setString(3, u.getPwd());
            ps.setString(4, u.getEncryptPwd());
            ps.setString(5, u.getOtp());
            ps.setString(6, u.getStatus() != null ? u.getStatus() : "active");
            ps.setDate  (7, u.getUpdateDate() != null ? u.getUpdateDate()
                                                       : new Date(System.currentTimeMillis()));
            ps.setString(8, u.getTime());
            ps.setString(9, u.getUpdateBy());
            ps.setString(10, u.getProfileImg());
            ps.executeUpdate();

        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Fetch all users ordered by id ---- */
    public ArrayList<UserDTO> getAllUsers() {
        ArrayList<UserDTO> list = new ArrayList<>();
        String sql = "SELECT * FROM user ORDER BY id";
        try (Connection conn = DBConfig.getConnection();
             Statement  st   = conn.createStatement();
             ResultSet  rs   = st.executeQuery(sql)) {

            while (rs.next()) list.add(map(rs));

        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /* ---- Fetch a single user by primary key ---- */
    public UserDTO getUserById(int id) {
        String sql = "SELECT * FROM user WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return map(rs);

        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /* ---- Update all editable fields for an existing user ---- */
    public void updateUser(UserDTO u) {
        String sql = "UPDATE user SET userId=?, user_name=?, user_pwd=?, encrypt_pwd=?, " +
                     "user_otp=?, user_status=?, update_date=?, update_time=?, " +
                     "update_by=?, profileImg=? WHERE id=?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1,  u.getUserId());
            ps.setString(2,  u.getUserName());
            ps.setString(3,  u.getPwd());
            ps.setString(4,  u.getEncryptPwd());
            ps.setString(5,  u.getOtp());
            ps.setString(6,  u.getStatus());
            ps.setDate  (7,  u.getUpdateDate());
            ps.setString(8,  u.getTime());
            ps.setString(9,  u.getUpdateBy());
            ps.setString(10, u.getProfileImg());
            ps.setInt   (11, u.getId());
            ps.executeUpdate();

        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Delete user by primary key ---- */
    public void deleteUser(int id) {
        String sql = "DELETE FROM user WHERE id = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (SQLException e) { e.printStackTrace(); }
    }

    /* ---- Check duplicate userId before registration ---- */
    public boolean userExists(String userId) {
        String sql = "SELECT COUNT(*) FROM user WHERE userId = ?";
        try (Connection conn = DBConfig.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;

        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    /*
     * ---- Private helper: map one ResultSet row → UserDTO ----
     * All column names match the actual DB schema.
     */
    private UserDTO map(ResultSet rs) throws SQLException {
        UserDTO u = new UserDTO();
        u.setId        (rs.getInt   ("id"));
        u.setUserId    (rs.getString("userId"));
        u.setUserName  (rs.getString("user_name"));
        u.setPwd       (rs.getString("user_pwd"));
        u.setEncryptPwd(rs.getString("encrypt_pwd"));
        u.setOtp       (rs.getString("user_otp"));
        u.setStatus    (rs.getString("user_status"));
        u.setUpdateDate(rs.getDate  ("update_date"));
        u.setTime      (rs.getString("update_time"));
        u.setUpdateBy  (rs.getString("update_by"));
        u.setProfileImg(rs.getString("profileImg"));
        return u;
    }
}
