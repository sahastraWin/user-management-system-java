<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.person.PersonDTO, com.qualification.QualificationDTO, com.login.UserDTO, java.util.ArrayList"%>
<%
UserDTO loggedUser = (UserDTO) session.getAttribute("userDTO");
if (loggedUser == null) { response.sendRedirect("../login/signIn.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8"><title>UMS &mdash; Person Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="dashboard.css">
</head>
<body>
<nav class="navbar">
    <a href="../adminIndex.jsp" class="brand">&#128101; Person Management</a>
    <div class="nav-actions">
        <span style="color:rgba(255,255,255,.8);font-size:13px;">&#128100; <%=loggedUser.getUserName() != null ? loggedUser.getUserName() : loggedUser.getUserId()%></span>
        <a href="personCntrl?opr=addNew" class="nav-btn nav-btn-success">+ Add Person</a>
        <a href="../adminIndex.jsp" class="nav-btn">&#127968; Home</a>
        <a href="../login/LoginController?opr=logout" class="nav-btn" style="background:#ef4444;border-color:#ef4444;">Logout</a>
    </div>
</nav>
<div class="container">
    <div class="page-header"><h2>&#128101; All Persons</h2></div>
    <div class="table-card">
        <table id="tbl" class="display" style="width:100%">
            <thead>
                <tr><th>ID</th><th>Name</th><th>Mobile</th><th>Email</th><th>Gender</th><th>State</th><th>City</th><th>Actions</th></tr>
            </thead>
            <tbody>
            <%
            ArrayList<PersonDTO> personList = (ArrayList<PersonDTO>) request.getAttribute("personList");
            if (personList != null) for (PersonDTO p : personList) { %>
            <tr>
                <td><%=p.getId()%></td>
                <td><strong><%=p.getName()%></strong></td>
                <td><%=p.getMobileNumber() != null ? p.getMobileNumber() : "-"%></td>
                <td><%=p.getEmailId() != null ? p.getEmailId() : "-"%></td>
                <td><%=p.getGender() != null ? p.getGender() : "-"%></td>
                <td><%=p.getState() != null ? p.getState() : "-"%></td>
                <td><%=p.getCity() != null ? p.getCity() : "-"%></td>
                <td>
                    <a href="personCntrl?opr=view&id=<%=p.getId()%>" class="action-btn btn-view">View</a>
                    <a href="personCntrl?opr=edit&id=<%=p.getId()%>" class="action-btn btn-edit">Edit</a>
                    <a href="personCntrl?opr=delete&id=<%=p.getId()%>" class="action-btn btn-delete"
                       onclick="return confirm('Delete <%=p.getName()%>?')">Delete</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>$(()=>$('#tbl').DataTable({pageLength:10}));</script>
</body>
</html>
