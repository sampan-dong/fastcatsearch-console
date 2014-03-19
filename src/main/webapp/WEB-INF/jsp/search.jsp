<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.regex.*"%>

<%
	JSONObject searchPageResult = (JSONObject) request.getAttribute("searchPageResult");
	JSONObject popularKeywordResult = (JSONObject) request.getAttribute("popularKeywordResult");
	JSONObject relateKeywordResult = (JSONObject) request.getAttribute("relateKeywordResult");

	boolean hasResult = (searchPageResult != null);
	
	String keyword = request.getParameter("keyword");
	if(keyword == null) {
		keyword = "";
	}
	String category = request.getParameter("category");
	if(category == null) {
		category = "";
	}
	String pageNumber = request.getParameter("page");
	if(pageNumber == null || pageNumber.length() == 0) {
		pageNumber = "1";
	}
%>
<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/assets/css/search.css">

<script>

$(document).ready(function(){
	
	$("#searchForm").submit(function(e) {
		if($("#searchBox").val() != ""){
			
		} else {
			return false;
		}
	});
	
});

function searchCategory(categoryId){
	$("#searchForm").find("[name=category]").val(categoryId);
	$("#searchForm").find("[name=page]").val("1");
	$("#searchForm").submit();
}

function search(keyword){
	$("#searchForm").find("[name=page]").val("1");
	$("#searchForm").find("[name=keyword]").val(keyword);
	$("#searchForm").submit();
}

function searchPage(uri, pageNo){
	$("#searchForm").find("[name=page]").val(pageNo);
	$("#searchForm").submit();
}

</script>


</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
	<div id="content">
		<div class="container">
			<!--=== Page Header ===-->
			<div class="page-header">
			</div>
			<!-- /Page Header -->
			
			<!--=== Page Content ===-->
			<div class="row bottom-space-sm">
				<form id="searchForm" method="get">
					<input type="hidden" name="category" value="<%=category %>" />
					<input type="hidden" name="page" value="<%=pageNumber %>" />
					<div class="col-xs-10 col-sm-4 col-sm-offset-3" style="padding-right: 5px;">
						<input type="text" id="searchBox" class="form-control" name="keyword" value="<%=keyword %>" style="border: 5px solid #416cb6;font-size: 18px !important; height:40px;"> 
						<ul class="relate-keyword">
						<%
						if(relateKeywordResult != null){
							JSONArray relateKeywordList =  relateKeywordResult.optJSONArray("relate");
							if(relateKeywordList != null){
								int maxCount = Math.min(relateKeywordList.length(), 7);
								for(int i=0; i < maxCount; i++){
									String relateKeyword = relateKeywordList.getString(i);
								%>
								<li><a href="javascript:search('<%=relateKeyword%>')"><%=relateKeyword %></a></li>
								<%
								}
							}
						}
						%>
						</ul>
					</div>
					<div style="padding-left: 0px;">
						<button class="btn btn-primary" type="submit" id="searchButton" style=" height:40px;">Search</button>
						<span style="float:right; margin: 0px 15px;"><a href="search/config.html"><i class="icon-cog"></i> Config</a></span>
					</div>
				</form>
			</div>
			<%
			if(hasResult) {
			%>
			
			<div class="row">
				<div class="col-md-10" style="padding-right: 0px;">
					<div class="tabbable tabbable-custom tabs-left">
						<!-- Only required for left/right tabs -->
						<ul id="category_tab" class="nav nav-tabs tabs-left">
							<li class="<%=(category == null || category.length() == 0) ? "active" : ""%>"><a href="javascript:searchCategory()"><strong>Total Search</strong></a></li>
							<%
							JSONArray categoryList = searchPageResult.getJSONArray("category-list");
							for(int i = 0 ; i < categoryList.length(); i++){
								JSONObject categoryInfo = categoryList.getJSONObject(i);
								String categoryId = categoryInfo.getString("id");
							%>
							<li class="<%=(categoryId.equals(category)) ? "active" : "" %>"><a href="javascript:searchCategory('<%=categoryInfo.getString("id") %>')" ><strong><%=categoryInfo.getString("name") %></strong></a></li>
							<%
							}
							%>
							
						</ul>
						<div class="tab-content result-pane">
							<%
							
							Pattern pattern = Pattern.compile("#(\\w+)");
							
							if(category == null || category.length() == 0){
							%>
							<div class="tab-pane active" id="tab_total_search">
								<%
								int totalCount = 0;
								JSONArray resultList = searchPageResult.getJSONArray("result-list");
								for(int i = 0 ; i < resultList.length(); i++){
									JSONObject categoryResult = resultList.getJSONObject(i);
									JSONObject searchResult = categoryResult.getJSONObject("result");
									totalCount += searchResult.getInt("total_count");
								}
								%>
								<div class="">
								<%=totalCount %> results (<%=searchPageResult.getString("time") %>s) 
								</div>
								
								
								<%
								for(int i = 0 ; i < resultList.length(); i++){
									JSONObject categoryResult = resultList.getJSONObject(i);
									String categoryId = categoryResult.getString("id");
									String categoryName = categoryResult.getString("name");
									String titleField = categoryResult.getString("titleField");
									String bodyField = categoryResult.getString("bodyField");
									String clickLink = categoryResult.getString("clickLink");
									JSONArray etcFieldList = categoryResult.getJSONArray("etcField");
									
									JSONObject searchResult = categoryResult.getJSONObject("result");
									
									JSONArray searchResultList = searchResult.getJSONArray("result");
									
									int categoryTotalCount = searchResult.getInt("total_count");
									if(categoryTotalCount == 0){
										continue;
									}
									
									boolean hasLink = (clickLink != null && clickLink.length() > 0);
								%>
								<div class="row col-md-12">
									<h3 style="border-bottom:1px solid #eee;"><%=categoryName %></h3>
									<div class="col-md-10">
										<ul class="search-result">
											<%
											for(int j = 0; j < searchResultList.length(); j++) {
												JSONObject item = searchResultList.getJSONObject(j);
												String etcData = "";
												for(int k = 0; k < etcFieldList.length(); k++) {
													if(k > 0){
														etcData += " | ";
													}
													String fieldId = etcFieldList.getString(k);
													etcData += item.getString(fieldId);
												}
												
												if(hasLink){
													Matcher matcher = pattern.matcher(clickLink);
													// check all occurance
													while (matcher.find()) {
														String key0 = matcher.group();
														String key = matcher.group(1).toUpperCase(); //필드명은 대문자이다.
														String value = item.optString(key);
														if(value == null){
															value = "";
														}
														clickLink = clickLink.replaceAll(key0, value);
													}
												}
											%>
											<li>
												<h3>
												<%
												if(hasLink){
												%>
												<a href="<%=clickLink %>" target="_fastcatsearch_demo"><%=item.getString(titleField) %></a>
												<%
												}else{
												%>
												<%=item.getString(titleField) %>
												<%
												}
												%>
												</h3>
												<div class="r"><%=item.getString(bodyField) %></div>
												<div class="etc"><%=etcData %></div>
											</li>
											<%
											}
											%>
										</ul>
										<%
										if(categoryTotalCount > searchResultList.length()){
										%>
										<div class="pull-right"><a href="javascript:searchCategory('<%=categoryId %>');">more results »</a></div>
										<%
										}
										%>
									</div>
								</div>
								<%
								}
								%>
							</div>
							<%
							} else {
								
								for(int i = 0 ; i < categoryList.length(); i++){
									JSONObject categoryInfo = categoryList.getJSONObject(i);
									String categoryId = categoryInfo.getString("id");
									String categoryName = categoryInfo.getString("name");
									
									if(categoryId.equals(category)){
										JSONArray resultList = searchPageResult.getJSONArray("result-list");
										JSONObject categoryResult = resultList.getJSONObject(0);
										
										String titleField = categoryResult.getString("titleField");
										String bodyField = categoryResult.getString("bodyField");
										String clickLink = categoryResult.getString("clickLink");
										int searchListSize = categoryResult.getInt("searchListSize");
										JSONArray etcFieldList = categoryResult.getJSONArray("etcField");
										
										JSONObject searchResult = categoryResult.getJSONObject("result");
										
										JSONArray searchResultList = searchResult.getJSONArray("result");
										
										int categoryTotalCount = searchResult.getInt("total_count");
										
										boolean hasLink = (clickLink != null && clickLink.length() > 0);
							%>
								
								<div class="tab-pane active" id="tab_<%=categoryId %>">
									<%
									if(categoryTotalCount > 0){
									%>
									<div>
									Page <%=pageNumber %> of <%=searchResult.getInt("total_count") %> results (<%=searchPageResult.getString("time") %>s) 
									</div>
									<h3 style="border-bottom:1px solid #eee;"><%=categoryName %></h3>
									<div class="col-md-12 ires">
										<ul class="search-result">
										<%
										for(int j = 0; j < searchResultList.length(); j++) {
											JSONObject item = searchResultList.getJSONObject(j);
											String etcData = "";
											for(int k = 0; k < etcFieldList.length(); k++) {
												if(k > 0){
													etcData += " | ";
												}
												String fieldId = etcFieldList.getString(k);
												etcData += item.getString(fieldId);
												
											}
											
											if(hasLink){
												Matcher matcher = pattern.matcher(clickLink);
												// check all occurance
												while (matcher.find()) {
													String key0 = matcher.group();
													String key = matcher.group(1).toUpperCase(); //필드명은 대문자이다.
													String value = item.optString(key);
													if(value == null){
														value = "";
													}
													clickLink = clickLink.replaceAll(key0, value);
												}
											}
										%>
										<li>
											<h3>
												<%
												if(hasLink){
												%>
												<a href="<%=clickLink %>" target="_fastcatsearch_demo"><%=item.getString(titleField) %></a>
												<%
												}else{
												%>
												<%=item.getString(titleField) %>
												<%
												}
												%>
											</h3>
											<div class="r"><%=item.getString(bodyField) %></div>
											<div class="etc"><%=etcData %></div>
										</li>
										<%
										}
										%>
										</ul>
										
										<jsp:include page="inc/pagenation.jsp" >
										 	<jsp:param name="pageNo" value="<%=pageNumber %>"/>
										 	<jsp:param name="totalSize" value="<%=categoryTotalCount %>" />
											<jsp:param name="pageSize" value="<%=searchListSize %>" />
											<jsp:param name="width" value="5" />
											<jsp:param name="callback" value="searchPage" />
										 </jsp:include>
									</div>
									
									<%
									}else{
									%>
									<h3 style="border-bottom:1px solid #eee;"><%=categoryName %></h3>
									<div class="col-md-12 ires"> No result. </div>
									
									<%
									}
									%>
								</div>
							<%
									} //if
								} //for
							} //if else
							%>
						</div>
					</div>

				</div>

				<div class="col-md-2" style="padding-left: 0px;">
					<%
					if(popularKeywordResult != null){
					%>
					<div class="panel panel-default" style="border-left: 0px;">
						<div class="panel-heading">
							<h3 class="panel-title">Popular Keyword</h3>
						</div>
						<div class="panel-body" style="padding: 10px 2px 0px 10px;">
							<ol class="popular-keyword">
							
							<%
							JSONArray popularKeywordList =  popularKeywordResult.optJSONArray("list");
							if(popularKeywordList != null){
								for(int i=0; i < popularKeywordList.length(); i++){
									JSONObject popularKeywordObj = popularKeywordList.getJSONObject(i);
									int rank = popularKeywordObj.getInt("rank");
									String word = popularKeywordObj.getString("word");
									String diffType = popularKeywordObj.getString("diffType");
									int diff = popularKeywordObj.getInt("diff");
								%>
								<li>
									<span class="badge badge-sx"><%=rank%></span> 
									<a href="javascript:search('<%=word %>')"><%=word %></a>
									<div class="rank-status">
									<%
									if(diffType.equals("NEW")){
										%><i class="rank-<%=diffType.toLowerCase()%>"></i><%
									}else if(diffType.equals("EQ")){
										%><i class="rank-<%=diffType.toLowerCase()%>"></i><%
									}else{
										%><i class="rank-<%=diffType.toLowerCase()%>"></i> <span class="_step"><%=diff %></span><%
									}
									%>
									</div>
								</li>
								<%
								}
							}
							%>
							</ol>
						</div>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<%
			}
			%>
			
			<!-- /Page Content -->
		</div>
		<!-- /.container -->

	</div>
</div>
</body>
</html>