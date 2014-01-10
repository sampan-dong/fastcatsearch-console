<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%
	JSONArray collectionList = (JSONArray) request.getAttribute("collectionList");
%>

<c:set var="ROOT_PATH" value="../.." scope="request" />
<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
<script>


	$(document).ready(function() {
		
		var collectionList = ${collectionList};
		var totalPoints = 60;

		//초기셋팅.
		var collectionData = {};
		for( var i = 0; i < collectionList.length; i++ ){
			id = collectionList[i].id;
			var data = [];
			for(var j=0; j < totalPoints; j++){
				data.push([j, 0]);
			}
			collectionData[id] = {"data": data, "seq": i};
		}
		
		function pushData(id, value) {
			countArray = collectionData[id].data;
			countArray.shift();
			
			for (var i = 0; i < countArray.length; i++){
				countArray[i][0]--;
			}
			
			countArray.push([countArray.length, value]);
		}
		
		
		var series_multiple = [];
		
		for( var i = 0; i < collectionList.length; i++ ){
			id = collectionList[i].id;
			series_multiple.push({"label": id, "data": collectionData[id].data });
		}
		
		
		// Initialize flot
		var plot = $.plot("#chart_multiple", series_multiple, $.extend(true, {}, Plugins.getFlotDefaults(), {
			series: {
				lines: { lineWidth: 1.5, show: true },
				points: { show: false },
				grow: { active: false }
			},
			grid: {
				hoverable: true,
				clickable: true
			},
			tooltip: true,
			tooltipOpts: {
				content: '%y'
			},
			yaxis: {
				min: 0,
				minTickSize:1,
				tickDecimals: 0
			},
			legend: {
				position: "nw"
			}
		}));
		
		function update() {
			requestSyncProxy("get", {uri:"/management/common/realtime-query-count.json"}, "json", function(data){
				for( var i = 0; i < collectionList.length; i++ ){
					id = collectionList[i].id;
					if(data != 'undefined'){
						count = data[id];
						if(count != 'undefined'){
							pushData(id, count);
						}else{
							pushData(id, 0);
						}
					}else{
						pushData(id, 0);
					}
				}
				
				plot.setData(series_multiple);
				plot.setupGrid();
				plot.draw();
			});
		}
		setInterval(update, 1000);
		
		var fnRefreshCollectionInfo = function() {
			requestProxy("post", {
					uri:"/management/collections/collection-info-list"
				}, "json", function(collectionInfoListData) {
					var collectionInfoList = collectionInfoListData["collectionInfoList"];
					
					var table1 = $("#collection_info_table");
					var table2 = $(document.createElement("table"));
					for(var inx=0;inx < collectionInfoList.length; inx++) {
						var info = collectionInfoList[inx];
						appendTableRecord(table2, Array(
								info["name"]+" ("+info["id"]+")"
							,info["documentSize"]
							,info["diskSize"]
							,info["createTime"]
						));
					}
					table1.find("tbody").html(table2.find("tbody").html());
				});
		}
		fnRefreshCollectionInfo();
		
		var fnRefreshIndexinInfoList = function() {
			requestProxy("post", {
					uri:"/management/collections/collection-indexing-info-list"
				}, "json", function(indexingInfoListData) {
					var indexingInfoList = indexingInfoListData["indexingInfoList"];
					var table1 = $("#indexing_info_table");
					var table2 = $(document.createElement("table"));
					
					for(var inx=0;inx < indexingInfoList.length; inx++) {
						var info = indexingInfoList[inx];
						if(info["time"]) {
							info["time"]=info["time"]+" ago";
						}
						appendTableRecord(table2, Array(
							 info["id"]
							,info["status"]
							,info["docSize"]
							,info["duration"]
							,info["time"]
						));
					}
					table1.find("tbody").html(table2.find("tbody").html());
				});
		}
		fnRefreshIndexinInfoList();
		
		var fnRefreshSystemInfo = function() {
		
			requestProxy("post", {
					uri:"/management/servers/list"
				}, "json", function(nodeList) {
					nodeList = nodeList["nodeList"];
					requestProxy("post", {
							uri:"/management/servers/systemHealth"
						}, "json", function(health) {
							
							var table1 = $("#system_info_table");
							var table2 = $(document.createElement("table"));
							
							for(var inx=0; inx < nodeList.length ; inx++) {
								var node = nodeList[inx];
								var nodeId = node["id"];
								var info = health[nodeId];
								var diskPrint = "";
								var memoryPrint = "";
								if(info) {
									diskPrint = info["totalDiskSize"];
									if(diskPrint > 0) {
										diskPrint = Math.round(info["usedDiskSize"] / diskPrint * 10000) / 100;
										diskPrint = diskPrint+"% ("+info["usedDiskSize"]+"MB / "+info["totalDiskSize"]+"MB)";
									}
									memoryPrint = info["maxMemory"];
									if(memoryPrint > 0) {
										memoryPrint = Math.round(info["usedMemory"] / memoryPrint * 10000) / 100;
										memoryPrint = memoryPrint+"% ("+info["usedMemory"]+"MB / "+info["maxMemory"]+"MB)";
									}
									info["jvmCpuUse"]+="%";
									info["systemCpuUse"]+="%";
									info["totalMemory"]+="MB";
								} else {
									info = {jvmCpuUse:"",systemCpuUse:"",totalMemory:"",systemLoadAverage:""};
								}
								appendTableRecord(table2, Array(
									inx + 1
									,node["name"]
									,node["host"]
									,node["port"]
									,(node["active"]==true?"Alive":"Gone")
									,diskPrint
									,info["jvmCpuUse"]
									,info["systemCpuUse"]
									,memoryPrint
									,info["totalMemory"]
									,info["systemLoadAverage"]
								));
							}
							table1.find("tbody").html(table2.find("tbody").html());
						});
				});
		}
		fnRefreshSystemInfo();
		
		var fnRefreshLog = function() {
			requestProxy("post", {
					uri:"/management/logs/notification-history-list",
					start:0, end:5
				}, "json", function(notificationData) {
					var table1 = $("#log_table");
					var table2 = $(document.createElement("table"));
					
					var notifications = notificationData["notifications"];
					for(var inx=0;inx<notifications.length;inx++) {
						var time = notifications[inx]["regtime"];
						appendTableRecord(table2, Array(
							notifications[inx]["message"], 
							time
						));
					}
					table1.find("tbody").html(table2.find("tbody").html());
				});
		}
		fnRefreshLog();
		
		var fnRefreshTaskInfo = function() {
			
			requestProxy("post", {
					uri:"/management/common/all-task-state",
					start:0, end:5
				}, "json", function(taskInfo) {
					var table1 = $("#task_info_table");
					var table2 = $(document.createElement("table"));
					
					table1.find("tbody").html(table2.find("tbody").html());
				});
		}
		fnRefreshTaskInfo();
		
	});
</script>
</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> <a href="javascript:void(0);">Dashboard</a>
						</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Dashboard</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<!--=== Page Content ===-->
				<div class="row">
					<div class="col-md-12">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Realtime Query Request</h4>
							</div>
							<div class="widget-content">
								<div id="chart_multiple" class="chart chart-medium"></div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Collections</h4>
								<div class="toolbar no-padding">
									<div class="btn-group">
										<span class="btn btn-xs"><i class="icon-external-link"></i></span>
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="collection_info_table" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>Collection</th>
											<th>Documents</th>
											<th>Disk Size</th>
											<th>Update Time</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!-- /.widget-content -->
						</div> <!-- /.widget -->
					</div>
					
					
					<div class="col-md-6">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Indexing Result</h4>
							</div>
							<div class="widget-content no-padding">
								<table id="indexing_info_table" class="table table-hover table-bordered">
									<thead>
										<tr>
											<th>Collection</th>
											<th>Status</th>
											<th>Documents</th>
											<th>Duration</th>
											<th>Time</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!-- /.widget-content -->
						</div> <!-- /.widget -->
					</div>
					
				</div>
				
				<div class="row">
					<div class="col-md-12">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Server Status</h4>
								<div class="toolbar no-padding">
									<div class="btn-group">
										<span class="btn btn-xs"><i class="icon-external-link"></i></span>
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="system_info_table" class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th>Server Name</th>
											<th>IP Address</th>
											<th>Port</th>
											<th>Status</th>
											<th>Disk</th>
											<th>Java CPU</th>
											<th>System CPU</th>
											<th>Java Memory</th>
											<th>System Memory</th>
											<th>Load</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!-- /.widget-content -->
						</div> <!-- /.widget -->
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-6">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Notifications</h4>
								<div class="toolbar no-padding">
									<div class="btn-group">
										<span class="btn btn-xs"><i class="icon-external-link"></i></span>
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="log_table" class="table table-hover table-bordered">
									<thead>
										<tr>
											<th>Message</th>
											<th>Time</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!-- /.widget-content -->
						</div> <!-- /.widget -->
					</div>
					
				
					<div class="col-md-6">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> Running Tasks</h4>
								<div class="toolbar no-padding">
									<div class="btn-group">
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="task_info" class="table table-bordered table-checkable table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th>Task Name</th>
											<th>Status</th>
											<th>Start Time</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>1</td>
											<td>Indexing</td>
											<td>[Sample] collection full indexing manually 420000 documents ..</td>
											<td>4.5 hours ago</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Indexing</td>
											<td>[Vol] collection add indexing manually 20000 documents ..</td>
											<td>1.5 hours ago</td>
										</tr>
									</tbody>
								</table>
							</div> <!-- /.widget-content -->
						</div> <!-- /.widget -->
					</div>
				
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>







