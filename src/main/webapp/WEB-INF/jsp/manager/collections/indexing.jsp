<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>

<%
	//String collectionId = (String) request.getAttribute("collectionId");
	JSONObject indexingStatus = (JSONObject) request.getAttribute("indexingStatus");
	JSONArray shardStatusList = indexingStatus.getJSONArray("shardStatus");
%>


<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />

<script>
$(document).ready(function(){
	
	$('#indexing_tab a[href!="#tab_indexing_run"]').on('show.bs.tab', function (e) {
		stopPollingIndexTaskState();
	});
	$('#indexing_tab a[href="#tab_indexing_run"]').on('show.bs.tab', function (e) {
		startPollingIndexTaskState('${collectionId}');
	});
});
</script>


</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="${collectionId}" />
			<c:param name="scat" value="indexing" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Indexing</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Indexing</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<div class="tabbable tabbable-custom tabbable-full-width ">
					<ul class="nav nav-tabs" id="indexing_tab">
						<li class="active"><a href="#tab_indexing_status" data-toggle="tab">Status</a></li>
						<li class=""><a href="#tab_indexing_schedule" data-toggle="tab">Schedule</a></li>
						<li class=""><a href="#tab_indexing_run" data-toggle="tab">Run</a></li>
						<li class=""><a href="#tab_indexing_history" data-toggle="tab">History</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_indexing_status">
							<div class="col-md-12">
							
								<div class="widget ">
									<div class="widget-header">
										<h4>Data Status</h4>
									</div>
									<div class="widget-content">
										<dl class="dl-horizontal">
											<dt>Total Document Size</dt>
											<dd><%=indexingStatus.getInt("totalDocumentSize") %></dd>
											<dt>Total Disk Size</dt>
											<dd><%=indexingStatus.getString("totalDiskSize") %></dd>
										</dl>
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>Shard</th>
													<th>Sequence</th>
													<th>Document Size</th>
													<th>Disk Size</th>
													<th>Create Time</th>
												</tr>
											</thead>
											<tbody>
												<%
												for(int i =0;i<shardStatusList.length();i++){
													JSONObject obj = shardStatusList.getJSONObject(i);
												%>
												<tr>
													<td><strong><%=obj.getString("id") %></strong></td>
													<td><%=obj.getInt("sequence") %></td>
													<td><%=obj.getInt("documentSize") %></td>
													<td><%=obj.getString("diskSize") %></td>
													<td><%=obj.getString("createTime") %></td>
												</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						<div class="tab-pane" id="tab_indexing_schedule">
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Full Indexing</h4>
									</div>
									<div class="widget-content">
										<div class="row form-horizontal">
											<div class="col-md-12">
												<div class="form-group">
													<label class="col-md-2 control-label">Scheduled:</label>
													<div class="col-md-10">
														<div class="make-switch">
															<input type="checkbox" checked="true">
														</div>
													</div>
												</div>
												
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Base Date:</label>
													<div class="col-md-10">
														<input type="text" class="fc_datepicker form-control input-width-small" placeholder="Date">
														<input type="text" class="fc_timepicker form-control input-width-small" placeholder="Time">
													</div>
												</div>
													
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Period:</label>
													<div class="col-md-10">
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" >
  															<span class="input-group-addon">Hr</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" >
															<span class="input-group-addon">Min</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										
									</div>
								</div> <!-- /.widget -->
								
								<div class="widget">
									<div class="widget-header">
										<h4>Add Indexing</h4>
									</div>
									<div class="widget-content">
										<div class="row form-horizontal">
											<div class="col-md-12">
												<div class="form-group">
													<label class="col-md-2 control-label">Scheduled:</label>
													<div class="col-md-10">
														<div class="make-switch">
															<input type="checkbox" checked="true">
														</div>
													</div>
												</div>
												
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Base Date:</label>
													<div class="col-md-10">
														<input type="text" class="fc_datepicker form-control input-width-small" placeholder="Date">
														<input type="text" class="fc_timepicker form-control input-width-small" placeholder="Time">
													</div>
												</div>
													
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Period:</label>
													<div class="col-md-10">
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" >
  															<span class="input-group-addon">Hr</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" >
															<span class="input-group-addon">Min</span>
														</div>
													</div>
												</div>
											</div>
										</div>
										
									</div>
								</div> <!-- /.widget -->
								
								<div class="form-actions">
									<input type="submit" value="Update Schedule" class="btn btn-primary ">
								</div>
							</div>
						</div>
						
						
						<div class="tab-pane" id="tab_indexing_run">
						
						
							<div class="col-md-12">
								
								<div class="widget ">
									<div class="widget-header">
										<h4>Collection Indexing</h4>
									</div>
									<div class="widget-content">
										<div class="row">
											<div class=" col-md-12">
												<a href="javascript:runFullIndexing('${collectionId}');" class="btn btn-sm"><span
													class="glyphicon glyphicon-play"></span> Run Full Indexing</a>
													&nbsp;
												<a href="javascript:runAddIndexing('${collectionId}');" class="btn btn-sm"><span
													class="glyphicon glyphicon-play"></span> Run Add Indexing</a>
													&nbsp;
												<a href="javascript:stopIndexing('${collectionId}');" class="btn btn-sm btn-danger">
													<span class="glyphicon glyphicon-stop"></span> Stop Indexing</a>
											</div>
										</div>
									</div>
								</div>
								<div class="widget ">
									<div class="widget-header">
										<h4>Running Indexing Tasks</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>Type</th>
													<th>State</th>
													<th>Document Count</th>
													<th>Schedule</th>
													<th>Start</th>
													<th>Duration</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><div id="indexing_type"></div></td>
													<td><div id="indexing_state"></div></td>
													<td><div id="indexing_document_count"></div></td>
													<td><div id="indexing_scheduled"></div></td>
													<td><div id="indexing_start_time"></div></td>
													<td><div id="indexing_elapsed"></div></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							
							</div>
	
						</div>
						
						<div class="tab-pane" id="tab_indexing_history">
							<div class="col-md-12">
								<div class="widget box">
									<div class="widget-content no-padding">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>#</th>
													<th>Shard</th>
													<th>Status</th>
													<th>Insert Size</th>
													<th>Schedule</th>
													<th>Start</th>
													<th>Finish</th>
													<th>Duration</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>10</td>
													<td>*<strong>VOL</strong></td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>9</td>
													<td>VOL1</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>8</td>
													<td>VOL2</td>
													<td><span class="label label-danger"><i class="glyphicon glyphicon-warning-sign"></i> Fail</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>7</td>
													<td>VOL2011</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>6</td>
													<td>VOL2012</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>5</td>
													<td>VOL2013</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>4</td>
													<td>*<strong>VOL</strong></td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>3</td>
													<td>VOL1</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>2</td>
													<td>VOL2</td>
													<td><span class="label label-danger"><i class="glyphicon glyphicon-warning-sign"></i> Fail</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
												<tr>
													<td>1</td>
													<td>VOL2011</td>
													<td><span class="label label-success"><i class="glyphicon glyphicon-ok"></i> Sucess</span></td>
													<td>1500</td>
													<td><span class="label label-default">Scheduled</span></td>
													<td>2013.09.05 12:40:00</td>
													<td>2013.09.05 12:50:00</td>
													<td>1h 20m 20s</td>
												</tr>
											</tbody>
										</table>
										<div class="table-footer">
											<div class="col-md-12">
											Rows 1 - 10 of 200 
											<ul class="pagination">
												<li class="disabled"><a href="javascript:void(0);">&laquo;</a></li>
												<li class="active"><a href="javascript:void(0);">1</a></li>
												<li><a href="javascript:void(0);">2</a></li>
												<li><a href="javascript:void(0);">3</a></li>
												<li><a href="javascript:void(0);">4</a></li>
												<li><a href="javascript:void(0);">5</a></li>
												<li><a href="javascript:void(0);">&raquo;</a></li>
											</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<!-- /.tab-content -->
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>