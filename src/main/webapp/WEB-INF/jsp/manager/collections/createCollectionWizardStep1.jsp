<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<%@page import="org.jdom2.*"%>
<%@page import="org.json.*" %>
<%@page import="java.util.*"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	String step = (String) request.getAttribute("step");
	JSONObject collectionInfo = (JSONObject) request.getAttribute("collectionInfo");
	JSONObject serverListObject = (JSONObject)request.getAttribute("serverListObject");
	JSONArray serverList = serverListObject.optJSONArray("nodeList");
%>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<link href="${contextPath}/resources/assets/css/collection-wizard.css" rel="stylesheet" type="text/css" />
<script>

$(document).ready(function() {
	
	$("form#collection-config-form").validate();
	
	$("form#collection-config-form select.node-select").change(function() {
		var inputs = $(this).parents("div.form-group").find("input.node-data")[0];
		var value = $(this).val().replace(/^\s+|\s+$/g, "");
		var str = inputs.value;
		var arr = str.split(",");
		var found = false;
		for(var inx=0;inx<arr.length;inx++) {
			if(arr[inx].replace(/^\s+|\s+$/g, "") == value) {
				found = true;
				break;
			}
		}
		
		if(value && !found) {
			if(str) {
				str = str+", ";
			}
			str+=$(this).val();
			inputs.value = str;
		}
		
	});
	
	var form = $("form#collection-config-form");
	form.submit(function(e){
		if(!form.valid()){
			e.preventDefault();
		}
	});
	
	
});

</script>
</head>
<body>
<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
	<div id="content">
		<div class="container">
			<!-- Breadcrumbs line -->
			<div class="crumbs">
				<ul id="breadcrumbs" class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${ROOT_PATH}/manager/index.html">Manager</a></li>
					<li class="current"> Create Collection Wizard</li>
				</ul>
	
			</div>
			<h3>Create Collection Wizard</h3>
			<div class="widget">
				<ul class="wizard">
					<li class="current"><span class="badge">1</span> Set Collection Information</li>
					<li><span class="badge">2</span> Data Mapping</li>
					<li><span class="badge">3</span> Set Field Schema</li>
					<li><span class="badge">4</span> Confirmation</li>
					<li><span class="badge">5</span> Finish</li>
				</ul>
				<div class="wizard-content">
					<div class="wizard-card current">
						<form id="collection-config-form" action="" method="get">
							<input type="hidden" name="step" value="1" />
							<input type="hidden" name="next" value="next"/>
							<div class="row">
								<div class="col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">Collection ID:</label>
										<div class="col-md-10"><input type="text" name="collectionId" class="form-control required fcol2" value="${collectionId}"></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Collection Name:</label>
										<div class="col-md-10"><input type="text" name="collectionName" class="form-control required fcol2" value="${collectionName}"></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Index Node:</label>
										<div class="col-md-10">
											<select class=" select_flat form-control fcol2" name="indexNode">
												<%
												for(int inx=0;inx<serverList.length();inx++) {
													JSONObject serverInfo = serverList.optJSONObject(inx);
													String active = serverInfo.optString("active");
													String nodeId = serverInfo.optString("id");
													String nodeName = serverInfo.optString("name");
												%>
													<% if("true".equals(active)) { %>
													<option value="<%=nodeId%>" <%=nodeId.equals(request.getAttribute("indexNode"))?"selected":"" %>><%=nodeName%></option>
													<% } %>
												<%
												}
												%>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Search Node List :</label>
										<div class="col-md-10 form-inline">
											<input type="text" name="searchNodeList" class="form-control fcol2 node-data required" value="${searchNodeList}">
											&nbsp;<select class=" select_flat form-control fcol2 node-select">
												<option value="">:: Add Node ::</option>
												<%
												for(int inx=0;inx<serverList.length();inx++) {
													JSONObject serverInfo = serverList.optJSONObject(inx);
													String active = serverInfo.optString("active");
													String nodeId = serverInfo.optString("id");
													String nodeName = serverInfo.optString("name");
												%>
													<% if("true".equals(active)) { %>
													<option value="<%=nodeId%>"><%=nodeName%> (<%=nodeId %>)</option>
													<% } %>
												<%
												}
												%>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Data Node List :</label>
										<div class="col-md-10 form-inline">
											<input type="text" name="dataNodeList" class="form-control fcol2 node-data required" value="${dataNodeList}">
											&nbsp;<select class="select_flat form-control fcol2 node-select">
												<option value="">:: Add Node ::</option>
												<%
												for(int inx=0;inx<serverList.length();inx++) {
													JSONObject serverInfo = serverList.optJSONObject(inx);
													String active = serverInfo.optString("active");
													String nodeId = serverInfo.optString("id");
													String nodeName = serverInfo.optString("name");
												%>
													<% if("true".equals(active)) { %>
													<option value="<%=nodeId%>"><%=nodeName%> (<%=nodeId %>)</option>
													<% } %>
												<%
												}
												%>
											</select>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wizard-bottom" >
								<a href="${ROOT_PATH}/manager/index.html" class="btn">Cancel</a>
								<input type="submit" value="Next" class="btn btn-primary fcol2">
							</div>
						</form>
					</div>
					
					
				</div>
			</div>
			<!-- /Page Header -->
		</div>
	</div>
	
</body>
</html>
