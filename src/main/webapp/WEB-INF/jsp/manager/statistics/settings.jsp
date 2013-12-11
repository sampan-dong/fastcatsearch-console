<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>

<%
	//JSONArray nodeList = (JSONArray) request.getAttribute("nodeList");
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
			<c:param name="lcat" value="statistics" />
			<c:param name="mcat" value="settings" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li> Statistics</li>
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

				<div class="widget">
					<div class="widget-header">
						<h4>Category Settings</h4>
					</div>
					
					<div class="widget-content">
						<div><a href="javascript:void(0);" data-toggle="modal" data-target="#newServerInfoModal" >
						<span class="icon-plus-sign"></span> Add Category</a></div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Category ID</th>
									<th>Name</th>
									<th>RealTime PopularKeyword</th>
									<th>PopularKeyword</th>
									<th>RelateKeyword</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>total</td>
									<td>통합검색</td>
									<td><label>Y</label></td>
									<td><label>Y</label></td>
									<td><label>Y</label></td>
									<td><a data-toggle="modal" data-target="#categoryEditModal_" href="javascript:void(0);">Edit</a></td>
								</tr>
								<tr>
									<td>2</td>
									<td>mobile</td>
									<td>모바일 검색</td>
									<td><label>Y</label></td>
									<td><label>Y</label></td>
									<td><label>Y</label></td>
									<td><a data-toggle="modal" data-target="#categoryEditModal_" href="javascript:void(0);">Edit</a></td>
								</tr>
							<%-- <%
							for(int i=0; i < nodeList.length(); i++){
								String id = nodeList.getJSONObject(i).getString("id");
								String name = nodeList.getJSONObject(i).getString("name");
								String host = nodeList.getJSONObject(i).getString("host");
								int port = nodeList.getJSONObject(i).getInt("port");
								boolean enabled = nodeList.getJSONObject(i).getBoolean("enabled");
								boolean active = nodeList.getJSONObject(i).getBoolean("active");
								
								String enabledStatus = enabled ? "<span class=\"text-primary\">Enabled</span>" : "<span class=\"text-danger\">Disabled</span>";
								String activeStatus = active ? "<span class=\"text-primary\">Active</span>" : "<span class=\"text-danger\">InActive</span>";
							%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=id %></strong></td>
									<td><%=name %></td>
									<td><%=host %></td>
									<td><%=port %></td>
									<td><%=enabledStatus %></td>
									<td><%=activeStatus %></td>
									<td><a data-toggle="modal" data-target="#serverInfoModal_<%=i %>" href="javascript:void(0);">Edit</a></td>
								</tr>
							<%
							}
							%> --%>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="widget">
					<div class="widget-header">
						<h4>Common Settings</h4>
					</div>
					<div class="widget-content">
						<div class="row">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Stopwords:</label>
									<div class="col-md-10"><textarea placeholder="word#1, word#2, ..." style="width:100%"></textarea></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="widget">
					<div class="widget-header">
						<h4>RealTime Popular Keyword</h4>
					</div>
					<div class="widget-content">
						<div class="row">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Minimum Hit Count:</label>
									<div class="col-md-2"><input type="text" name="" class="form-control digits required" value="5"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="widget">
					<div class="widget-header">
						<h4>Popular Keyword</h4>
					</div>
					<div class="widget-content">
						<div class="row">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Minimum Hit Count:</label>
									<div class="col-md-2"><input type="text" name="" class="form-control digits required" value="5"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="widget">
					<div class="widget-header">
						<h4>Relate Keyword</h4>
					</div>
					<div class="widget-content">
						<div class="row">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Minimum Hit Count:</label>
									<div class="col-md-2"><input type="text" name="" class="form-control digits required" value="3"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="form-actions">
					<input type="submit" value="Update Settings" class="btn btn-primary pull-right">
				</div>
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>