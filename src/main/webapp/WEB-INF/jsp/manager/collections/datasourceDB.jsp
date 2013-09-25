<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="sample" />
			<c:param name="scat" value="datasource" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Datasource</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Datasource [db1]</h3>
						<p><a class="btn btn-xs btn-default" href="../datasource.html">Back</a>&nbsp;</p>
					</div>
				</div>
				<!-- /Page Header -->
				
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Connection</h4>
									</div>
									<div class="widget-content">
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label class="col-md-2 control-label">JDBC Source:</label>
													<div class="col-md-10">
														<select class="select2">
															<option value="dbsource1">운영디비 소스1</option>
															<option value="dbsource2">운영디비 소스2</option>
															<option value="test_dbsource">테스트 소스</option>
														</select>
													</div>
												</div>

											</div>
										</div> <!-- /.row -->
									</div> <!-- /.widget-content -->
								</div>
								
								<div class="widget">
									<div class="widget-header">
										<h4>Setting</h4>
									</div>
									<div class="widget-content">
										<div class="row">
											<div class="col-md-12 form-horizontal">
												<div class="form-group">
													<label class="col-md-2 control-label">Reader Class:</label>
													<div class="col-md-10"><input type="text" name="regular" class="form-control" value="org.fastcatsearch.datasource.reader.DBReader"></div>
												</div>
												
												<div class="form-group">
													<label class="col-md-2 control-label">Fetch Size:</label>
													<div class="col-md-10"><input type="text" name="regular" class="form-control input-width-small" value="1000"></div>
												</div>

												<div class="form-group">
													<label class="col-md-2 control-label">Bulk Size:</label>
													<div class="col-md-10"><input type="text" name="regular" class="form-control input-width-small" value="100"></div>
												</div>
												
												<div class="form-group">
													<label class="col-md-2 control-label">Modifier Class:</label>
													<div class="col-md-10"><input type="text" name="regular" class="form-control" value="org.fastcatsearch.datasource.reader.Modifier"></div>
												</div>
											</div>
											
										</div>
									</div>
								</div> <!-- /.widget -->
							</div>
							
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Query</h4>
									</div>
									<div class="widget-content">
										<div class="row">
											<div class="col-md-12">
												<div class="tabbable tabbable-custom tabs-left">
													<!-- Only required for left/right tabs -->
													<ul class="nav nav-tabs tabs-left">
														<li class="active"><a href="#tab_3_1" data-toggle="tab">VOL</a></li>
														<li ><a href="#tab_3_2" data-toggle="tab">VOL1 Shard</a></li>
														<li><a href="#tab_3_3" data-toggle="tab">VOL2 Shard</a></li>
													</ul>
													<div class="tab-content">
														<div class="tab-pane active" id="tab_3_1">
															<form class="form-horizontal" action="#">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label">Data SQL :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
				
																	<div class="form-group">
																		<label class="col-md-2 control-label">Delete-ID SQL:</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																</div>
															</form>
														</div>
														<div class="tab-pane " id="tab_3_2">
															<form class="form-horizontal" action="#">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label">Data SQL :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
				
																	<div class="form-group">
																		<label class="col-md-2 control-label">Delete-ID SQL:</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																</div>
															</form>
														</div>
														<div class="tab-pane" id="tab_3_3">
															<form class="form-horizontal" action="#">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label">Data SQL :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
				
																	<div class="form-group">
																		<label class="col-md-2 control-label">Delete-ID SQL:</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																</div>
															</form>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								
								<div class="form-actions">
									<a class="btn btn-primary" href="javascript:void(0);">Save</a>
									&nbsp;
									<a class="btn" href="javascript:void(0);">Cancel</a>
									<span class="pull-right">
									<a class="btn btn-danger" href="javascript:void(0);">Remove</a>
									</span>
								</div>
								
								
							</div>
				
				
			</div>
		</div>
	</div>
</body>
</html>