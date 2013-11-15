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
													<th>Dictionary</th>
													<th>Collections</th>
													<th>Analysis</th>
													<th>Servers</th>
													<th>Logs</th>
													<th>&nbsp;</th>
												</tr>
											</thead>	
											<tbody>
												<tr>
													<th>Administrator</th>
													<td><span class="text-danger">WRITE</span></td>
													<td><span class="text-danger">WRITE</span></td>
													<td><span class="text-danger">WRITE</span></td>
													<td><span class="text-danger">WRITE</span></td>
													<td><span class="text-danger">WRITE</span></td>
													<th> </th>
												</tr>
												<tr>
													<th>Opeartor</th>
													<td><span class="text-success">READ</span></td>
													<td><span class="text-danger">WRITE</span></td>
													<td><span class="text-success">READ</span></td>
													<td><span class="text-success">READ</span></td>
													<td><span class="text-success">READ</span></td>
													<td><a href="javascript:showUpdateGroupModal(0)">Edit</a></td>
												</tr>
												<tr>
													<th>User</th>
													<td><span class="text-success">READ</span></td>
													<td><span class="text-muted">NONE</span></td>
													<td><span class="text-success">READ</span></td>
													<td><span class="text-muted">NONE</span></td>
													<td><span class="text-success">READ</span></td>
													<td><a href="javascript:showUpdateGroupModal(0)">Edit</a></td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
								<form name="update-authority-form" class="form-horizontal">
								<input type="hidden" name="mode" value="update"/>
								<ul class="feeds">
								<%
								JSONArray groupArray = jGroupAuthorityList.optJSONArray("groupList");
								if(groupArray!=null && groupArray.length() > 0) {
								for(int groupInx=0;groupInx < groupArray.length(); groupInx++) {
								%>
									<%
									JSONObject groupRecord = groupArray.optJSONObject(groupInx);
									int groupId = groupRecord.optInt("groupId", 0);
									String groupName = groupRecord.optString("groupName");
									%>
									<li>
										<p>
											<input type="hidden" name="groupId_<%=groupInx %>" value="<%=groupId%>"/>
											<div class="clearfix"> 
												<label class="control-label" class="col-md-1">
												<input type="checkbox" name="check_group_<%=groupInx %>" value="<%=groupId %>" class="form-control"/>
												</label>
												<div class="col-md-2 control">
												<input type="text" name="groupName_<%=groupInx %>" value="<%=groupName %>" class="form-control"/>
												</div>
											</div>
											<% 
											JSONArray groupList = jGroupAuthorityList.optJSONArray("groupList");
											JSONObject groupAccount = groupList.optJSONObject(groupInx);
											JSONArray authorities = groupAccount.optJSONArray("authorities");
											for (int authorityInx=0;authorityInx<authorities.length();authorityInx++) {
											%>
												<% 
												JSONObject record = authorities.optJSONObject(authorityInx);
												String authorityCode = record.optString("authorityCode");
												String authorityName = record.optString("authorityName");
												String authorityLevel = record.optString("authorityLevel");
												if(!"R".equals(authorityLevel) && !"W".equals(authorityLevel)) {
													authorityLevel = "";
												}
												%>
												<div class="col-md-6">
													<div class="col-md-3">
													<%=authorityName%> 
													</div>
													<div class="form-group">
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_<%=groupInx %>_<%=authorityCode %>" <%="".equals(authorityLevel)?"checked":"" %> class="form-control" value=""/>
															None
														</label>
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_<%=groupInx %>_<%=authorityCode %>" <%="R".equals(authorityLevel)?"checked":"" %> class="form-control" value="R"/>
															Read
														</label>
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_<%=groupInx %>_<%=authorityCode %>" <%="W".equals(authorityLevel)?"checked":"" %> class="form-control" value="W"/>
															Write
														</label>
													</div>
												</div>
											<% } %>
										</p>
									</li>
								<%
								}
								}
								%>
								</ul>
								<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
										<a href="javascript:updateGroupAuthority('update-authority-form');" class="btn btn-sm"><span
											class="glyphicon glyphicon-ok-sign"></span> Apply All</a>
											&nbsp;
										<a href="javascript:updateGroupAuthority('update-authority-form','delete');" class="btn btn-sm"><span
											class="glyphicon glyphicon-minus-sign"></span> Remove Checked</a>
											&nbsp;
									</div>
								</div>
								</form>
								<ul class="feeds">
									<li>
										<form name="new-authority-form" class="form-horizontal">
											<input type="hidden" name="mode" value="update"/>
											<input type="hidden" name="groupId_0" value="-1"/>
											<div class="clearfix"> 
												<label class="col-md-1 control-label">
												Group Name
												</label>
												<div class="col-md-2 control">
												<input type="text" name="groupName_0" class="form-control"/>
												</div>
											</div>
											<% 
											JSONArray groupList = jAuthorityList.optJSONArray("groupList");
											JSONObject groupAccount = groupList.optJSONObject(0);
											JSONArray authorities = groupAccount.optJSONArray("authorities");
											for (int authorityInx=0;authorityInx<authorities.length();authorityInx++) {
											%>
												<% 
												JSONObject record = authorities.optJSONObject(authorityInx);
												String authorityCode = record.optString("authorityCode");
												String authorityName = record.optString("authorityName");
												String authorityLevel = record.optString("authorityLevel");
												if(!"R".equals(authorityLevel) && !"W".equals(authorityLevel)) {
													authorityLevel = "";
												}
												%>
												<div class="col-md-6">
													<div class="col-md-3">
													<%=authorityName%>
													</div>
													<div class="form-group">
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_0_<%=authorityCode %>" <%="".equals(authorityLevel)?"checked":"" %> class="form-control" value=""/>
															None
														</label>
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_0_<%=authorityCode %>" <%="R".equals(authorityLevel)?"checked":"" %> class="form-control" value="R"/>
															Read
														</label>
														<label class="col-md-2 radio">
															<input type="radio" name="authorityLevel_0_<%=authorityCode %>" <%="W".equals(authorityLevel)?"checked":"" %> class="form-control" value="W"/>
															Write
														</label>
													</div>
												</div>
											<% 
											}
											%>
											<div class="dataTables_header clearfix">
													<div class="input-group col-md-12">
													<a href="javascript:updateGroupAuthority('new-authority-form');" class="btn btn-sm"><span
														class="glyphicon glyphicon-plus-sign"></span> Add Group</a>
												</div>
											</div>
										</form>
									</li>
								</ul>
											
											
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
								<input type="text" class="form-control" id="groupName" placeholder="Group name">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">Dictionary</label>
							<div class="col-sm-8">
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value=""/>
										None
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="R"/>
										Read
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="W"/>
										Write
									</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">Collections</label>
							<div class="col-sm-8">
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value=""/>
										None
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="R"/>
										Read
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="W"/>
										Write
									</label>
							</div>
						</div>
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
						<div class="form-group">
							<label class="col-sm-4 control-label">Dictionary</label>
							<div class="col-sm-8">
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value=""/>
										None
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="R"/>
										Read
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="W"/>
										Write
									</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-4 control-label">Collections</label>
							<div class="col-sm-8">
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value=""/>
										None
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="R"/>
										Read
									</label>
									<label class="col-md-2 radio">
										<input type="radio" name="authorityLevel_" class="form-control" value="W"/>
										Write
									</label>
							</div>
						</div>
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