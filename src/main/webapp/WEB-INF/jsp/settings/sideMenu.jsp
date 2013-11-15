<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String menuId = (String) request.getParameter("menuId");
if(menuId == null){
	menuId = "group";
}
%>
<ul class="nav nav-tabs tabs-left">
	<li class="<%="group".equals(menuId) ? "active" : "" %>"><a href="group.html"><strong>Group</strong></a>
	<li class="<%="user".equals(menuId) ? "active" : "" %>"><a href="user.html"><strong>User</strong></a>
</ul>
