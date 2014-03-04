<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/assets/css/search.css">	
<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
		<div id="content">
			<div class="container">
				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Search Page Config</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				<!--=== Page Content ===-->
				<div class="col-md-12">
					<div class="widget margin-space">
						<div class="widget-header">
							<h4>Common Settings</h4>
						</div>
						<div class="widget-content">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Total Search List Size :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required" value="5"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search List Size :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required" value="10"></div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="widget margin-space">
						<div class="widget-header">
							<h4>Category List</h4>
						</div>
						<div class="widget-content">
							<div class="category-group col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Category Name :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 display-inline required" value="커뮤니티"> <a href="#" class="btn">Remove</a></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required" value="community"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search Query :</label>
									<div class="col-md-10"><textarea rows="3" name="" class="form-control required">fl=title,content,date,author&se={title:#keyword}</textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Title Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required" value="title"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Body Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required" value="content"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">ETC Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control required" value="date, author"></div>
								</div>
							</div>
							
							<div class="category-group col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Category Name :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 display-inline required"> <a href="#" class="btn">Remove</a></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search Query :</label>
									<div class="col-md-10"><textarea rows="3" name="" class="form-control required"></textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Title Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Body Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control fcol2 required"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">ETC Field ID :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control required"></div>
								</div>
							</div>
							
							<div class="row">
							<div class="col-md-12 col-md-offset-2">
								<a class="btn"><i class="icon-plus"></i> Add Category</a>
							</div>
							</div>
						</div>
					</div>
					
					<div class="widget margin-space">
						<div class="widget-header">
							<h4>Relate Keyword</h4>
						</div>
						<div class="widget-content">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">URL :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control required" value="/management/request.html?url=/keyword/relate.xml?keyword=#keyword"></div>
									
								</div>
							</div>
						</div>
					</div>
					
					<div class="widget margin-space">
						<div class="widget-header">
							<h4>Realtime Popular Keyword</h4>
						</div>
						<div class="widget-content">
							<div class="col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">URL :</label>
									<div class="col-md-10"><input type="text" name="" class="form-control required" value="/management/request.html?url=/keyword/popular/rt.xml?keyword=#keyword"></div>
									
								</div>
							</div>
						</div>
					</div>
					
					
					
					<div class="form-actions">
						<a href="#" class="btn btn-primary  fcol2" >Save Changes</a>
					</div>
					
					<br>
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>