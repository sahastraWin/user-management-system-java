<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Add Qualification</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#127891; Add Qualification</h2>
<button class="button" onclick="location.href='qualificationCntrl?opr=dashboard'">&#8592; Back</button>
<form action="qualificationCntrl" method="get"><input type="hidden" name="opr" value="save">
<h3>Code</h3><div class="input-box"><input type="text" name="code" placeholder="e.g. BTech" required></div>
<h3>Qualification Name</h3><div class="input-box"><input type="text" name="value" placeholder="e.g. Bachelor of Technology" required></div>
<div class="input-box button"><input type="submit" value="Save Qualification"></div>
</form></div></body></html>
