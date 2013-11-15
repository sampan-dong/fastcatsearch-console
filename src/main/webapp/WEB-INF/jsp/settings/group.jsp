<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="
org.json.JSONObject,
org.json.JSONArray
" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String menuId = "group";

JSONObject jGroupAuthorityList = (JSONObject)request.getAttribute("groupAuthorityList");
JSONObject jAuthorityList = (JSONObject)request.getAttribute("authorityList");
JSONArray jAuthorityLevels = jAuthorityList.optJSONArray("authorityLevel");
JSONArray jAuthorities = jAuthorityList.optJSONArray("groupAuthorities");
JSONArray jGroupList = jGroupAuthorityList.optJSONArray("groupList");

%>
<c:set var="ROOT_PATH" value="../.." scope="request"/>
<c:import url="../inc/common.jsp" />
<html>
<head>
<c:import url="../inc/header.jsp" />

<script>
function showUpdateGroupModal(groupId){
	//1. 성공하면 현재 페이지 reload
	//2. 실패하면 그대로...
	//requestProxy(methodType, data, resultType, successCallback, failCallback);
	$("#groupEdit").modal("show");
	
	//$("#groupEdit").modal("hide");
	
}

</script>
</head>
<body>
<c:import url="../inc/mainMenu.jsp" />

<div id="container" class="sidebar-closed">

		<div id="content">

			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> <a href="javascript:void(0);">Settings</a>
						</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Settings</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<!--=== Page Content ===-->
			
				<div class="tabbable tabbable-custom tabs-left">
					<c:import url="${ROOT_PATH}/settings/sideMenu.jsp" >
					 	<c:param name="menu" value="<%=menuId %>"/>
					 </c:import>
					 
					<div class="tab-content">
						<div class="tab-pane active" id="tab_3_1">

							<div class="col-md-12">

								<div class="widget box">
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="input-group col-md-12">
												<button class="btn btn-sm" data-toggle="modal" data-target="#groupNew">
												 <span class="icon-group"></span> New Group
												 </button>
											</div>
										</div>
										<table class="table table-bordered">
											<thead>
												<tr>
													<th>Group Name</th>
													<%
													for(int authorityInx=0; authorityInx < jAuthorities.length(); authorityInx++) {
														JSONObject jGroupRecord = jAuthorities.optJSONObject(authorityInx);
														String authorityCode = jGroupRecord.optString("authorityCode");
														String authorityName = jGroupRecord.optString("authorityName");
													%>
													<th><%=authorityName %></th>
													<%
													}
													%>
													<th></th>
												</tr>
											</thead>	
											<tbody>
											<%
											for (int groupInx=0;groupInx < jGroupList.length(); groupInx++) { 
											%>
												<%
												JSONObject groupRecord = jGroupList.optJSONObject(groupInx);
												int groupId = groupRecord.optInt("groupId", 0);
												String groupName = groupRecord.optString("groupName");
												JSONArray authorities = groupRecord.optJSONArray("authorities");
												%>
												<tr>
													<th><%=groupName %></th>
													<%
													for(int attributeInx=0;attributeInx < authorities.length(); attributeInx++) {
													%>
													<td><span class="text-danger"><%=authorities.get(attributeInx) %></span></td>
													<%
													}
													%>
													<td><a href="javascript:showUpdateGroupModal(0)">Edit</a></td>
												</tr>
											<% 
											} 
											%>
											</tbody>
										</table>
									</div>
								</div>
								<form name="update-authority-form" class="form-horizontal">
								<input type="hidden" name="mode" value="update"/>
						</div>
					</div>
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
	</div>
</div>

	<div class="modal" id="groupNew">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">New Group</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="groupName" class="col-sm-4 control-label">Group Name</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="groupName" name="groupName" placeholder="Group name">
							</div>
						</div>
						<% 
						for(int authorityInx=0;authorityInx < jAuthorities.length(); authorityInx++ ) { 
							JSONObject authorityRecord = jAuthorities.optJSONObject(authorityInx);
							String authorityCode = authorityRecord.optString("authorityCode");
							String authorityName = authorityRecord.optString("authorityName");
						%>
						<div class="form-group">
							<label class="col-sm-4 control-label"><%=authorityName %></label>
							<div class="col-sm-12">
									<%
									for(int levelInx=0;levelInx < jAuthorityLevels.length();levelInx++) {
										String levelName = jAuthorityLevels.optString(levelInx);
									%>
									<label class="col-md-4 radio">
										<input type="radio" name="authorityLevel_<%=authorityCode %>" class="form-control" value=""/>
										<%=levelName %>
									</label>
									<%
									}
									%>
							</div>
						</div>
						<%
						}
						%>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary">Create group</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>

	<div class="modal" id="groupEdit">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Edit Group</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="groupName" class="col-sm-4 control-label">Group Name</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="groupName" placeholder="Group name">
							</div>
						</div>
						<% 
						for(int authorityInx=0;authorityInx < jAuthorities.length(); authorityInx++ ) { 
							JSONObject authorityRecord = jAuthorities.optJSONObject(authorityInx);
							String authorityCode = authorityRecord.optString("authorityCode");
							String authorityName = authorityRecord.optString("authorityName");
						%>
						<div class="form-group">
							<label class="col-sm-4 control-label"><%=authorityName %></label>
							<div class="col-sm-12">
									<%
									for(int levelInx=0;levelInx < jAuthorityLevels.length();levelInx++) {
										String levelName = jAuthorityLevels.optString(levelInx);
									%>
									<label class="col-md-4 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value=""/>
										<%=levelName %>
									</label>
									<%
									}
									%>
							</div>
						</div>
						<%
						}
						%>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger pull-left">Remove</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
					<button type="button" class="btn btn-primary">Save chages</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
</body>
</html>