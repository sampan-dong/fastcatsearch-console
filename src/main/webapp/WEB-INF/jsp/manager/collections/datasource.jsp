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
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp" />
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
						<h3>Datasource</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				<div class="tabbable tabbable-custom tabbable-full-width ">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_datasource_overview" data-toggle="tab">Overview</a></li>
						<li class=""><a href="#tab_datasource_file" data-toggle="tab">File1</a></li>
						<li class=""><a href="#tab_datasource_db" data-toggle="tab">DB1</a></li>
						<li class=""><a href="#tab_datasource_db" data-toggle="tab">DB2</a></li>
						<li class=""><a href="#tab_analyzed_data" data-toggle="tab">OTHER1</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_datasource_overview">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-plus-sign"></span> Add Datasource</a>
												&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-minus-sign"></span> Remove Datasource
											</a>
										</div>
										
									</div>
									<table class="table table-hover table-bordered">
										<thead>
											<tr>
												<th><input type="checkbox" /></th>
												<th>Type</th>
												<th>ID</th>
												<th>Name</th>
												<th>Reader Class</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="checkbox" /></td>
												<td>File</td>
												<td><strong>file1</strong></td>
												<td>FILE1</td>
												<td>org.fastcatsearch.datasource.reader.FileReader</td>
											</tr>
											<tr>
												<td><input type="checkbox" /></td>
												<td>DB</td>
												<td><strong>db1</strong></td>
												<td>DB1</td>
												<td>org.fastcatsearch.datasource.reader.DBReader</td>
											</tr>
											<tr>
												<td><input type="checkbox" /></td>
												<td>DB</td>
												<td><strong>db2</strong></td>
												<td>DB2</td>
												<td>org.fastcatsearch.datasource.reader.DBReader</td>
											</tr>
											<tr>
												<td><input type="checkbox" /></td>
												<td>CUSTOM</td>
												<td><strong>other</strong></td>
												<td>OTHER1</td>
												<td>org.fastcatsearch.datasource.reader.MyCustomReader</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						
						
						<div class="tab-pane" id="tab_datasource_file">
							<form class="form-horizontal" action="#">
								<div class="col-md-12">
									<div class="widget">
										<div class="widget-header">
											<h4>Setting</h4>
										</div>
										<div class="widget-content">
											<div class="row">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-2 control-label">Reader Class:</label>
														<div class="col-md-10"><input type="text" name="regular" class="form-control" value="org.fastcatsearch.datasource.reader.DBReader"></div>
													</div>
													
													<div class="form-group">
														<label class="col-md-2 control-label">File Encoding:</label>
														<div class="col-md-10"><input type="text" name="regular" class="form-control input-width-small" value="UTF-8"></div>
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
							</form>
							
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>File Path</h4>
									</div>
									<div class="widget-content">
										<div class="row">
											<div class="col-md-12">
												<div class="tabbable tabbable-custom tabs-left">
													<!-- Only required for left/right tabs -->
													<ul class="nav nav-tabs tabs-left">
														<li class="active"><a href="#tab_3_1" data-toggle="tab">ROOT</a></li>
														<li ><a href="#tab_3_2" data-toggle="tab">VOL1 Shard</a></li>
														<li><a href="#tab_3_3" data-toggle="tab">VOL2 Shard</a></li>
													</ul>
													<div class="tab-content">
														<div class="tab-pane active" id="tab_3_1">
															<form class="form-horizontal" action="#">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label">Full-Indexing :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
				
																	<div class="form-group">
																		<label class="col-md-2 control-label">Add-Indexing :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Delete-ID :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																</div>
															</form>
														</div>
														<div class="tab-pane " id="tab_3_2">
															<p>I'm in Section 2.</p>
															<p>
																Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat.
															</p>
														</div>
														<div class="tab-pane" id="tab_3_3">
															<p>I'm in Section 3.</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						
						<div class="tab-pane" id="tab_datasource_db">
							<form class="form-horizontal" action="#">
								<div class="col-md-12">
									<div class="widget">
										<div class="widget-header">
											<h4>Connection Information</h4>
										</div>
										<div class="widget-content">
											<div class="row">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-2 control-label">JDBC Driver:</label>
														<div class="col-md-10"><input type="text" name="regular" class="form-control" value="oracle.jdbc.driver.OracleDriver"></div>
													</div>

													<div class="form-group">
														<label class="col-md-2 control-label">JDBC URL:</label>
														<div class="col-md-10"><input type="text" name="regular" class="form-control" value="jdbc:oracle:thin:@203.250.196.44:1551:KISTI5"></div>
													</div>
												</div>


												<div class="col-md-6">
													<div class="form-group">
														<label class="col-md-4 control-label">Username:</label>
														<div class="col-md-8"><input type="text" name="regular" class="form-control input-width-small" value="scopus"></div>
													</div>

													<div class="form-group">
														<label class="col-md-4 control-label">Password:</label>
														<div class="col-md-8"><input type="password" name="regular" class="form-control input-width-small" value="scopus"></div>
													</div>
												</div>
											</div> <!-- /.row -->
										</div> <!-- /.widget-content -->
										
										
										<div class="widget-header">
											<h4>Setting</h4>
										</div>
										<div class="widget-content">
											<div class="row">
												<div class="col-md-12">
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
							</form>
							
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
														<li class="active"><a href="#tab_3_1" data-toggle="tab">ROOT</a></li>
														<li ><a href="#tab_3_2" data-toggle="tab">VOL1 Shard</a></li>
														<li><a href="#tab_3_3" data-toggle="tab">VOL2 Shard</a></li>
													</ul>
													<div class="tab-content">
														<div class="tab-pane active" id="tab_3_1">
															<form class="form-horizontal" action="#">
																<div class="col-md-12">
																	<div class="form-group">
																		<label class="col-md-2 control-label">Full-Indexing :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
				
																	<div class="form-group">
																		<label class="col-md-2 control-label">Add-Indexing :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																	<div class="form-group">
																		<label class="col-md-2 control-label">Delete-ID :</label>
																		<div class="col-md-10"><textarea name="regular" class="form-control"></textarea></div>
																	</div>
																</div>
															</form>
														</div>
														<div class="tab-pane " id="tab_3_2">
															<p>I'm in Section 2.</p>
															<p>
																Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat.
															</p>
														</div>
														<div class="tab-pane" id="tab_3_3">
															<p>I'm in Section 3.</p>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //tab field -->
						
						
					</div>
					<!-- /.tab-content -->
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>