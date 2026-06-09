package com.service;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete")
public class DeleteFile extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String fileName = req.getParameter("file");

		try {
			Connection conn = DBConnection.getConn();

			// ✅ First get the file path from DB
			PreparedStatement ps = conn.prepareStatement("SELECT img_name FROM img_details WHERE img_name=?");
			ps.setString(1, fileName);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				String imgName = rs.getString("img_name");

				// ✅ Delete from DB
				PreparedStatement ps2 = conn.prepareStatement("DELETE FROM img_details WHERE img_name=?");
				ps2.setString(1, fileName);
				ps2.executeUpdate();

				// ✅ Delete from images folder
				String path = getServletContext().getRealPath("") + "images" + File.separator + imgName;
				File f = new File(path);
				if (f.exists()) {
					f.delete();
				}
			}

			resp.sendRedirect("index.jsp");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
