<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qualification.QualificationDTO"%>
<% QualificationDTO q=(QualificationDTO)request.getAttribute("qualification"); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Edit Qualification</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#9998; Edit Qualification</h2>
<button class="button" onclick="location.href='qualificationCntrl?opr=dashboard'">&#8592; Back</button>
<form action="qualificationCntrl" method="get">
<input type="hidden" name="opr" value="update"><input type="hidden" name="id" value="<%=q.getId()%>">
<h3>Code</h3><div class="input-box"><input type="text" name="code" value="<%=q.getCode()%>" required></div>
<h3>Qualification Name</h3><div class="input-box"><input type="text" name="value" value="<%=q.getValue()%>" required></div>
<div class="input-box button"><input type="submit" value="Update Qualification"></div>
</form></div></body></html>
