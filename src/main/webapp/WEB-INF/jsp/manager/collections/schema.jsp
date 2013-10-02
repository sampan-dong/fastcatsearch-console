<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="java.util.*"%>
<%
	Document document = (Document) request.getAttribute("document");

%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.fcol1 {
	width: 30px;
}

.fcol2 {
	width: 150px;
}

.fcol3 {
	width: 150px;
}

.fcol4 {
	width: 150px;
}

.fcol5 {
	width: 150px;
}
</style>
<script>
	$(document).ready(function() {
		$('#schema_table').on('click', 'tbody tr', function(event) {
			$(this).addClass('checked').siblings().removeClass('checked');
			//alert($(this).find("._field_multivalue").text());
			var id = $(this).attr("id");
			var store = $("#data_store").find("."+id+">._field_store").text();
			var multivalue = $("#data_store").find("."+id+">._field_multivalue").text();
			var multivalueDelimiter = $("#data_store").find("."+id+">._field_multivalue_delimiter").text();
			if(store){
				$('#_footer_field').find("._field_store").prop("checked", true);
			}else{
				$('#_footer_field').find("._field_store").removeAttr("checked");
			}
			if(multivalue == "true"){
				$('#_footer_field').find("._field_multivalue").prop("checked", true);
			}else{
				$('#_footer_field').find("._field_multivalue").removeAttr("checked");
			}
			$('#_footer_field').find("._field_multivalue_delimiter").val(multivalueDelimiter);
			//console.log($('#_footer_field').find("._field_store").prop("nodeName"), store, multivalue, multivalueDelimiter);
			$.uniform.update();
		});
		$('#schema_table2').on('click', 'tbody tr', function(event) {
			$(this).addClass('checked').siblings().removeClass('checked');
		});
	});
	
	function selectFieldRow(id){
		
	}
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="sample" />
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
				</div>
				<!-- /Page Header -->
				
				
				<!--=== Page Content ===-->

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_field" data-toggle="tab">Fields</a></li>
						<li class=""><a href="#tab_search_indexes" data-toggle="tab">Search
								Indexes</a></li>
						<li class=""><a href="#tab_field_indexes" data-toggle="tab">Field
								Indexes</a></li>
						<li class=""><a href="#tab_group_indexes" data-toggle="tab">Group
								Indexes</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_field">
							<div class="col-md-12">
								<div class="widget box">

									<div class="widget-content no-padding">
										<div class="row">
											<div class="dataTables_header clearfix">
												<div class="col-md-6">
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
												<div class="col-md-6">
													<div class="pull-right">
													<a href="javascript:void(0);">Expand Table</a> &nbsp;|&nbsp;
													<a href="javascript:void(0);">Shrink Table</a>
													</div>
												</div>
											</div>
										</div>
										<div>
											<div style="margin-right: 15px">
												<table class="table table-bordered">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol2">Field</th>
															<th class="fcol2">Name</th>
															<th class="fcol3">Type</th>
															<th class="fcol4">Length</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow: auto; height: 300px;">

												<table id="schema_table" class="table table-bordered table-checkable">
													<tbody>
													<%
													Element root = document.getRootElement();
													Element el = root.getChild("field-list");
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
														<tr id="_row_<%=id%>">
															<td class="fcol1"><%=i+1 %></td>
															<td class="fcol2"><%=id %></td>
															<td class="fcol2"><%=name %></td>
															<td class="fcol3"><%=type %></td>
															<td class="fcol4"><%=size %></td>
															
															
														</tr>														
														<%
														}
													}
													%>
													</tbody>
												</table>
											</div>
										</div>
										
										<div id="data_store" class="hidden">
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
											<div class="_row_<%=id%>">
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
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div> -->
										
										<!-- --- -->

										<div class="row form-horizontal">
											<div id="_footer_field" class="table-footer ">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Store:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="uniform _field_store"> Yes
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="uniform _field_multivalue" value=""> Yes
															</label>
														</div>
													</div>
													
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value
															Delimiter: </label>
														<div class="col-md-9">
															<input type="text" name="regular" class="form-control _field_multivalue_delimiter">
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
						<!-- //tab field -->
						<!-- search indexes -->
						<div class="tab-pane" id="tab_search_indexes">
							<div class="col-md-12">
							
							dddd
							</div>
							
							</div>
						<!-- //search indexes -->
						<!--=== Edit Account ===-->
						<div class="tab-pane active" id="tab_edit_account"></div>
						<!-- /Edit Account -->
					</div>
					<!-- /.tab-content -->
				</div>



				<!-- /Page Content -->
				
				
			</div>
		</div>
	</div>
</body>
</html>