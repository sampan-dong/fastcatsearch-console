<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
<script>
$(document).ready(function(){
	$("#user-update-form").validate();
	
	$("#user-update-form").submit(function(e) {
		
		
	});
});

</script>
</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
	<div id="content">
		<div class="container">
			<!-- Breadcrumbs line -->
			<div class="crumbs">
				<ul id="breadcrumbs" class="breadcrumb">
					<li><i class="icon-home"></i> <a href="javascript:void(0);">My Profile</a>
					</li>
				</ul>
	
			</div>
			<!-- /Breadcrumbs line -->
			<!--=== Page Header ===-->
			<div class="page-header">
				<div class="page-title">
					<h3>My Profile</h3>
					
				</div>
			</div>
			<!-- /Page Header -->
			
			
			<form id="user-update-form">
				<input type="hidden" name="uri" value="/management/collections/update-config"/>
				
				<div class="col-md-12">
					<div class="widget">
						<div class="widget-header">
							<h4>General Information</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">User ID:</label>
										<div class="col-md-3" style="padding-top: 6px;">Johny</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Group:</label>
										<div class="col-md-3" style="padding-top: 6px;">Administrator</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">User Name:</label>
										<div class="col-md-3"><input type="text" name="userName" class="form-control fcol2 required" value="형도니" /></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Email Address:</label>
										<div class="col-md-3"><input type="text" name="email" class="form-control fcol3 email" value="" /></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">SMS Number:</label>
										<div class="col-md-3"><input type="text" name="sms" class="form-control fcol2 digits" value="" /></div>
									</div>
									
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12">
					<div class="widget">
						<div class="widget-header">
							<h4>Password</h4>
						</div>
						<div class="widget-content">
							<div class="row">
								<div class="col-md-12 form-horizontal">		
									<div class="form-group">
										<label class="col-md-2 control-label">Old Password:</label>
										<div class="col-md-3"><input type="password" name="oldPassword" class="form-control fcol2" value=""></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">New Password:</label>
										<div class="col-md-3"><input type="password" name="newPassword" class="form-control fcol2" value=""></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Repeat New Password:</label>
										<div class="col-md-3"><input type="password" name="newPassword2" class="form-control fcol2" value=""></div>
									</div>
								</div>
							</div>
						</div>
					</div> <!-- /.widget -->
				</div>
				<div>
					<div class="form-actions">
						<input type="submit" value="Update Profile" class="btn btn-primary pull-right">
					</div>
				</div>
			
			</form>
		</div>
	</div>
</div>
</body>
</html>