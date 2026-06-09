<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.statecity.stateCityDTO, java.util.ArrayList"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - StateCity Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="dashboard.css"></head>
<body>
<nav class="navbar"><a href="../adminIndex.jsp" class="brand">&#128506; State-City Mapping</a>
<div class="nav-actions"><a href="statecityCntrl?opr=addNew" class="nav-btn nav-btn-success">+ Add Mapping</a>
<a href="../adminIndex.jsp" class="nav-btn">&#127968; Home</a></div></nav>
<div class="container"><div class="page-header"><h2>&#128506; All State-City Mappings</h2></div>
<div class="table-card"><table id="tbl" class="display" style="width:100%">
<thead><tr><th>ID</th><th>State Code</th><th>City Code</th><th>Actions</th></tr></thead>
<tbody>
<% ArrayList<stateCityDTO> statecityList=(ArrayList<stateCityDTO>)request.getAttribute("statecityList");
   if(statecityList!=null) for(stateCityDTO sc:statecityList){ %>
<tr><td><%=sc.getId()%></td><td><strong><%=sc.getStateCode()%></strong></td><td><%=sc.getCityCode()%></td>
<td><a href="statecityCntrl?opr=view&id=<%=sc.getId()%>" class="action-btn btn-view">View</a>
<a href="statecityCntrl?opr=edit&id=<%=sc.getId()%>" class="action-btn btn-edit">Edit</a>
<a href="statecityCntrl?opr=delete&id=<%=sc.getId()%>" class="action-btn btn-delete" onclick="return confirm('Delete?')">Delete</a></td></tr>
<% } %></tbody></table></div></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>$(()=>$('#tbl').DataTable({pageLength:10}));</script>
</body></html>
