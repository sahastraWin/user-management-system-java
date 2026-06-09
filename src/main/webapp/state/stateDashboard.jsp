<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.state.StateDTO, java.util.ArrayList"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - State Dashboard</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="dashboard.css"></head>
<body>
<nav class="navbar"><a href="../adminIndex.jsp" class="brand">&#127758; State Management</a>
<div class="nav-actions"><a href="stateCntrl?opr=addNew" class="nav-btn nav-btn-success">+ Add State</a>
<a href="../adminIndex.jsp" class="nav-btn">&#127968; Home</a></div></nav>
<div class="container"><div class="page-header"><h2>&#127758; All States</h2></div>
<div class="table-card"><table id="tbl" class="display" style="width:100%">
<thead><tr><th>ID</th><th>Code</th><th>State Name</th><th>Actions</th></tr></thead>
<tbody>
<% ArrayList<StateDTO> stateList=(ArrayList<StateDTO>)request.getAttribute("stateList");
   if(stateList!=null) for(StateDTO s:stateList){ %>
<tr><td><%=s.getId()%></td><td><strong><%=s.getCode()%></strong></td><td><%=s.getValue()%></td>
<td><a href="stateCntrl?opr=view&id=<%=s.getId()%>" class="action-btn btn-view">View</a>
<a href="stateCntrl?opr=edit&id=<%=s.getId()%>" class="action-btn btn-edit">Edit</a>
<a href="stateCntrl?opr=delete&id=<%=s.getId()%>" class="action-btn btn-delete" onclick="return confirm('Delete?')">Delete</a></td></tr>
<% } %></tbody></table></div></div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script>$(()=>$('#tbl').DataTable({pageLength:10}));</script>
</body></html>
