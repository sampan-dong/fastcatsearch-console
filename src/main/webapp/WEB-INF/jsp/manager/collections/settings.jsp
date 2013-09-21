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
						<li class="current"> Settings</li>
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
				
				
				
				
				<div class="col-md-12">
					<div class="widget">
						<div class="widget-header">
							<h4>General Information</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">Collection Name:</label>
										<div class="col-md-3"><input type="text" name="regular" class="form-control" value="샘플"></div>
									</div>
								</div>
								
							</div>
						</div>
					</div> <!-- /.widget -->
				</div>
				
				<div class="col-md-12">
					<div class="widget">
						<div class="widget-header">
							<h4>Index Config</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12">
									<form class="form-horizontal" action="#">
										<div class="col-md-5">
											<div class="form-group">
												<label class="col-md-8 control-label">term-interval :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>

											<div class="form-group">
												<label class="col-md-8 control-label">work-bucket-size :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>
										</div>
										<div class="col-md-5">
											<div class="form-group">
												<label class="col-md-8 control-label">work-memory-size :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>

											<div class="form-group">
												<label class="col-md-8 control-label">pk-bucket-size :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>
										</div>
										<div class="col-md-5">
											<div class="form-group">
												<label class="col-md-8 control-label">pk-term-interval :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>

										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-md-12">
					<div class="widget">
						<div class="widget-header">
							<h4>Data Plan</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12">
									<form class="form-horizontal" action="#">
										<div class="col-md-5">
											<div class="form-group">
												<label class="col-md-8 control-label">Data-sequence-cycle :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>

											<div class="form-group">
												<label class="col-md-8 control-label">Segment-revision-backup-size :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>
										</div>
										<div class="col-md-5">
											<div class="form-group">
												<label class="col-md-8 control-label">Segment-document-limit :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>

											<div class="form-group">
												<label class="col-md-8 control-label">Separate-inc-indexing :</label>
												<div class="col-md-4"><input type="text" name="regular" class="form-control"></div>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
					
					<div class="form-actions">
						<input type="submit" value="Update Settings" class="btn btn-primary pull-right">
					</div>
				</div>
				
				
				
				
				
			</div>
		</div>
	</div>
</body>
</html>