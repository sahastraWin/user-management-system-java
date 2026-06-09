<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UMS &mdash; Sign In</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
* { margin:0; padding:0; box-sizing:border-box; font-family:'Poppins',sans-serif; }

body {
    min-height: 100vh;
    background: linear-gradient(135deg, #1a3faa 0%, #3f6fdf 60%, #6a9fd8 100%);
    display: flex; align-items: center; justify-content: center; padding: 20px;
}

.card {
    width: 100%; max-width: 420px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 25px 60px rgba(0,0,0,0.25);
    padding: 40px 36px 32px;
    animation: fadeUp 0.4s ease;
}

@keyframes fadeUp {
    from { opacity:0; transform:translateY(20px); }
    to   { opacity:1; transform:translateY(0); }
}

.logo-area { text-align:center; margin-bottom:28px; }
.logo-icon {
    width:60px; height:60px; background:linear-gradient(135deg,#4070f4,#1a3faa);
    border-radius:16px; display:inline-flex; align-items:center; justify-content:center;
    font-size:28px; margin-bottom:12px;
}
.logo-area h1 { font-size:22px; font-weight:700; color:#1a1a2e; }
.logo-area p  { font-size:13px; color:#888; margin-top:2px; }

.alert {
    padding:10px 14px; border-radius:8px; font-size:13px;
    margin-bottom:18px; font-weight:500;
}
.alert-error   { background:#fef2f2; color:#dc2626; border:1px solid #fecaca; }
.alert-success { background:#f0fdf4; color:#16a34a; border:1px solid #bbf7d0; }

.form-group { margin-bottom:16px; }
.form-group label {
    display:block; font-size:12px; font-weight:600;
    color:#555; margin-bottom:6px; text-transform:uppercase; letter-spacing:0.5px;
}
.form-group input {
    width:100%; height:46px; padding:0 16px;
    border:1.5px solid #d6dff7; border-radius:10px;
    font-size:15px; color:#333; background:#f8faff; outline:none;
    transition:border-color .25s, box-shadow .25s, background .25s;
}
.form-group input:focus {
    border-color:#4070f4;
    box-shadow:0 0 0 4px rgba(64,112,244,.12);
    background:#fff;
}

.remember-row {
    display:flex; align-items:center; gap:8px;
    font-size:13px; color:#555; margin-bottom:20px;
}
.remember-row input[type="checkbox"] { accent-color:#4070f4; width:16px; height:16px; }

.btn-login {
    width:100%; height:48px; border:none; border-radius:12px;
    background:linear-gradient(135deg,#4070f4,#2952d4);
    color:#fff; font-size:16px; font-weight:600;
    cursor:pointer; transition:all .3s ease;
    box-shadow:0 4px 14px rgba(64,112,244,.35);
    letter-spacing:.5px;
}
.btn-login:hover {
    background:linear-gradient(135deg,#2952d4,#1a3ab8);
    box-shadow:0 6px 20px rgba(64,112,244,.45);
    transform:translateY(-1px);
}

.links { text-align:center; margin-top:20px; font-size:13px; color:#666; }
.links a { color:#4070f4; text-decoration:none; font-weight:500; }
.links a:hover { text-decoration:underline; }
.links span { margin:0 8px; color:#ccc; }

.divider { border:none; border-top:1px solid #eef0f6; margin:20px 0; }
</style>
</head>
<body>
<div class="card">
    <div class="logo-area">
        <div class="logo-icon">&#128100;</div>
        <h1>User Management</h1>
        <p>Sign in to your account</p>
    </div>

    <%-- Show error or success messages passed from controller --%>
    <% String err = (String) request.getAttribute("errorMessage");
       String suc = (String) request.getAttribute("successMessage");
       if (err != null) { %>
        <div class="alert alert-error">&#9888; <%=err%></div>
    <% } %>
    <% if (suc != null) { %>
        <div class="alert alert-success">&#10003; <%=suc%></div>
    <% } %>

    <%-- Form posts to LoginController via context-relative path to prevent 404 --%>
    <form method="post" action="<%=request.getContextPath()%>/login/LoginController">

        <div class="form-group">
            <label for="uname">Username</label>
            <input type="text" id="uname" name="uname" placeholder="Enter username" required autocomplete="username">
        </div>

        <div class="form-group">
            <label for="psw">Password</label>
            <input type="password" id="psw" name="psw" placeholder="Enter password" required autocomplete="current-password">
        </div>

        <div class="remember-row">
            <input type="checkbox" id="remember" name="remember" checked>
            <label for="remember">Remember me</label>
        </div>

        <button type="submit" class="btn-login">Sign In</button>
    </form>

    <hr class="divider">

    <div class="links">
        <a href="forgetPassword.jsp">Forgot password?</a>
        <span>|</span>
        <a href="userRegistration.jsp">New User Registration</a>
    </div>
</div>
</body>
</html>
