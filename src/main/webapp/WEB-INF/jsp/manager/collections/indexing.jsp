<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="org.jdom2.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>



<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />

<script>
$(document).ready(function(){
	
	$('#indexing_tab a[href!="#tab_indexing_run"]').on('hide.bs.tab', function (e) {
		stopPollingIndexTaskState();
		$('#autoUpdate').attr('checked', false);
	});
	$('#indexing_tab a[href="#tab_indexing_run"]').on('show.bs.tab', function (e) {
		startPollingIndexTaskState('${collectionId}', false); //한번만 보여준다.
	});
	
	//load status tab contents
	$('#indexing_tab a[href="#tab_indexing_status"]').on('show.bs.tab', function (e) {
		loadToTab('indexing/status.html', {}, '#tab_indexing_status');
	});
	
	//load history tab contents
	$('#indexing_tab a[href="#tab_indexing_history"]').on('show.bs.tab', function (e) {
		loadToTab('indexing/history.html', {}, '#tab_indexing_history');
	});
	
	//load schedule tab contents
	$('#indexing_tab a[href="#tab_indexing_schedule"]').on('show.bs.tab', function (e) {
		loadToTab('indexing/schedule.html', {}, '#tab_indexing_schedule');
	});
	
	loadToTab('indexing/status.html', {}, '#tab_indexing_status');
	
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

function reloadIndexingSchdulePage(){
	loadToTab('indexing/schedule.html', {}, '#tab_indexing_schedule');
}



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
						<li class="current"> ${collectionId}</li>
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
							
						</div>



						
						<div class="tab-pane" id="tab_indexing_schedule">
							
						</div>
						
						
						<div class="tab-pane" id="tab_indexing_run">
						
						
							<div class="col-md-12">
								
								<div class="widget ">
									<div class="widget-header">
										<h4>Collection Indexing</h4>
										<div class="toolbar no-padding">
											<a href="#advanceIndexTool" role="button" data-toggle="modal" class="transparent">advance</a>
										</div>
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
														&nbsp;
														
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
	
	
	<div class="modal" id="advanceIndexTool" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Advance Index Tool</h4>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class=" col-md-12">
							<a href="javascript:runDocumentFullIndexing('${collectionId}');" class="">
								Run Document Full Indexing</a>
								&nbsp;|&nbsp;
							<a href="javascript:runIndexBuildFullIndexing('${collectionId}');" class="">
								Buld Index Full Indexing</a>
								&nbsp;
							<%-- <a href="javascript:runDocumentFullIndexing('${collectionId}');" class="">
								<span class="glyphicon glyphicon-play"></span> Run Document Add Indexing</a>
								&nbsp;
							<a href="javascript:runRebuildIndex('${collectionId}');" class="">
								<span class="glyphicon glyphicon-play"></span> Buld Index Add Indexing</a>
								&nbsp; --%>
						</div>
					</div>
					<br/>
					<div class="row">
						<div class=" col-md-12">
							<a href="javascript:runRebuildIndex('${collectionId}');" class="">
								Copy Index to Search Nodes..</a>
							&nbsp;|&nbsp;
							<a href="javascript:runRebuildIndex('${collectionId}');" class="">
								Switch to Next Sequence Index</a>
						</div>
					</div>
				</div>
				<div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      	</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>	
	
</body>
</html>