<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.login.UserDTO, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>UMS &mdash; User Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f0f4ff;min-height:100vh;}

/* ---- Top Nav ---- */
.navbar {
    background:linear-gradient(135deg,#1a3faa,#3f6fdf);
    padding:14px 28px;display:flex;align-items:center;justify-content:space-between;
    box-shadow:0 2px 12px rgba(26,63,170,.3);
}
.navbar .brand{color:#fff;font-size:18px;font-weight:700;text-decoration:none;}
.navbar .nav-actions{display:flex;gap:10px;align-items:center;}
.nav-btn {
    padding:8px 16px;border-radius:8px;font-size:13px;font-weight:500;
    text-decoration:none;cursor:pointer;border:none;transition:all .25s;
}
.nav-btn-outline{background:rgba(255,255,255,.15);color:#fff;border:1px solid rgba(255,255,255,.3);}
.nav-btn-outline:hover{background:rgba(255,255,255,.25);}
.nav-btn-danger{background:#ef4444;color:#fff;}
.nav-btn-danger:hover{background:#dc2626;}

/* ---- Page Body ---- */
.container{max-width:1200px;margin:0 auto;padding:28px 20px;}

.page-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;}
.page-header h2{font-size:20px;font-weight:700;color:#1a1a2e;}
.btn-add {
    padding:10px 20px;background:linear-gradient(135deg,#4070f4,#2952d4);
    color:#fff;border:none;border-radius:10px;font-size:14px;font-weight:600;
    cursor:pointer;text-decoration:none;transition:all .25s;
    box-shadow:0 3px 10px rgba(64,112,244,.3);
}
.btn-add:hover{transform:translateY(-1px);box-shadow:0 5px 14px rgba(64,112,244,.4);}

/* ---- Table Card ---- */
.table-card{background:#fff;border-radius:16px;box-shadow:0 2px 16px rgba(0,0,0,.08);padding:20px;overflow:auto;}
table{width:100%;border-collapse:collapse;}
thead th {
    background:#f8faff;color:#555;font-size:12px;font-weight:600;
    text-transform:uppercase;letter-spacing:.5px;padding:12px 14px;
    border-bottom:2px solid #eef0f6;text-align:left;white-space:nowrap;
}
tbody td{padding:12px 14px;font-size:14px;color:#333;border-bottom:1px solid #f0f0f0;vertical-align:middle;}
tbody tr:hover{background:#f8faff;}
tbody tr:last-child td{border-bottom:none;}

.badge {
    padding:3px 10px;border-radius:20px;font-size:11px;font-weight:600;
}
.badge-active{background:#dcfce7;color:#16a34a;}
.badge-inactive{background:#fee2e2;color:#dc2626;}

.action-btn {
    display:inline-block;padding:5px 12px;border-radius:6px;font-size:12px;
    font-weight:500;text-decoration:none;margin:1px;transition:all .2s;border:none;cursor:pointer;
}
.btn-view{background:#dbeafe;color:#1d4ed8;}    .btn-view:hover{background:#bfdbfe;}
.btn-edit{background:#dcfce7;color:#16a34a;}    .btn-edit:hover{background:#bbf7d0;}
.btn-del{background:#fee2e2;color:#dc2626;}     .btn-del:hover{background:#fecaca;}

.avatar{
    width:36px;height:36px;border-radius:50%;object-fit:cover;
    background:#dbeafe;display:inline-flex;align-items:center;justify-content:center;
    font-size:16px;vertical-align:middle;
}
</style>
</head>
<body>

<%
UserDTO loggedUser = (UserDTO) session.getAttribute("userDTO");
if (loggedUser == null) { response.sendRedirect("signIn.jsp"); return; }
%>

<nav class="navbar">
    <a href="<%=request.getContextPath()%>/adminIndex.jsp" class="brand">&#128100; UMS Dashboard</a>
    <div class="nav-actions">
        <span style="color:rgba(255,255,255,.8);font-size:13px;">
            Welcome, <strong><%=loggedUser.getUserName() != null ? loggedUser.getUserName() : loggedUser.getUserId()%></strong>
        </span>
        <a href="<%=request.getContextPath()%>/adminIndex.jsp" class="nav-btn nav-btn-outline">Admin Home</a>
        <a href="<%=request.getContextPath()%>/login/LoginController?opr=logout" class="nav-btn nav-btn-danger">Logout</a>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h2>&#128101; Registered Users</h2>
        <a href="LoginController?opr=addNew" class="btn-add">+ Add New User</a>
    </div>

    <div class="table-card">
        <table id="userTable" class="display">
            <thead>
                <tr>
                    <th>#</th><th>User ID</th><th>Name</th>
                    <th>Status</th><th>Updated By</th><th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
            ArrayList<UserDTO> userList = (ArrayList<UserDTO>) request.getAttribute("userList");
            if (userList != null) {
                for (UserDTO u : userList) {
            %>
            <tr>
                <td><%=u.getId()%></td>
                <td><strong><%=u.getUserId()%></strong></td>
                <td><%=u.getUserName() != null ? u.getUserName() : "-"%></td>
                <td>
                    <span class="badge <%="active".equalsIgnoreCase(u.getStatus()) ? "badge-active" : "badge-inactive"%>">
                        <%=u.getStatus() != null ? u.getStatus() : "unknown"%>
                    </span>
                </td>
                <td><%=u.getUpdateBy() != null ? u.getUpdateBy() : "-"%></td>
                <td>
                    <a href="LoginController?opr=view&id=<%=u.getId()%>" class="action-btn btn-view">View</a>
                    <a href="LoginController?opr=edit&id=<%=u.getId()%>" class="action-btn btn-edit">Edit</a>
                    <a href="LoginController?opr=delete&id=<%=u.getId()%>" class="action-btn btn-del"
                       onclick="return confirm('Delete user <%=u.getUserId()%>?')">Delete</a>
                </td>
            </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>$(document).ready(function(){ $('#userTable').DataTable({pageLength:10}); });</script>
</body>
</html>
