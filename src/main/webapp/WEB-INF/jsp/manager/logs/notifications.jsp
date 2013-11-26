<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="
org.json.JSONObject,
org.json.JSONArray
"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.."/>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
</head>
<%
int totalSize = 1;
int totalPage = 1;
int pageNum = 1;
int rowSize = 15;
int pageSize = 10;
int rowStarts = 1;
int rowFinish = 15;
int pageStarts = 1;
int pageFinish = 1;
JSONArray notificationList = null;

try {
	JSONObject notifications = (JSONObject)request.getAttribute("notifications");
	totalSize = notifications.optInt("totalSize",totalSize);
	pageNum = notifications.optInt("pageNum", pageNum);
	rowSize = notifications.optInt("rowSize", rowSize);
	pageSize = notifications.optInt("pageSize", pageSize);
	totalPage = totalSize / rowSize + 1;
	rowStarts = notifications.optInt("rowStarts", rowStarts);
	rowFinish = notifications.optInt("rowFinish", rowFinish);
	notificationList = notifications.optJSONArray("notifications");
	pageStarts = (pageNum-1) - ((pageNum-1) % pageSize)+1;
	pageFinish = pageStarts + (pageSize-1);
	if(pageFinish > totalPage) {
		pageFinish = totalPage;
	}
} catch (Exception e) {
}

%>
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
				<div class="tab-pane active" id="tab_message_list">
					<div class="col-md-12">
					<div class="widget box">
						<div class="widget-content no-padding">
							<div class="dataTables_header clearfix">
								<div class="col-md-12">
									<span>Rows <%=rowStarts %> - <%=rowFinish %> of <%=totalSize %></span>
									<div class="btn-group pull-right">
										<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&laquo;</a>
										<% for(int pageInx=pageStarts;pageInx <=pageFinish; pageInx++) { %>
										<a href="javascript:void(0);" class="btn btn-sm <%=pageInx==pageNum?"btn-primary":"" %>" rel="tooltip"><%=pageInx %></a>
										<% } %>
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
									<%
									for(int inx=0;notificationList!=null && inx < notificationList.length(); inx++) {
									%>
										<%
										JSONObject record = notificationList.optJSONObject(inx);
										%>
										<tr>
											<td><%=record.optInt("id") %></td>
											<td><%=record.optString("regtime") %></td>
											<td><%=record.optString("node") %></td>
											<td><%=record.optString("messageCode") %></td>
											<td><%=record.optString("message") %></td>
										</tr>
									<%
									}
									%>
								</tbody>
							</table>
<!--
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
-->
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