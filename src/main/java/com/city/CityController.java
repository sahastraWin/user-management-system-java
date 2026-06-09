package com.city;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/** CityController — CRUD for dd_city table. URL: /city/cityCntrl */
@WebServlet("/city/cityCntrl")
public class CityController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String opr = req.getParameter("opr");
        if (opr == null) opr = "dashboard";
        CityDBService db = new CityDBService();

        switch (opr) {
            case "dashboard":
                req.setAttribute("cityList", db.getAllCities());
                req.getRequestDispatcher("cityDashboard.jsp").forward(req, res); break;
            case "adminIndex":
                res.sendRedirect("../adminIndex.jsp"); break;
            case "addNew":
                req.getRequestDispatcher("addNewCity.jsp").forward(req, res); break;
            case "save":
                CityDTO nc = new CityDTO();
                nc.setCode(req.getParameter("code")); nc.setValue(req.getParameter("value"));
                nc.setPincode(Integer.parseInt(req.getParameter("pincode")));
                db.insertRecord(nc);
                res.sendRedirect("cityCntrl?opr=dashboard"); break;
            case "delete":
                db.deleteRecord(Integer.parseInt(req.getParameter("id")));
                res.sendRedirect("cityCntrl?opr=dashboard"); break;
            case "edit":
                req.setAttribute("city", db.getCity(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("cityEdit.jsp").forward(req, res); break;
            case "update":
                CityDTO uc = new CityDTO();
                uc.setId(Integer.parseInt(req.getParameter("id")));
                uc.setCode(req.getParameter("code")); uc.setValue(req.getParameter("value"));
                uc.setPincode(Integer.parseInt(req.getParameter("pincode")));
                db.updateRecord(uc);
                res.sendRedirect("cityCntrl?opr=dashboard"); break;
            case "view":
                req.setAttribute("city", db.getCity(Integer.parseInt(req.getParameter("id"))));
                req.getRequestDispatcher("viewCity.jsp").forward(req, res); break;
            default:
                res.sendRedirect("../adminIndex.jsp");
        }
    }
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException { doGet(req, res); }
}
