<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="org.jdom2.*" %>
<%@ page import="java.util.*" %>
<%
Document searchConfig = (Document) request.getAttribute("searchConfig");
%>

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
		
		$.ajax({
				url : PROXY_REQUEST_URI,
				type: "POST",
				data : postData,
				dataType : "json",
				success:function(data, textStatus, jqXHR) {
					try {
						if(data.success) {
							location.href = "../search.html";
						}else{
							noty({text: "Update failed : " + data.message, type: "error", layout:"topRight", timeout: 5000});
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
					<form id="search-page-config-form">
						<%
						Element root = searchConfig.getRootElement();
						String totalSearchListSize = root.getChildText("total-search-list-size");
						String searchListSize = root.getChildText("search-list-size");
						String realtimePopularKeywordUrl = root.getChildText("realtime-popular-keyword-url");
						String relateKeywordUrl = root.getChildText("relate-keyword-url");
						Element searchCategoryList = root.getChild("search-category-list");
						List<Element> searchCategoryElList = searchCategoryList.getChildren("search-category");
						%>

						<div class="widget margin-space">
							<div class="widget-header">
								<h4>Common Settings</h4>
							</div>
							<div class="widget-content">
								<div class="col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">Total Search List Size :</label>
										<div class="col-md-10"><input type="text" name="totalSearchListSize" class="form-control fcol2 required" value="<%=totalSearchListSize%>"></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Search List Size :</label>
										<div class="col-md-10"><input type="text" name="searchListSize" class="form-control fcol2 required" value="<%=searchListSize%>"></div>
									</div>
								</div>
							</div>
						</div>
						
						
					
						<input type="hidden" name="uri" value="/settings/search-config/update"/>
						
						<div class="widget margin-space">
							<div class="widget-header">
								<h4>Category List</h4>
							</div>
							<div class="widget-content">
							
								<%
								for(int i = 0; i < searchCategoryElList.size(); i++){
									Element el = searchCategoryElList.get(i);
									String etcList = "";
									List<Element> etcFieldList = el.getChild("etc-field-list").getChildren("etc-field");
									for(int j = 0; j < etcFieldList.size(); j++){
										if(etcList.length() > 0){
											etcList += ", ";
										}
										etcList += etcFieldList.get(j).getText();
									}
								%>
								<div class="category-group col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">Display Order :</label>
										<div class="col-md-10"><input type="text" name="order_<%=i %>" class="form-control fcol2 display-inline required" value="<%=el.getAttributeValue("order") %>"> <a href="#" class="btn">Remove</a></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Category Name :</label>
										<div class="col-md-10"><input type="text" name="categoryName_<%=i %>" class="form-control fcol2 display-inline required" value="<%=el.getAttributeValue("name")%>"></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Category ID :</label>
										<div class="col-md-10"><input type="text" name="categoryId_<%=i %>" class="form-control fcol2 required" value="<%=el.getAttributeValue("id")%>"></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Search Query :</label>
										<div class="col-md-10"><textarea rows="3" name="searchQuery_<%=i %>" class="form-control required"><%=el.getChildText("search-query")%></textarea>
											<div class="help-block">ex) cn=news_kor&fl=title,content:150,regdate,username&se={title:#keyword}</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Title Field ID :</label>
										<div class="col-md-10"><input type="text" name="titleField_<%=i %>" class="form-control fcol2 required" value="<%=el.getChildText("title-field")%>">
											<div class="help-block">ex) title</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Body Field ID :</label>
										<div class="col-md-10"><input type="text" name="bodyField_<%=i %>" class="form-control fcol2 required" value="<%=el.getChildText("body-field")%>">
											<div class="help-block">ex) content</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">ETC Field ID :</label>
										<div class="col-md-10"><input type="text" name="etcField_<%=i %>" class="form-control required" value="<%=etcList%>">
											<div class="help-block">ex) regdate, username</div>
										</div>
									</div>
								</div>
								<%
								}
								%>
								
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
										<div class="col-md-10"><input type="text" name="relateKeywordURL" class="form-control required" value="<%=relateKeywordUrl%>">
											<div class="help-block">ex) http://demo.fastcatsearch.org:8050/service/keyword/relate.json?keyword=#keyword</div>
										</div>
										
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
										<div class="col-md-10"><input type="text" name="realtimePopularKeywordURL" class="form-control required" value="<%=realtimePopularKeywordUrl%>">
											<div class="help-block">ex) http://demo.fastcatsearch.org:8050/service/keyword/popular/rt.json?siteId=total</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						
						
						
						<div class="form-actions">
							<button type="submit" class="btn btn-primary fcol2" >Save Changes</button>
						</div>
					</form>
				
					
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>