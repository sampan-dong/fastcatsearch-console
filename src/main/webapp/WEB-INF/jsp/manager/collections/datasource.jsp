<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="java.util.*"%>
<%
	Document document = (Document) request.getAttribute("document");
	Element root = document.getRootElement();
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
													<th>Type</th>
													<th>ID</th>
													<th>Name</th>
													<th>Enable</th>
													<th>Reader Class</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>File</td>
													<td><a href="datasource/file.html"><strong>file1</strong></a></td>
													<td>FILE1</td>
													<td>Enabled</td>
													<td>org.fastcatsearch.datasource.reader.FileReader</td>
												</tr>
												<tr>
													<td>DB</td>
													<td><a href="datasource/db.html"><strong>db1</strong></a></td>
													<td>DB1</td>
													<td>Disabled</td>
													<td>org.fastcatsearch.datasource.reader.DBReader</td>
												</tr>
												<tr>
													<td>DB</td>
													<td><a href="datasource/db.html"><strong>db2</strong></a></td>
													<td>DB2</td>
													<td>Enabled</td>
													<td>org.fastcatsearch.datasource.reader.DBReader</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
						
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
													<th>Type</th>
													<th>ID</th>
													<th>Name</th>
													<th>Enable</th>
													<th>Reader Class</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>File</td>
													<td><a href="datasource/file.html"><strong>file2</strong></a></td>
													<td>FILE1</td>
													<td>Enabled</td>
													<td>org.fastcatsearch.datasource.reader.FileReader</td>
												</tr>
												<tr>
													<td>DB</td>
													<td><a href="datasource/db.html"><strong>db2</strong></a></td>
													<td>DB1</td>
													<td>Disabled</td>
													<td>org.fastcatsearch.datasource.reader.DBReader</td>
												</tr>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
						
					
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
													<span class="glyphicon glyphicon-edit"></span> Edit JDBC
												</a>
													&nbsp;
												<a href="javascript:void(0);" class="btn btn-sm">
													<span class="glyphicon glyphicon-minus-sign"></span> Remove JDBC
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
												<tr>
													<td class="checkbox-column">
														<input type="checkbox" class="uniform">
													</td>
													<td>sysdb1</td>
													<td>시스템디비</td>
													<td>com.mysql.driver.Driver</td>
													<td>jdbc://mysql:192.168.0.50/sample</td>
													<td>system</td>
													<td>12***a</td>
												</tr>
												<tr>
													<td class=" ">
														<input type="checkbox" class="uniform">
													</td>
													<td>sysdb2</td>
													<td>시스템디비2</td>
													<td>com.mysql.driver.Driver</td>
													<td>jdbc://mysql:192.168.0.50/sample</td>
													<td>system</td>
													<td>23***b</td>
												</tr>
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