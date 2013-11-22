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
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="${collectionId}" />
			<c:param name="scat" value="shard" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Shard</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Shard</h3>
						<p>Horizontal partitioning data</p>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="input-group col-md-12">
								<a href="#addShardModal" class="btn btn-sm" role="button" data-toggle="modal" data-backdrop="static">
									<span class="glyphicon glyphicon-plus-sign"></span> Add Shard</a>
							</div>
							
						</div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>ID</th>
									<th>Name</th>
									<th>Filter</th>
									<th>Data Node</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
							
								<%
								Element root = document.getRootElement();
								List<Element> list = root.getChildren();
								
								for(int i=0; i < list.size(); i++){
									Element el = list.get(i);
									String shardId = el.getChildText("id");
 									String shardName = el.getChildText("name");
									String filter = el.getChildText("filter");
									List<Element> dataNodeList = el.getChildren("data-node");
									String dataNodeString = "";
									
									for(int j=0; j < dataNodeList.size(); j++){
										Element dataNode = dataNodeList.get(j);
										if(j > 0){
											dataNodeString += ", ";
										}
										dataNodeString += dataNode.getChildText("node");
									}
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=shardId %></strong></td>
									<td><%=shardName %></td>
									<td><%=filter %></td>
									<td><%=dataNodeString %></td>
									<td>
										<a href="javascript:editShard('<%=shardId %>')" class="btn btn-sm">Edit</a>
									</td>
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
	
	
	<div class="modal" id="addShardModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Add Shard</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="add-shard-form">
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label">Shard ID</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="shardId" placeholder="Shard ID">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Shard Name</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="shardName" placeholder="Shard Name">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Filter</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="filter" placeholder="Filter">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Data Node List</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="dataNodeList" placeholder="Data Node List">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
			        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		      	</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	
	<div class="modal" id="editShardModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title">Add Shard</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="edit-shard-form">
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label">Shard ID</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="shardId" placeholder="Shard ID">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Shard Name</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="shardName" placeholder="Shard Name">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Filter</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="filter" placeholder="Filter">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Data Node List</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" name="dataNodeList" placeholder="Data Node List">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger pull-left" onclick="updateUsingProxy('update-user-form','delete')">Remove</button>
			        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
		      	</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
</body>
</html>