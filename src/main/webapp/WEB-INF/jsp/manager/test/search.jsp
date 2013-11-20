<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){
	$("#searchStructured").on("click", function(){
		$("#structuredSearchTest").submit();
	});
	$("#searchQuery").on("click", function(){
		
	});
	
	$("#structuredSearchTest").submit(function(e) {
		var postData = $(this).serializeArray();
		$.ajax({
				url : PROXY_REQUEST_URI,
				type: "POST",
				data : postData,
				dataType : "json",
				success:function(data, textStatus, jqXHR) {
					try {
						if(data.status == 0) {
							console.log("search success.", data);
							$("#searchResultModal").modal({show:true, backdrop:'static'});
						}else{
							alert("search failed. " + data);	
						}
					} catch (e) { 
						alert("Abnormal result "+data);
					}
				}, error: function(jqXHR, textStatus, errorThrown) {
					alert("ERROR" + textStatus + " : " + errorThrown);
				}
		});
		e.preventDefault(); //STOP default page load submit
	});
	
});

</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="test" />
			<c:param name="mcat" value="search" />
			<c:param name="scat" value="" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Test</li>
						<li class="current"> Search</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Search</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul id="data_tab" class="nav nav-tabs">
						<li class="active"><a href="#tab_structured_search" data-toggle="tab">Structured Search</a></li>
						<li class=""><a href="#tab_query_search" data-toggle="tab">Query Search</a></li>
						<li class=""><a href="#tab_search_result" data-toggle="tab">Search Result</a></li>
					</ul>
					<div class="tab-content row">
						<div class="tab-pane active" id="tab_structured_search">
						
							<div class="col-md-12">
								<form class="col-md-12 form-horizontal searchTest" id="structuredSearchTest" role="form">
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">COLLECTION NAME</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="cn" placeholder="CN">news_kor</textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">SHARD NAME</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="sd" placeholder="SD">news_kor</textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">FIELD LIST</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="fl" placeholder="FL">code,title</textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">SEARCH</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="se" placeholder="SE">{title:김규리}</textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">FILTER</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="ft" placeholder="FT"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">GROUP</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="gr" placeholder="GR"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">START</label>
										<div class="col-sm-2">
											<input class="form-control" name="sn" placeholder="SN" value="1">
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">LENGTH</label>
										<div class="col-sm-2">
											<input class="form-control" name="ln" placeholder="LN" value="10">
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">SEARCH OPTION</label>
										<div class="col-sm-10">
											<input class="form-control" name="so" placeholder="SO" value="nocache">
										</div>
									</div>
									<div class="form-group">
										<label for="query_se" class="col-sm-2 control-label">USER DATA</label>
										<div class="col-sm-10">
											<textarea class="form-control" name="ud" placeholder="UD"></textarea>
										</div>
									</div>
									<div class="form-group">
										<div class="col-sm-offset-2 col-sm-3">
											<select name="uri" class="form-control select_flat" >
												<option value="/service/search.json">Search</option>
												<option value="/service/search/group.json">Grouping</option>
												<option value="/service/search-single.json">Search (Single)</option>
												<option value="/service/search-single/group.json">Grouping (Single)</option>
											</select>
										</div>
										<div class="col-sm-4">
											<a href="javascript:void(0);" id="searchStructured" class="btn btn-primary" >Search</a>
										</div>
									</div>
		
								</form>
								
							</div>
						</div>
					
					
					
						<div class="tab-pane" id="tab_query_search">
							<div class="col-md-12">
								<form role="form" id="querySearchTest">
									<div class="form-group">
										<textarea class="form-control long6" id="query_raw" placeholder="Query"></textarea>
									</div>
									<div class="form-group">
										<div class="col-sm-3">
											<select name="uri" class="form-control select_flat" >
												<option value="/service/search.json">Search</option>
												<option value="/service/search/group.json">Grouping</option>
												<option value="/service/search-single.json">Search (Single)</option>
												<option value="/service/search-single/group.json">Grouping (Single)</option>
											</select>
										</div>
										<div class="col-sm-4">
											<button id="searchStructured" class="btn btn-primary">Search</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						
						
						<div class="tab-pane" id="tab_search_result"></div>
						
						
						
					</div>
					<!-- /.tab-content -->
				</div>
				
			</div>
		</div>
	</div>



<div class="modal" id="searchResultModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">Search Result</h4>
			</div>
			<div class="modal-body" id="searchResultModalBody">
			</div>
			<div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
</body>
</html>