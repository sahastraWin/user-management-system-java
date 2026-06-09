<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.statecity.stateCityDTO,com.state.StateDTO,com.city.CityDTO,java.util.ArrayList"%>
<% stateCityDTO sc=(stateCityDTO)request.getAttribute("statecity");
   ArrayList<StateDTO> stateList=(ArrayList<StateDTO>)request.getAttribute("stateList");
   ArrayList<CityDTO> cityList=(ArrayList<CityDTO>)request.getAttribute("cityList"); %>
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><title>UMS - Edit State-City</title>
<link rel="stylesheet" href="style.css"></head>
<body><div class="wrapper"><h2>&#9998; Edit State-City Mapping</h2>
<button class="button" onclick="location.href='statecityCntrl?opr=dashboard'">&#8592; Back</button>
<form action="statecityCntrl" method="get">
<input type="hidden" name="opr" value="update"><input type="hidden" name="id" value="<%=sc.getId()%>">
<h3>State</h3>
<div class="input-box"><select name="stateCode">
<% for(StateDTO s:stateList){ %>
<option value="<%=s.getCode()%>" <%=sc.getStateCode().equals(s.getCode())?"selected":""%>><%=s.getValue()%></option>
<% } %></select></div>
<h3>City</h3>
<div class="input-box"><select name="cityCode">
<% for(CityDTO c:cityList){ %>
<option value="<%=c.getCode()%>" <%=sc.getCityCode().equals(c.getCode())?"selected":""%>><%=c.getValue()%></option>
<% } %></select></div>
<div class="input-box button"><input type="submit" value="Update Mapping"></div>
</form></div></body></html>
