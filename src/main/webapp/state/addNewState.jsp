<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Add State</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#127758; Add New State</h2>
<button class="button" onclick="location.href='stateCntrl?opr=dashboard'">&#8592; Back</button>
<form action="stateCntrl" method="get"><input type="hidden" name="opr" value="save">
<h3>State Code</h3><div class="input-box"><input type="text" name="code" placeholder="e.g. MP" required></div>
<h3>State Name</h3><div class="input-box"><input type="text" name="value" placeholder="e.g. Madhya Pradesh" required></div>
<div class="input-box button"><input type="submit" value="Save State"></div>
</form></div></body></html>
