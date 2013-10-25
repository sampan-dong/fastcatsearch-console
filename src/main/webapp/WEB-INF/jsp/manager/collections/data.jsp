<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
JSONObject indexDataStatusResult = (JSONObject) request.getAttribute("indexDataStatus");
JSONObject indexDataResult = (JSONObject) request.getAttribute("indexDataResult");
JSONArray indexDataStatusList = indexDataStatusResult.getJSONArray("indexDataStatus");

String selectedShardId = (String) request.getAttribute("shardId");

%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.dataWidth {
	width: 150px;
}
</style>
<script>
$(document).ready(function(){
	$("#shardSelect").on("change", function(e) { 
		submitPost("", {shardId: e.val});
		}
	);
});
function selectFieldValue(value){
	$("#selectedDataPanel").text(value);
}
function goIndexDataPage(uri, pageNo){
	submitPost(uri, {shardId: '${shardId}', pageNo: pageNo});
}
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="${collectionId}" />
			<c:param name="scat" value="data" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Data</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Data</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_raw_data" data-toggle="tab">Raw</a></li>
						<!-- <li class=""><a href="#tab_analyzed_data" data-toggle="tab">Analyzed Raw</a></li>
						<li class=""><a href="#tab_analyzed_data" data-toggle="tab">Search</a></li> -->
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_field">
							<div class="col-md-12">
								<div class="widget box">
	
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="col-md-4">
												<select id="shardSelect" class="select_flat col-md-12">
													<%
													int totalSize = 0;
													for( int i = 0 ; i < indexDataStatusList.length() ; i++ ){
														JSONObject indexDataStatus = indexDataStatusList.getJSONObject(i);
														String shardId = indexDataStatus.getString("shardId");
														int documentSize = indexDataStatus.getInt("documentSize");
														if(shardId.equals(selectedShardId)){
															totalSize = documentSize;
														}
													%>
													<option value="<%=shardId %>" <%=shardId.equals(selectedShardId) ? "selected" : "" %>><%=shardId %> : <%=documentSize %> documents</option>
													<%
													}
													%>
												</select>
												
											</div>
											<div class="col-md-4" style="margin-top:5px">
											<%
											JSONArray indexDataList = indexDataResult.getJSONArray("indexData");
											JSONArray fieldList = indexDataResult.getJSONArray("fieldList");
											if(indexDataList.length() > 0){
											%>
												<span>Rows ${start} - ${end} of <%=totalSize %></span>
											<%
											}else{
											%>
												<span>Rows 0</span>
											<%
											}
											%>
											</div>
											<div class="col-md-4">
												<div class="pull-right">
													<jsp:include page="../../inc/pagenationTop.jsp" >
													 	<jsp:param name="pageNo" value="${pageNo }"/>
													 	<jsp:param name="totalSize" value="<%=totalSize %>" />
														<jsp:param name="pageSize" value="${pageSize }" />
														<jsp:param name="width" value="5" />
														<jsp:param name="callback" value="goIndexDataPage" />
														<jsp:param name="requestURI" value="" />
													 </jsp:include>
												 </div>
											</div>
										</div>
										<div style="overflow: scroll; height: 400px;">
	
											<%
											if(indexDataList.length() > 0){
											%>
											<table class="table table-hover table-bordered" style="white-space:nowrap;table-layout:fixed; ">
												<thead>
													<tr>
														<%
														for( int i = 0 ; i < fieldList.length() ; i++ ){
														%>
														<th class="dataWidth"><%=fieldList.getString(i) %></th>
														<%
														}
														%>
													</tr>
												</thead>
												<tbody>
												<%
												for( int i = 0 ; i < indexDataList.length() ; i++ ){
													JSONObject indexData = indexDataList.getJSONObject(i);
												%>
													<tr>
														<%
														JSONObject row = indexData.getJSONObject("row");
														
														for( int j = 0 ; j < fieldList.length() ; j++ ){
															String fieldName = fieldList.getString(j);
														%>
														<td class="dataWidth" style="overflow:hidden; cursor:pointer" onclick="javascript:selectFieldValue($(this).text())"><%=row.getString(fieldName) %></td>
														<%
														}
														%>
													</tr>
												<%
												}
												%>
													
												</tbody>
											</table>
											<%
											}
											%>
										</div>
	
										<div class="table-footer">
											<!-- <div class="panel">
												this is sample. this is sample. this is sample. this is sample. this is sample. this is sample. this is sample.
											</div> -->
											<label class="col-md-2 control-label">Selected Data:</label>
											<div class="col-md-10">
												<div id="selectedDataPanel" class="panel"></div>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<!-- //tab field -->
						<!-- search indexes -->
						<div class="tab-pane" id="tab_search_indexes">
							<div class="col-md-12">
							
							dddd
							</div>
							
							</div>
						<!-- //search indexes -->
						<!--=== Edit Account ===-->
						<div class="tab-pane active" id="tab_edit_account"></div>
						<!-- /Edit Account -->
					</div>
					<!-- /.tab-content -->
				</div>
				
				
			</div>
		</div>
	</div>
</body>
</html>