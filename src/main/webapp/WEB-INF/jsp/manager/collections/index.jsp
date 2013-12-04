<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
	JSONArray collectionInfoList = (JSONArray) request.getAttribute("collectionInfoList");

%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){
	
	$("#newCollectionForm").validate();
	
	var fnSubmit = function(event){
		event.preventDefault();
		if(! $(this).valid()){
			return false;
		} 

		$.ajax({
			url: PROXY_REQUEST_URI,
			type: "POST",
			dataType: "json",
			data: $(this).serializeArray(),
			success: function(response, statusText, xhr, $form){
				if(response["success"]==true) {
					location.href = location.href;
				} else {
					noty({text: "Cannot create collection : " + response["errorMessage"], type: "error", layout:"topRight", timeout: 5000});
				}
				
			}, fail: function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
			
		});
		return false;
	};
	
	$("#newCollectionForm").submit(fnSubmit);
});


</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="index" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> Overview</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Overview</h3>
					</div>
				</div>
				<!-- /Page Header -->
				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="input-group col-md-12">
								<a data-toggle="modal" data-target="#newCollectionModal" class="btn btn-sm"><span
									class="glyphicon glyphicon-plus-sign"></span> Create Collection</a>
							</div>
							
						</div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Collection ID</th>
									<th>Name</th>
									<th>Status</th>
									<th>Index Node</th>
									<th>Data Node List</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%
								for(int i = 0; i< collectionInfoList.length(); i++){
									JSONObject collectionInfo = collectionInfoList.getJSONObject(i);
									String collectionId = collectionInfo.getString("id");
									boolean isActive = collectionInfo.getBoolean("isActive");
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=collectionInfo.getString("id") %></strong></td>
									<td><%=collectionInfo.getString("name") %></td>
									<td><%=isActive ? "<span class='text-success'>Active</span>" : "<span class='text-danger'>InActive</span>" %></td>
									<td><%=collectionInfo.getString("indexNode") %></td>
									<td><%=collectionInfo.getString("dataNodeList") %></td>
									<td>
									<% if(isActive) { %>
									<a href="javascript:stopCollection('<%=collectionId%>')">STOP</a>
									<% } else { %>
									<a href="javascript:startCollection('<%=collectionId%>')">START</a>
									<% } %>
									</td>
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
	</div>
	
	
	
	<div class="modal" id="newCollectionModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="newCollectionForm" method="GET">
					<input type="hidden" name="uri" value="/management/collections/create"/>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title"> Create Collection</h4>
					</div>
					<div class="modal-body">
						<div class="col-md-12">
							<div class="widget">
								<div class="widget-content">
									<div class="row">
										<div class="col-md-12 form-horizontal">
											<div class="form-group">
												<label class="col-md-3 control-label">Collection ID:</label>
												<div class="col-md-9"><input type="text" name="collectionId" class="form-control input-width-medium required" value="" placeholder="Collection ID"></div>
											</div>
											
											<div class="form-group">
												<label class="col-md-3 control-label">Name:</label>
												<div class="col-md-9"><input type="text" name="name" class="form-control input-width-medium required" value="" placeholder="NAME"></div>
											</div>
											
											<div class="form-group">
												<label class="col-md-3 control-label">Index Node:</label>
												<div class="col-md-9"><input type="text" name="indexNode" class="form-control input-width-medium required" value="" placeholder="Index Node"></div>
											</div>
											
											<div class="form-group">
												<label class="col-md-3 control-label">Data Node List:</label>
												<div class="col-md-9"><input type="text" name="dataNodeList" class="form-control required" value="" placeholder="Data Node List"></div>
											</div>
											
										</div>
										
									</div>
								</div>
							</div> <!-- /.widget -->
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Create</button>
					</div>
				</form>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</body>
</html>