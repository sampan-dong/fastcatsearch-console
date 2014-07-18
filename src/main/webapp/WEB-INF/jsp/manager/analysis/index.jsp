<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="
org.jdom2.Element,
java.util.List
"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />

<%
String analysisId = (String) request.getAttribute("analysisId"); 
%>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />

<script>
$(document).ready(function(){
	$("#analyzeToolsForm").validate();
	
	$("#analyzeToolsForm").submit(function(e) {
		e.preventDefault(); //STOP default page load submit
		
		if(! $(this).valid()){
			return;
		}
		
		var formData = $(this).serializeArray();
		$.ajax({
				url : "analyzeTools.html",
				type: "POST",
				data : formData,
				dataType : "html",
				success:function(data, textStatus, jqXHR) {
					try {
						//console.log("search success.", data);
						$("#analyzedResult").html(data);
					} catch (e) { 
						alert("Abnormal result "+data);
					}
				}, error: function(jqXHR, textStatus, errorThrown) {
					alert("ERROR" + textStatus + " : " + errorThrown);
				}
		});
		
	});
});
</script>

</head>
<%
Element element = null;
Element rootElement = (Element) request.getAttribute("setting");

String analyzerName = "";

String description = "";

String namespace = "";

String analyzerClass = "";

String analyzerVersion = "";

boolean usedb = false;

List<Element> dictionaryList = null;
List<Element> scheduleList = null;
List<Element> actionList = null;
List<Element> analyzerList = null;

if(rootElement!=null) {

	analyzerName = rootElement.getChildText("name");
	
	description = rootElement.getChildText("description");
	
	namespace = rootElement.getAttributeValue("namespace");
	
	analyzerClass = rootElement.getAttributeValue("class");
	
	analyzerVersion = rootElement.getChildText("version");
	
	usedb = "true".equals(rootElement.getChildText("use-db"));
	

	if((element = rootElement.getChild("dictionary-list"))!=null) {
		dictionaryList = element.getChildren();
	}
	
	if((element = rootElement.getChild("schedule-list"))!=null) {
		scheduleList = element.getChildren();
	}
	
	if((element = rootElement.getChild("action-list"))!=null) {
		actionList = element.getChildren();
	}
	
	if((element = rootElement.getChild("analyzer-list"))!=null) {
		analyzerList = element.getChildren();
	}
}

%>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="analysis" />
			<c:param name="mcat" value="${analysisId}" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Analysis</li>
						<li class="current"> ${analysisId} </li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>${analysisId}</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_analysis_settings" data-toggle="tab">Settings</a></li>
						<li class=""><a href="#tab_analysis_tools" data-toggle="tab">Tools</a></li>
					</ul>
					
					<div class="tab-content row">
						<div class="tab-pane active" id="tab_analysis_settings">
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Overview</h4>
									</div>
									<div class="widget-content">
										<dl class="dl-horizontal">
											<dt>ID</dt>
											<dd>${analysisId} analysis</dd>
											<dt>Namespace</dt>
											<dd><%=namespace%></dd>
											<dt>Class</dt>
											<dd><%=analyzerClass%></dd>
											<dt>Name</dt>
											<dd><%=analyzerName%></dd>
											<dt>Version</dt>
											<dd><%=analyzerVersion%></dd>
											<dt>Decription</dt>
											<dd><%=description %></dd>
										</dl>
									</div>
								</div>
								<% 
								if (dictionaryList!=null) { 
								%>
								<div class="widget">
									<div class="widget-header">
										<h4>Dictionary</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>#</th>
													<th>ID</th>
													<th>Name</th>
													<th>Dictionary File</th>
													<th>Dictionary Type</th>
													<th>Ignore Case</th>
													<th>Columns</th>
												</tr>
											</thead>
											<tbody>
												<%
												for(int rowInx=0;rowInx<dictionaryList.size();rowInx++) {
												%>
													<%
													Element dictionary = dictionaryList.get(rowInx);
													String dictionaryId = dictionary.getAttributeValue("id");
													String dictionaryName = dictionary.getAttributeValue("name");
													String dictionaryType = dictionary.getAttributeValue("type");
													String ignoreCase = dictionary.getAttributeValue("ignoreCase");
													if(dictionaryType==null) {
														dictionaryType="";
													}
													if(ignoreCase != null && ignoreCase.equalsIgnoreCase("true")){
														ignoreCase = "Y";
													}else{
														ignoreCase = "N";
													}
													List<Element> schema = dictionary.getChildren();
													%>
													<tr>
														<td><%=rowInx+1 %></td>
														<td><strong><%=dictionaryId %></strong></td>
														<td><%=dictionaryName %></td>
														<td><i><%=dictionaryId.toLowerCase() %>.dict</i></td>
														<td><span class="label label-default"><%=dictionaryType %></span></td>
														<td><%=ignoreCase %></td>
														<td>
														<% if(schema!=null && schema.size() > 0) { %>
															<a data-toggle="modal" href="#schemaView<%=rowInx%>" >View</a>
														<% } %>
														</td>
													</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<%
								}
								%>
									
								<%
								if(analyzerList!=null) {
								%>		
								<div class="widget">
									<div class="widget-header">
										<h4>Analyzer</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>#</th>
													<th>ID</th>
													<th>Name</th>
													<th>Class</th>
												</tr>
											</thead>
											<tbody>
												<%
												for(int rowInx=0;rowInx<analyzerList.size();rowInx++) {
												%>
													<%
													Element analyzer = analyzerList.get(rowInx);
													String id = analyzer.getAttributeValue("id");
													String name = analyzer.getAttributeValue("name");
													String className = analyzer.getAttributeValue("className");
													%>
													<tr>
														<td><%=rowInx+1 %></td>
														<td>${analysisId}.<%=id.toUpperCase() %></td>
														<td><%=name %></td>
														<td><i><%=className %></i></td>
													</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<%
								}
								%>		
										
								<%
								boolean hasAnalysisDetailTools = false; //상세분석툴 action이 있는지 여부.
								if(actionList!=null) {
								%>		
								<div class="widget">
									<div class="widget-header">
										<h4>Action</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>#</th>
													<th>URI</th>
													<th>Method</th>
													<th>Class</th>
												</tr>
											</thead>
											<tbody>
												<%
												for(int rowInx=0;rowInx<actionList.size();rowInx++) {
													Element action = actionList.get(rowInx);
													String actionClass = action.getAttributeValue("className");
													String methods = action.getAttributeValue("methods");
													String actionMethod = methods != null ? methods.toUpperCase() : "";
													String actionUri = action.getAttributeValue("uri");
													hasAnalysisDetailTools = "/analysis-tools-detail".equals(actionUri);
													String cssClass = "";
													if(actionUri == null){
														actionUri = "[Not Available]";
														cssClass = "danger";
													}else{
														actionUri = "/_plugin/" + analysisId + actionUri;
													}
													%>
													<tr class="<%=cssClass %>">
														<td><%=rowInx+1 %></td>
														<td><%=actionUri %></td>
														<td><%=actionMethod %></td>
														<td><i><%=actionClass %></i></td>
													</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<%
								}
								%>
											
								<%
								if(scheduleList!=null) {
								%>
								<div class="widget">
									<div class="widget-header">
										<h4>Schedule</h4>
									</div>
									<div class="widget-content">
										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>#</th>
													<th>Task</th>
													<th>Base Time</th>
													<th>Period</th>
												</tr>
											</thead>
											<tbody>
												<%
												for(int rowInx=0;rowInx<scheduleList.size();rowInx++) {
												%>
													<%
													Element schedule = scheduleList.get(rowInx);
													String scheduleClass = schedule.getAttributeValue("class");
													String startTime = schedule.getAttributeValue("startTime");
													int period = -1;
													String unit = "Minute";
													try {
														period = Integer.parseInt(schedule.getAttributeValue("periodInMinute"));
													} catch (Exception e) {
													}
													if(period > 60) {
														period = period / 60;
														unit = "Hour";
													}
													%>
													
													<tr id="schedule_<%=rowInx+1%>">
														<td><%=rowInx+1 %></td>
														<td><strong><%=scheduleClass %></strong></td>
														<td><%=startTime %></td>
														<td>
														<% if(period != -1) { %>
															<%=period %> <%=unit %>
														<% } %>
														</td>
													</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
								<%
								}
								%>
							
							
							
							
							</div>
						
							
						</div>
						
						<!-- tab_analysis_tools -->
						<div class="tab-pane" id="tab_analysis_tools">
							<div class="col-md-12">
								<form role="form" id="analyzeToolsForm">
									
									<div class="form-group">
										<label for="words" class="control-label">Query Words:</label>
										<input type="text" class="form-control required largeText" name="queryWords" placeholder="Query Words" value="Sandisk Extream Z80 USB 16gb"/>
									</div>
									
									<div class="form-inline">
										<div class="form-group">
											<label class="radio">
												<input type="radio" name="type" class="form-control" value="simple" checked> Simple
											</label>
										</div>
										<%
										if(hasAnalysisDetailTools) {
										%>
										&nbsp;
										<div class="form-group">
											<label class="radio">
												<input type="radio" name="type" class="form-control" value="detail"> Detail
											</label>
										</div>
										<%
										}
										%>
										&nbsp;
										<div class="form-group">
											<label class="checkbox">
												<input type="checkbox" name="isForQuery" class="" value="true" checked > For Query
											</label>
										</div>
										&nbsp;
										<select name="analyzerId" class="select_flat form-control fcol2-1">
											<%
											for(int rowInx=0;rowInx<analyzerList.size();rowInx++) {
											%>
												<%
												Element analyzer = analyzerList.get(rowInx);
												String id = analyzer.getAttributeValue("id");
												String name = analyzer.getAttributeValue("name");
												%>
												<option value="<%=id %>"><%=name %></option>
											<%
											}
											%>
										</select>
										&nbsp;
											
										<div class="form-group">
											<button class="btn btn-sm">Analyze</button>
										</div>
									</div>
								</form>
							</div>
							<br/>
							
							<!-- 분석결과 -->
							<div class="col-md-12" id="analyzedResult"></div>
							<!--// 분석결과 -->
						</div>
						<!--// tab_analysis_tools -->
						
					</div>
				
				</div>


				

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
	<% 
	for (int rowInx=0;dictionaryList!=null && rowInx < dictionaryList.size(); rowInx++) { 
	%>
		<%
		Element dictionary = dictionaryList.get(rowInx);
		String dictionaryId = dictionary.getAttributeValue("id");
		String dictionaryName = dictionary.getAttributeValue("name");
		List<Element>schema = dictionary.getChildren();
		%>
		<div class="modal" id="schemaView<%=rowInx%>">
			<div class="modal-dialog" style="width: 900px;">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Dictionary Schema ( <%=dictionaryName %> )</h4>
					</div>
					<div class="modal-body">
						<table class="table table-hover table-bordered">
						<thead>
							<tr>
								<th>#</th>
								<th>Name</th>
								<th>Type</th>
								<th>Key</th>
								<th>Index</th>
								<th>Search</th>
								<th>Compile</th>
								<th>NullUnique</th>
							</tr>
						</thead>
						<tbody>
						<%
						for(int colInx=0; colInx < schema.size(); colInx++) {
						%>
							<%
							Element columns = schema.get(colInx);
							String columnName = columns.getAttributeValue("name").toUpperCase();
							String columnType = columns.getAttributeValue("type").toUpperCase();
							String isKey = columns.getAttributeValue("key");
							if(isKey != null){
								isKey = isKey.toUpperCase();
							}else{
								isKey = "FALSE";
							}
							String isIndex = columns.getAttributeValue("index").toUpperCase();
							String isSearchable = columns.getAttributeValue("searchable").toUpperCase();
							String isCompilable = columns.getAttributeValue("compilable").toUpperCase();
							String isNullableUnique = columns.getAttributeValue("nullableUnique").toUpperCase();
							%>
							<tr>
								<td><%=colInx+1 %></td>
								<td><%=columnName %></td>
								<td><%=columnType %></td>
								<td><%=isKey %></td>
								<td><%=isIndex %></td>
								<td><%=isSearchable %></td>
								<td><%=isCompilable %></td>
								<td><%=isNullableUnique %></td>
							</tr>
						<%
						}
						%>
						</tbody>
						</table>
					</div>
					<div class="modal-footer">
			        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      		</div>
				</div>
				<!-- /.modal-content -->
				
			</div>
			<!-- /.modal-dialog -->
		</div>
	<%
	}
	%>
						
</body>
</html>