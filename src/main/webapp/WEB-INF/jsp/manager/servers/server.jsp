<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DecimalFormat"%>
<%
	JSONObject nodeInfo = (JSONObject) request.getAttribute("nodeInfo");
	JSONObject systemHealth = (JSONObject) request.getAttribute("systemHealth");
	JSONObject taskStatus = (JSONObject) request.getAttribute("taskStatus");
	JSONObject systemInfo = (JSONObject) request.getAttribute("systemInfo");
	JSONObject indexStatus = (JSONObject) request.getAttribute("indexStatus");
	JSONObject pluginStatus = (JSONObject) request.getAttribute("pluginStatus");
	JSONObject moduleStatus = (JSONObject) request.getAttribute("moduleStatus");
	JSONObject threadStatus = (JSONObject) request.getAttribute("threadStatus");
	String nodeId = (String) request.getAttribute("nodeId");
	String[] serviceClasses = (String[]) request.getAttribute("serviceClasses");
	String nodeName = "";
	
	boolean systemActive = false;
	
	JSONArray nodeSettingList = nodeInfo.optJSONArray("nodeList");
	JSONObject nodeSetting = null;
	if(nodeSettingList != null && nodeSettingList.length() > 0) {
		nodeSetting = nodeSettingList.optJSONObject(0);
		nodeName = nodeSetting.optString("name");
		systemActive = nodeSetting.optBoolean("active");
	}
%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
div#nodeStatus table td a { cursor:pointer; }
div#moduleStatus table td a { cursor:pointer; }
.stacktrace {display:none;}
</style>
<script>
$(document).ready(function(){
	
	$("div#nodeStatus table td a").click(function() {
		var action = $(this).attr("class");
		
		if(confirm("WARNING : this can halt or damage your search-engine")) {
			
			var uri="";
			var nodeId="${nodeId}";
			
			if(action=="restart") {
				uri="/management/servers/restart";
			} else if(action="shutdown") {
				uri="/management/servers/shutdown";
			}
			
			if(uri!="" && nodeId!="") {
				requestProxy("post", {
					uri:uri,
					nodeId:nodeId
				}, "json", function(data) {
					if(data["success"]==true) {
						noty({text: "module update success", type: "success", layout:"topRight", timeout: 3000});
					} else {
						noty({text: "module update failed", type: "error", layout:"topRight", timeout: 3000});
					}
					setTimeout(function(){ location.reload(true); },1000);
				});
			}
		}
	});
	
	$("div#moduleStatus table td a").click(function() {
		var action = $(this).attr("class");
		var serviceClass = $(this).parents("tr").attr("id");
		
		if(confirm("WARNING : this can halt or damage your search-engine")) {
			
			var nodeId="${nodeId}";
			
			requestProxy("post", {
				uri:"/management/common/update-modules-state",
				nodeId:nodeId,
				services:serviceClass,
				action:action
			}, "json", function(data) {
				if(data["success"]==true) {
					noty({text: "module update success", type: "success", layout:"topRight", timeout: 3000});
				} else {
					noty({text: "module update failed", type: "error", layout:"topRight", timeout: 3000});
				}
				setTimeout(function(){ location.reload(true); },1000);
			});
		}
	});
});

function toggle(tid){
	var el = $("#st-"+tid);
	el.toggle();
}

function showAllThreadStacktrace(){
	$("#thread-status").find(".stacktrace").each(function( index, element ) {
		$(element).show();
	});
}
function hideAllThreadStacktrace(){
	$("#thread-status").find(".stacktrace").each(function( index, element ) {
		$(element).hide();
	});
}
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="servers" />
			<c:param name="mcat" value="${nodeId}" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class=""> Servers</li>
						<li class="current"> <%=nodeName %></li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3><%=nodeName %></h3>
						<p>Each server information </p>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget" id="nodeStatus">
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
									<th>Node Port</th>
									<th>Service Port</th>
									<th>Enabled</th>
									<th>Active</th>
									<%if (systemActive) { %>
									<th>&nbsp;</th>
									<% } %>
								</tr>
							</thead>
							<tbody>
							<%
							if(nodeSetting != null) {
							%>
								<%
								String id = nodeSetting.optString("id");
								String name = nodeSetting.optString("name");
								String host = nodeSetting.optString("host");
								int port = nodeSetting.optInt("port");
								int servicePort = nodeSetting.optInt("servicePort");
								boolean enabled = nodeSetting.optBoolean("enabled");
								boolean active = systemActive;
								
								String enabledStatus = enabled ? "<span class=\"text-primary\">Enabled</span>" : "<span class=\"text-danger\">Disabled</span>";
								String activeStatus = active ? "<span class=\"text-primary\">Active</span>" : "<span class=\"text-danger\">Inactive</span>";
								%>
								<tr>
									<td><strong><%=id %></strong></td>
									<td><%=name %></td>
									<td><%=host %></td>
									<td><%=port %></td>
									<td><%=servicePort %></td>
									<td><%=enabledStatus %></td>
									<td><%=activeStatus %></td>
									<% if(active) { %>
									<td>
										<a class="restart">Restart</a>&nbsp;
										<a class="shutdown">Shutdown</a>
									</td>
									<% } %>
								</tr>
							<%
							}
							%>
							</tbody>
						</table>
					</div>
				</div>
				<%
				if(systemActive) {
				%>
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
								JSONObject info = systemHealth.optJSONObject(nodeId);
								if(info!=null) {
								%>
									<%
									DecimalFormat decimalFormat = new DecimalFormat("##.#");
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
								<%
								}
								%>
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
							<%
							JSONArray taskList =  taskStatus.optJSONArray("taskState");
							for(int inx=0 ; taskList != null && inx < taskList.length() ; inx++ ) {
							%>
								<%
								JSONObject taskData = taskList.optJSONObject(inx);
								%>
								<tr>
									<td><%=inx+1 %></td>
									<td><%=taskData.optString("summary") %></td>
									<td><%=taskData.optString("elapsed") %></td>
									<td><%=taskData.optString("startTime") %></td>
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
								<%
								systemInfo = systemInfo.optJSONObject(nodeId);
								if(systemInfo!=null) {
								%>
								<tr>
									<td><%=systemInfo.optString("homePath") %></td>
									<td><%=systemInfo.optString("osName") %></td>
									<td><%=systemInfo.optString("osArch") %></td>
									<td><%=systemInfo.optString("javaHome") %></td>
									<td><%=systemInfo.optString("javaVendor") %></td>
									<td><%=systemInfo.optString("javaVersion") %></td>
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
								JSONArray indexStatusList = indexStatus.optJSONArray("indexingState");
								for(int inx = 0; indexStatusList!=null && inx < indexStatusList.length(); inx++){
									JSONObject indexData = indexStatusList.getJSONObject(inx);
								%>
								<tr>
									<td><%=indexData.optInt("documentSize", -1) %></td>
									<td><%=indexData.optString("dataPath", "-") %></td>
									<td><%=indexData.optString("diskSize", "-") %></td>
									<td><%=indexData.optInt("segmentSize", -1) %></td>
									<%
									String revisionUUID = indexData.optString("revisionUUID", "-");
									if(revisionUUID.length() > 10){
										revisionUUID = revisionUUID.substring(0, 10);
									}
									%>
									<td><%=revisionUUID %></td>
									<td><%=indexData.optString("createTime", "-") %></td>
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
							JSONArray pluginStatusList = pluginStatus.optJSONArray("pluginList");
							for(int inx=0;inx<pluginStatusList.length(); inx++) {
							%>
								<%
								JSONObject plugin = pluginStatusList.optJSONObject(inx);
								JSONArray analyzers = plugin.optJSONArray("analyzer");
								String analyzerNameStr = "";
								for(int analyzerInx=0;analyzerInx< analyzers.length(); analyzerInx++) {
									JSONObject analyzer = analyzers.optJSONObject(analyzerInx);
									analyzerNameStr+=", "+ analyzer.optString("id");
								}
								if(analyzerNameStr.length() > 0) {
									analyzerNameStr = analyzerNameStr.substring(1).toUpperCase();
								}
								%>
								<tr>
								<td><%=plugin.optString("name") %></td>
								<td><%=plugin.optString("id") %></td>
								<td><%=analyzerNameStr %></td>
								<td style="word-break:break-word;"><%=plugin.optString("className") %></td>
								<td><%=plugin.optString("version") %></td>
								<td><%=plugin.optString("description") %></td>
								</tr>
							
							<%
							}
							%>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="widget" id="moduleStatus">
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
							<%
							JSONArray moduleStatusList = moduleStatus.optJSONArray("moduleState");
							for(int moduleInx=0;moduleStatusList!=null && moduleInx < moduleStatusList.length(); moduleInx++) {
							%>
								<%
								JSONObject module = moduleStatusList.optJSONObject(moduleInx);
								boolean running = module.optBoolean("status", false);
								String runningStatus = running ? "<span class=\"text-primary\">Running</span>" : "<span class=\"text-danger\">Stopped</span>";
								%>
								<tr id="<%=module.optString("serviceClass")%>">
									<td><%=module.optString("serviceName") %></td>
									<td><%=runningStatus %></td>
									<td>
									<%
									if(running) {
									%>
										<a class="stop">Stop</a> &nbsp;
										<a class="restart">Restart</a>
									<%
									} else {
									%>
										<a class="restart">Start</a>
									<%
									}
									%>
									</td>
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
						<h4>Thread Status</h4>
					</div>
					<div class="widget-content">
						<p>Thread count : <%=threadStatus.optInt("count", 0) %>
						&nbsp;&nbsp;&nbsp;<a href="javascript:showAllThreadStacktrace();" class="show-link">Show all stacktrace</a>
						&nbsp; | &nbsp;&nbsp;<a href="javascript:hideAllThreadStacktrace();" class="show-link">Collapse all stacktrace</a>
						</p>
						<div style="height:400px; overflow-y:scroll">
						<table id="thread-status" class="table table-hover table-bordered table-highlight-head">
							<thead>
								<tr>
									<th>#</th>
									<th>Group</th>
									<th>Name</th>
									<th>Tid</th>
									<th>Priority</th>
									<th>State</th>
									<th>Daemon</th>
									<th>Alive</th>
									<th>Interrupted</th>
									<th>&nbsp;</th>
								</tr>
							</thead>
							<tbody>
							<%
							JSONArray threadStatusList = threadStatus.optJSONArray("threadList");
							for(int inx=0; threadStatusList!=null && inx < threadStatusList.length(); inx++) {
							%>
								<%
								JSONObject thread = threadStatusList.optJSONObject(inx);
								%>
								<tr>
									<td><%=inx + 1 %></td>
									<td><%=thread.optString("group") %></td>
									<td><%=thread.optString("name") %></td>
									<td><%=thread.optString("tid") %></td>
									<td><%=thread.optString("priority") %></td>
									<td><%=thread.optString("state") %></td>
									<td><%=thread.optBoolean("daemon", false) ? "Daemom" : "User" %></td>
									<td><%=thread.optBoolean("alive", false) ? "Alive" : "Stop" %></td>
									<td><%=thread.optBoolean("interrupt", false) ? "Interrupted" : "-" %></td>
									<td><a href="javascript:toggle(<%=thread.optString("tid") %>)">Stacktrace</a></td>
								</tr>
								<tr id="st-<%=thread.optString("tid") %>" class="stacktrace">
									<td>&nbsp;</td>
									<td colspan = "9"><pre><%=thread.optString("stacktrace") %></pre></td>
								</tr>
							<%
							}
							%>
							</tbody>
						</table>
						</div>
					</div>
				</div>
				<%
				}//system is active
				%>
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>