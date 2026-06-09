package com.person;

import com.city.CityDBService;
import com.city.CityDTO;
import com.login.UserDTO;
import com.qualification.QualificationDBService;
import com.qualification.QualificationDTO;
import com.state.StateDBService;
import com.state.StateDTO;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * ============================================================
 * PersonController — Servlet for Person CRUD operations
 *
 * URL Pattern : /person/personCntrl
 *
 * Operations (via ?opr=):
 *   dashboard → list all persons
 *   addNew    → show registration form with dropdowns
 *   save      → insert person + qualifications
 *   edit      → load person + dropdowns for edit form
 *   update    → update person record
 *   delete    → delete person + qualifications
 *   view      → view person with resolved qualifications
 *   adminIndex→ redirect to admin home
 *
 * Session guard: redirects to signIn.jsp if no userDTO in session.
 * ============================================================
 */
@WebServlet("/person/personCntrl")
public class PersonController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        /* Session guard — all person operations require login */
        UserDTO loggedUser = (UserDTO) request.getSession().getAttribute("userDTO");
        if (loggedUser == null) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/login/signIn.jsp");
            return;
        }

        String opr = request.getParameter("opr");
        if (opr == null) opr = "dashboard";

        switch (opr) {

            case "dashboard": {
                PersonDBService db = new PersonDBService();
                request.setAttribute("personList", db.getAllPersons());
                fwd(request, response, "personDashboard.jsp");
                break;
            }

            case "adminIndex":
                response.sendRedirect("../adminIndex.jsp");
                break;

            case "addNew": {
                /* Load all dropdown data needed for registration form */
                loadDropdowns(request);
                fwd(request, response, "registration.jsp");
                break;
            }

            case "save": {
                PersonDTO person = buildPersonFromRequest(request);

                PersonDBService db = new PersonDBService();
                db.insertRecord(person);  // sets person.id via RETURN_GENERATED_KEYS

                /* Save each selected qualification as a separate junction row */
                String[] quals = request.getParameterValues("qualification");
                if (quals != null) {
                    for (String code : quals) {
                        PersonQualification pq = new PersonQualification();
                        pq.setPersonId(person.getId());
                        pq.setQualificationCode(code);
                        db.insertQualification(pq);
                    }
                }

                response.sendRedirect("personCntrl?opr=dashboard");
                break;
            }

            case "delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                new PersonDBService().deleteRecord(id);
                response.sendRedirect("personCntrl?opr=dashboard");
                break;
            }

            case "edit": {
                int id = Integer.parseInt(request.getParameter("id"));
                PersonDTO person = new PersonDBService().getPerson(id);
                request.setAttribute("person", person);
                loadDropdowns(request);
                fwd(request, response, "personEdit.jsp");
                break;
            }

            case "update": {
                PersonDTO person = buildPersonFromRequest(request);
                person.setId(Integer.parseInt(request.getParameter("id")));
                new PersonDBService().updateRecord(person);
                response.sendRedirect("personCntrl?opr=dashboard");
                break;
            }

            case "view": {
                int id = Integer.parseInt(request.getParameter("id"));
                PersonDBService db = new PersonDBService();
                PersonDTO person = db.getPerson(id);
                /* Resolve qualification codes → full names for display */
                person.setQualificationList(db.getPersonQualificationList(id));
                request.setAttribute("person", person);
                fwd(request, response, "viewPerson.jsp");
                break;
            }

            default:
                fwd(request, response, "pageNotFound.jsp");
        }
    }

    /*
     * ---- Build PersonDTO from form fields ----
     * Reads name, mobile, email, dob, gender, state, city.
     * Qualification handled separately (multi-value parameter).
     */
    private PersonDTO buildPersonFromRequest(HttpServletRequest request) {
        PersonDTO p = new PersonDTO();
        p.setName        (request.getParameter("name"));
        p.setMobileNumber(request.getParameter("mobileNumber"));
        p.setEmailId     (request.getParameter("emailId"));
        p.setGender      (request.getParameter("gender"));
        p.setState       (request.getParameter("state"));
        p.setCity        (request.getParameter("city"));

        try {
            String dob = request.getParameter("dob");
            if (dob != null && !dob.isEmpty()) {
                SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                p.setDob(fmt.parse(dob));
            }
        } catch (Exception e) { System.err.println("DOB parse error: " + e.getMessage()); }

        return p;
    }

    /*
     * ---- Load all three dropdowns into request scope ----
     * Called before forwarding to registration.jsp or personEdit.jsp.
     */
    private void loadDropdowns(HttpServletRequest request) {
        request.setAttribute("stateList",         new StateDBService().getAllStates());
        request.setAttribute("cityList",           new CityDBService().getAllCities());
        request.setAttribute("qualificationList",  new QualificationDBService().getAllQualifications());
    }

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
