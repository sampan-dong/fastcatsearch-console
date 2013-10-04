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
								<a href="javascript:void(0);" class="btn btn-sm"><span
									class="glyphicon glyphicon-plus-sign"></span> Add Shard</a>
									&nbsp;
								<a href="javascript:void(0);" class="btn btn-sm">
									<span class="glyphicon glyphicon-minus-sign"></span> Remove Shard
								</a>
								&nbsp;
								<a href="javascript:void(0);" class="btn btn-sm">
									<span class="icon-edit"></span> Edit Shard
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
									<th>Filter</th>
									<th>Data Node</th>
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
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong><%=shardId %></strong></td>
									<td><%=shardName %></td>
									<td><%=filter %></td>
									<td><%=dataNodeString %></td>
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
</body>
</html>