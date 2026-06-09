<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.city.CityDTO"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><title>UMS &mdash; Edit City</title>
<link rel="stylesheet" href="style.css">
</head>
<% CityDTO city = (CityDTO) request.getAttribute("city"); %>
<body>
<div class="wrapper">
    <h2>&#9998; Edit City</h2>
    <button class="button" onclick="location.href='cityCntrl?opr=dashboard'">&#8592; Back</button>
    <form action="cityCntrl" method="get">
        <input type="hidden" name="opr" value="update">
        <input type="hidden" name="id" value="<%=city.getId()%>">
        <h3>City Code</h3>
        <div class="input-box"><input type="text" name="code" value="<%=city.getCode()%>" required></div>
        <h3>City Name</h3>
        <div class="input-box"><input type="text" name="value" value="<%=city.getValue()%>" required></div>
        <h3>Pincode</h3>
        <div class="input-box"><input type="text" name="pincode" value="<%=city.getPincode()%>" pattern="[0-9]{6}" required></div>
        <div class="input-box button"><input type="submit" value="Update City"></div>
    </form>
</div>
</body>
</html>
