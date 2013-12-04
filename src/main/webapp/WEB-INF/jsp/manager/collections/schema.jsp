<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="java.util.*"%>
<%
	Document document = (Document) request.getAttribute("document");
	String schemaType = (String) request.getAttribute("schemaType");
	boolean isWorkSchema = "workSchema".equals(schemaType);
%>
<c:set var="ROOT_PATH" value="../.." scope="request"/>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>

$(document).ready(function(){
	showOverview();
});
	function showOverview(){
		console.log("showOverview");
		$("#tab_key_overview").addClass("active"); //탭표시.
		$("#tab_key_overview").siblings().removeClass("active"); //탭표시.
		$(".tab-pane").addClass("active");
	}
	function reloadSchema(){
		location.href = location.href;		
	}
	
	function editWorkSchema(){
		submitGet("workSchemaEdit.html", {});
	}
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
	 <c:import url="${ROOT_PATH}/manager/sideMenu.jsp" >
	 	<c:param name="lcat" value="collections"/>
	 	<c:param name="mcat" value="${collectionId}" />
		<c:param name="scat" value="schema" />
	 </c:import>
		
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> ${collectionId}</li>
						<li class="current"> Schema</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				
				<%
				if(!isWorkSchema){
				%>
				<div class="page-header">
					<div class="page-title">
						<h3>Schema</h3>
					</div>
					<div class="btn-group" style="float:right; padding: 25px 0;">
						<a href="javascript:reloadSchema();" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
						<a href="workSchema.html" class="btn btn-sm">View Work Schema</a>
					</div>
				</div>
				<% }else{ %>
				<div class="page-header">
					<div class="page-title">
						<h3>Work Schema</h3>
					</div>
					<div class="btn-group" style="float:right; padding: 25px 0;">
						<a href="javascript:reloadSchema();" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
						<a href="schema.html" class="btn btn-sm">View Schema</a>
						<a href="javascript:editWorkSchema();" class="btn btn-sm"><span class="icon-edit"></span> Edit Work Schema</a>
					</div>
				</div>
				
				<% } %>
				<!-- /Page Header -->
				
				
				<!--=== Page Content ===-->
				<%
				int fieldListSize = 0;
				int primaryKeySize = 0;
				int analyzerSize = 0;
				int searchIndexesSize = 0;
				int fieldIndexesSize = 0;
				int groupIndexesSize = 0;
				Element root = document.getRootElement();
				Element el = root.getChild("field-list");
				if(el != null){
					fieldListSize = el.getChildren().size();
				}
				el = root.getChild("primary-key");
				if(el != null){
					primaryKeySize = el.getChildren().size();
				}
				el = root.getChild("analyzer-list");
				if(el != null){
					analyzerSize = el.getChildren().size();
				}
				el = root.getChild("index-list");
				if(el != null){
					searchIndexesSize = el.getChildren().size();
				}
				el = root.getChild("field-index-list");
				if(el != null){
					fieldIndexesSize = el.getChildren().size();
				}
				el = root.getChild("group-index-list");
				if(el != null){
					groupIndexesSize = el.getChildren().size();
				}
				%>
				<div class="tabbable tabbable-custom tabbable-full-width" id="schema_tabs">
					<ul class="nav nav-tabs">
						<li class="active" id="tab_key_overview"><a href="javascript:showOverview();">Overview</a></li>
						<li class=""><a href="#tab_fields" data-toggle="tab">Fields</a></li>
						<li class=""><a href="#tab_constraints" data-toggle="tab">Primary Key</a></li>
						<li class=""><a href="#tab_analyzers" data-toggle="tab">Analyzers</a></li>
						<li class=""><a href="#tab_search_indexes" data-toggle="tab">Search Indexes</a></li>
						<li class=""><a href="#tab_field_indexes" data-toggle="tab">Field Indexes</a></li>
						<li class=""><a href="#tab_group_indexes" data-toggle="tab">Group Indexes</a></li>
					</ul>
					<div class="tab-content row">
						
						<!--=== fields tab ===-->
						<div class="tab-pane" id="tab_fields">
							<div class="col-md-12">
								<div class="widget">
									<div class="widget-header">
										<h4>Fields</h4>
									</div>

									<div class="widget-content">

										<table id="schema_table_fields" class="table table-bordered table-hover table-highlight-head table-condensed">
											
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="">ID</th>
													<th class="">Name</th>
													<th class="">Type</th>
													<th class="">Length</th>
													<th class="fcol1">Store</th>
													<th class="fcol1">Multi Value</th>
													<th class="fcol1">Multi Value Delimiter</th>
												</tr>
											</thead>
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("field-list");
											if(el != null){
											List<Element> fildList = el.getChildren();
												for(int i = 0; i <fildList.size(); i++){
													Element field = fildList.get(i);
													String id = field.getAttributeValue("id");
													String type = field.getAttributeValue("type");
													String name = field.getAttributeValue("name", "");
													String source = field.getAttributeValue("source", "");
													String size = field.getAttributeValue("size", "");
													String removeTag = field.getAttributeValue("removeTag", "");
													String multiValue = field.getAttributeValue("multiValue", "false");
													String multiValueDelimeter = field.getAttributeValue("multiValueDelimeter", "");
													String store = field.getAttributeValue("store", "true");
												%>
												<tr id="_field_<%=id%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class=""><%=id %></td>
													<td class=""><%=name %></td>
													<td class=""><%=type %></td>
													<td class=""><%=size %></td>
													<td class=" _field_store " ><label class="">Y</label></td>
													<td class=" _field_multivalue " ><label class="">N</label></td>
													<td class=" _field_multivalue_delimiter " ><%=multiValueDelimeter %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>
									</div>
								</div>

							</div>
						</div>
						<!-- //fields tab -->
						
						<!-- constraints tab  -->
						<div class="tab-pane" id="tab_constraints">
							<div class="col-md-12">
							
								<div class="widget">
									<div class="widget-header">
										<h4>Primary Keys</h4>
									</div>

									<div class="widget-content">
										<table class="table table-bordered table-hover table-highlight-head table-condensed">
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="fcol2">Field</th>
												</tr>
											</thead>
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("primary-key");
											if(el != null){
												List<Element> fieldList = el.getChildren();
												for(int i = 0; i < fieldList.size(); i++){
													Element field = fieldList.get(i);
													String ref = field.getAttributeValue("ref");
												%>
												<tr id="_row_<%=ref%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class="fcol2"><%=ref %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>
									</div>
								</div>
								
							</div>
						</div>
						<!--//constraints tab  -->
						
						<!-- analyzer tab  -->
						<div class="tab-pane" id="tab_analyzers">
							<div class="col-md-12">
							
								<div class="widget">
									<div class="widget-header">
										<h4>Analyzers</h4>
									</div>

									<div class="widget-content">
										<table class="table table-bordered table-hover table-highlight-head table-condensed" >
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="fcol2">ID</th>
													<th class="fcol2">Core<br>Pool Size</th>
													<th class="fcol2">Maximum<br>Pool Size</th>
													<th class="">Analyzer</th>
												</tr>
											</thead>
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("analyzer-list");
											if(el != null){
												List<Element> analyzerList = el.getChildren();
												for(int i = 0; i < analyzerList.size(); i++){
													Element analyzer = analyzerList.get(i);
													
													String id = analyzer.getAttributeValue("id");
													String corePoolSize = analyzer.getAttributeValue("corePoolSize", "");
													String maximumPoolSize = analyzer.getAttributeValue("maximumPoolSize", "");
													String analyzerClass = analyzer.getAttributeValue("className");
												%>
												<tr class="_row_<%=id%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class="fcol2"><%=id %></td>
													<td class="fcol2"><%=corePoolSize %></td>
													<td class="fcol2"><%=maximumPoolSize %></td>
													<td class=""><%=analyzerClass %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>
									</div>
								</div>
								
							</div>
						</div>
						<!--//analyzer tab  -->
						
						
						<!-- search indexes -->
						<div class="tab-pane" id="tab_search_indexes">
							<div class="col-md-12">
							
								<div class="widget">
									<div class="widget-header">
										<h4>Search Indexes</h4>
									</div>

									<div class="widget-content">
										
										<table id="schema_table_search_indexes" class="table table-bordered table-hover table-highlight-head table-condensed">
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="fcol1-2">ID</th>
													<th class="fcol2">Name</th>
													<th class="">Field</th>
													<th class="fcol2">Index Analyzer</th>
													<th class="fcol2">Query Analyzer</th>
													<th class="fcol1">Ignore Case</th>
													<th class="fcol1">Store Position</th>
													<th class="fcol1">Position Increment Gap</th>
												</tr>
											</thead>
											
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("index-list");
											if(el != null){
												List<Element> indexList = el.getChildren();
												for(int i = 0; i <indexList.size(); i++){
													Element field = indexList.get(i);
													List<Element> fieldList = field.getChildren("field");
													String fieldRefList = "";
													for(int j = 0; j < fieldList.size(); j++){
														if(fieldRefList.length() > 0){
															fieldRefList += ", ";
														}
														Element fieldRef = fieldList.get(j);
														fieldRefList += fieldRef.getAttributeValue("ref");
													}
													String id = field.getAttributeValue("id");
													String name = field.getAttributeValue("name", "");
													String indexAnalyzer = field.getAttributeValue("indexAnalyzer", "");
													String queryAnalyzer = field.getAttributeValue("queryAnalyzer", "");
													String ignoreCase = field.getAttributeValue("ignoreCase", "");
													String storePosition = field.getAttributeValue("storePosition", "");
													String positionIncrementGap = field.getAttributeValue("positionIncrementGap", "");
												%>
												<tr id="_search_indexes_<%=id%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class="fcol1-2"><%=id %></td>
													<td class="fcol2"><%=name %></td>
													<td class=""><%=fieldRefList %></td>
													<td class="fcol2"><%=indexAnalyzer %></td>
													<td class="fcol2"><%=queryAnalyzer %></td>
													<td class="_search_indexes_ignorecase" ><%=ignoreCase %></td>
													<td class="_search_indexes_store_position" ><%=storePosition %></td>
													<td class="_search_indexes_positionIncrementGap" ><%=positionIncrementGap %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>

									</div>
								</div>
								
							</div>
						</div>
						<!-- //search indexes -->
						
						
						<!-- field_indexes tab  -->
						<div class="tab-pane" id="tab_field_indexes">
							<div class="col-md-12">
							
								<div class="widget">
									<div class="widget-header">
										<h4>Field Indexes</h4>
									</div>

									<div class="widget-content">
										<table class="table table-bordered table-hover table-highlight-head table-condensed">
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="fcol2">ID</th>
													<th class="fcol2">Name</th>
													<th class="fcol2">Field</th>
													<th class="fcol2">Size</th>
												</tr>
											</thead>
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("field-index-list");
											if(el != null){
												List<Element> indexList = el.getChildren();
												for(int i = 0; i < indexList.size(); i++){
													Element fieldIndex = indexList.get(i);
													
													String id = fieldIndex.getAttributeValue("id");
													String name = fieldIndex.getAttributeValue("name", "");
													String ref = fieldIndex.getAttributeValue("ref", "");
													String size = fieldIndex.getAttributeValue("size", "");
												%>
												<tr id="_row_<%=id%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class="fcol2"><%=id %></td>
													<td class="fcol2"><%=name %></td>
													<td class="fcol2"><%=ref %></td>
													<td class="fcol2"><%=size %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>
									</div>
								</div>
								
							</div>
						</div>
						<!--//field_indexes tab  -->
						
						
						<!-- group_indexes tab  -->
						<div class="tab-pane" id="tab_group_indexes">
							<div class="col-md-12">
							
								<div class="widget">
									<div class="widget-header">
										<h4>Group Indexes</h4>
									</div>

									<div class="widget-content">
										<table class="table table-bordered table-hover table-highlight-head table-condensed">
											<thead>
												<tr>
													<th class="fcol1">#</th>
													<th class="fcol2">ID</th>
													<th class="fcol2">Name</th>
													<th class="fcol2">Field</th>
												</tr>
											</thead>
											<tbody>
											<%
											root = document.getRootElement();
											el = root.getChild("group-index-list");
											if(el != null){
												List<Element> indexList = el.getChildren();
												for(int i = 0; i < indexList.size(); i++){
													Element groupIndex = indexList.get(i);
													
													String id = groupIndex.getAttributeValue("id");
													String name = groupIndex.getAttributeValue("name", "");
													String ref = groupIndex.getAttributeValue("ref", "");
												%>
												<tr id="_row_<%=id%>">
													<td class="fcol1"><%=i+1 %></td>
													<td class="fcol2"><%=id %></td>
													<td class="fcol2"><%=name %></td>
													<td class="fcol2"><%=ref %></td>
												</tr>														
												<%
												}
											}
											%>
											</tbody>
										</table>
									</div>
								</div>
								
							</div>
						</div>
						<!--//group_indexes tab  -->
						
					</div>
					<!-- /.tab-content -->
				</div>



				<!-- /Page Content -->
				
				
			</div>
		</div>
	</div>
</body>
</html>