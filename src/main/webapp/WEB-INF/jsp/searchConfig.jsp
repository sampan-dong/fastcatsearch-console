<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/assets/css/search.css">	
<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
<script>

$(document).ready(function(){
	$("#search-page-config-form").validate();
	
	$("#search-page-config-form").submit(function(e) {
		var postData = $(this).serializeArray();
		console.log("postData > ", postData);
		
		//TODO  _# 의 리스트를 함께 보내어 파라미터를 get 할수 있도록 한다.
		
		
		$.ajax({
				url : PROXY_REQUEST_URI,
				type: "POST",
				data : postData,
				dataType : "json",
				success:function(data, textStatus, jqXHR) {
					try {
						if(data.success) {
							//location.href = location.href;
						}else{
							noty({text: "Update failed", type: "error", layout:"topRight", timeout: 5000});
						}
					} catch (e) {
						noty({text: "Update error : "+e, type: "error", layout:"topRight", timeout: 5000});
					}
					
				}, error: function(jqXHR, textStatus, errorThrown) {
					noty({text: "Update error. status="+textStatus+" : "+errorThrown, type: "error", layout:"topRight", timeout: 5000});
				}
		});
		e.preventDefault(); //STOP default action
	});
});

</script>
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
									<div class="col-md-10"><input type="text" name="totalSearchListSize" class="form-control fcol2 required" value="5"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search List Size :</label>
									<div class="col-md-10"><input type="text" name="searchListSize" class="form-control fcol2 required" value="10"></div>
								</div>
							</div>
						</div>
					</div>
					
					
				<form id="search-page-config-form">
					<input type="hidden" name="uri" value="/settings/search-config/update"/>
					
					<div class="widget margin-space">
						<div class="widget-header">
							<h4>Category List</h4>
						</div>
						<div class="widget-content">
							<div class="category-group col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Display Order :</label>
									<div class="col-md-10"><input type="text" name="order_1" class="form-control fcol2 display-inline required" value="1"> <a href="#" class="btn">Remove</a></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category Name :</label>
									<div class="col-md-10"><input type="text" name="categoryName_1" class="form-control fcol2 display-inline required" value="커뮤니티"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category ID :</label>
									<div class="col-md-10"><input type="text" name="categoryId_1" class="form-control fcol2 required" value="community"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search Query :</label>
									<div class="col-md-10"><textarea rows="3" name="searchQuery_1" class="form-control required">fl=title,content,date,author&se={title:#keyword}</textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Title Field ID :</label>
									<div class="col-md-10"><input type="text" name="titleField_1" class="form-control fcol2 required" value="title"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Body Field ID :</label>
									<div class="col-md-10"><input type="text" name="bodyField_1" class="form-control fcol2 required" value="content"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">ETC Field ID :</label>
									<div class="col-md-10"><input type="text" name="etcField_1" class="form-control required" value="date, author"></div>
								</div>
							</div>
							
							<div class="category-group col-md-12 form-horizontal">
								<div class="form-group">
									<label class="col-md-2 control-label">Display Order :</label>
									<div class="col-md-10"><input type="text" name="order_2" class="form-control fcol2 display-inline required" value="2"> <a href="#" class="btn">Remove</a></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category Name :</label>
									<div class="col-md-10"><input type="text" name="categoryName_2" class="form-control fcol2 display-inline required" value="뉴스"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Category ID :</label>
									<div class="col-md-10"><input type="text" name="categoryId_2" class="form-control fcol2 required" value="news"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Search Query :</label>
									<div class="col-md-10"><textarea rows="3" name="searchQuery_2" class="form-control required">fl=title,content,date,author&se={title:#keyword}</textarea></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Title Field ID :</label>
									<div class="col-md-10"><input type="text" name="titleField_2" class="form-control fcol2 required" value="title"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">Body Field ID :</label>
									<div class="col-md-10"><input type="text" name="bodyField_2" class="form-control fcol2 required" value="content"></div>
								</div>
								<div class="form-group">
									<label class="col-md-2 control-label">ETC Field ID :</label>
									<div class="col-md-10"><input type="text" name="etcField_2" class="form-control required" value="date, author"></div>
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
									<div class="col-md-10"><input type="text" name="relateKeywordURL" class="form-control required" value="/management/request.html?url=/keyword/relate.xml?keyword=#keyword"></div>
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
									<div class="col-md-10"><input type="text" name="realtimePopularKeywordURL" class="form-control required" value="/management/request.html?url=/keyword/popular/rt.xml?keyword=#keyword"></div>
								</div>
							</div>
						</div>
					</div>
					
					
					
					<div class="form-actions">
						<button type="submit" class="btn btn-primary fcol2" >Save Changes</button>
					</div>
				</form>
				
					
					<br>
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>