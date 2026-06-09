package com.state;

import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/** StateController — CRUD for dd_state table. URL: /state/stateCntrl */
@WebServlet("/state/stateCntrl")
public class StateController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String opr = req.getParameter("opr");
        if (opr == null) opr = "dashboard";
        StateDBService db = new StateDBService();

        switch (opr) {
            case "dashboard":
                req.setAttribute("stateList", db.getAllStates());
                req.getRequestDispatcher("stateDashboard.jsp").forward(req, res); break;
            case "adminIndex":
                res.sendRedirect("../adminIndex.jsp"); break;
            case "addNew":
                req.getRequestDispatcher("addNewState.jsp").forward(req, res); break;
            case "save":
                StateDTO ns = new StateDTO();
                ns.setCode(req.getParameter("code")); ns.setValue(req.getParameter("value"));
                db.insertRecord(ns); res.sendRedirect("stateCntrl?opr=dashboard"); break;
            case "delete":
                db.deleteRecord(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("stateCntrl?opr=dashboard"); break;
            case "edit":
                req.setAttribute("state", db.getState(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("stateEdit.jsp").forward(req, res); break;
            case "update":
                StateDTO us = new StateDTO();
                us.setId(Integer.parseInt(req.getParameter("id")));
                us.setCode(req.getParameter("code")); us.setValue(req.getParameter("value"));
                db.updateRecord(us); res.sendRedirect("stateCntrl?opr=dashboard"); break;
            case "view":
                req.setAttribute("state", db.getState(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("viewState.jsp").forward(req, res); break;
            default:
                res.sendRedirect("../adminIndex.jsp");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException { doGet(req, res); }
}
