<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp" />
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
									<th>Indexing Node</th>
									<th>Data Node</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td>*<strong>VOL</strong></td>
									<td>TOTAL</td>
									<td></td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>VOL1</strong></td>
									<td>ELEC</td>
									<td>cate1=(123,456,789)</td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>VOL2</strong></td>
									<td>COMPUTER</td>
									<td>cate1=a01</td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>VOL2011</strong></td>
									<td>PRODUCT 2011</td>
									<td>year<2012</td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>VOL2012</strong></td>
									<td>PRODUCT 2012</td>
									<td>year>=2012<2013</td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
								<tr>
									<td class="checkbox-column">
										<input type="checkbox" class="uniform">
									</td>
									<td><strong>VOL2013</strong></td>
									<td>PRODUCT 2013</td>
									<td>year>2013</td>
									<td>Node1</td>
									<td>Node1, Node2</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				
				
				
			</div>
		</div>
	</div>
</body>
</html>