<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
						<li class="active"><a><strong>user</strong></a>
						<li><a><strong>group</strong></a>
					</ul>
					<div class="tab-content">
						<div class="tab-pane active" id="tab_3_1">

							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>User</h4>
									</div>
									<div class="widget-content no-padding">
									
										<div>
											<ul class="feeds">
											
											<% for (int inx=0;inx<4;inx++) { %>
												<li>
													<form class="form-horizontal">
														<div class="form-group">
															<label class="col-md-1 control-label">Name</label>
															<div class="col-md-9 controls">
																<input type="text" class="form-control"/>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-1 control-label">User ID</label>
															<div class="col-md-9 controls">
																<input type="text" class="form-control"/>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-1 control-label">Password</label>
															<div class="col-md-4 controls">
																<input type="text" class="form-control"/>
															</div>
															<label class="col-md-1 control-label">Confirm</label>
															<div class="col-md-4 controls">
																<input type="text" class="form-control"/>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-1 control-label">E-mail</label>
															<div class="col-md-9 controls">
																<input type="text" class="form-control"/>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-1 control-label">SMS</label>
															<div class="col-md-9 controls">
																<input type="text" class="form-control"/>
															</div>
														</div>
														<div class="form-group">
															<label class="col-md-1 control-label">User Group</label>
															<div class="col-md-9 control">
																<select class="form-control">
																</select>
															</div>
														</div>
													</form>
													<div class="dataTables_header clearfix">
															<div class="input-group col-md-12">
															<a href="javascript:void(0);" class="btn btn-sm"><span
																class="glyphicon glyphicon-ok-sign"></span> Apply User</a>
																&nbsp;
															<a href="javascript:void(0);" class="btn btn-sm"><span
																class="glyphicon glyphicon-minus-sign"></span> Remove User</a>
																&nbsp;
														</div>
													</div>
												</li>
											<% } %>
											</ul>
										</div>
										
										<!--
										<table class="table table-hover table-bordered table-checkable">
											<tbody>
												<tr>
													<td rowspan="3">1</td>
													<td colspan="2">a</td>
													<td rowspan="3">1</td>
												</tr>
												<tr>
													<td><strong>Name</strong></td>
													<td><input type="text" class="form-control"/></td>
												</tr>
												<tr>
													<td><strong>UserId</strong></td>
													<td><input type="text" class="form-control"/></td>
												</tr>
											</tbody>
										</table>
										  -->
									</div> <!-- /.widget-content -->
									</div> <!-- /.widget -->
								<!-- <div class="form-actions">
									<input type="submit" value="Update Settings" class="btn btn-primary pull-right">
								</div> -->
									
								
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