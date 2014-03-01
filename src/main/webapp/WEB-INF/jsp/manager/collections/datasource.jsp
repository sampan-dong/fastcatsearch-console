<%@page import="org.jdom2.output.XMLOutputter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="java.util.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>

<%
	Document document = (Document) request.getAttribute("document");
	Element root = document.getRootElement();
	
	Element fullIndexingNode = root.getChild("full-indexing");
	Element addIndexingNode = root.getChild("add-indexing");
	Element jdbcSourcesNode = root.getChild("jdbc-sources");
	
%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
$(document).ready(function(){
	$(".fullIndexingForm").each(function(){ $(this).validate(); });
	$(".addIndexingForm").each(function(){ $(this).validate(); });
	$(".jdbcForm").each(function(){ $(this).validate(); });
	
	$("a[data-toggle|=modal]").css("cursor","pointer");
	
	//new input form reset
	$("a[data-toggle|=modal][index-type]").click(function() {
		
		$(".newIndexingForm")[0].reset();
		
		var indexType = $(this).attr("index-type");
		
		$("div#newSourceModal input[name=indexType]").val(indexType);
		
		var parent = $("div#newSourceModal i.icon-plus-sign").parent()
			.parent().parent().parent();
		
		var elements = parent.children();
		
		var length = elements.length;
		
		for(var inx=length-2;inx>=0;inx--) {
			$(elements[inx]).remove();
		}
		
	});
	
	//property remove
	var fncRemove = function() {
		var element = $(this).parent().parent().parent().parent();
		element.remove();
	};
	//property append
	$("div.modal i.icon-plus-sign").parent().click(function() {
		var element = $(this).parent().parent();
		element.before($("div#property-template").html());
		
		$("div.modal span.input-group-btn button i.icon-minus-sign").parent()
			.click(fncRemove).css("cursor","pointer");
	}).css("cursor","pointer");
	//property remove
	$("div.modal span.input-group-btn button i.icon-minus-sign").parent()
		.click(fncRemove).css("cursor","pointer");
	//remove button
	$("div.modal div.modal-footer button.btn-danger.pull-left ").click(function() {
		var form = $(this).parents("form")[0];
		form.mode.value="delete";
		$(form).submit();
	});
	
	//submit form
	var fnSubmit = function(event){
		event.preventDefault();
		if(! $(this).valid()){
			return false;
		} 

		var findKey = $(this).find("input[name=key]");
		findKey.each(function() { $(this).attr("name","key"+findKey.index($(this))); });
		findKey = $(this).find("input[name=value]");
		findKey.each(function() { $(this).attr("name","value"+findKey.index($(this))); });
		
		var paramData = $(this).serializeArray();
		
		$.ajax({
			url: PROXY_REQUEST_URI,
			type: "POST",
			dataType: "json",
			data: paramData,
			success: function(response, statusText, xhr, $form){
				if(response["success"]==true) {
					$("div.modal").addClass("hidden");
					noty({text: "Datasource update success", type: "success", layout:"topRight", timeout: 3000});
					setTimeout(function() {
						location.href = location.href;
					},1000);
				} else {
					noty({text: "Datasource update fail", type: "error", layout:"topRight", timeout: 5000});
				}
				
			}, fail: function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
			
		});
		return false;
	};
	
	$(".fullIndexingForm").submit(fnSubmit);
	$(".addIndexingForm").submit(fnSubmit);
	$(".newIndexingForm").submit(fnSubmit);
	
	var fnJdbcSubmit = function(event) {
		event.preventDefault();
		if(! $(this).valid()) {
			return false;
		}
		
		var paramData = $(this).serializeArray();
		
		$.ajax({
			url: PROXY_REQUEST_URI,
			type: "POST",
			dataType: "json",
			data: paramData,
			success:function(response, statusText, xhr, $form) {
				if(response["success"]==true) {
					$("div.modal").addClass("hidden");
					noty({text: "JDBC Source update success", type: "success", layout:"topRight", timeout: 3000});
					location.href = location.href;
				} else {
					noty({text: "JDBC Source update fail", type: "error", layout:"topRight", timeout: 5000});
				}
				
			}, fail:function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
		});
		
		return false;
	};
	
	$(".newJdbcSourceForm").submit(fnJdbcSubmit);
	$(".jdbcSourceForm").submit(fnJdbcSubmit);
});

</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="${collectionId}" />
			<c:param name="scat" value="datasource" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> ${collectionId}</li>
						<li class="current"> Datasource</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Datasource</h3>
					</div>
				</div>
				<!-- /Page Header -->
				<div class="widget">
					<div class="widget-header">
						<h4>Full Indexing</h4>
					</div>
					<div class="widget-content">
						<a data-toggle="modal" data-target="#newSourceModal" index-type="full" update-type="new"><span class="icon-plus-sign"></span> Add Datasource</a>
						<table class="table table-hover table-bordered table-checkable">
							<thead>
								<tr>
									<th>Name</th>
									<th>Enable</th>
									<th>Reader / Modifier</th>
									<th> </th>
								</tr>
							</thead>
							<tbody>
								<%
								List<Element> sourceConfigList = fullIndexingNode.getChildren("source");
								for(int i = 0; sourceConfigList != null && i < sourceConfigList.size(); i++){
									Element sourceConfig = sourceConfigList.get(i);
									String name = sourceConfig.getAttributeValue("name");
									String active = sourceConfig.getAttributeValue("active");
									String reader = sourceConfig.getChildText("reader");
									String modifier = sourceConfig.getChildText("modifier");
								%>
								<tr class="_full_<%=i %>">
									<td class="._name"><%=name %></td>
									<td class="._active"><%="true".equals(active) ? "Enabled" : "Disabled" %></td>
									<td class="._reader"><%=reader %><%=modifier != null && modifier.length() > 0 ? "<p>("+modifier+")</p>" : "<p>(No modifier)</p>" %></td>
									<td class=""><a data-toggle="modal" data-target="#fullSourceModal_<%=i%>">Edit</a></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				
				<%
				sourceConfigList = fullIndexingNode.getChildren("source");
				for(int i = 0; i< sourceConfigList.size(); i++){
					Element sourceConfig = sourceConfigList.get(i);
					String name = sourceConfig.getAttributeValue("name");
					String active = sourceConfig.getAttributeValue("active");
					String reader = sourceConfig.getChildText("reader");
					String modifier = sourceConfig.getChildText("modifier");
				%>
					<div class="modal" id="fullSourceModal_<%=i %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form id="fullSourceModalForm_<%=i %>" class="fullIndexingForm" method="POST">
									<input type="hidden" name="collectionId" value="${collectionId}"/>
									<input type="hidden" name="sourceIndex" value="<%=i%>"/>
									<input type="hidden" name="indexType" value="full"/>
									<input type="hidden" name="mode" value="update"/>
									<input type="hidden" name="uri" value="/management/collections/update-datasource"/>
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title"> Full Indexing Source</h4>
									</div>
									<div class="modal-body">
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Setting</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
															<div class="form-group">
																<label class="col-md-3 control-label">Name:</label>
																<div class="col-md-9"><input type="text" name="name" class="form-control input-width-small required" value="<%=name %>"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Enabled:</label>
																<div class="col-md-9">
																	<label class="checkbox">
																		<input type="checkbox" name="active" class="form-control" value="true" <%="true".equalsIgnoreCase(active)? "checked" :"" %>>
																		Yes
																	</label>
																</div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Reader Class:</label>
																<div class="col-md-9"><input type="text" name="readerClass" class="form-control required" value="<%=reader %>"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Modifier Class:</label>
																<div class="col-md-9"><input type="text" name="modifierClass" class="form-control" value="<%=modifier %>"></div>
															</div>
														</div>
														
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Properties</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
														<%
														Element properties = sourceConfig.getChild("properties");
														if(properties != null){
														%>
															<%
															List<Element> propertyList = properties.getChildren("property");
															for(int j=0; propertyList != null && j<propertyList.size(); j++){
															%>
																<%
																Element property = propertyList.get(j);
																String key = property.getAttributeValue("key");
																String value = property.getValue();
																%>
																<div class="form-group">
																	<div class="col-md-4"><input type="text" name="key" class="form-control" value="<%=key %>" placeholder="KEY"></div>
																	<div class="col-md-8">
																		<div class="input-group">
																			<input type="text" name="value" class="form-control" value="<%=value %>" placeholder="VALUE">
																			<span class="input-group-btn valign-top">
																				<button class="btn btn-default" type="button"><i class="icon-minus-sign text-danger"></i></button>
																			</span>
																		</div>
																	</div>
																</div>
															<%
															}
															%>
														<%
														}
														%>
														<div class="form-group">
															<div class="col-md-4"><input type="text" name="key" class="form-control" value="test" placeholder="KEY"></div>
															<div class="col-md-8">
																<div class="input-group">
																	<textarea rows="4" name="value" class="form-control" placeholder="VALUE" >testvalue</textarea>
																	<span class="input-group-btn valign-top">
																		<button class="btn btn-default" type="button"><i class="icon-minus-sign text-danger"></i></button>
																	</span>
																</div>
															</div>
														</div>
														<div class="form-group">
															<div class="col-md-12">
																<a><i class="icon-plus-sign"></i> Add Property</a>
															</div>
														</div>
														</div>
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-danger pull-left" onclick="javascript:void(0)">Remove</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-primary">Save changes</button>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<%
					}
					%>
					<div class="modal" id="newSourceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form id="newSourceModalForm" class="newIndexingForm" method="POST">
									<input type="hidden" name="collectionId" value="${collectionId}"/>
									<input type="hidden" name="sourceIndex" value="-1"/>
									<input type="hidden" name="indexType" value=""/>
									<input type="hidden" name="mode" value="update"/>
									<input type="hidden" name="uri" value="/management/collections/update-datasource"/>
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title"> Indexing Source</h4>
									</div>
									<div class="modal-body">
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Setting</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
															<div class="form-group">
																<label class="col-md-3 control-label">Name:</label>
																<div class="col-md-9"><input type="text" name="name" class="form-control input-width-small required" ></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Enabled:</label>
																<div class="col-md-9">
																	<label class="checkbox">
																		<input type="checkbox" name="active" class="form-control" value="true" checked>
																		Yes
																	</label>
																</div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Reader Class:</label>
																<div class="col-md-9"><input type="text" name="readerClass" class="form-control required"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Modifier Class:</label>
																<div class="col-md-9"><input type="text" name="modifierClass" class="form-control"></div>
															</div>
														</div>
														
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Properties</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
															<div class="form-group">
																<div class="col-md-12">
																	<a><i class="icon-plus-sign"></i> Add Property</a>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-primary">Save changes</button>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
						
					<div class="widget">
						<div class="widget-header">
							<h4>Add Indexing</h4>
						</div>
						<div class="widget-content">
							<a data-toggle="modal" data-target="#newSourceModal" index-type="add"><span class="icon-plus-sign"></span> Add Datasource</a>
							<table class="table table-hover table-bordered table-checkable">
								<thead>
									<tr>
										<th>Name</th>
										<th>Enable</th>
										<th>Reader / Modifier</th>
										<th> </th>
									</tr>
								</thead>
								<tbody>
									<%
									sourceConfigList = addIndexingNode.getChildren("source");
									for(int i = 0; sourceConfigList != null && i< sourceConfigList.size(); i++){
										Element sourceConfig = sourceConfigList.get(i);
										String name = sourceConfig.getAttributeValue("name");
										String active = sourceConfig.getAttributeValue("active");
										String reader = sourceConfig.getChildText("reader");
										String modifier = sourceConfig.getChildText("modifier");
									%>
									<tr class="_add_<%=i %>">
										<td class="._name"><%=name %></td>
										<td class="._active"><%="true".equals(active) ? "Enabled" : "Disabled" %></td>
										<td class="._reader"><%=reader %><%=modifier != null && modifier.length() > 0 ? "<p>("+modifier+")</p>" : "<p>(No modifier)</p>" %></td>
										<td class=""><a data-toggle="modal" data-target="#addSourceModal_<%=i %>">Edit</a></td>
									</tr>
									<%
									}
									%>
								</tbody>
							</table>
						</div>
					</div>
					
					<%
					sourceConfigList = addIndexingNode.getChildren("source");
					for(int i = 0; i< sourceConfigList.size(); i++){
						Element sourceConfig = sourceConfigList.get(i);
						String name = sourceConfig.getAttributeValue("name");
						String active = sourceConfig.getAttributeValue("active");
						String reader = sourceConfig.getChildText("reader");
						String modifier = sourceConfig.getChildText("modifier");
					%>
						<div class="modal" id="addSourceModal_<%=i %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<form id="addSourceModalForm_<%=i %>" class="addIndexingForm" method="POST">
										<input type="hidden" name="collectionId" value="${collectionId}"/>
										<input type="hidden" name="sourceIndex" value="<%=i%>"/>
										<input type="hidden" name="indexType" value="add"/>
										<input type="hidden" name="mode" value="update"/>
										<input type="hidden" name="uri" value="/management/collections/update-datasource"/>
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
											<h4 class="modal-title"> Add Indexing Source</h4>
										</div>
										<div class="modal-body">
											<div class="col-md-12">
												<div class="widget">
													<div class="widget-header">
														<h4>Setting</h4>
													</div>
													<div class="widget-content">
														<div class="row">
															<div class="col-md-12 form-horizontal">
																<div class="form-group">
																	<label class="col-md-3 control-label">Name:</label>
																	<div class="col-md-9"><input type="text" name="name" class="form-control input-width-small" value="<%=name %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Enabled:</label>
																	<div class="col-md-9">
																		<label class="checkbox">
																			<input type="checkbox" name="active" class="form-control" value="true" <%="true".equalsIgnoreCase(active)? "checked" :"" %>>
																			Yes
																		</label>
																	</div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Reader Class:</label>
																	<div class="col-md-9"><input type="text" name="readerClass" class="form-control" value="<%=reader %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Modifier Class:</label>
																	<div class="col-md-9"><input type="text" name="modifierClass" class="form-control" value="<%=modifier %>"></div>
																</div>
															</div>
															
														</div>
													</div>
												</div> <!-- /.widget -->
											</div>
											<div class="col-md-12">
												<div class="widget">
													<div class="widget-header">
														<h4>Properties</h4>
													</div>
													<div class="widget-content">
														<div class="row">
															<div class="col-md-12 form-horizontal">
															<%
															Element properties = sourceConfig.getChild("properties");
															if(properties != null){
															%>
																<%
																List<Element> propertyList = properties.getChildren("property");
																for(int j=0; j<propertyList.size(); j++){
																%>
																	<%
																	Element property = propertyList.get(j);
																	String key = property.getAttributeValue("key");
																	String value = property.getValue();
																	%>
																	<div class="form-group">
																		<div class="col-md-4"><input type="text" name="key" class="form-control" value="<%=key %>" placeholder="KEY"></div>
																		<div class="col-md-8">
																			<div class="input-group">
																				<input type="text" name="value" class="form-control" value="<%=value %>" placeholder="VALUE">
																				<span class="input-group-btn">
																					<button class="btn btn-default" type="button"><i class="icon-minus-sign text-danger"></i></button>
																				</span>
																			</div>
																		</div>
																	</div>
																<%
																}
																%>
															<%
															}
															%>
															<div class="form-group">
																<div class="col-md-12">
																	<a><i class="icon-plus-sign"></i> Add Property</a>
																</div>
															</div>
															</div>
															
														</div>
													</div>
												</div> <!-- /.widget -->
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-danger pull-left" onclick="javascript:void(0)">Remove</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
											<button type="submit" class="btn btn-primary">Save changes</button>
										</div>
									</form>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						
						<%
						}
						%>
						
						<div class="widget">
						<div class="widget-header">
							<h4>JDBC List</h4>
						</div>
						<div class="widget-content">
								
								<a data-toggle="modal" data-target="#newJdbcSourceModal"><span class="icon-plus-sign"></span> Add JDBC</a>
								
							<table class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>#</th>
										<th>ID</th>
										<th>Name</th>
										<th>Driver</th>
										<th>URL</th>
										<th>User</th>
										<th>Password</th>
										<th></th>
									</tr>
								</thead>
								<tbody>
								<%
								List<Element> sourceNodeList = jdbcSourcesNode.getChildren("jdbc-source");
								for(int i =0; i< sourceNodeList.size(); i++){
									Element sourceNode = sourceNodeList.get(i);
									String id = sourceNode.getAttributeValue("id");
									String name = sourceNode.getAttributeValue("name");
									String driver = sourceNode.getAttributeValue("driver");
									String url = sourceNode.getAttributeValue("url");
									String user = sourceNode.getAttributeValue("user");
									String maskedPassword = WebUtils.getMaskedPassword(sourceNode.getAttributeValue("password"));
								%>
									<tr>
										<td><%=i+1 %></td>
										<td><%=id %></td>
										<td><%=name %></td>
										<td><%=driver %></td>
										<td><%=url %></td>
										<td><%=user %></td>
										<td><%=maskedPassword %></td>
										<td><a data-toggle="modal" data-target="#jdbcSourceModal_<%=i%>">Edit</a></td>
									</tr>
								<%
								}
								%>
								</tbody>
							</table>
						</div>
					</div>
					<%
					sourceNodeList = jdbcSourcesNode.getChildren("jdbc-source");
					for(int i =0; i< sourceNodeList.size(); i++){
						Element sourceNode = sourceNodeList.get(i);
						String id = sourceNode.getAttributeValue("id");
						String name = sourceNode.getAttributeValue("name");
						String driver = sourceNode.getAttributeValue("driver");
						String url = sourceNode.getAttributeValue("url");
						String user = sourceNode.getAttributeValue("user");
					%>
					<div class="modal" id="jdbcSourceModal_<%=i %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form id="jdbcSourceForm_<%=i %>" class="jdbcSourceForm" method="POST">
									<input type="hidden" name="collectionId" value="${collectionId}"/>
									<input type="hidden" name="sourceIndex" value="<%=i%>"/>
									<input type="hidden" name="uri" value="/management/collections/update-jdbc-source"/>
									<input type="hidden" name="mode" value="update"/>
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title"> Jdbc Source</h4>
									</div>
									<div class="modal-body">
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Setting</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
															<div class="form-group">
																<label class="col-md-3 control-label">Id:</label>
																<div class="col-md-9"><input type="text" name="id" class="form-control input-width-small required" value="<%=id%>" placeholder="ID"></div>
															</div>
															<div class="form-group">
																<label class="col-md-3 control-label">Name:</label>
																<div class="col-md-9"><input type="text" name="name" class="form-control input-width-small required" value="<%=name%>" placeholder="NAME"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Driver:</label>
																<div class="col-md-9"><input type="text" name="driver" class="form-control required" value="<%=driver%>" placeholder="DRIVER"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Url:</label>
																<div class="col-md-9"><input type="text" name="url" class="form-control required" value="<%=url%>" placeholder="URL"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">User:</label>
																<div class="col-md-9"><input type="text" name="user" class="form-control" value="<%=user%>" placeholder="USER"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Password:</label>
																<div class="col-md-9"><input type="text" name="password" class="form-control" placeholder="PASSWORD (LEAVE BLANK IF YOU DON'T WANT CHANGE)"></div>
															</div>
														</div>
														
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-danger pull-left">Remove</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-primary">Save changes</button>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					
					<%
					}
					%>	
					<div class="modal" id="newJdbcSourceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<form id="newJdbcSourceForm" class="newJdbcSourceForm" method="POST">
									<input type="hidden" name="collectionId" value="${collectionId}"/>
									<input type="hidden" name="sourceIndex" value="-1"/>
									<input type="hidden" name="uri" value="/management/collections/update-jdbc-source"/>
									<input type="hidden" name="mode" value="update"/>
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
										<h4 class="modal-title"> Jdbc Source</h4>
									</div>
									<div class="modal-body">
										<div class="col-md-12">
											<div class="widget">
												<div class="widget-header">
													<h4>Setting</h4>
												</div>
												<div class="widget-content">
													<div class="row">
														<div class="col-md-12 form-horizontal">
															<div class="form-group">
																<label class="col-md-3 control-label">Id:</label>
																<div class="col-md-9"><input type="text" name="id" class="form-control input-width-small required" placeholder="ID"></div>
															</div>
															<div class="form-group">
																<label class="col-md-3 control-label">Name:</label>
																<div class="col-md-9"><input type="text" name="name" class="form-control input-width-small required" placeholder="NAME"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Driver:</label>
																<div class="col-md-9"><input type="text" name="driver" class="form-control required" placeholder="DRIVER"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Url:</label>
																<div class="col-md-9"><input type="text" name="url" class="form-control required" placeholder="URL"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">User:</label>
																<div class="col-md-9"><input type="text" name="user" class="form-control" placeholder="USER"></div>
															</div>
															
															<div class="form-group">
																<label class="col-md-3 control-label">Password:</label>
																<div class="col-md-9"><input type="text" name="password" class="form-control" placeholder="PASSWORD"></div>
															</div>
														</div>
														
													</div>
												</div>
											</div> <!-- /.widget -->
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
										<button type="submit" class="btn btn-primary">Save changes</button>
									</div>
								</form>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal-dialog -->
					</div>
					<div id="property-template" class="hidden">
						<div class="form-group">
							<div class="col-md-4"><input type="text" name="key" class="form-control" value="" placeholder="KEY"></div>
							<div class="col-md-8">
								<div class="input-group">
									<input type="text" name="value" class="form-control" value="" placeholder="VALUE">
									<span class="input-group-btn">
										<button class="btn btn-default" type="button"><i class="icon-minus-sign text-danger"></i></button>
									</span>
								</div>
							</div>
						</div>
					</div>
			</div>
		</div>
	</div>
</body>
</html>