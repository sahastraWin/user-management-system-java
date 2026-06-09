package com.gender;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/** GenderController — CRUD for dd_gender table. URL: /gender/genderCntrl */
@WebServlet("/gender/genderCntrl")
public class GenderController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String opr = req.getParameter("opr");
        if (opr == null) opr = "dashboard";
        GenderDBService db = new GenderDBService();

        switch (opr) {
            case "dashboard":
                req.setAttribute("genderList", db.getAllGenders());
                req.getRequestDispatcher("genderDashboard.jsp").forward(req, res); break;
            case "adminIndex":
                res.sendRedirect("../adminIndex.jsp"); break;
            case "addNew":
                req.getRequestDispatcher("addNewGender.jsp").forward(req, res); break;
            case "save":
                GenderDTO ng = new GenderDTO();
                ng.setCode(req.getParameter("code")); ng.setValue(req.getParameter("value"));
                db.insertRecord(ng); res.sendRedirect("genderCntrl?opr=dashboard"); break;
            case "delete":
                db.deleteRecord(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("genderCntrl?opr=dashboard"); break;
            case "edit":
                req.setAttribute("gender", db.getGender(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("genderEdit.jsp").forward(req, res); break;
            case "update":
                GenderDTO ug = new GenderDTO();
                ug.setId(Integer.parseInt(req.getParameter("id")));
                ug.setCode(req.getParameter("code")); ug.setValue(req.getParameter("value"));
                db.updateRecord(ug); res.sendRedirect("genderCntrl?opr=dashboard"); break;
            case "view":
                req.setAttribute("gender", db.getGender(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("viewGender.jsp").forward(req, res); break;
            default:
                res.sendRedirect("../adminIndex.jsp");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException { doGet(req, res); }
}
