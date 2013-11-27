<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="
org.json.JSONObject,
org.json.JSONArray
"%>
<%
JSONObject exceptionInfo = (JSONObject)request.getAttribute("exceptionInfo");
%>
	<dl class="dl-horizontal col-md-12">
		<dt>Time</dt>
		<dd><%=exceptionInfo.optString("regtime") %></dd>
		<dt>Node</dt>
		<dd><%=exceptionInfo.optString("node") %></dd>
		<dt>Message</dt>
		<dd><div class="panel">
		<%=exceptionInfo.optString("message") %>
		</div></dd>
	</dl>