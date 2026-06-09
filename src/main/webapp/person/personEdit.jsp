<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.person.PersonDTO,com.state.StateDTO,com.city.CityDTO,com.qualification.QualificationDTO,java.util.ArrayList"%>
<%
PersonDTO person=(PersonDTO)request.getAttribute("person");
ArrayList<StateDTO> listState=(ArrayList<StateDTO>)request.getAttribute("stateList");
ArrayList<CityDTO> listCity=(ArrayList<CityDTO>)request.getAttribute("cityList");
ArrayList<QualificationDTO> listQual=(ArrayList<QualificationDTO>)request.getAttribute("qualificationList");
String pg=person.getGender()!=null?person.getGender():"";
String ps=person.getState()!=null?person.getState():"";
String pc=person.getCity()!=null?person.getCity():"";
%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Edit Person</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:linear-gradient(135deg,#1a3faa,#3f6fdf,#6a9fd8);display:flex;align-items:flex-start;justify-content:center;padding:30px 16px;}
.wrapper{width:100%;max-width:520px;background:#fff;padding:36px 40px 30px;border-radius:20px;box-shadow:0 20px 50px rgba(0,0,0,.22);}
h2{text-align:center;font-size:21px;font-weight:700;color:#1a1a2e;margin-bottom:22px;}
.btn-back{display:inline-flex;align-items:center;gap:6px;padding:8px 18px;background:#f0f4ff;color:#4070f4;border:1.5px solid #c5d3f9;border-radius:8px;font-size:13px;font-weight:500;cursor:pointer;margin-bottom:18px;transition:all .25s;text-decoration:none;}
.btn-back:hover{background:#4070f4;color:#fff;}
.form-group{margin-bottom:14px;}
.form-group label{display:block;font-size:12px;font-weight:600;color:#777;margin-bottom:5px;text-transform:uppercase;letter-spacing:.5px;}
.form-group input,.form-group select{width:100%;height:44px;padding:0 14px;border:1.5px solid #d6dff7;border-radius:10px;font-size:14px;color:#333;background:#f8faff;outline:none;transition:border-color .25s,box-shadow .25s;-webkit-appearance:none;appearance:none;}
.form-group input:focus,.form-group select:focus{border-color:#4070f4;box-shadow:0 0 0 4px rgba(64,112,244,.12);background:#fff;}
.form-group select{background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%234070f4' d='M6 8L1 3h10z'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 14px center;padding-right:36px;}
.radio-group{display:flex;gap:12px;margin-top:4px;}
.radio-group label{display:flex;align-items:center;gap:7px;font-size:13px;font-weight:500;color:#444;cursor:pointer;padding:7px 12px;border:1.5px solid #d6dff7;border-radius:8px;background:#f8faff;text-transform:none;letter-spacing:0;}
.radio-group input[type="radio"]{accent-color:#4070f4;width:14px;height:14px;margin:0;}
.qual-grid{display:grid;grid-template-columns:1fr 1fr;gap:9px 12px;margin-top:6px;}
.qual-item{display:flex;align-items:center;gap:7px;padding:8px 10px;border:1.5px solid #d6dff7;border-radius:8px;background:#f8faff;}
.qual-item input[type="checkbox"]{accent-color:#4070f4;width:14px;height:14px;flex-shrink:0;}
.qual-item label{font-size:12px;font-weight:500;color:#444;cursor:pointer;}
.divider{border:none;border-top:1px solid #eef0f6;margin:14px 0;}
.btn-submit{width:100%;height:48px;border:none;border-radius:12px;background:linear-gradient(135deg,#4070f4,#2952d4);color:#fff;font-size:16px;font-weight:600;cursor:pointer;transition:all .3s;box-shadow:0 4px 14px rgba(64,112,244,.35);margin-top:12px;}
.btn-submit:hover{background:linear-gradient(135deg,#2952d4,#1a3ab8);transform:translateY(-1px);}
</style></head>
<body><div class="wrapper">
<h2>&#9998; Edit Person</h2>
<a href="personCntrl?opr=dashboard" class="btn-back">&#8592; Back</a>
<form action="personCntrl" method="post">
<input type="hidden" name="opr" value="update">
<input type="hidden" name="id" value="<%=person.getId()%>">
<div class="form-group"><label>Full Name</label><input type="text" name="name" value="<%=person.getName()%>" required></div>
<div class="form-group"><label>Mobile Number</label><input type="text" name="mobileNumber" value="<%=person.getMobileNumber()%>" required></div>
<div class="form-group"><label>Email Address</label><input type="email" name="emailId" value="<%=person.getEmailId()%>" required></div>
<div class="form-group"><label>Date of Birth</label><input type="date" name="dob" value="<%=person.getDob()%>" required></div>
<hr class="divider">
<div class="form-group"><label>Gender</label><div class="radio-group">
<label><input type="radio" name="gender" value="M" <%=pg.equals("M")?"checked":""%>> Male</label>
<label><input type="radio" name="gender" value="F" <%=pg.equals("F")?"checked":""%>> Female</label>
<label><input type="radio" name="gender" value="O" <%=pg.equals("O")?"checked":""%>> Other</label>
</div></div>
<hr class="divider">
<div class="form-group"><label>State</label><select name="state">
<% for(StateDTO s:listState){ %><option value="<%=s.getCode()%>" <%=ps.equals(s.getCode())?"selected":""%>><%=s.getValue()%></option><% } %></select></div>
<div class="form-group"><label>City</label><select name="city">
<% for(CityDTO c:listCity){ %><option value="<%=c.getCode()%>" <%=pc.equals(c.getCode())?"selected":""%>><%=c.getValue()%></option><% } %></select></div>
<hr class="divider">
<div class="form-group"><label>Qualification</label><div class="qual-grid">
<% for(QualificationDTO q:listQual){ %>
<div class="qual-item"><input type="checkbox" name="qualification" value="<%=q.getCode()%>" id="qe_<%=q.getCode()%>"><label for="qe_<%=q.getCode()%>"><%=q.getValue()%></label></div>
<% } %></div></div>
<button type="submit" class="btn-submit">Save Changes</button>
</form></div></body></html>
