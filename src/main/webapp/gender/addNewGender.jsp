<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Add Gender</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#9874; Add New Gender</h2>
<button class="button" onclick="location.href='genderCntrl?opr=dashboard'">&#8592; Back</button>
<form action="genderCntrl" method="get"><input type="hidden" name="opr" value="save">
<h3>Gender Code</h3><div class="input-box"><input type="text" name="code" placeholder="e.g. M" required></div>
<h3>Gender Value</h3><div class="input-box"><input type="text" name="value" placeholder="e.g. Male" required></div>
<div class="input-box button"><input type="submit" value="Save Gender"></div>
</form></div></body></html>
