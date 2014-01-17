<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>

<%
	JSONObject nodeInfo = (JSONObject) request.getAttribute("nodeInfo");
	JSONObject systemHealth = (JSONObject) request.getAttribute("systemHealth");
	JSONObject systemInfo = (JSONObject) request.getAttribute("systemInfo");
	
	JSONArray indexStatusList = (JSONArray) request.getAttribute("indexStatusList");
	JSONArray pluginStatusList = (JSONArray) request.getAttribute("pluginStatusList");
	
%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){

});
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="servers" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class=""> Servers</li>
						<li class="current"> Node1</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Node#</h3>
						<p>Each server information </p>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget">
					<div class="widget-header">
						<h4>Node Settings</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>ID</th>
									<th>Name</th>
									<th>IP Address</th>
									<th>Service Port</th>
									<th>Internal Port</th>
									<th>Enabled</th>
									<th>Active</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody>
							<%
								String id = nodeInfo.optString("id");
								String name = nodeInfo.optString("name");
								String host = nodeInfo.optString("host");
								int servicePort = nodeInfo.optInt("servicePort");
								int internalPort = nodeInfo.optInt("internalPort");
								boolean enabled = nodeInfo.optBoolean("enabled");
								boolean active = nodeInfo.optBoolean("active");
								
								String enabledStatus = enabled ? "<span class=\"label text-primary\">Enabled</span>" : "<span class=\"text-danger\">Disabled</span>";
								String activeStatus = active ? "<span class=\"text-primary\">Active</span>" : "<span class=\"text-danger\">Inactive</span>";
							%>
							<tr>
								<td><strong><%=id %></strong></td>
								<td><%=name %></td>
								<td><%=host %></td>
								<td><%=servicePort %></td>
								<td><%=internalPort %></td>
								<td><%=enabledStatus %></td>
								<td><%=activeStatus %></td>
								<td><a href="javascript:void(0);">Restart</a> &nbsp;<a href="javascript:void(0);">Shutdown</a></td>
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
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>Disk</th>
									<th>Java CPU</th>
									<th>System CPU</th>
									<th>Java Memory</th>
									<th>System Memory</th>
									<th>Load</th>
								</tr>
							</thead>
							<tbody>
								<%
									DecimalFormat decimalFormat = new DecimalFormat("##.#");
									JSONObject info = systemHealth;
									int totalDiskSize = info.optInt("totalDiskSize");
									int usedDiskSize = info.optInt("usedDiskSize");
									float diskUseRate = 0;
									if(totalDiskSize > 0){
										diskUseRate = (float) usedDiskSize / (float) totalDiskSize;
										diskUseRate *= 100.0;
									}
									
									int usedMemory = info.optInt("usedMemory");
									int maxMemory = info.optInt("maxMemory");
									float memoryUseRate = 0;
									if(maxMemory > 0){
										memoryUseRate = (float) usedMemory / (float) maxMemory;
										memoryUseRate *= 100.0;
									}
										
										
								%>
								<tr>
									<td><%=decimalFormat.format(diskUseRate) %>% (<%=usedDiskSize %>MB / <%=totalDiskSize %>MB)</td>
									<td><%=info.optInt("jvmCpuUse")%>%</td>
									<td><%=info.optInt("systemCpuUse")%>%</td>
									<td><%=decimalFormat.format(memoryUseRate) %>% (<%=usedMemory %>MB / <%=maxMemory %>MB)</td>
									<td><%=info.optInt("totalMemory")%>MB</td>
									<td><%=decimalFormat.format(info.optDouble("systemLoadAverage")) %></td>
								</tr>
							</tbody>
						</table>
					
					</div>
				</div>
				<div class="widget">
					<div class="widget-header">
						<h4>Running Tasks</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>#</th>
									<th>Task</th>
									<th>Elapsed</th>
									<th>Start</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>2</td>
									<td>Collection Vol1 indexing..130000
									</td>
									<td>1h 20m</td>
									<td>2013-09-10 12:35:00</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<div class="widget">
					<div class="widget-header">
						<h4>System Information</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>Engine Path</th>
									<th>OS Name</th>
									<th>OS Arch</th>
									<th>Java Path</th>
									<th>Java Vendor</th>
									<th>Java Version</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><%=systemInfo.optString("homePath") %></td>
									<td><%=systemInfo.optString("osName") %></td>
									<td><%=systemInfo.optString("osArch") %></td>
									<td><%=systemInfo.optString("javaHome") %></td>
									<td><%=systemInfo.optString("javaVendor") %></td>
									<td><%=systemInfo.optString("javaVersion") %></td>
								</tr>
							</tbody>
						</table>
					
					</div>
				</div>


				<div class="widget ">
					<div class="widget-header">
						<h4>Collection Status</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>Document Size</th>
									<th>Data Path</th>
									<th>Data Disk Size</th>
									<th>Segment Size</th>
									<th>Revision UUID</th>
									<th>Update Time</th>
								</tr>
							</thead>
							<tbody>
								<%
								for(int i = 0; i < indexStatusList.length(); i++){
									JSONObject indexStatus = indexStatusList.getJSONObject(i);
								%>
								<tr>
									<td><%=indexStatus.optInt("documentSize", -1) %></td>
									<td><%=indexStatus.optString("dataPath", "-") %></td>
									<td><%=indexStatus.optString("diskSize", "-") %></td>
									<td><%=indexStatus.optInt("segmentSize", -1) %></td>
									<%
									String revisionUUID = indexStatus.optString("revisionUUID", "-");
									if(revisionUUID.length() > 10){
										revisionUUID = revisionUUID.substring(0, 10);
									}
									%>
									<td><%=revisionUUID %></td>
									<td><%=indexStatus.optString("createTime", "-") %></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="widget ">
					<div class="widget-header">
						<h4>Plugin Status</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>Name</th>
									<th>ID</th>
									<th>Namespace</th>
									<th>Class</th>
									<th>Version</th>
									<th>Decription</th>
								</tr>
							</thead>
							<tbody>
								<%
								for(int i = 0; i < pluginStatusList.length(); i++){
									JSONObject pluginStatus = pluginStatusList.getJSONObject(i);
								%>
								<tr>
									<td><%=pluginStatus.optInt("documentSize", -1) %></td>
									<td><%=pluginStatus.optString("dataPath", "-") %></td>
									<td><%=pluginStatus.optString("diskSize", "-") %></td>
									<td><%=pluginStatus.optInt("segmentSize", -1) %></td>
									<%
									String revisionUUID = pluginStatus.optString("revisionUUID", "-");
									if(revisionUUID.length() > 10){
										revisionUUID = revisionUUID.substring(0, 10);
									}
									%>
									<td><%=revisionUUID %></td>
									<td><%=pluginStatus.optString("createTime", "-") %></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				
				
				<div class="widget ">
					<div class="widget-header">
						<h4>Module Status</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>Name</th>
									<th>Status</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>IRService</td>
									<td>Running</td>
									<td><a href="javascript:void(0);">Stop</a></td>
								</tr>
								<tr>
									<td>NodeService</td>
									<td>Stopped</td>
									<td><a href="javascript:void(0);">Start</a></td>
								</tr>
								<tr>
									<td>DBService</td>
									<td>Stopped</td>
									<td><a href="javascript:void(0);">Start</a></td>
								</tr>
								<tr>
									<td>JobService</td>
									<td>Running</td>
									<td><a href="javascript:void(0);">Stop</a></td>
								</tr>
								<tr>
									<td>SystemInfoService</td>
									<td>Running</td>
									<td><a href="javascript:void(0);">Stop</a></td>
								</tr>
								<tr>
									<td>HttpRequestService</td>
									<td>Running</td>
									<td><a href="javascript:void(0);">Stop</a></td>
								</tr>
								<tr>
									<td>NotificationService</td>
									<td>Running</td>
									<td><a href="javascript:void(0);">Stop</a></td>
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