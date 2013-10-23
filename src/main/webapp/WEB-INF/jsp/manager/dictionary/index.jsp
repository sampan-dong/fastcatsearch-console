<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%
	JSONArray dictionaryList = (JSONArray) request.getAttribute("list");
%>


<c:set var="ROOT_PATH" value="../.." scope="request" />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />

<script>
$(document).ready(function(){
	//load dictionary tab contents
	$('#dictionary_tab a').on('shown.bs.tab', function (e) {
		var targetId = e.target.hash;
		var aObj = $(e.target);
		if($(targetId).text() != ""){
			//이미 로드되어있으면 다시 로드하지 않음.
			return;
		}
		var dictionaryId = aObj.attr("_id");
		var dictionaryType = aObj.attr("_type");
		loadDictionaryTab(dictionaryType, dictionaryId, 1, null, false, targetId);
	});
});

</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="dictionary" />
			<c:param name="mcat" value="${analysisId}" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Dictionary</li>
						<li class="current"> Korean</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Korean</h3>
					</div>
				</div>
				<!-- /Page Header -->
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul id="dictionary_tab" class="nav nav-tabs">
						<li class="active"><a href="#tab_dictionary_overview" data-toggle="tab">Overview</a></li>
						
						<%
						for(int i = 0; i < dictionaryList.length(); i++){
							JSONObject dictionary = dictionaryList.getJSONObject(i);
							String id = dictionary.getString("id");
							String name = dictionary.getString("name");
							String type = dictionary.getString("type");
						%>
						<li class=""><a href="#tab_dictionary_<%=id %>" data-toggle="tab" _type="<%=type %>" _id="<%=id %>"><%=name %></a></li>
						<%
						}
						%>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_dictionary_overview">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-time"></span> Sync Search Engine</a>
										</div>
									</div>
									<table class="table table-hover table-bordered table-checkable">
										<thead>
											<tr>
												<th class="checkbox-column">
													<input type="checkbox" class="uniform">
												</th>
												<th>Name</th>
												<th>Entry Size</th>
												<th>Sync Time</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<%
											for(int i = 0; i < dictionaryList.length(); i++){
												JSONObject dictionary = dictionaryList.getJSONObject(i);
											%>
											<tr>
												<td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong><%=dictionary.getString("name") %></strong></td>
												<td><%=dictionary.getInt("entrySize") %></td>
												<td><%=dictionary.getString("syncTime") %></td>
												<td>
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-upload"></span> Upload
												</a>
												&nbsp;
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-download"></span> Download
												</a>
												</td>
											</tr>
											<%
											}
											%>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<%
						for(int i = 0; i < dictionaryList.length(); i++){
							JSONObject dictionary = dictionaryList.getJSONObject(i);
							String id = dictionary.getString("id");
							String name = dictionary.getString("name");
							String type = dictionary.getString("type");
						%>
						<div class="tab-pane" id="tab_dictionary_<%=id %>"></div>
						<%
						}
						%>
						
						<!-- Synonym Dict -->
						<div class="tab-pane hide" id="tab_synonym_dictionary">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										
										
										<div class="input-group col-md-6">
											<span class="input-group-addon"><i class="icon-search"></i></span> <input type="text"
												class="form-control" placeholder="Search">
										</div>
										
										<div class="col-md-6">
											<div class="pull-right">
												<div class="btn-group">
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
												</div>
												&nbsp;
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-edit"></span> Edit
												</a>
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-saved"></span> Done
												</a>
											</div>
										</div>
									</div>
									

									<table class="table table-hover table-bordered">
										<thead>
											<tr>
												<th style="width:20%">Representative</th>
												<th>Word Entry</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><span class="my_r_tag">가나다</span></td>
												<td>
													<span class="mytag">가나다</span><span class="mytag">마바사</span><span class="mytag">아자차</span><span class="mytag">카타파</span><span class="mytag">하하하</span><span class="mytag">가나다</span><span class="mytag">마바사</span>
												</td>
											</tr>
											<tr>
												<td><span class="my_r_tag">아이폰</span></td>
												<td>
													<span class="mytag">가나다</span><span class="mytag">마바사</span><span class="mytag">아자차</span><span class="mytag">카타파</span><span class="mytag">하하하</span><span class="mytag">가나다</span><span class="mytag">마바사</span>
												</td>
											</tr>
										</tbody>
									</table>
									
									<table id="mytable" class="table table-hover table-bordered">
										<thead>
											<tr>
												<th style="width:30px">&nbsp;</th>
												<th style="width:20%">Representative</th>
												<th>Word Entry</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><label class="radio"><input type="radio" class="uniform" name="wordSelect" value="1"></label></td>
												<td><input type="text" class="form-control mytag_input" value="나다사"></td>
												<td>
													<input type="text" class="tags" value="가나다,라마바사,아자"> 	
												</td>
											</tr>
											<tr>
												<td><div class="form-group"><label class="radio"><input type="radio" class="uniform" name="wordSelect" value="2"></label></div></td>
												<td><input type="text" class="form-control mytag_input" value="아이폰"></td>
												<td><input type="text" class="tags" value="tags,with,autocomplete"> 
												</td>
											</tr>
										</tbody>
									</table>
									
									<div class="table-footer">
									<div class="col-md-6">
											Rows 1 - 50 of 2809 (filtered from 8 total entries)
										</div>
										
										<div class="col-md-6">
											<ul class="pagination">
												<li class="disabled"><a href="javascript:void(0);">&laquo;</a></li>
												<li class="active"><a href="javascript:void(0);">1</a></li>
												<li><a href="javascript:void(0);">2</a></li>
												<li><a href="javascript:void(0);">3</a></li>
												<li><a href="javascript:void(0);">4</a></li>
												<li><a href="javascript:void(0);">5</a></li>
												<li><a href="javascript:void(0);">&raquo;</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //Synonym Dict -->
						<!-- //tab field -->
					</div>
					<!-- /.tab-content -->
				</div>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>