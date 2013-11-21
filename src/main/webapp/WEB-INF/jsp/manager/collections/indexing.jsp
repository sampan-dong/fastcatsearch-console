<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="org.jdom2.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>

<%
	JSONObject indexingStatus = (JSONObject) request.getAttribute("indexingStatus");
	JSONObject indexingResult = (JSONObject) request.getAttribute("indexingResult");
	Document indexingSchedule = (Document) request.getAttribute("indexingSchedule");
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
		$('#autoUpdate').attr('checked', false);
	});
	$('#indexing_tab a[href="#tab_indexing_run"]').on('show.bs.tab', function (e) {
		startPollingIndexTaskState('${collectionId}', false); //한번만 보여준다.
	});
	
	//load history tab contents
	$('#indexing_tab a[href="#tab_indexing_history"]').on('shown.bs.tab', function (e) {
		loadToTab('indexing/history.html', {}, '#tab_indexing_history');
	});
	
	
	$('#autoUpdate').on("change", function(){
		if($(this).is(':checked')){
			console.log("start!");
			startPollingIndexTaskState('${collectionId}', true);
		}else{
			console.log("stop!");
			stopPollingIndexTaskState();
		}
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
										<h4>Index Data Status</h4>
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
													<th>Documents</th>
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
								
								<div class="widget ">
									<div class="widget-header">
										<h4>Indexing Result</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>Type</th>
													<th>Result</th>
													<th>Scheduled</th>
													<th>Documents</th>
													<th>Inserts</th>
													<th>Updates</th>
													<th>Deletes</th>
													<th>Start</th>
													<th>End</th>
													<th>Duration</th>
												</tr>
											</thead>
											<tbody>
												<%
												if(indexingResult.has("FULL")){
													JSONObject fullIndexingResult = indexingResult.getJSONObject("FULL");
												%>
												<tr>
													<td><strong>FullIndexing</strong></td>
													<% if(fullIndexingResult != null) { %> 
													<td><%=fullIndexingResult.getString("status") %></td>
													<td><%=fullIndexingResult.getString("isScheduled") %></td>
													<td><%=fullIndexingResult.getInt("docSize") %></td>
													<td><%=fullIndexingResult.getInt("insertSize") %></td>
													<td><%=fullIndexingResult.getInt("updateSize") %></td>
													<td><%=fullIndexingResult.getInt("deleteSize") %></td>
													<td><%=fullIndexingResult.getString("startTime") %></td>
													<td><%=fullIndexingResult.getString("endTime") %></td>
													<td><%=fullIndexingResult.getString("duration") %></td>
													<% } else { %>
													<td colspan="9">No full indexing result.</td>
													<% } %>
												</tr>
												<%
												}
												
												if(indexingResult.has("ADD")){
													JSONObject addIndexingResult = indexingResult.getJSONObject("ADD");
												%>
												<tr>
													<td><strong>AddIndexing</strong></td>
													<% if(addIndexingResult != null) { %> 
													<td><%=addIndexingResult.getString("status") %></td>
													<td><%=addIndexingResult.getString("isScheduled") %></td>
													<td><%=addIndexingResult.getInt("docSize") %></td>
													<td><%=addIndexingResult.getInt("insertSize") %></td>
													<td><%=addIndexingResult.getInt("updateSize") %></td>
													<td><%=addIndexingResult.getInt("deleteSize") %></td>
													<td><%=addIndexingResult.getString("startTime") %></td>
													<td><%=addIndexingResult.getString("endTime") %></td>
													<td><%=addIndexingResult.getString("duration") %></td>
													<% } else { %>
													<td colspan="9">No add indexing result.</td>
													<% } %>
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



						<%
						Element rootElement = indexingSchedule.getRootElement();
						Element fullElement = rootElement.getChild("full-indexing-schedule");
						Element addElement = rootElement.getChild("add-indexing-schedule");
						String fullActive = "true".equals(fullElement.getAttributeValue("active")) ? "checked='checked'" : "";
						String addActive = "true".equals(addElement.getAttributeValue("active")) ? "checked='checked'" : "";
						String[] fullStartTime = fullElement.getAttributeValue("start").split(" ");
						String[] addStartTime = addElement.getAttributeValue("start").split(" ");
						int[] fullTimeUnits = WebUtils.convertSecondsToTimeUnits(Integer.parseInt(fullElement.getAttributeValue("periodInSecond")));
						int[] addTimeUnits = WebUtils.convertSecondsToTimeUnits(Integer.parseInt(addElement.getAttributeValue("periodInSecond")));
						%>
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
															<input type="checkbox" class="uniform" <%=fullActive %>>
														</div>
													</div>
												</div>
												
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Base Date:</label>
													<div class="col-md-10">
														<input type="text" class="fc_datepicker form-control input-width-small" placeholder="Date" value="<%=fullStartTime[0] %>">
														<input type="text" class="fc_timepicker form-control input-width-small" placeholder="Time" value="<%=fullStartTime[1] %>">
													</div>
												</div>
													
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Period:</label>
													<div class="col-md-10">
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=fullTimeUnits[0] %>">
  															<span class="input-group-addon">Day</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=fullTimeUnits[1] %>">
  															<span class="input-group-addon">Hr</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=fullTimeUnits[2] %>">
															<span class="input-group-addon">Min</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=fullTimeUnits[3] %>">
															<span class="input-group-addon">Sec</span>
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
															<input type="checkbox" class="uniform" <%=addActive %>>
														</div>
													</div>
												</div>
												
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Base Date:</label>
													<div class="col-md-10">
														<input type="text" class="fc_datepicker form-control input-width-small" placeholder="Date" value="<%=addStartTime[0] %>">
														<input type="text" class="fc_timepicker form-control input-width-small" placeholder="Time" value="<%=addStartTime[1] %>">
													</div>
												</div>
													
												<div class="form-group form-inline">
													<label class="col-md-2 control-label">Period:</label>
													<div class="col-md-10">
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[0] %>">
  															<span class="input-group-addon">Day</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[1] %>">
  															<span class="input-group-addon">Hr</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[2] %>">
															<span class="input-group-addon">Min</span>
														</div>
														<div class="input-group col-md-1" style="padding-left: 0px;">
															<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[3] %>">
															<span class="input-group-addon">Sec</span>
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
										<span class="checkbox"><label><input type="checkbox" id="autoUpdate"> Auto Update <i class="icon-refresh"></i></label></span>
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
						
						<div class="tab-pane active" id="tab_indexing_history">
						</div>
						
					</div>
					<!-- /.tab-content -->
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>