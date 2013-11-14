<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="
org.json.JSONObject,
org.json.JSONArray
" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
JSONObject jGroupAuthorityList = (JSONObject)request.getAttribute("groupAuthorityList");
JSONObject jAuthorityList = (JSONObject)request.getAttribute("authorityList");
%>

<c:import url="../inc/common.jsp" />
<html>
<head>
<c:import url="../inc/header.jsp" />
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
						<h3>Account Settings</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<!--=== Page Content ===-->
			
				<div class="tabbable tabbable-custom tabs-left">
					<ul class="nav nav-tabs tabs-left">
						<li><a><strong>user</strong></a>
						<li class="active"><a><strong>group</strong></a>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_3_1">

							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Group</h4>
									</div>
									<div class="widget-content no-padding">
										<div>
											<ul class="feeds">
											<%
											{
											JSONArray groupArray = jGroupAuthorityList.optJSONArray("groupList");
											for(int groupInx=0;groupInx < groupArray.length(); groupInx++) {
											%>
												<%
												JSONObject record = groupArray.optJSONObject(groupInx);
												int groupId = record.optInt("groupId", -1);
												%>
												<li>
													<div> <strong>Group Name</strong> </div>
													<p>
													<form class="form-horizontal">
														<% for (int authorityInx=0;authorityInx<10;authorityInx++) { %>
														<div class="col-md-6">
															<div class="col-md-3">
																테스트
															</div>
															<div class="form-group">
																	<label class="col-md-2 radio">
																		<input type="radio" name="group_<%=authorityInx %>" class="form-control"/>
																		None
																	</label>
																	<label class="col-md-2 radio">
																		<input type="radio" name="group_<%=authorityInx %>" class="form-control"/>
																		Read
																	</label>
																	<label class="col-md-2 radio">
																		<input type="radio" name="group_<%=authorityInx %>" class="form-control"/>
																		Write
																	</label>
															</div>
														</div>
														<% } %>
													</form>
													</p>
												</li>
											<%
											}
											}
											%>
												<li>
													<p>
													<div class="clearfix"> 
														<label class="col-md-1 control-label">
														Group Name
														</label>
														<div class="col-md-9 control">
														<input type="text" name="groupName" class="form-control"/>
														</div>
													</div>
													<form class="form-horizontal">
														<% 
														{
														JSONArray groupList = jAuthorityList.optJSONArray("groupList");
														JSONObject groupAccount = groupList.optJSONObject(0);
														JSONArray authorities = groupAccount.optJSONArray("authorities");
														for (int authorityInx=0;authorityInx<authorities.length();authorityInx++) {
														%>
															<% 
															JSONObject record = authorities.optJSONObject(authorityInx);
															String authorityName = record.optString("authorityName");
															String authorityLevel = record.optString("authorityLevel");
															if(!"R".equals(authorityLevel) && !"W".equals(authorityLevel)) {
																authorityLevel = "N";
															}
															%>
															<div class="col-md-6">
																<div class="col-md-3">
																<%=authorityName%>
																</div>
																<div class="form-group">
																		<label class="col-md-2 radio">
																			<input type="radio" name="group_<%=-1%>_<%=authorityName %>_N" <%="N".equals(authorityLevel)?"checked":"" %> class="form-control"/>
																			None
																		</label>
																		<label class="col-md-2 radio">
																			<input type="radio" name="group_<%=-1%>_<%=authorityName %>_R" <%="R".equals(authorityLevel)?"checked":"" %> class="form-control"/>
																			Read
																		</label>
																		<label class="col-md-2 radio">
																			<input type="radio" name="group_<%=-1%>_<%=authorityName %>_W" <%="W".equals(authorityLevel)?"checked":"" %> class="form-control"/>
																			Write
																		</label>
																</div>
															</div>
														<% 
														}
														}
														%>
													</form>
													<div class="dataTables_header clearfix">
															<div class="input-group col-md-12">
															<a href="javascript:void(0);" class="btn btn-sm"><span
																class="glyphicon glyphicon-plus-sign"></span> Add Group</a>
														</div>
													</div>
													</p>
												</li>
											</ul>
										</div>
									</div> <!-- /.widget -->
							</div>
						</div>
					</div>
				</div>
				

				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>