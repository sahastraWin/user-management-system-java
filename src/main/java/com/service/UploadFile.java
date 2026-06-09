package com.service;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/upload")
@MultipartConfig
public class UploadFile extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		Part p = req.getPart("files");
		String fileName = p.getSubmittedFileName();

		String remark = req.getParameter("remark");
		System.out.println("filename is " + fileName + " " + remark);

		HttpSession session = req.getSession();

		try {
			Connection conn = DBConnection.getConn();
			System.out.println("Connection Established  : " + conn);

			PreparedStatement ps = conn.prepareStatement("insert into img_details(img_name,remark) values(?,?)");
			ps.setString(1, fileName);
			ps.setString(2, remark);

			int i = ps.executeUpdate();

			String absoluteFilePath = getServletContext().getRealPath("") + "images";
			System.out.println("path is " + absoluteFilePath);

			if (i == 1) {
				File f = new File(absoluteFilePath);
				if (!f.exists()) {
					f.mkdirs();
				}
				p.write(absoluteFilePath + File.separator + fileName);

				session.setAttribute("msg", "Upload Success");

				resp.sendRedirect("index.jsp");
				System.out.println(absoluteFilePath);

				System.out.println("Upload Success");
			} else {
				System.out.println("Error in server");
			}

			conn.close();

		} catch (Exception e) {
			System.out.println("Connection Failed: " + e.getMessage());
			e.printStackTrace();
		}
	}

}