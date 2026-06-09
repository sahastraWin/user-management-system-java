package com.qualification;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/** QualificationController — CRUD for dd_qualification. URL: /qualification/qualificationCntrl */
@WebServlet("/qualification/qualificationCntrl")
public class QualificationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String opr = req.getParameter("opr");
        if (opr == null) opr = "dashboard";
        QualificationDBService db = new QualificationDBService();

        switch (opr) {
            case "dashboard":
                req.setAttribute("qualificationList", db.getAllQualifications());
                req.getRequestDispatcher("qualificationDashboard.jsp").forward(req, res); break;
            case "adminIndex":
                res.sendRedirect("../adminIndex.jsp"); break;
            case "addNew":
                req.getRequestDispatcher("addNewQualification.jsp").forward(req, res); break;
            case "save":
                QualificationDTO nq = new QualificationDTO();
                nq.setCode(req.getParameter("code")); nq.setValue(req.getParameter("value"));
                db.insertRecord(nq); res.sendRedirect("qualificationCntrl?opr=dashboard"); break;
            case "delete":
                db.deleteRecord(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("qualificationCntrl?opr=dashboard"); break;
            case "edit":
                req.setAttribute("qualification", db.getQualification(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("qualificationEdit.jsp").forward(req, res); break;
            case "update":
                QualificationDTO uq = new QualificationDTO();
                uq.setId(Integer.parseInt(req.getParameter("id")));
                uq.setCode(req.getParameter("code")); uq.setValue(req.getParameter("value"));
                db.updateRecord(uq); res.sendRedirect("qualificationCntrl?opr=dashboard"); break;
            case "view":
                req.setAttribute("qualification", db.getQualification(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("viewQualification.jsp").forward(req, res); break;
            default:
                res.sendRedirect("../adminIndex.jsp");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException { doGet(req, res); }
}
