<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.qualification.QualificationDTO, java.util.ArrayList"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Qualification Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="dashboard.css"></head>
<body>
<nav class="navbar"><a href="../adminIndex.jsp" class="brand">&#127891; Qualification Management</a>
<div class="nav-actions"><a href="qualificationCntrl?opr=addNew" class="nav-btn nav-btn-success">+ Add Qualification</a>
<a href="../adminIndex.jsp" class="nav-btn">&#127968; Home</a></div></nav>
<div class="container"><div class="page-header"><h2>&#127891; All Qualifications</h2></div>
<div class="table-card"><table id="tbl" class="display" style="width:100%">
<thead><tr><th>ID</th><th>Code</th><th>Qualification</th><th>Actions</th></tr></thead>
<tbody>
<% ArrayList<QualificationDTO> qualificationList=(ArrayList<QualificationDTO>)request.getAttribute("qualificationList");
   if(qualificationList!=null) for(QualificationDTO q:qualificationList){ %>
<tr><td><%=q.getId()%></td><td><strong><%=q.getCode()%></strong></td><td><%=q.getValue()%></td>
<td><a href="qualificationCntrl?opr=view&id=<%=q.getId()%>" class="action-btn btn-view">View</a>
<a href="qualificationCntrl?opr=edit&id=<%=q.getId()%>" class="action-btn btn-edit">Edit</a>
<a href="qualificationCntrl?opr=delete&id=<%=q.getId()%>" class="action-btn btn-delete" onclick="return confirm('Delete?')">Delete</a></td></tr>
<% } %></tbody></table></div></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>$(()=>$('#tbl').DataTable({pageLength:10}));</script>
</body></html>
