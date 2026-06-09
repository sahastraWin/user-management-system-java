<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.login.UserDTO"%>
<%
/* Session guard — only logged-in users can see admin index */
UserDTO loggedUser = (UserDTO) session.getAttribute("userDTO");
if (loggedUser == null) {
    response.sendRedirect(request.getContextPath() + "/login/signIn.jsp");
    return;
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>UMS &mdash; Admin Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{min-height:100vh;background:#f0f4ff;}

.navbar {
    background:linear-gradient(135deg,#1a3faa,#3f6fdf);
    padding:14px 32px;display:flex;align-items:center;justify-content:space-between;
    box-shadow:0 2px 16px rgba(26,63,170,.3);
}
.brand{color:#fff;font-size:20px;font-weight:700;}
.nav-right{display:flex;align-items:center;gap:12px;}
.welcome{color:rgba(255,255,255,.85);font-size:13px;}
.nav-btn{
    padding:8px 16px;border-radius:8px;font-size:13px;font-weight:500;
    text-decoration:none;border:1px solid rgba(255,255,255,.3);
    color:#fff;background:rgba(255,255,255,.15);transition:all .25s;
}
.nav-btn:hover{background:rgba(255,255,255,.25);}
.nav-btn-red{background:#ef4444;border-color:#ef4444;}
.nav-btn-red:hover{background:#dc2626;}

.hero {
    background:linear-gradient(135deg,#1a3faa,#3f6fdf);
    color:#fff;padding:48px 32px;text-align:center;
}
.hero h1{font-size:30px;font-weight:700;margin-bottom:8px;}
.hero p{font-size:15px;opacity:.85;}

.container{max-width:1000px;margin:0 auto;padding:40px 20px;}

.grid{
    display:grid;
    grid-template-columns:repeat(auto-fit,minmax(200px,1fr));
    gap:20px;
}

.module-card {
    background:#fff;border-radius:16px;
    box-shadow:0 2px 16px rgba(0,0,0,.07);
    padding:28px 20px;text-align:center;
    text-decoration:none;color:inherit;
    transition:all .3s ease;
    border:2px solid transparent;
}
.module-card:hover{
    transform:translateY(-6px);
    box-shadow:0 12px 32px rgba(64,112,244,.2);
    border-color:#4070f4;
}
.module-icon{
    font-size:40px;margin-bottom:14px;display:block;
}
.module-title{font-size:15px;font-weight:700;color:#1a1a2e;margin-bottom:6px;}
.module-desc{font-size:12px;color:#888;line-height:1.5;}
.module-badge{
    display:inline-block;margin-top:12px;padding:4px 12px;
    background:#eef2ff;color:#4070f4;border-radius:20px;
    font-size:11px;font-weight:600;
}
</style>
</head>
<body>

<nav class="navbar">
    <span class="brand">&#128100; UMS</span>
    <div class="nav-right">
        <span class="welcome">Welcome, <strong><%=loggedUser.getUserName() != null ? loggedUser.getUserName() : loggedUser.getUserId()%></strong></span>
        <a href="login/LoginController?opr=dashboard" class="nav-btn">Users</a>
        <a href="login/LoginController?opr=logout" class="nav-btn nav-btn-red">Logout</a>
    </div>
</nav>

<div class="hero">
    <h1>&#127968; Admin Control Panel</h1>
    <p>Manage all modules of the User Management System</p>
</div>

<div class="container">
    <div class="grid">

        <a href="person/personCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#128101;</span>
            <div class="module-title">Persons</div>
            <div class="module-desc">Manage person records, qualifications, and demographics</div>
            <span class="module-badge">CRUD</span>
        </a>

        <a href="login/LoginController?opr=dashboard" class="module-card">
            <span class="module-icon">&#128100;</span>
            <div class="module-title">Users</div>
            <div class="module-desc">Manage system user accounts and login credentials</div>
            <span class="module-badge">CRUD</span>
        </a>

        <a href="gender/genderCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#9874;</span>
            <div class="module-title">Gender</div>
            <div class="module-desc">Manage gender dropdown reference data</div>
            <span class="module-badge">Dropdown</span>
        </a>

        <a href="state/stateCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#127758;</span>
            <div class="module-title">States</div>
            <div class="module-desc">Manage Indian state reference data</div>
            <span class="module-badge">Dropdown</span>
        </a>

        <a href="city/cityCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#127961;</span>
            <div class="module-title">Cities</div>
            <div class="module-desc">Manage city data with pincodes</div>
            <span class="module-badge">Dropdown</span>
        </a>

        <a href="statecity/statecityCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#128506;</span>
            <div class="module-title">State-City</div>
            <div class="module-desc">Map cities to their states</div>
            <span class="module-badge">Mapping</span>
        </a>

        <a href="qualification/qualificationCntrl?opr=dashboard" class="module-card">
            <span class="module-icon">&#127891;</span>
            <div class="module-title">Qualifications</div>
            <div class="module-desc">Manage academic qualification dropdown data</div>
            <span class="module-badge">Dropdown</span>
        </a>

    </div>
</div>

</body>
</html>
