<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>

<%
	JSONArray nodeList = (JSONArray) request.getAttribute("nodeList");
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
			<c:param name="lcat" value="servers" />
			<c:param name="mcat" value="settings" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li> Servers</li>
						<li class="current"> Settings</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Settings</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="input-group col-md-12">
								<a href="javascript:void(0);" class="btn btn-sm"><span
									class="glyphicon glyphicon-plus-sign"></span> Add Server</a>
								
								<!-- <span class="pull-right">
								<a href="javascript:void(0);" class="btn btn-sm btn-primary">
									<span class="glyphicon glyphicon-ok"></span> Save Changes
								</a>
								</span> -->
							</div>
							
						</div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>ID</th>
									<th>Name</th>
									<th>IP Address</th>
									<th>Port</th>
									<th>Enabled</th>
									<th>Active</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							<%
							for(int i=0; i < nodeList.length(); i++){
								String id = nodeList.getJSONObject(i).getString("id");
								String name = nodeList.getJSONObject(i).getString("name");
								String host = nodeList.getJSONObject(i).getString("host");
								int port = nodeList.getJSONObject(i).getInt("port");
								boolean enabled = nodeList.getJSONObject(i).getBoolean("enabled");
								boolean active = nodeList.getJSONObject(i).getBoolean("active");
								
								String enabledStatus = enabled ? "<span class=\"text-primary\">Enabled</span>" : "<span class=\"text-danger\">Disabled</span>";
								String activeStatus = active ? "<span class=\"text-primary\">Active</span>" : "<span class=\"text-danger\">Inactive</span>";
							%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=id %></strong></td>
									<td><%=name %></td>
									<td><%=host %></td>
									<td><%=port %></td>
									<td><%=enabledStatus %></td>
									<td><%=activeStatus %></td>
									<td><a href="javascript:void(0);">Edit</a></td>
								</tr>
							<%
							}
							%>
							</tbody>
						</table>
					</div>
				</div>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>