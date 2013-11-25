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
<script>
$(document).ready(function(){
	prepareShardForm("add-shard-form");
/* 	var formObj = $("#add-shard-form");
	formObj.validate();
	formObj.submit(function(e) {
		if(!formObj.valid()){
			return;
		}
		
		var postData = $(this).serializeArray();
		$.ajax({
				url : PROXY_REQUEST_URI,
				type: "POST",
				data : postData,
				dataType : "json",
				success:function(data, textStatus, jqXHR) {
					try {
						if(data["success"]==true) {
							location.href = location.href;
						}
					} catch (e) { 
						alert("error occured for update");
					}
					
				}, error: function(jqXHR, textStatus, errorThrown) {
					alert("ERROR" + textStatus + " : " + errorThrown);
				}
		});
		e.preventDefault(); //STOP default action
	}); */
});
function prepareShardForm(formName){
	var formObj = $("#"+formName);
	formObj.validate();
	formObj.submit(function(e) {
		e.preventDefault(); //STOP default action
		
		if(!formObj.valid()){
			return;
		}
		
		var postData = $(this).serializeArray();
		$.ajax({
				url : PROXY_REQUEST_URI,
				type: "POST",
				data : postData,
				dataType : "json",
				success:function(data, textStatus, jqXHR) {
					try {
						if(data.success == true) {
							location.href = location.href;
						}else{
							noty({text: "Operation Failed. "+data.errorMessage, type: "error", layout:"topRight", timeout: 5000});
						}
					} catch (e) { 
						alert("error occured for update");
					}
					
				}, error: function(jqXHR, textStatus, errorThrown) {
					alert("ERROR" + textStatus + " : " + errorThrown);
				}
		});
		
	});
}

function removeShard(shardId){
	if(!confirm("Remove shard ["+shardId+"]?")){
		return;
	}
	$.ajax({
		url : PROXY_REQUEST_URI,
		type: "POST",
		data : {
			uri: "/management/collections/shard-remove",
			collectionId: "${collectionId}",
			shardId: shardId
		},
		dataType : "json",
		success:function(data, textStatus, jqXHR) {
			try {
				if(data["success"]==true) {
					location.href = location.href;
				}
			} catch (e) { 
				alert("error occured for update");
			}
			
		}, error: function(jqXHR, textStatus, errorThrown) {
			alert("ERROR" + textStatus + " : " + errorThrown);
		}
});
}
</script>
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
										if(dataNodeString.length() > 0){
											dataNodeString += ", ";
										}
										String childNodeText = dataNode.getChildText("node");
										if(childNodeText != null){
											dataNodeString += childNodeText;
										}
									}
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><strong><%=shardId %></strong></td>
									<td><%=shardName %></td>
									<td><%=filter %></td>
									<td><%=dataNodeString %></td>
									<td>
										<a href="#editShardModal_<%=shardId %>" class="btn btn-sm" role="button" data-toggle="modal" data-backdrop="static">Edit</a>
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
				<form class="form-horizontal" role="form" id="add-shard-form">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Add Shard</h4>
					</div>
					<div class="modal-body">
						
						<input type="hidden" name="uri" value="/management/collections/shard-add" />
						<input type="hidden" name="collectionId" value="${collectionId}" />
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label">Shard ID</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="shardId" placeholder="Shard ID" minlength="3">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Shard Name</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="shardName" placeholder="Shard Name">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Filter</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="filter" placeholder="Filter">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Data Node List</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="dataNodeList" placeholder="Data Node List">
							</div>
						</div>
						
					</div>
					<div class="modal-footer">
						<button type="submit" class="btn btn-primary" >Confirm</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			      	</div>
		      	</form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	
<%
	Element root2 = document.getRootElement();
	List<Element> list2 = root.getChildren();
	
	for(int i=0; i < list2.size(); i++){
		Element el = list2.get(i);
		String shardId = el.getChildText("id");
		String shardName = el.getChildText("name");
		String filter = el.getChildText("filter");
		List<Element> dataNodeList = el.getChildren("data-node");
		String dataNodeString = "";
		
		for(int j=0; j < dataNodeList.size(); j++){
			Element dataNode = dataNodeList.get(j);
			if(dataNodeString.length() > 0){
				dataNodeString += ", ";
			}
			String childNodeText = dataNode.getChildText("node");
			if(childNodeText != null){
				dataNodeString += childNodeText;
			}
		}
%>
	<div class="modal" id="editShardModal_<%=shardId %>" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<form class="form-horizontal" role="form" id="edit-shard-form_<%=shardId %>">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title">Add Shard</h4>
					</div>
					<div class="modal-body">
						
						<input type="hidden" name="uri" value="/management/collections/shard-update" />
						<input type="hidden" name="collectionId" value="${collectionId}" />
						<div class="form-group">
							<label for="name" class="col-sm-3 control-label">Shard ID</label>
							<div class="col-sm-9">
								<input type="hidden" name="shardId" value="<%=shardId %>">
								<input type="text" class="form-control" value="<%=shardId %>" disabled>
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Shard Name</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="shardName" placeholder="Shard Name" value="<%=shardName %>">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Filter</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="filter" placeholder="Filter" value="<%=filter %>">
							</div>
						</div>
						<div class="form-group">
							<label for="userId" class="col-sm-3 control-label">Data Node List</label>
							<div class="col-sm-9">
								<input type="text" class="form-control required" name="dataNodeList" placeholder="Data Node List" value="<%=dataNodeString %>">
							</div>
						</div>
						
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger pull-left" onclick="removeShard('<%=shardId %>')">Remove</button>
						<button type="submit" class="btn btn-primary" >Confirm</button>
				        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
			      	</div>
		      	</form>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div>
	<script>
	$(document).ready(function(){
		prepareShardForm("edit-shard-form_<%=shardId %>");
	});
	</script>
<%
	}
%>
</body>
</html>