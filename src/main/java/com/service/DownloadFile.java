package com.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/download")
public class DownloadFile extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("file");

        if (fileName == null || fileName.trim().equals("")) {
            resp.getWriter().println("Invalid file request");
            return;
        }

        // ✅ Path of uploaded images
        String path = getServletContext().getRealPath("") + "images" + File.separator + fileName;
       
        File file = new File(path);

        if (!file.exists()) {
            resp.getWriter().println("File not found!");
            return;
        }

        // ✅ Set response headers
        resp.setContentType("application/octet-stream");
        resp.setHeader("Content-Disposition", "attachment;filename=" + fileName);

        // ✅ Stream file data to response
        try (FileInputStream fis = new FileInputStream(file); 
             OutputStream os = resp.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        }
    }
}