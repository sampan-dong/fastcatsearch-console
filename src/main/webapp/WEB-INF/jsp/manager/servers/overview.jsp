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
			<c:param name="mcat" value="overview" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li> Servers</li>
						<li class="current"> Overview</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Overview</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget">
					<div class="widget-header">
						<h4>Node Settings</h4>
					</div>
					<div class="widget-content">
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
								</tr>
							<%
							}
							%>
							</tbody>
						</table>
					</div>
				</div>

				<div class="widget">
					<div class="widget-header">
						<h4>Engine Information</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>JVM Path</th>
									<th>JVM Version</th>
									<th>JVM Option</th>
									<th>Install Path</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>/home/jvm</td>
									<td>1.7</td>
									<td>-Xmx5g -server</td>
									<td>/home/fastcatsearch/fastcatsearch2</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>/home/jvm</td>
									<td>1.7</td>
									<td>-Xmx5g -server</td>
									<td>/home/fastcatsearch/fastcatsearch2</td>
								</tr>
							</tbody>
						</table>
					
					</div>
				</div>

				<div class="widget">
					<div class="widget-header">
						<h4>Collection Status</h4>
					</div>
					<div class="widget-content">
						<h5><i class="icon-angle-right"></i> Vol1</h5>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Document Size</th>
									<th>Data Path</th>
									<th>Data Disk Size</th>
									<th>Segment Size</th>
									<th>Revision ID</th>
									<th>Revision UUID</th>
									<th>Update Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
							</tbody>
						</table>
						
						<h5><i class="icon-angle-right"></i> Vol2</h5>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Document Size</th>
									<th>Data Path</th>
									<th>Data Disk Size</th>
									<th>Segment Size</th>
									<th>Revision ID</th>
									<th>Revision UUID</th>
									<th>Update Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
							</tbody>
						</table>
						
						<h5><i class="icon-angle-right"></i> Vol3</h5>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Document Size</th>
									<th>Data Path</th>
									<th>Data Disk Size</th>
									<th>Segment Size</th>
									<th>Revision ID</th>
									<th>Revision UUID</th>
									<th>Update Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
						
						
						
						
						
				<div class="widget">
					<div class="widget-header">
						<h4>System Health</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Disk</th>
									<th>CPU</th>
									<th>RAM</th>
									<th>Load</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>20% (256Mb/1.5Tb)</td>
									<td>12%</td>
									<td>45% (16GB/32GB)</td>
									<td>1.1</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>10% (256Mb/1.5Tb)</td>
									<td>22%</td>
									<td>45% (16GB/32GB)</td>
									<td>0.5</td>
								</tr>
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