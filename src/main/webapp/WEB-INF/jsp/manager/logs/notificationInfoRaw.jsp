<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="
org.json.JSONObject,
org.json.JSONArray
"%>
<%
JSONObject notificationInfo = (JSONObject)request.getAttribute("notificationInfo");
%>
	<dl class="dl-horizontal col-md-12">
		<dt>Time</dt>
		<dd><%=notificationInfo.optString("regtime") %></dd>
		<dt>Node</dt>
		<dd><%=notificationInfo.optString("node") %></dd>
		<dt>Code</dt>
		<dd><%=notificationInfo.optString("messageCode") %></dd>
		<dt>Message</dt>
		<dd><div class="panel">
		<%=notificationInfo.optString("message") %>
		</div></dd>
	</dl>