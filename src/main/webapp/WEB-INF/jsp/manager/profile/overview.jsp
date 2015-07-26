<%@page import="org.json.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
	JSONArray profileList = (JSONArray) request.getAttribute("profileList");
%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){
	
	$("#newProfileForm").validate();
	
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
					noty({text: "Cannot create profile : " + response["errorMessage"], type: "error", layout:"topRight", timeout: 5000});
				}
				
			}, fail: function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
			
		});
		return false;
	};
	
	$("#newProfileForm").submit(fnSubmit);
});


</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="ranking" />
			<c:param name="mcat" value="overview" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Ranking</li>
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
								<a data-toggle="modal" data-target="#newCollectionModal" class="btn btn-sm" data-backdrop="static"><span
									class="glyphicon glyphicon-plus-sign"></span> Create Profile</a>
							</div>
							
						</div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Profile ID</th>
									<th>Name</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<%
								for(int i = 0; i< profileList.length(); i++){
									JSONObject profileInfo = profileList.getJSONObject(i);
									String profileId = profileInfo.getString("id");
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=profileId %></strong></td>
									<td><%=profileInfo.getString("name") %></td>
									<td>
										<a href="javascript:modifyProfile('<%=profileId %>')" class="text-danger">MODIFY</a>
										|
										<a href="javascript:removeProfile('<%=profileId %>')" class="text-danger">REMOVE</a>
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
	
	
	
	<div class="modal" id="newProfileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<form id="newProfileForm" method="GET">
					<input type="hidden" name="uri" value="/management/ranking/create-profile"/>
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
												<label class="col-md-3 control-label">Profile ID:</label>
												<div class="col-md-9"><input type="text" name="collectionId" class="form-control input-width-medium required" value="" placeholder="Collection ID"></div>
											</div>
											
											<div class="form-group">
												<label class="col-md-3 control-label">Name:</label>
												<div class="col-md-9"><input type="text" name="name" class="form-control input-width-medium required" value="" placeholder="NAME"></div>
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