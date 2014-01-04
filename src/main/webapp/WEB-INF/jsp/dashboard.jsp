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
				
				console.log(data);
				
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
								<table class="table table-bordered table-hover">
									<thead>
										<tr>
											<th>Collection</th>
											<th>Documents</th>
											<th>Disk Size</th>
											<th>Update Time</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>VOL</td>
											<td>1500</td>
											<td>128.5MB</td>
											<td>2013-09-10 12:00:05</td>
										</tr>
										<tr>
											<td>BOOK</td>
											<td>45000</td>
											<td>3128.5MB</td>
											<td>2013-09-11 16:00:05</td>
										</tr>
										<tr>
											<td>COMMUNITY_ETC</td>
											<td>45000</td>
											<td>3128.5MB</td>
											<td>2013-09-11 16:00:05</td>
										</tr>
										<tr>
											<td>BOOK_SHORT</td>
											<td>45000</td>
											<td>3128.5MB</td>
											<td>2013-09-11 16:00:05</td>
										</tr>
										<tr>
											<td>SAMPLE</td>
											<td>45000</td>
											<td>3128.5MB</td>
											<td>2013-09-11 16:00:05</td>
										</tr>
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
								<table class="table table-hover table-bordered">
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
										<tr>
											<td>VOL</td>
											<td>Sucess</td>
											<td>1500</td>
											<td>1h 20m 20s</td>
											<td>20 mins ago</td>
										</tr>
										<tr>
											<td>BOOK</td>
											<td>Sucess</td>
											<td>1500</td>
											<td>1h 20m 20s</td>
											<td>20 mins ago</td>
										</tr>
										<tr>
											<td>COMMUNITY_ETC</td>
											<td>Fail</td>
											<td>1500</td>
											<td>1h 20m 20s</td>
											<td>20 mins ago</td>
										</tr>
										<tr>
											<td>BOOK_SHORT</td>
											<td>Sucess</td>
											<td>1500</td>
											<td>1h 20m 20s</td>
											<td>20 mins ago</td>
										</tr>
										<tr>
											<td>SAMPLE</td>
											<td>Fail</td>
											<td>1500</td>
											<td>1h 20m 20s</td>
											<td>20 mins ago</td>
										</tr>
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
								<table class="table table-bordered table-hover">
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
										<tr>
											<td>1</td>
											<td>Node1</td>
											<td>localhost</td>
											<td>8090</td>
											<td>Alive</td>
											<td>81.6% (193968MB / 237655MB)</td>
											<td>10%</td>
											<td>50%</td>
											<td>41.6% (433MB / 1040MB)</td>
											<td>8192MB</td>
											<td>1.7</td>
										</tr>
										<tr>
											<td>2</td>
											<td>Node2</td>
											<td>192.168.0.30</td>
											<td>8090</td>
											<td>Alive</td>
											<td>80.5% (192532MB / 237655MB)</td>
											<td>20%</td>
											<td>40%</td>
											<td>35.6% (417MB / 1040MB)</td>
											<td>8192MB</td>
											<td>1.5</td>
										</tr>
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
											
										<tr>
											<td class="">community_etc컬렉션의 FULL색인이 실패하였습니다.</td>
											<td>10 min ago</td>
										</tr>
										<tr>
											<td class="">community_etc컬렉션의 FULL색인이 Manual실행되었습니다.</td>
											<td>8 min ago</td>
										</tr>
										<tr>
											<td class="">community_etc컬렉션의 FULL색인이 실패하였습니다.</td>
											<td>6 min ago</td>
										</tr>
										<tr>
											<td class="">community_etc컬렉션의 FULL색인이 Manual실행되었습니다.</td>
											<td>5 min ago</td>
										</tr>
										<tr>
											<td class="">community_etc컬렉션의 FULL색인이 실패하였습니다.</td>
											<td>3 min ago</td>
										</tr>
										
				
			
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
								<table class="table table-bordered table-checkable table-hover">
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







