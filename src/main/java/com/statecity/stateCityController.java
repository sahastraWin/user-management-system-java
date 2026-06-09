package com.statecity;

import com.city.CityDBService;
import com.state.StateDBService;
import java.io.IOException;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/** stateCityController — CRUD for statecity mapping. URL: /statecity/statecityCntrl */
@WebServlet("/statecity/statecityCntrl")
public class stateCityController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String opr = req.getParameter("opr");
        if (opr == null) opr = "dashboard";
        stateCityDBService db = new stateCityDBService();

        switch (opr) {
            case "dashboard":
                req.setAttribute("statecityList", db.getAllStateCities());
                req.getRequestDispatcher("stateCityDashboard.jsp").forward(req, res); break;
            case "adminIndex":
                res.sendRedirect("../adminIndex.jsp"); break;
            case "addNew":
                req.setAttribute("stateList", new StateDBService().getAllStates());
                req.setAttribute("cityList", new CityDBService().getAllCities());
                req.getRequestDispatcher("addNewStateCity.jsp").forward(req, res); break;
            case "save":
                stateCityDTO nsc = new stateCityDTO();
                nsc.setStateCode(req.getParameter("stateCode"));
                nsc.setCityCode(req.getParameter("cityCode"));
                db.insertRecord(nsc); res.sendRedirect("statecityCntrl?opr=dashboard"); break;
            case "delete":
                db.deleteRecord(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("statecityCntrl?opr=dashboard"); break;
            case "edit":
                req.setAttribute("statecity", db.getStateCity(Integer.parseInt(req.getParameter("id"))));
                req.setAttribute("stateList", new StateDBService().getAllStates());
                req.setAttribute("cityList", new CityDBService().getAllCities());
                req.getRequestDispatcher("stateCityEdit.jsp").forward(req, res); break;
            case "update":
                stateCityDTO usc = new stateCityDTO();
                usc.setId(Integer.parseInt(req.getParameter("id")));
                usc.setStateCode(req.getParameter("stateCode"));
                usc.setCityCode(req.getParameter("cityCode"));
                db.updateRecord(usc); res.sendRedirect("statecityCntrl?opr=dashboard"); break;
            case "view":
                req.setAttribute("statecity", db.getStateCity(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("viewStateCity.jsp").forward(req, res); break;
            default:
                res.sendRedirect("../adminIndex.jsp");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException { doGet(req, res); }
}
