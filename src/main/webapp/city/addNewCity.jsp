<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><title>UMS &mdash; Add City</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="wrapper">
    <h2>&#127961; Add New City</h2>
    <button class="button" onclick="location.href='cityCntrl?opr=dashboard'">&#8592; Back</button>
    <form action="cityCntrl" method="get">
        <input type="hidden" name="opr" value="save">
        <h3>City Code</h3>
        <div class="input-box"><input type="text" name="code" placeholder="e.g. BPL" required></div>
        <h3>City Name</h3>
        <div class="input-box"><input type="text" name="value" placeholder="e.g. Bhopal" required></div>
        <h3>Pincode</h3>
        <div class="input-box"><input type="text" name="pincode" placeholder="e.g. 462001" pattern="[0-9]{6}" title="6-digit pincode" required></div>
        <div class="input-box button"><input type="submit" value="Save City"></div>
    </form>
</div>
</body>
</html>
