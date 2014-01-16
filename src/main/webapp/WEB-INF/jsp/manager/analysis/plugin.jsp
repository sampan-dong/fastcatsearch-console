<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%
JSONArray analysisPluginList = (JSONArray) request.getAttribute("analysisPluginOverview");
%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="analysis" />
			<c:param name="mcat" value="plugin" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Analysis</li>
						<li class="current"> Plugin</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Plugin</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th>#</th>
							<th>ID</th>
							<th>Name</th>
							<th>Version</th>
							<th>Decription</th>
							<th>Class</th>
						</tr>
					</thead>
					<tbody>
						<%
						for(int i = 0; i< analysisPluginList.length(); i++){
							JSONObject pluginInfo = analysisPluginList.getJSONObject(i);
						%>
						<tr>
							<td><%=i+1 %></td>
							<td><strong><%=pluginInfo.getString("id") %></strong></td>
							<td><%=pluginInfo.getString("name") %></td>
							<td><%=pluginInfo.getString("version") %></td>
							<td><%=pluginInfo.getString("description") %></td>
							<td><%=pluginInfo.getString("className") %></td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>