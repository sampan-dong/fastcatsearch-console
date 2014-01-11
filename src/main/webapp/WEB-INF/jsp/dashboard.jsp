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
		var plot = $.plot("#chart_qps_bar", series_multiple, $.extend(true, {}, Plugins.getFlotDefaults(), {
			series: {
				stack: true,
				bars: {
					show: true,
					align: 'center',
					lineWidth: 0
				},
				lines: { show: false },
				points: { show: false },
				grow: { active: false }
			},
			grid: {
				hoverable: true,
				clickable: true
			},
			tooltip: true,
			tooltipOpts: {
				content: '%s : %y'
			},
			yaxis: {
				min: 0,
				minTickSize:1,
				tickDecimals: 0
			},
			legend: {
				position: "nw",
				noColumns: 10,
				container: $("#chart_legend")
			}
		}));
		
		var startTime = new Date().getTime();
		var rt_qps = 0;
		var total_time_elapsed = 0;
		var total_throughput = 0;
		function update() {
			requestSyncProxy("get", {uri:"/management/common/realtime-query-count.json"}, "json", function(data){
				rt_qps = 0;
				total_time_elapsed++;
				for( var i = 0; i < collectionList.length; i++ ){
					id = collectionList[i].id;
					if(data != 'undefined'){
						count = data[id];
						if(count){
							pushData(id, count);
							rt_qps += count;
							total_throughput += count;
						}else{
							pushData(id, 0);
						}
					}else{
						pushData(id, 0);
					}
				}
				
				var now = new Date().getTime();
				var diff = now - startTime;
				$("#rt_qps").text(rt_qps);
				$("#avg_qps").text(Math.round((total_throughput / total_time_elapsed) * 10) / 10);
				$("#time_elapsed").text(getTimeHumanReadableDigits(diff));
				$("#current_time").text(formatTime(new Date()));
				plot.setData(series_multiple);
				plot.setupGrid();
				plot.draw();
			});
		}
		setInterval(update, 1000);
		
		var fnRefreshCollectionInfo = function() {
			console.log("call refreshCollectionInfo");
			var table1 = $("#collection_info_table");
			requestProxy("post", {
					uri:"/management/collections/collection-info-list"
				}, "json", function(collectionInfoListData) {
					var collectionInfoList = collectionInfoListData["collectionInfoList"];
					
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
			return table1;
		}
		var table = fnRefreshCollectionInfo();
		table.parent().parent().find("span.btn-xs i.icon-external-link").click(function() {
			location.href=CONTEXT+"/manager/collections/index.html";
		});
		table.parent().parent().find("span.btn-xs i.icon-refresh").click(fnRefreshCollectionInfo);
		
		var fnRefreshIndexinInfoList = function() {
			console.log("call refreshIndexingInfo");
			var table1 = $("#indexing_info_table");
			requestProxy("post", {
					uri:"/management/collections/collection-indexing-info-list"
				}, "json", function(indexingInfoListData) {
					var indexingInfoList = indexingInfoListData["indexingInfoList"];
					var table2 = $(document.createElement("table"));
					
					for(var inx=0;inx < indexingInfoList.length; inx++) {
						var info = indexingInfoList[inx];
						if(info["duration"]) {
							info["duration"]=getTimeHumanReadable(info["duration"]*1,1,2);
						}
						if(info["time"]) {
							info["time"]=
								getTimeHumanReadable(new Date().getTime() - 
								parseDate(info["time"]).getTime(),1,2)+ " ago";
						}
						appendTableRecord(table2, Array(
							info["name"]+" ("+info["id"]+")"
							,info["status"]
							,info["docSize"]
							,info["duration"]
							,info["time"]
						));
					}
					table1.find("tbody").html(table2.find("tbody").html());
				});
			return table1;
		}
		var table = fnRefreshIndexinInfoList();
		table.parent().parent().find("span.btn-xs i.icon-refresh").click(fnRefreshIndexinInfoList);
		
		var fnRefreshSystemInfo = function() {
			console.log("call refreshSystemInfo");
			var table1 = $("#system_info_table");
			requestProxy("post", {
					uri:"/management/servers/list"
				}, "json", function(nodeList) {
					nodeList = nodeList["nodeList"];
					requestProxy("post", {
							uri:"/management/servers/systemHealth"
						}, "json", function(health) {
							
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
									systemLoadAverage = info["systemLoadAverage"];
									if(systemLoadAverage > 0) {
										systemLoadAverage = Math.round(info["systemLoadAverage"] * 10) / 10;
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
									,systemLoadAverage
								));
							}
							table1.find("tbody").html(table2.find("tbody").html());
						});
				});
			return table1;
		}
		var table = fnRefreshSystemInfo();
		table.parent().parent().find("span.btn-xs i.icon-external-link").click(function() {
			location.href=CONTEXT+"/manager/servers/overview.html";
		});
		table.parent().parent().find("span.btn-xs i.icon-refresh").click(fnRefreshSystemInfo);
		
		var fnRefreshLog = function() {
			console.log("call refreshLog");
			var table1 = $("#log_table");
			requestProxy("post", {
					uri:"/management/logs/notification-history-list",
					start:0, end:5
				}, "json", function(notificationData) {
					var table2 = $(document.createElement("table"));
					
					var notifications = notificationData["notifications"];
					for(var inx=0;inx<notifications.length;inx++) {
						var time1 = parseDate(notifications[inx]["regtime"]).getTime();
						var time2 = new Date().getTime();
						
						var time = getTimeHumanReadable(time2-time1,1);
						
						if(time) {
							time+=" ago";
						}
						
						appendTableRecord(table2, Array(
							notifications[inx]["message"], 
							time
						));
					}
					table1.find("tbody").html(table2.find("tbody").html());
				});
			return table1;
		}
		var table = fnRefreshLog();
		table.parent().parent().find("span.btn-xs i.icon-external-link").click(function() {
			location.href=CONTEXT+"/manager/logs/notifications.html";
		});
		table.parent().parent().find("span.btn-xs i.icon-refresh").click(fnRefreshLog);
		
		var fnRefreshTaskInfo = function() {
			console.log("call refreshTaskInfo");
			var table1 = $("#task_info_table");
			requestProxy("post", {
					uri:"/management/common/all-task-state",
					start:0, end:5
				}, "json", function(taskInfo) {
					var table2 = $(document.createElement("table"));
					
					var taskList = taskInfo["taskState"];
					for(var inx=0;inx<taskList.length;inx++) {
						var task = taskList[inx];
						appendTableRecord(table2, Array(
							inx+1
							,task["summary"]
							,task["elapsed"]
							,task["startTime"]
						));
					}
					
					table1.find("tbody").html(table2.find("tbody").html());
				});
			return table1;
		}
		var table = fnRefreshTaskInfo();
		table.parent().parent().find("span.btn-xs i.icon-external-link").click(function() {
			location.href=CONTEXT+"/manager/logs/tasks.html";
		});
		table.parent().parent().find("span.btn-xs i.icon-refresh").click(fnRefreshTaskInfo);
		
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
							<div class="widget-content" style="border-bottom: 1px solid #d9d9d9;">
								<div id="chart_legend"></div>
								<div id="chart_qps_bar" class="chart-medium fcol100"></div>
							</div>
							<div class="widget-content">
								<ul class="stats stats-sm"> <!-- .no-dividers -->
									<li>
										<strong id="current_time">&nbsp;</strong>
										<small>Current Time</small>
									</li>
									<li>
										<strong id="time_elapsed">&nbsp;</strong>
										<small>Time Elapsed</small>
									</li>
									<li>
										<strong id="avg_qps">0</strong>
										<small>Average QPS</small>
									</li>
									<li>
										<strong id="rt_qps">0</strong>
										<small>Realtime QPS</small>
									</li>
								</ul>
								
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
										<span class="btn btn-xs"><i class="icon-refresh"></i></span>
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
								<div class="toolbar no-padding">
									<div class="btn-group">
										<span class="btn btn-xs"><i class="icon-refresh"></i></span>
									</div>
								</div>
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
										<span class="btn btn-xs"><i class="icon-refresh"></i></span>
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
										<span class="btn btn-xs"><i class="icon-refresh"></i></span>
										<span class="btn btn-xs"><i class="icon-external-link"></i></span>
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="log_table" class="table table-hover table-bordered">
									<thead>
										<tr>
											<th>Message</th>
											<th class="fcol2">Time</th>
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
										<span class="btn btn-xs"><i class="icon-refresh"></i></span>
										<span class="btn btn-xs"><i class="icon-external-link"></i></span>
									</div>
								</div>
							</div>
							<div class="widget-content no-padding">
								<table id="task_info_table" class="table table-bordered table-checkable table-hover">
									<thead>
										<tr>
											<th>#</th>
											<th>Task</th>
											<th>Elapsed</th>
											<th>Start Time</th>
										</tr>
									</thead>
									<tbody>
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







