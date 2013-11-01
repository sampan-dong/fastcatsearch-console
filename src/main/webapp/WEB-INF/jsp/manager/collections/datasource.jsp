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
						<li class="current"> VOL</li>
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
				
				<div class="tabbable tabbable-custom tabbable-full-width ">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_datasource_full" data-toggle="tab">Full Indexing</a></li>
						<li class=""><a href="#tab_datasource_add" data-toggle="tab">Add Indexing</a></li>
						<li class=""><a href="#tab_db_sources" data-toggle="tab"><i class="icon-reorder"></i> JDBC Sources</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_datasource_full">
							<div class="col-md-12">
								<div class="widget box">
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="input-group col-md-12">
												<a href="javascript:void(0);" class="btn btn-sm"><span
													class="glyphicon glyphicon-plus-sign"></span> Add Datasource</a>
											</div>
											
										</div>
										<table class="table table-hover table-bordered table-checkable">
											<thead>
												<tr>
													<th>ID</th>
													<th>Name</th>
													<th>Enable</th>
													<th>Reader / Modifier</th>
													<th> </th>
												</tr>
											</thead>
											<tbody>
												<%
												List<Element> sourceConfgiList = fullIndexingNode.getChildren("source");
												for(int i = 0; sourceConfgiList != null && i < sourceConfgiList.size(); i++){
													Element sourceConfig = sourceConfgiList.get(i);
													String sourceId = sourceConfig.getAttributeValue("id");
													String name = sourceConfig.getAttributeValue("name");
													String active = sourceConfig.getAttributeValue("active");
													String reader = sourceConfig.getChildText("reader");
													String modifier = sourceConfig.getChildText("modifier");
												%>
												<tr class="_full_<%=sourceId %>">
													<td class="._sourceId"><strong><%=sourceId %></strong></td>
													<td class="._name"><%=name %></td>
													<td class="._active"><%="true".equals(active) ? "Enabled" : "Disabled" %></td>
													<td class="._reader"><%=reader %><%=modifier != null && modifier.length() > 0 ? "<p>("+modifier+")</p>" : "<p>(No modifier)</p>" %></td>
													<td class=""><button type="button" class="btn btn-sm" data-toggle="modal" data-target="#fullSourceModal_<%=sourceId %>">View</button></td>
												</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>

						
						<%
						sourceConfgiList = fullIndexingNode.getChildren("source");
						for(int i = 0; i< sourceConfgiList.size(); i++){
							Element sourceConfig = sourceConfgiList.get(i);
							String sourceId = sourceConfig.getAttributeValue("id");
							String name = sourceConfig.getAttributeValue("name");
							String active = sourceConfig.getAttributeValue("active");
							String reader = sourceConfig.getChildText("reader");
							String modifier = sourceConfig.getChildText("modifier");
						%>
							<div class="modal" id="fullSourceModal_<%=sourceId %>" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
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
																	<label class="col-md-3 control-label">ID:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control input-width-small" value="<%=sourceId %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Name:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control input-width-small" value="<%=name %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Enabled:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control input-width-small" value="<%=active %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Reader Class:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control" value="<%=reader %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Modifier Class:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control" value="<%=modifier %>"></div>
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
																List<Element> propertyList = properties.getChildren("property");
																for(int j=0; propertyList != null && j<propertyList.size(); j++){
																	Element property = propertyList.get(j);
																	String key = property.getAttributeValue("key");
																	String value = property.getValue();
															%>
																
																	<div class="form-group">
																	<div class="col-md-4"><input type="text" name="regular" class="form-control" value="<%=key %>"></div>
																	<div class="col-md-8"><input type="text" name="regular" class="form-control" value="<%=value %>"></div>
																	</div>
															<%
																}
															}
															%>
															</div>
														</div>
													</div>
												</div> <!-- /.widget -->
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Save
												changes</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
						<%
						}
						%>
						
						
						<div class="tab-pane" id="tab_datasource_add">
							<div class="col-md-12">
								<div class="widget box">
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="input-group col-md-12">
												<a href="javascript:void(0);" class="btn btn-sm"><span
													class="glyphicon glyphicon-plus-sign"></span> Add Datasource</a>
											</div>
											
										</div>
										<table class="table table-hover table-bordered table-checkable">
											<thead>
												<tr>
													<th>ID</th>
													<th>Name</th>
													<th>Enable</th>
													<th>Reader / Modifier</th>
													<th> </th>
												</tr>
											</thead>
											<tbody>
												<%
												sourceConfgiList = addIndexingNode.getChildren("source");
												for(int i = 0; sourceConfgiList != null && i< sourceConfgiList.size(); i++){
													Element sourceConfig = sourceConfgiList.get(i);
													String sourceId = sourceConfig.getAttributeValue("id");
													String name = sourceConfig.getAttributeValue("name");
													String active = sourceConfig.getAttributeValue("active");
													String reader = sourceConfig.getChildText("reader");
													String modifier = sourceConfig.getChildText("modifier");
												%>
												<tr class="_add_<%=sourceId %>">
													<td class="._sourceId"><strong><%=sourceId %></strong></td>
													<td class="._name"><%=name %></td>
													<td class="._active"><%="true".equals(active) ? "Enabled" : "Disabled" %></td>
													<td class="._reader"><%=reader %><%=modifier != null ? "<p/>("+modifier+")" : "" %></td>
													<td class=""><button type="button" class="btn btn-sm" data-toggle="modal" data-target="#addSourceModal_<%=sourceId %>">View</button></td>
												</tr>
												<%
												}
												%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
						
						
						<%
						sourceConfgiList = addIndexingNode.getChildren("source");
						for(int i = 0; i< sourceConfgiList.size(); i++){
							Element sourceConfig = sourceConfgiList.get(i);
							String sourceId = sourceConfig.getAttributeValue("id");
							String name = sourceConfig.getAttributeValue("name");
							String active = sourceConfig.getAttributeValue("active");
							String reader = sourceConfig.getChildText("reader");
							String modifier = sourceConfig.getChildText("modifier");
						%>
							<div class="modal" id="addSourceModal_<%=sourceId %>" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal"
												aria-hidden="true">&times;</button>
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
																	<label class="col-md-3 control-label">ID:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control" value="<%=sourceId %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Name:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control input-width-small" value="<%=name %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Enabled:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control input-width-small" value="<%=active %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Reader Class:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control" value="<%=reader %>"></div>
																</div>
																
																<div class="form-group">
																	<label class="col-md-3 control-label">Modifier Class:</label>
																	<div class="col-md-9"><input type="text" name="regular" class="form-control" value="<%=modifier %>"></div>
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
														<div class="row form-horizontal">
														<%
														Element properties = sourceConfig.getChild("properties");
														List<Element> propertyList = properties.getChildren("property");
														for(int j=0; j<propertyList.size(); j++){
															Element property = propertyList.get(j);
															String key = property.getAttributeValue("key");
															String value = property.getValue();
														%>
															
																<div class="form-group">
																<div class="col-md-4"><input type="text" name="regular" class="form-control" value="<%=key %>"></div>
																<div class="col-md-8"><input type="text" name="regular" class="form-control" value="<%=value %>"></div>
																</div>
														<%
															}
														%>
														</div>
													</div>
												</div> <!-- /.widget -->
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
											<button type="button" class="btn btn-primary">Save
												changes</button>
										</div>
									</div>
									<!-- /.modal-content -->
								</div>
								<!-- /.modal-dialog -->
							</div>
							
						<%
						}
						%>
						
					
						<!-- //tab field -->
						<div class="tab-pane" id="tab_db_sources">
							<div class="col-md-12">
								<div class="widget box">
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="input-group col-md-12">
												<a href="javascript:void(0);" class="btn btn-sm"><span
													class="glyphicon glyphicon-plus-sign"></span> Add JDBC</a>
													&nbsp;
												<a href="javascript:void(0);" class="btn btn-sm">
													<span class="glyphicon glyphicon-minus-sign"></span> Remove JDBC
												</a>
													&nbsp;
												<a href="javascript:void(0);" class="btn btn-sm">
													<span class="glyphicon glyphicon-edit"></span> Edit JDBC
												</a>
											</div>
											
										</div>
										<table class="table table-hover table-bordered table-checkable">
											<thead>
												<tr>
													<th class="checkbox-column">
														<input type="checkbox" class="uniform">
													</th>
													<th>ID</th>
													<th>Name</th>
													<th>Driver</th>
													<th>URL</th>
													<th>User</th>
													<th>Password</th>
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
													<td class="checkbox-column">
														<input type="checkbox" class="uniform">
													</td>
													<td><%=id %></td>
													<td><%=name %></td>
													<td><%=driver %></td>
													<td><%=url %></td>
													<td><%=user %></td>
													<td><%=maskedPassword %></td>
												</tr>
												
											<%
											}
											%>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
					</div>
					<!-- /.tab-content -->
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>