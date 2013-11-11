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
											
											<% for (int groupInx=0;groupInx<4;groupInx++) { %>
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
											<% } %>
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