<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.gender.GenderDTO"%>
<% GenderDTO gender=(GenderDTO)request.getAttribute("gender"); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - View Gender</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:linear-gradient(135deg,#1a3faa,#3f6fdf,#6a9fd8);display:flex;align-items:center;justify-content:center;padding:20px;}
.card{background:#fff;border-radius:20px;padding:36px;max-width:380px;width:100%;box-shadow:0 20px 50px rgba(0,0,0,.2);}
.icon{font-size:48px;text-align:center;margin-bottom:12px;} h2{font-size:20px;font-weight:700;color:#1a1a2e;text-align:center;margin-bottom:24px;}
.row{display:flex;padding:11px 0;border-bottom:1px solid #f0f0f0;} .row:last-of-type{border-bottom:none;}
.lbl{flex:0 0 80px;font-size:12px;font-weight:600;color:#888;text-transform:uppercase;letter-spacing:.4px;}
.val{flex:1;font-size:14px;color:#333;font-weight:500;}
.btn-back{display:block;text-align:center;margin-top:22px;padding:11px;border:1.5px solid #d6dff7;border-radius:10px;color:#4070f4;font-weight:600;font-size:14px;text-decoration:none;}
.btn-back:hover{background:#f0f4ff;}</style></head>
<body><div class="card"><div class="icon">&#9874;</div><h2>Gender Details</h2>
<div class="row"><span class="lbl">ID</span><span class="val"><%=gender.getId()%></span></div>
<div class="row"><span class="lbl">Code</span><span class="val"><%=gender.getCode()%></span></div>
<div class="row"><span class="lbl">Value</span><span class="val"><%=gender.getValue()%></span></div>
<a href="genderCntrl?opr=dashboard" class="btn-back">&#8592; Back to Dashboard</a>
</div></body></html>
