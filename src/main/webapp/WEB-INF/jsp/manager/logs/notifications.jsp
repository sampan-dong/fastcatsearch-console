<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.."/>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){
	loadNotificationTab(1, "#tab_message_list");
});

function loadMessage(uid) {
	$.ajax({
		url : CONTEXT+"/manager/logs/notificationInfo.html",
		data : {id:uid},
		
		dataType : "text",
		success : function(response) {
			$('#tab_message_detail').html(response);
		}
	});
}
</script>
</head>
<body>
<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
<div id="container">
	<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
		<c:param name="lcat" value="logs" />
		<c:param name="mcat" value="notifications" />
	</c:import>
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
				<div class="tab-pane active" id="tab_message_list"></div>
				
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