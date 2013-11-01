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
<script>
$(document).ready(function(){

	// Sample Data
	var data_server_load = [];
	var data_used_ram    = [];

	// Random data for "Server load"
	for (var x = 0; x < 200; x+=5) {
		var y = Math.floor( 50 - 15 + Math.random() * 30 );
		data_server_load.push([x, y]);
	}

	// Random data for "Used RAM"
	function getRandomData() {
		if (data_used_ram.length > 0)
			data_used_ram = data_used_ram.slice(1);

		// do a random walk
		while (data_used_ram.length < 200) {
			var prev = data_used_ram.length > 0 ? data_used_ram[data_used_ram.length - 1] : 50;
			var y = prev + Math.random() * 10 - 5;
			if (y < 0)
			y = 0;
			if (y > 100)
			y = 100;
			data_used_ram.push(y);
		}

		// zip the generated y values with the x values
		var res = [];
		for (var i = 0; i < data_used_ram.length; ++i)
		res.push([i, data_used_ram[i]])
		return res;
	}

	var series_multiple = [
		{
			label: "Used RAM",
			data: getRandomData(),
			color: App.getLayoutColorCode('red'),
			lines: {
				fill: true
			},
			points: {
				show: false
			}
		},{
			label: "Server load",
			data: data_server_load,
			color: App.getLayoutColorCode('blue')
		}
	];

	// Initialize flot
	var plot = $.plot("#chart_multiple", series_multiple, $.extend(true, {}, Plugins.getFlotDefaults(), {
		series: {
			lines: { show: true },
			points: { show: true },
			grow: { active: true }
		},
		grid: {
			hoverable: true,
			clickable: true
		},
		tooltip: true,
		tooltipOpts: {
			content: '%s: %y'
		}
	}));

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

				<div class="row">
				<div class="col-md-12">
					<div class="widget box">
						<div class="widget-header">
							<h4><i class="icon-reorder"></i> System</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12">
									<div id="chart_multiple" class="chart"></div>
								</div>
							</div>
						</div>
						<div class="divider"></div>
						<div class="widget-content">
							<ul class="stats no-dividers">
								<li class="circular-chart-inline">
									<div class="circular-chart" data-percent="27" data-size="90">27%</div>
									<span class="description">Server Load</span>
								</li>
								<li class="circular-chart-inline">
									<div class="circular-chart" data-percent="75" data-size="90" data-bar-color="#e25856">75%</div>
									<span class="description">Used RAM</span>
								</li>
								<li class="circular-chart-inline">
									<div class="circular-chart" data-percent="10" data-size="90" data-bar-color="#8fc556">281 MB</div>
									<span class="description">Space</span>
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
								<h4><i class="icon-reorder"></i> Engine Information</h4>
							</div>
							<div class="widget-content">
								<div class="row">
									<dl class="dl-horizontal">
										<dt>Install Path</dt>
										<dd>/home/fastcatsearch/fastcatsearch2</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
					<div class="col-md-6">
						<div class="widget box">
							<div class="widget-header">
								<h4><i class="icon-reorder"></i> JVM Information</h4>
							</div>
							<div class="widget-content">
								<div class="row">
									<dl class="dl-horizontal">
										<dt>JVM Path</dt>
										<dd>/home/jvm</dd>
										<dt>JVM Version</dt>
										<dd>1.7</dd>
										<dt>JVM Options </dt>
										<dd>-Xmx5g -server</dd>
									</dl>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
				<div class="col-md-6">
					<div class="widget box">
						<div class="widget-header">
							<h4><i class="icon-reorder"></i> Service Module</h4>
						</div>
						<div class="widget-content">
							<table class="table table-hover ">
								<tr>
									<td>IRService</td>
									<td>Running</td>
								</tr>
								<tr>
									<td>DBService</td>
									<td>Running</td>
								</tr>
								<tr>
									<td>XXXService</td>
									<td>Stop</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
				</div>
						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>