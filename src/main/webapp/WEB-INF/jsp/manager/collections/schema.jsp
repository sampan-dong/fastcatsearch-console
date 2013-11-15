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
	$(document).ready(function() {
		$('#schema_table_fields').on('click', 'tbody tr', function(event) {
			$(this).addClass('checked').siblings().removeClass('checked');
			var id = $(this).attr("id");
			var store = $("#data_store_fields").find("."+id+">._field_store").text();
			var multivalue = $("#data_store_fields").find("."+id+">._field_multivalue").text();
			var multivalueDelimiter = $("#data_store_fields").find("."+id+">._field_multivalue_delimiter").text();
			if(store){
				$('#_footer_fields').find("._field_store").prop("checked", true);
			}else{
				$('#_footer_fields').find("._field_store").removeAttr("checked");
			}
			if(multivalue == "true"){
				$('#_footer_fields').find("._field_multivalue").prop("checked", true);
			}else{
				$('#_footer_fields').find("._field_multivalue").removeAttr("checked");
			}
			$('#_footer_fields').find("._field_multivalue_delimiter").val(multivalueDelimiter);
			//console.log($('#_footer_fields').find("._field_store").prop("nodeName"), store, multivalue, multivalueDelimiter);
		});
		$('#schema_table_search_indexes').on('click', 'tbody tr', function(event) {
			$(this).addClass('checked').siblings().removeClass('checked');
			var id = $(this).attr("id");
			var ignorecase = $("#data_store_search_indexes").find("."+id+">._search_indexes_ignorecase").text();
			console.log(id, ignorecase);
			var storePosition = $("#data_store_search_indexes").find("."+id+">._search_indexes_store_position").text();
			var positionIncrementGap = $("#data_store_search_indexes").find("."+id+">._search_indexes_positionIncrementGap").text();
			if(ignorecase == "true"){
				$('#_footer_search_indexes').find("._search_indexes_ignorecase").prop("checked", true);
			}else{
				$('#_footer_search_indexes').find("._search_indexes_ignorecase").removeAttr("checked");
			}
			if(storePosition == "true"){
				$('#_footer_search_indexes').find("._search_indexes_store_position").prop("checked", true);
			}else{
				$('#_footer_search_indexes').find("._search_indexes_store_position").removeAttr("checked");
			}
			$('#_footer_search_indexes').find("._search_indexes_positionIncrementGap").val(positionIncrementGap);
			//console.log($('#_footer_search_indexes').find("._field_store").prop("nodeName"), store, multivalue, multivalueDelimiter);
		});
	});
	
	function selectFieldRow(id){
		
	}
	
	function reloadSchema(){
		var tabTarget = $(".tab-content div.active").prop("id").substring(4);
		var pathname = $(location).attr('pathname');
		submitPost(pathname, {"tab": tabTarget});
		
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
						<h3>Schema</h3>
					</div>
					<div class="btn-group" style="float:right; padding: 25px 0;">
						<a href="javascript:reloadSchema();" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
						<a href="javascript:void(0);" class="btn btn-sm"><span class="glyphicon glyphicon-edit"></span> Edit</a>
					</div>
				</div>
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
						<li class="${tab == 'fields' ? 'active' : '' }"><a href="#tab_fields" data-toggle="tab">Fields <%-- <span class="badge badge-sm"><%=fieldListSize %></span> --%></a></li>
						<li class="${tab == 'constraints' ? 'active' : '' }"><a href="#tab_constraints" data-toggle="tab">Primary Key <%-- <span class="badge badge-sm"><%=primaryKeySize %></span> --%></a></li>
						<li class="${tab == 'analyzers' ? 'active' : '' }"><a href="#tab_analyzers" data-toggle="tab">Analyzers <%-- <span class="badge badge-sm"><%=analyzerSize %></span> --%></a></li>
						<li class="${tab == 'search_indexes' ? 'active' : '' }"><a href="#tab_search_indexes" data-toggle="tab">Search
								Indexes <%-- <span class="badge badge-sm"><%=searchIndexesSize %></span> --%></a></li>
						<li class="${tab == 'field_indexes' ? 'active' : '' }"><a href="#tab_field_indexes" data-toggle="tab">Field
								Indexes <%-- <span class="badge badge-sm"><%=fieldIndexesSize %></span> --%></a></li>
						<li class="${tab == 'group_indexes' ? 'active' : '' }"><a href="#tab_group_indexes" data-toggle="tab">Group
								Indexes <%-- <span class="badge badge-sm"><%=groupIndexesSize %></span> --%></a></li>
					</ul>
					<div class="tab-content row">

						<!--=== fields tab ===-->
						<div class="tab-pane ${tab == 'fields' ? 'active' : '' }" id="tab_fields">
							<div class="col-md-12">
								<div class="widget box">

									<div class="widget-content no-padding">
										<!-- <div class="row">
											<div class="dataTables_header clearfix">
												<div class="col-md-6">
													<div class="btn-group">
														<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
														<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
													</div>
												</div>
											</div>
										</div> -->
										<div>
											<div style="margin-right: 15px">
												<table class="table table-bordered table-highlight-head table-condensed">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol2">ID</th>
															<th class="fcol2">Name</th>
															<th class="fcol2">Type</th>
															<th class="fcol2">Length</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow-y: scroll; height: 300px;">

												<table id="schema_table_fields" class="table table-bordered table-checkable table-condensed table-selectable">
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
															<td class="fcol2"><%=id %></td>
															<td class="fcol2"><%=name %></td>
															<td class="fcol2"><%=type %></td>
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
										
										<div id="data_store_fields" class="hidden">
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
												String multiValueDelimeter = field.getAttributeValue("multiValueDelimiter", "");
												String store = field.getAttributeValue("store", "true");
											%>
											<div class="_field_<%=id%>">
												<div class="_field_store" ><%=store %></div>
												<div class="_field_multivalue" ><%=multiValue %></div>
												<div class="_field_multivalue_delimiter" ><%=multiValueDelimeter %></div>
											</div>
										<%
											}
										}
										%>
										</div>
										
										<!-- ---- -->
										<!-- <div>
											<div style="margin-right: 15px">
												<table class="table table-bordered">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol2">Field</th>
															<th class="fcol3">Type</th>
															<th class="fcol4">Length</th>
															<th class="fcol5">Key</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow: auto; height: 300px;">

												<table id="schema_table2" class="table table-bordered table-checkable">
													<tbody>
														<tr>
															<td class="fcol1">1</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox"></input></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div> -->
										
										<!-- --- -->

										<div class="row form-horizontal">
											<div id="_footer_fields" class="table-footer ">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Store:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="_field_store" readonly> Yes
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="_field_multivalue" readonly> Yes
															</label>
														</div>
													</div>
													
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value
															Delimiter: </label>
														<div class="col-md-3">
															<input type="text" name="regular" class="form-control _field_multivalue_delimiter" readonly>
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
						<!-- //fields tab -->
						
						<!-- constraints tab  -->
						<div class="tab-pane ${tab == 'constraints' ? 'active' : '' }" id="tab_constraints">
							<div class="col-md-12">
							
								<div class="widget box">

									<div class="widget-content no-padding">
										<div>
											<table class="table table-bordered table-highlight-head table-condensed">
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
						</div>
						<!--//constraints tab  -->
						
						<!-- analyzer tab  -->
						<div class="tab-pane ${tab == 'analyzers' ? 'active' : '' }" id="tab_analyzers">
							<div class="col-md-12">
							
								<div class="widget box">

									<div class="widget-content no-padding">
										<div>
											<table class="table table-bordered table-highlight-head table-condensed table-fixed" >
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
														String analyzerClass = analyzer.getValue();
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
						</div>
						<!--//analyzer tab  -->
						
						
						<!-- search indexes -->
						<div class="tab-pane ${tab == 'search_indexes' ? 'active' : '' }" id="tab_search_indexes">
							<div class="col-md-12">
							
								<div class="widget box">

									<div class="widget-content no-padding">
										<!-- <div class="row">
											<div class="dataTables_header clearfix">
												<div class="col-md-6">
													<div class="btn-group">
														<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
														<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
													</div>
												</div>
											</div>
										</div> -->
										<div>
											<div style="margin-right: 15px">
												<table class="table table-bordered table-highlight-head table-condensed table-fixed">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol1-2">ID</th>
															<th class="fcol2">Name</th>
															<th class="">Field</th>
															<th class="fcol2">Index Analyzer</th>
															<th class="fcol2">Query Analyzer</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow-y: scroll; height: 300px;">

												<table id="schema_table_search_indexes" class="table table-bordered table-checkable table-condensed table-fixed table-selectable">
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
														</tr>														
														<%
														}
													}
													%>
													</tbody>
												</table>
											</div>
										</div>
										
										<div id="data_store_search_indexes" class="hidden">
										<%
										root = document.getRootElement();
										el = root.getChild("index-list");
										if(el != null){
											List<Element> indexList = el.getChildren();
											for(int i = 0; i <indexList.size(); i++){
												Element field = indexList.get(i);
												String id = field.getAttributeValue("id");
												String ignoreCase = field.getAttributeValue("ignoreCase", "");
												String storePosition = field.getAttributeValue("storePosition", "");
												String positionIncrementGap = field.getAttributeValue("positionIncrementGap", "");
											%>
											<div class="_search_indexes_<%=id%>">
												<div class="_search_indexes_ignorecase" ><%=ignoreCase %></div>
												<div class="_search_indexes_store_position" ><%=storePosition %></div>
												<div class="_search_indexes_positionIncrementGap" ><%=positionIncrementGap %></div>
											</div>
										<%
											}
										}
										%>
										</div>
									
										<div class="row form-horizontal">
											<div id="_footer_search_indexes" class="table-footer ">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Ignore Case:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="_search_indexes_ignorecase" readonly> Yes
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Store Position:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="_search_indexes_store_position" readonly> Yes
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Position Increment Gap: </label>
														<div class="col-md-3">
															<input type="text" name="regular" class="form-control _search_indexes_positionIncrementGap" readonly>
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>
								
							</div>
						</div>
						<!-- //search indexes -->
						
						
						<!-- field_indexes tab  -->
						<div class="tab-pane ${tab == 'field_indexes' ? 'active' : '' }" id="tab_field_indexes">
							<div class="col-md-12">
							
								<div class="widget box">

									<div class="widget-content no-padding">
										<div>
											<table class="table table-bordered table-highlight-head table-condensed">
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
						</div>
						<!--//field_indexes tab  -->
						
						
						<!-- group_indexes tab  -->
						<div class="tab-pane ${tab == 'group_indexes' ? 'active' : '' }" id="tab_group_indexes">
							<div class="col-md-12">
							
								<div class="widget box">

									<div class="widget-content no-padding">
										<div>
											<table class="table table-bordered table-highlight-head table-condensed">
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