<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="java.util.*"%>
<%
	Document document = (Document) request.getAttribute("document");

%>
<c:set var="ROOT_PATH" value="../.." scope="request"/>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>

$(document).ready(function(){
	
	$("#schemaForm").validate();
	
	$("#schemaForm").submit(function(event){
		event.preventDefault();
		
		if(! $(this).valid()){
			return;
		} 
		var queryString = $(this).serialize();
		
		$.ajax({
			url: "workSchemaSave.html",
			type: "POST",
			dataType:"json",
			data:{queryString: queryString},
			success:function(response, status) {
				if(response.success) {
					noty({text: "Schema update success", type: "success", layout:"topRight", timeout: 3000});
				} else {
					noty({text: "Schema update fail : " + response.errorMessage, type: "error", layout:"topRight", timeout: 0}); //클릭해야 사라진다.
				}
			}, fail:function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
		});
		return;
	});
	
	var addRowTooltip = {title : "Insert 1 below"};
	var deleteRowTooltip = {title : "Delete row"};
	
	$("a.addRow").tooltip(addRowTooltip);
	$("a.deleteRow").tooltip(deleteRowTooltip);
	
	var inputClearFunction = function() {
		if($(this).attr("name")!="KEY_NAME") {
			$(this).val("");
		}
		$(this).removeAttr("checked");
	};
	
	var addRowFunction = function(){
		var trElement = $(this).parents("tr");
		var clone = trElement.clone();
		var key = keyId = clone.find("input[name=KEY_NAME]").val();
		var regex = /([a-zA-Z_]+)([0-9]+)/.exec(key);
		var prefix = regex[1];
		var index = regex[2];
		
		var newIndex = new Date().getTime();
		
		clone.find("input[name=KEY_NAME]").val(prefix+newIndex);
		clone.find("input").each(function() {
			if($(this).attr("name").indexOf(prefix+index)==0) {
				var regex = /([a-zA-Z_]+)([0-9]+)(.+)/.exec($(this).attr("name"));
				$(this).attr("name",prefix+newIndex+regex[3]);
			}
		});
		
		//remove tooltip object
		clone.find("div.tooltip.fade.top.in").remove();
		//clear input
		clone.find("input").each(inputClearFunction);
		//link event
		clone.find("a.addRow").click(addRowFunction).tooltip(addRowTooltip);
		clone.find("a.deleteRow").click(deleteRowFunction).tooltip(deleteRowTooltip);
		trElement.after(clone);
	};
	
	var deleteRowFunction = function() {
		var trElement = $(this).parents("tr");
		var trElements = trElement.parents("tbody").find("tr");
		if(trElements.length>1) {
			trElement.remove();
		} else {
			trElement.find("input").each(inputClearFunction);
		}
	};
	
	$("a.addRow").click(addRowFunction);
	$("a.deleteRow").click(deleteRowFunction);
	
});

	function saveSchema(){
		$("#schemaForm").submit();
	}
	function removeSchema(){
		
		requestProxy("POST", {uri:"/management/collections/schema/remove.json", collectionId:"${collectionId}", type:"workSchema"},
			"json", 
			function(response, status) {
				if(response.success) {
					submitGet("schema.html");
				} else {
					noty({text: "Work schema remove fail", type: "error", layout:"topRight", timeout: 5000});
				}
			}, function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			});
	}
	
	function reloadSchema(){
		location.href = location.href;
	}
	
	function backToSchema(){
		submitGet("workSchema.html", {});
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
						<li class="current"> VOL</li>
						<li class="current"> Schema</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Work Schema</h3>
					</div>
					<div class="btn-group" style="float:right; padding: 25px 0;">
						<a href="javascript:removeSchema(0);" class="btn btn-sm btn-danger"><span class="icon-trash"></span> Remove</a>
						<a href="javascript:saveSchema();" class="btn btn-sm" style="margin-left:5px"><span class="icon-ok"></span> Save</a>
						<a href="javascript:reloadSchema();" class="btn btn-sm" style="margin-left:5px"><i class="icon-refresh"></i></a>
						<a href="javascript:backToSchema();" class="btn btn-sm"><span class="icon-eye-open"></span> View</a>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<!--=== Page Content ===-->
				<%
				Element root = document.getRootElement();
				Element el = root.getChild("field-list");
				%>
				<form id="schemaForm">
				
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<h4>Fields</h4>
							</div>
			
							<div class="widget-content">
	
								<table id="schema_table_fields" class="table table-bordered table-hover table-highlight-head table-condensed">
									
									<thead>
										<tr>
											<th>ID</th>
											<th>Name</th>
											<th class="fcol2">Type</th>
											<th class="fcol2">Length</th>
											<th class="fcol1">Store</th>
											<th class="fcol1">Remove Tags</th>
											<th class="fcol1">Multi Value</th>
											<th class="fcol1">Multi Value Delimiter</th>
											<th class="fcol1-1"></th>
										</tr>
									</thead>
									<tbody>
									<%
									root = document.getRootElement();
									el = root.getChild("field-list");
									if(el != null){
										List<Element> fieldList = el.getChildren();
										if(fieldList.size()==0) {
											Element element = new Element("field");
											fieldList.add(element);
											element.setAttribute("id","")
												.setAttribute("type","")
												.setAttribute("name","")
												.setAttribute("source","")
												.setAttribute("size","")
												.setAttribute("store","true")
												.setAttribute("multiValue","")
												.setAttribute("multiValueDelimeter","");
										}
										for(int i = 0; i <fieldList.size(); i++){
											Element field = fieldList.get(i);
											String id = field.getAttributeValue("id");
											String type = field.getAttributeValue("type");
											String name = field.getAttributeValue("name", "");
											String source = field.getAttributeValue("source", "");
											String size = field.getAttributeValue("size", "");
											String store = field.getAttributeValue("store", "true");
											String removeTag = field.getAttributeValue("removeTag", "");
											String multiValue = field.getAttributeValue("multiValue", "false");
											String multiValueDelimeter = field.getAttributeValue("multiValueDelimeter", "");
										%>
										<tr>
											<td><input type="hidden" name="KEY_NAME" value="_fields_<%=i %>" /><input type="text" name="_fields_<%=i%>-id" class="form-control required" value="<%=id %>"></td>
											<td><input type="text" name="_fields_<%=i%>-name" class="form-control required" value="<%=name %>"></td>
											<td><input type="text" name="_fields_<%=i%>-type" class="form-control required" value="<%=type %>"></td>
											<td><input type="text" name="_fields_<%=i%>-size" class="form-control digit" value="<%=size %>"></td>
											<td ><label class="checkbox"><input type="checkbox" value="true" name="_fields_<%=i%>-store" <%="true".equalsIgnoreCase(store) ? "checked" : "" %>></label></td>
											<td ><label class="checkbox"><input type="checkbox" value="true" name="_fields_<%=i%>-removeTag" <%="true".equalsIgnoreCase(removeTag) ? "checked" : "" %>></label></td>
											<td ><label class="checkbox"><input type="checkbox" value="true" name="_fields_<%=i%>-multiValue" <%="true".equalsIgnoreCase(multiValue) ? "checked" : "" %>></label></td>
											<td ><input type="text" class="form-control" name="_fields_<%=i%>-multiValueDelimeter" value="<%=multiValueDelimeter %>"></td>
											<td>
												<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
												<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
											</td>
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
					<!-- //fields tab -->
						
						<!-- constraints tab  -->
					<div class="col-md-12">
					
						<div class="widget">
							<div class="widget-header">
								<h4>Primary Keys</h4>
							</div>

							<div class="widget-content">
								<div>
									<table class="table table-bordered table-hover table-highlight-head table-condensed">
										<thead>
											<tr>
												<th>Field</th>
												<th class="fcol1-1"></th>
											</tr>
										</thead>
										<tbody>
										<%
										root = document.getRootElement();
										el = root.getChild("primary-key");
										if(el != null){
											List<Element> fieldList = el.getChildren();
											if(fieldList.size()==0) {
												Element element = new Element("fild");
												fieldList.add(element);
												element.setAttribute("ref","");
											}
											for(int i = 0; i < fieldList.size(); i++){
												Element field = fieldList.get(i);
												String ref = field.getAttributeValue("ref");
											%>
											<tr>
												<td>
													<input type="hidden" name="KEY_NAME" value="_constraints_<%=i %>" />
													<input type="text" name="_constraints_<%=i%>-ref" class="fcol2 form-control required" value="<%=ref %>"/>
												</td>
												<td>
													<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
													<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
												</td>
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
					<div class="col-md-12">
					
						<div class="widget">
							<div class="widget-header">
								<h4>Analyzers</h4>
							</div>

							<div class="widget-content">
								<div>
									<table class="table table-bordered table-hover table-highlight-head table-condensed" >
										<thead>
											<tr>
												<th class="fcol2">ID</th>
												<th class="fcol1-1">Core<br>Pool Size</th>
												<th class="fcol1-1">Maximum<br>Pool Size</th>
												<th>Analyzer</th>
												<th class="fcol1-1"></th>
											</tr>
										</thead>
										<tbody>
										<%
										root = document.getRootElement();
										el = root.getChild("analyzer-list");
										if(el != null){
											List<Element> analyzerList = el.getChildren();
											if(analyzerList.size()==0) {
												Element element = new Element("analyzer");
												analyzerList.add(element);
												element.setAttribute("id","")
													.setAttribute("corePoolSize","")
													.setAttribute("maximumPoolSize","")
													.setAttribute("className","");
												
											}
											for(int i = 0; i < analyzerList.size(); i++){
												Element analyzer = analyzerList.get(i);
												
												String id = analyzer.getAttributeValue("id");
												String corePoolSize = analyzer.getAttributeValue("corePoolSize", "");
												String maximumPoolSize = analyzer.getAttributeValue("maximumPoolSize", "");
												String analyzerClass = analyzer.getAttributeValue("className", "");
											%>
											<tr>
												<td>
													<input type="hidden" name="KEY_NAME" value="_analyzers_<%=i %>" />
													<input type="text" name="_analyzers_<%=i%>-id" class="form-control required" value="<%=id %>"></td>
												<td><input type="text" name="_analyzers_<%=i%>-corePoolSize" class="form-control required digits" value="<%=corePoolSize %>"></td>
												<td><input type="text" name="_analyzers_<%=i%>-maximumPoolSize" class="form-control required digits" value="<%=maximumPoolSize %>"></td>
												<td><input type="text" name="_analyzers_<%=i%>-class" class="form-control required" value="<%=analyzerClass %>"></td>
												<td>
												<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
												<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
												</td>
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
					<div class="col-md-12">
					
						<div class="widget">
							<div class="widget-header">
								<h4>Search Indexes</h4>
							</div>

							<div class="widget-content">
								<table id="schema_table_search_indexes" class="table table-bordered table-hover table-highlight-head table-condensed">
									<thead>
										<tr>
											<th class="fcol1-2">ID</th>
											<th class="fcol2">Name</th>
											<th class="fcol2">Field</th>
											<th>Index Analyzer</th>
											<th>Query Analyzer</th>
											<th class="fcol1">Ignore Case</th>
											<th class="fcol1">Store Position</th>
											<th class="fcol1">Position Increment Gap</th>
											<th class="fcol1-1"></th>
										</tr>
									</thead>
									
									<tbody>
									<%
									root = document.getRootElement();
									el = root.getChild("index-list");
									if(el != null){
										List<Element> indexList = el.getChildren();
										if(indexList.size()==0) {
											Element element = new Element("index");
											indexList.add(element);
											element.setAttribute("id","")
												.setAttribute("name","")
												.setAttribute("indexAnalyzer","")
												.setAttribute("queryAnalyzer","")
												.setAttribute("ignoreCase","")
												.setAttribute("storePosition","")
												.setAttribute("positionIncrementGap","");
										}
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
										<tr>
											<td>
												<input type="hidden" name="KEY_NAME" value="_search_indexes_<%=i %>" />
												<input type="text" name="_search_indexes_<%=i%>-id" class="form-control required" value="<%=id %>"></td>
											<td><input type="text" name="_search_indexes_<%=i%>-name" class="form-control required" value="<%=name %>"></td>
											<td><input type="text" name="_search_indexes_<%=i%>-refList" class="form-control required" value="<%=fieldRefList %>"></td>
											<td><input type="text" name="_search_indexes_<%=i%>-indexAnalyzer" class="form-control required" value="<%=indexAnalyzer %>"></td>
											<td><input type="text" name="_search_indexes_<%=i%>-queryAnalyzer" class="form-control required" value="<%=queryAnalyzer %>"></td>
											<td ><label class="checkbox"><input type="checkbox" value="true" name="_search_indexes_<%=i%>-ignoreCase" <%="true".equalsIgnoreCase(ignoreCase) ? "checked" : "" %>></label></td>
											<td ><label class="checkbox"><input type="checkbox" value="true" name="_search_indexes_<%=i%>-storePosition" <%="true".equalsIgnoreCase(storePosition) ? "checked" : "" %>></label></td>
											<td ><input type="text" name="_search_indexes_<%=i%>-pig" class="form-control digits" value="<%=positionIncrementGap %>"></td>
											<td>
												<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
												<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
											</td>
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
					<!-- //search indexes -->
						
						
					<!-- field_indexes tab  -->
					<div class="col-md-12">
					
						<div class="widget">
							<div class="widget-header">
								<h4>Field Indexes</h4>
							</div>

							<div class="widget-content">
								<table class="table table-bordered table-hover table-highlight-head table-condensed">
									<thead>
										<tr>
											<th class="fcol2">ID</th>
											<th>Name</th>
											<th class="fcol2">Field</th>
											<th class="fcol2">Size</th>
											<th class="fcol1-1"></th>
										</tr>
									</thead>
									<tbody>
									<%
									root = document.getRootElement();
									el = root.getChild("field-index-list");
									if(el != null){
										List<Element> indexList = el.getChildren();
										if(indexList.size()==0) {
											Element element = new Element("index");
											indexList.add(element);
											element.setAttribute("id","")
												.setAttribute("name","")
												.setAttribute("ref","")
												.setAttribute("size","");
										}
										for(int i = 0; i < indexList.size(); i++){
											Element fieldIndex = indexList.get(i);
											
											String id = fieldIndex.getAttributeValue("id");
											String name = fieldIndex.getAttributeValue("name", "");
											String ref = fieldIndex.getAttributeValue("ref", "");
											String size = fieldIndex.getAttributeValue("size", "");
										%>
										<tr>
											<td>
												<input type="hidden" name="KEY_NAME" value="_field_indexes_<%=i %>" />
												<input type="text" name="_field_indexes_<%=i%>-id" class="form-control" value="<%=id %>"></td>
											<td><input type="text" name="_field_indexes_<%=i%>-name" class="form-control" value="<%=name %>"></td>
											<td><input type="text" name="_field_indexes_<%=i%>-field" class="form-control" value="<%=ref %>"></td>
											<td><input type="text" name="_field_indexes_<%=i%>-size" class="form-control digits fcol1-1" value="<%=size %>"></td>
											<td>
												<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
												<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
											</td>
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
					<!--//field_indexes tab  -->
						
						
					<!-- group_indexes tab  -->
					<div class="col-md-12">
					
						<div class="widget">
							<div class="widget-header">
								<h4>Group Indexes</h4>
							</div>
							<div class="widget-content">
								<div>
									<table class="table table-bordered table-hover table-highlight-head table-condensed">
										<thead>
											<tr>
												<th class="fcol2">ID</th>
												<th>Name</th>
												<th class="fcol2">Field</th>
												<th class="fcol1-1"></th>
											</tr>
										</thead>
										<tbody>
										<%
										root = document.getRootElement();
										el = root.getChild("group-index-list");
										if(el != null){
											List<Element> indexList = el.getChildren();
											if(indexList.size()==0) {
												Element element = new Element("index");
												indexList.add(element);
												element.setAttribute("id","")
													.setAttribute("name","")
													.setAttribute("ref","");
											}
											for(int i = 0; i<indexList.size(); i++){
												String id="", name="", ref="";
												if(indexList.size() > 0) {
													Element groupIndex = indexList.get(i);
													id = groupIndex.getAttributeValue("id");
													name = groupIndex.getAttributeValue("name", "");
													ref = groupIndex.getAttributeValue("ref", "");
												}
											%>
											<tr>
												<td>
													<input type="hidden" name="KEY_NAME" value="_group_indexes_<%=i %>" />
													<input type="text" name="_group_indexes_<%=i%>-id" class="form-control" value="<%=id %>"></td>
												<td><input type="text" name="_group_indexes_<%=i%>-name" class="form-control" value="<%=name %>"></td>
												<td><input type="text" name="_group_indexes_<%=i%>-ref" class="form-control" value="<%=ref %>"></td>
												<td>
													<span><a class="btn btn-xs addRow" href="javascript:void(0);"><i class="icon-plus-sign"></i></a></span>
													<span><a class="btn btn-xs deleteRow" href="javascript:void(0);" style="margin-left:5px;"><i class="icon-minus-sign text-danger"></i></a></span>
												</td>
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
						
				</form>

				<!-- /Page Content -->
				
				
			</div>
		</div>
	</div>
</body>
</html>