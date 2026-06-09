<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.state.StateDTO,com.city.CityDTO,java.util.ArrayList"%>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Add State-City</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#128506; Add State-City Mapping</h2>
<button class="button" onclick="location.href='statecityCntrl?opr=dashboard'">&#8592; Back</button>
<form action="statecityCntrl" method="get"><input type="hidden" name="opr" value="save">
<h3>State</h3>
<div class="input-box">
<select name="stateCode">
<% ArrayList<StateDTO> stateList=(ArrayList<StateDTO>)request.getAttribute("stateList");
   if(stateList!=null) for(StateDTO s:stateList){ %>
<option value="<%=s.getCode()%>"><%=s.getValue()%></option>
<% } %></select></div>
<h3>City</h3>
<div class="input-box">
<select name="cityCode">
<% ArrayList<CityDTO> cityList=(ArrayList<CityDTO>)request.getAttribute("cityList");
   if(cityList!=null) for(CityDTO c:cityList){ %>
<option value="<%=c.getCode()%>"><%=c.getValue()%></option>
<% } %></select></div>
<div class="input-box button"><input type="submit" value="Save Mapping"></div>
</form></div></body></html>
