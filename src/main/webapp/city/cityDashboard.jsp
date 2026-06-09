<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.city.CityDTO, java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>UMS &mdash; City Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="dashboard.css">
</head>
<body>
<nav class="navbar">
    <a href="../adminIndex.jsp" class="brand">&#127961; City Management</a>
    <div class="nav-actions">
        <a href="cityCntrl?opr=addNew" class="nav-btn nav-btn-success">+ Add City</a>
        <a href="../adminIndex.jsp" class="nav-btn">&#127968; Home</a>
    </div>
</nav>
<div class="container">
    <div class="page-header">
        <h2>&#127961; All Cities</h2>
    </div>
    <div class="table-card">
        <table id="tbl" class="display" style="width:100%">
            <thead><tr><th>ID</th><th>Code</th><th>City Name</th><th>Pincode</th><th>Actions</th></tr></thead>
            <tbody>
            <%
            ArrayList<CityDTO> cityList = (ArrayList<CityDTO>) request.getAttribute("cityList");
            if (cityList != null) for (CityDTO c : cityList) { %>
            <tr>
                <td><%=c.getId()%></td>
                <td><strong><%=c.getCode()%></strong></td>
                <td><%=c.getValue()%></td>
                <td><%=c.getPincode()%></td>
                <td>
                    <a href="cityCntrl?opr=view&id=<%=c.getId()%>" class="action-btn btn-view">View</a>
                    <a href="cityCntrl?opr=edit&id=<%=c.getId()%>" class="action-btn btn-edit">Edit</a>
                    <a href="cityCntrl?opr=delete&id=<%=c.getId()%>" class="action-btn btn-delete"
                       onclick="return confirm('Delete <%=c.getValue()%>?')">Delete</a>
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
