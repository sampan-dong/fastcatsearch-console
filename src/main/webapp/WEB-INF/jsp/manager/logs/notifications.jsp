<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.."/>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
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
				<li><i class="icon-home"></i> Manager
				</li>
				<li class="current"> Logs
				</li>
				<li class="current"> Notifications
				</li>
			</ul>

		</div>
		<!-- /Breadcrumbs line -->

		<!--=== Page Header ===-->
		<div class="page-header">
			<div class="page-title">
				<h3>Notifications</h3>
			</div>
		</div>
		<!-- /Page Header -->
		
		<!--=== Page Content ===-->
		<div class="tabbable tabbable-custom tabbable-full-width">
			<ul class="nav nav-tabs">
				<li class="active"><a href="#tab_message_list" data-toggle="tab">List</a></li>
				<li class=""><a href="#tab_message_alert_settings" data-toggle="tab">Alert Settings</a></li>
			</ul>
			<div class="tab-content row">

				<!--=== Overview ===-->
				<div class="tab-pane active" id="tab_message_list">
					<div class="col-md-12">
					<div class="widget box">
						<div class="widget-content no-padding">
							<div class="dataTables_header clearfix">
								<div class="col-md-12">
									<span>Rows 1 - 15 of 2809</span>
									<div class="btn-group pull-right">
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&laquo;</a>
										<a href="javascript:void(0);" class="btn btn-sm btn-primary" rel="tooltip">1</a>
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">2</a>
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">3</a>
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">4</a>
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">5</a>
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&raquo;</a>
									</div>
								</div>
								
							</div>
							<table id="log_table" class="table table-hover table-bordered table-condensed table-checkable">
								<thead>
									<tr>
										<th>#</th>
										<th>Time</th>
										<th>Node</th>
										<th>Code</th>
										<th>Message</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>15</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>14</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>13</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>12</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>11</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>10</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>9</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>8</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>7</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>6</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>5</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>4</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>3</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>2</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
									<tr>
										<td>1</td>
										<td>2013-09-10 12:35:00</td>
										<td>node1</td>
										<td>FC-100</td>
										<td>Collection [sample] is not indexed.</td>
									</tr>
								</tbody>
							</table>
							
							<div class="table-footer">
								<dl class="dl-horizontal col-md-12">
									<dt>Time</dt>
									<dd>2013-09-10 12:35:00</dd>
									<dt>Node</dt>
									<dd>node1</dd>
									<dt>Code</dt>
									<dd>FC-100</dd>
									<dt>Message</dt>
									<dd><div class="panel">
									Collection [sample] is not indexed.angwook-ui-MacBook-Air.local UserEventAgent[139] <Error>: cannot find fw daemon port 1102
	Jun 27 08:51:58 sangwook-ui-MacBook-Air.local UserEventAgent[140] <Error>: cannot find fw daemon port 1102
	Jun 27 09:05:31 sangwook-ui-MacBook-Air.local UserEventAgent[139] <Error>: cannot find fw daemon port 1102
	Jul  1 09:45:45 sangwook-ui-MacBook-Air.local UserEventAgent[145] <Error>: cannot find fw daemon port 1102
	Jul  8 08:01:55 sangwook-ui-MacBook-Air.local UserEventAgent[126] <Error>: cannot find useragent 1102
	Jul  8 08:02:01 local UserEventAgent[139] <Error>: cannot find fw daemon port 1102
	Jun 27 08:51:58 sangwook-ui-MacBook-Air.local UserEventAgent[140] <Error>: cannot find fw daemon port 1102
	Jun 27 09:05:31 sangwook-ui-MacBook-Air.local UserEventAgent[139] <Error>: cannot find fw daemon port 1102
	Jul  1 09:45:45 sangwook-ui-MacBook-Air.local UserEventAgent[145] <Error>: cannot find fw daemon port 1102
	Jul  8 08:01:55 sangwook-ui-MacBook-Air.local UserEventAgent[126] <Error>: cannot find useragent 1102
	Jul  8 08:02:01 
									</div></dd>
								</dl>
							</div>
											
						</div>
					</div>
					</div>
				</div>
				
				<div class="tab-pane " id="tab_message_alert_settings">
					<div class="col-md-12">
						<div class="widget box">
							<div class="widget-content no-padding">
								<div class="dataTables_header clearfix">
									<div class="input-group col-md-12">
										<a href="javascript:void(0);" class="btn btn-sm"><span
											class="glyphicon glyphicon-plus-sign"></span> Add Alert</a>
											&nbsp;
										<a href="javascript:void(0);" class="btn btn-sm">
											<span class="glyphicon glyphicon-minus-sign"></span> Remove Alert
										</a>
											&nbsp;
										<a href="javascript:void(0);" class="btn btn-sm">
											<span class="glyphicon glyphicon-edit"></span> Edit Alert
										</a>
									</div>
								</div>
								<table class="table table-hover table-bordered table-checkable">
									<thead>
										<tr>
											<th class="checkbox-column">
												<input type="checkbox" class="uniform">
											</th>
											<th>Trigger Code</th>
											<th>Alert To</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="checkbox-column">
												<input type="checkbox" class="uniform">
											</td>
											<td><strong>FC-200</strong></td>
											<td>
												<div><span class="icon-envelope"> John Doe</span></div>
												<div><span class="icon-envelope"> Smith Black</span></div>
												<div><span class="icon-user"> John Doe</span></div>
											</td>
										</tr>
										<tr>
											<td class="checkbox-column">
												<input type="checkbox" class="uniform">
											</td>
											<td><strong>FC-100</strong></td>
											<td>
												<div><span class="icon-envelope"> John Doe</span></div>
												<div><span class="icon-user"> John Doe</span></div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					
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