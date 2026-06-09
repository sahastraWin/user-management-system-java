<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.login.UserDTO"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>UMS &mdash; Edit User</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:linear-gradient(135deg,#1a3faa,#3f6fdf,#6a9fd8);display:flex;align-items:flex-start;justify-content:center;padding:30px 20px;}
.card{width:100%;max-width:480px;background:#fff;border-radius:20px;padding:36px;box-shadow:0 25px 60px rgba(0,0,0,.25);}
h2{font-size:20px;font-weight:700;color:#1a1a2e;margin-bottom:24px;text-align:center;}
.form-group{margin-bottom:14px;}
.form-group label{display:block;font-size:12px;font-weight:600;color:#555;margin-bottom:5px;text-transform:uppercase;letter-spacing:.5px;}
.form-group input,.form-group select{width:100%;height:44px;padding:0 14px;border:1.5px solid #d6dff7;border-radius:10px;font-size:14px;color:#333;background:#f8faff;outline:none;transition:border-color .25s,box-shadow .25s;}
.form-group input:focus,.form-group select:focus{border-color:#4070f4;box-shadow:0 0 0 4px rgba(64,112,244,.12);background:#fff;}
.btn-row{display:flex;gap:10px;margin-top:20px;}
.btn-save{flex:1;height:46px;border:none;border-radius:10px;background:linear-gradient(135deg,#4070f4,#2952d4);color:#fff;font-size:15px;font-weight:600;cursor:pointer;transition:all .3s;}
.btn-save:hover{transform:translateY(-1px);box-shadow:0 5px 14px rgba(64,112,244,.4);}
.btn-back{flex:1;height:46px;border:1.5px solid #d6dff7;border-radius:10px;background:#f8faff;color:#555;font-size:15px;font-weight:500;cursor:pointer;text-decoration:none;display:flex;align-items:center;justify-content:center;transition:all .3s;}
.btn-back:hover{border-color:#4070f4;color:#4070f4;}
</style>
</head>
<body>
<%
UserDTO user = (UserDTO) request.getAttribute("user");
if (user == null) { response.sendRedirect("LoginController?opr=dashboard"); return; }
%>
<div class="card">
    <h2>&#9998; Edit User</h2>
    <form method="post" action="<%=request.getContextPath()%>/login/LoginController" enctype="multipart/form-data">
        <input type="hidden" name="opr" value="update">
        <input type="hidden" name="id" value="<%=user.getId()%>">
        <input type="hidden" name="existingImg" value="<%=user.getProfileImg() != null ? user.getProfileImg() : ""%>">

        <div class="form-group">
            <label>User ID</label>
            <input type="text" name="userId" value="<%=user.getUserId()%>" required>
        </div>
        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="userName" value="<%=user.getUserName() != null ? user.getUserName() : ""%>" required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="pwd" value="<%=user.getPwd() != null ? user.getPwd() : ""%>">
        </div>
        <div class="form-group">
            <label>OTP</label>
            <input type="text" name="otp" value="<%=user.getOtp() != null ? user.getOtp() : ""%>">
        </div>
        <div class="form-group">
            <label>Status</label>
            <select name="status">
                <option value="active" <%="active".equalsIgnoreCase(user.getStatus()) ? "selected" : ""%>>Active</option>
                <option value="inactive" <%="inactive".equalsIgnoreCase(user.getStatus()) ? "selected" : ""%>>Inactive</option>
            </select>
        </div>
        <div class="form-group">
            <label>Updated By</label>
            <input type="text" name="updateBy" value="<%=user.getUpdateBy() != null ? user.getUpdateBy() : ""%>">
        </div>
        <div class="form-group">
            <label>Profile Image (leave blank to keep existing)</label>
            <input type="file" name="profileImg" accept="image/*">
        </div>
        <div class="btn-row">
            <a href="LoginController?opr=dashboard" class="btn-back">&#8592; Back</a>
            <button type="submit" class="btn-save">Save Changes</button>
        </div>
    </form>
</div>
</body>
</html>
