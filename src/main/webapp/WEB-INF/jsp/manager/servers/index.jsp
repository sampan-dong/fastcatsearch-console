<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.task .percent {
float: right;
display: inline-block;
color: #adadad;
font-size: 11px;
}
</style>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp" />
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Servers</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Servers</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="input-group col-md-12">
								<a href="javascript:void(0);" class="btn btn-sm"><span
									class="glyphicon glyphicon-plus-sign"></span> Add Server</a>
									&nbsp;
								<a href="javascript:void(0);" class="btn btn-sm">
									<span class="glyphicon glyphicon-minus-sign"></span> Remove Server
								</a>
									&nbsp;
								<a href="javascript:void(0);" class="btn btn-sm">
									<span class="glyphicon glyphicon-edit"></span> Edit Server
								</a>
								<span class="pull-right">
								<a href="javascript:void(0);" class="btn btn-sm btn-primary">
									<span class="glyphicon glyphicon-ok"></span> Save Changes
								</a>
								</span>
							</div>
							
						</div>
						<table class="table table-hover table-bordered table-checkable">
							<thead>
								<tr>
									<th class="checkbox-column">
										<input type="checkbox" class="uniform">
									</th>
									<th>ID</th>
									<th>Name</th>
									<th>IP Address</th>
									<th>Port</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>node1</strong></td>
									<td>node1</td>
									<td>192.168.0.11</td>
									<td>9090</td>
									<td><span class="text-primary"><span class="glyphicon glyphicon-ok-sign"></span> Alive</span></td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>node2</strong></td>
									<td>node2</td>
									<td>192.168.0.12</td>
									<td>9090</td>
									<td><span class="text-primary"><span class="glyphicon glyphicon-ok-sign"></span> Alive</span></td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>node3</strong></td>
									<td>node3</td>
									<td>192.168.0.13</td>
									<td>9090</td>
									<td><span class="text-danger"><span class="glyphicon glyphicon-warning-sign"></span> Fail</span></td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>node4</strong></td>
									<td>node4</td>
									<td>192.168.0.14</td>
									<td>9090</td>
									<td><span class="text-primary"><span class="glyphicon glyphicon-ok-sign"></span> Alive</span></td>
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