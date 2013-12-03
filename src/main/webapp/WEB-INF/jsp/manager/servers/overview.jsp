<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%
	JSONArray nodeList = (JSONArray) request.getAttribute("nodeList");

	JSONObject systemInfo = (JSONObject) request.getAttribute("systemInfo");
	JSONObject systemHealth = (JSONObject) request.getAttribute("systemHealth");
	
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
						<h4>System Information</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Engine Path</th>
									<th>OS Name</th>
									<th>OS Arch</th>
									<th>Java Path</th>
									<th>Java Vendor</th>
									<th>Java Version</th>
								</tr>
							</thead>
							<tbody>
								<%
								Iterator<String> systemInfoIterator = systemInfo.keys();
								int i = 1;
								while(systemInfoIterator.hasNext()){
									String nodeId = systemInfoIterator.next();
									JSONObject info = systemInfo.optJSONObject(nodeId);
									if(nodeId != null){
								%>
								<tr>
									<td><%=i++ %></td>
									<td><%=info.optString("nodeName") %></td>
									<td><%=info.optString("homePath") %></td>
									<td><%=info.optString("osName") %></td>
									<td><%=info.optString("osArch") %></td>
									<td><%=info.optString("javaHome") %></td>
									<td><%=info.optString("javaVendor") %></td>
									<td><%=info.optString("javaVersion") %></td>
								</tr>
								<%
									}
								}
								%>
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
									<th>Java CPU</th>
									<th>System CPU</th>
									<th>Memory</th>
									<th>Load</th>
								</tr>
							</thead>
							<tbody>
								<%
								Iterator<String> systemHealthIterator = systemHealth.keys();
								i = 1;
								DecimalFormat decimalFormat = new DecimalFormat("##.#");
								while(systemHealthIterator.hasNext()){
									String nodeId = systemHealthIterator.next();
									JSONObject info = systemHealth.optJSONObject(nodeId);
									if(nodeId != null){
										int totalDiskSize = info.optInt("totalDiskSize");
										int usedDiskSize = info.optInt("usedDiskSize");
										float diskUseRate = 0;
										if(totalDiskSize > 0){
											diskUseRate = (float) usedDiskSize / (float) totalDiskSize;
											diskUseRate *= 100.0;
										}
										
										int usedMemory = info.optInt("usedMemory");
										int totalMemory = info.optInt("totalMemory");
										float memoryUseRate = 0;
										if(totalMemory > 0){
											memoryUseRate = (float) usedMemory / (float) totalMemory;
											memoryUseRate *= 100.0;
										}
										
										
								%>
								<tr>
									<td><%=i++ %></td>
									<td><%=info.optString("nodeName") %></td>
									<td><%=decimalFormat.format(diskUseRate) %>% (<%=usedDiskSize %>MB / <%=totalDiskSize %>MB)</td>
									<td><%=info.optInt("jvmCpuUse")%>%</td>
									<td><%=info.optInt("systemCpuUse")%>%</td>
									<td><%=decimalFormat.format(memoryUseRate) %>% (<%=usedMemory %>MB / <%=totalMemory %>MB)</td>
									<td><%=decimalFormat.format(info.optDouble("systemLoadAverage")) %></td>
								</tr>
								<%
									}
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