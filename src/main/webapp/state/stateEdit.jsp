<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.state.StateDTO"%>
<% StateDTO state=(StateDTO)request.getAttribute("state"); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Edit State</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#9998; Edit State</h2>
<button class="button" onclick="location.href='stateCntrl?opr=dashboard'">&#8592; Back</button>
<form action="stateCntrl" method="get">
<input type="hidden" name="opr" value="update"><input type="hidden" name="id" value="<%=state.getId()%>">
<h3>State Code</h3><div class="input-box"><input type="text" name="code" value="<%=state.getCode()%>" required></div>
<h3>State Name</h3><div class="input-box"><input type="text" name="value" value="<%=state.getValue()%>" required></div>
<div class="input-box button"><input type="submit" value="Update State"></div>
</form></div></body></html>
