<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gender.GenderDTO"%>
<% GenderDTO gender=(GenderDTO)request.getAttribute("gender"); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Edit Gender</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#9998; Edit Gender</h2>
<button class="button" onclick="location.href='genderCntrl?opr=dashboard'">&#8592; Back</button>
<form action="genderCntrl" method="get">
<input type="hidden" name="opr" value="update"><input type="hidden" name="id" value="<%=gender.getId()%>">
<h3>Gender Code</h3><div class="input-box"><input type="text" name="code" value="<%=gender.getCode()%>" required></div>
<h3>Gender Value</h3><div class="input-box"><input type="text" name="value" value="<%=gender.getValue()%>" required></div>
<div class="input-box button"><input type="submit" value="Update Gender"></div>
</form></div></body></html>
