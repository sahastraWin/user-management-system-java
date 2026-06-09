<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.login.UserDTO"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>UMS &mdash; View User</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:linear-gradient(135deg,#1a3faa,#3f6fdf,#6a9fd8);display:flex;align-items:center;justify-content:center;padding:30px 20px;}
.card{width:100%;max-width:480px;background:#fff;border-radius:20px;padding:36px;box-shadow:0 25px 60px rgba(0,0,0,.25);}
h2{font-size:20px;font-weight:700;color:#1a1a2e;margin-bottom:24px;text-align:center;}
.info-row{display:flex;padding:12px 0;border-bottom:1px solid #f0f0f0;}
.info-row:last-of-type{border-bottom:none;}
.info-label{flex:0 0 140px;font-size:12px;font-weight:600;color:#888;text-transform:uppercase;letter-spacing:.5px;padding-top:2px;}
.info-value{flex:1;font-size:14px;color:#333;font-weight:500;}
.badge{padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;}
.badge-active{background:#dcfce7;color:#16a34a;}
.badge-inactive{background:#fee2e2;color:#dc2626;}
.profile-img{width:80px;height:80px;border-radius:50%;object-fit:cover;border:3px solid #4070f4;display:block;margin:0 auto 20px;}
.btn-back{display:block;text-align:center;margin-top:24px;padding:11px;border:1.5px solid #d6dff7;border-radius:10px;color:#4070f4;font-weight:600;font-size:14px;text-decoration:none;transition:all .25s;}
.btn-back:hover{background:#f0f4ff;border-color:#4070f4;}
</style>
</head>
<body>
<%
UserDTO user = (UserDTO) request.getAttribute("user");
if (user == null) { response.sendRedirect("LoginController?opr=dashboard"); return; }
%>
<div class="card">
    <% if (user.getProfileImg() != null && !user.getProfileImg().isEmpty()) { %>
    <img src="<%=request.getContextPath()%>/images/<%=user.getProfileImg()%>" class="profile-img" alt="Profile">
    <% } else { %>
    <div style="text-align:center;font-size:64px;margin-bottom:16px;">&#128100;</div>
    <% } %>
    <h2>User Profile</h2>
    <div class="info-row"><span class="info-label">ID</span><span class="info-value"><%=user.getId()%></span></div>
    <div class="info-row"><span class="info-label">User ID</span><span class="info-value"><%=user.getUserId()%></span></div>
    <div class="info-row"><span class="info-label">Name</span><span class="info-value"><%=user.getUserName() != null ? user.getUserName() : "-"%></span></div>
    <div class="info-row"><span class="info-label">Status</span><span class="info-value">
        <span class="badge <%="active".equalsIgnoreCase(user.getStatus()) ? "badge-active" : "badge-inactive"%>"><%=user.getStatus()%></span>
    </span></div>
    <div class="info-row"><span class="info-label">Updated By</span><span class="info-value"><%=user.getUpdateBy() != null ? user.getUpdateBy() : "-"%></span></div>
    <div class="info-row"><span class="info-label">Update Date</span><span class="info-value"><%=user.getUpdateDate() != null ? user.getUpdateDate() : "-"%></span></div>
    <a href="LoginController?opr=dashboard" class="btn-back">&#8592; Back to Dashboard</a>
</div>
</body>
</html>
