<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.width100 {
	width: 100px;
}
</style>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="${collectionId}" />
			<c:param name="scat" value="data" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Data</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Data</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_raw_data" data-toggle="tab">Raw</a></li>
						<li class=""><a href="#tab_analyzed_data" data-toggle="tab">Analyzed Raw</a></li>
						<li class=""><a href="#tab_analyzed_data" data-toggle="tab">Search</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_field">
							<div class="col-md-12">
								<div class="widget box">
	
									<div class="widget-content no-padding">
										<div class="dataTables_header clearfix">
											<div class="col-md-6">
												Rows 1 - 50 of 2809
											</div>
											<div class="col-md-6">
												<div class="btn-group pull-right">
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&laquo;</a>
													<a href="javascript:void(0);" class="btn btn-sm btn-primary" rel="tooltip">1</a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">2</a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">3</a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">4</a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">5</a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&raquo;</a>
												</div>
											</div>
										</div>
										<div style="overflow: scroll; height: 400px;">
	
											<table class="table table-hover table-bordered" style="white-space:nowrap;table-layout:fixed; ">
												<thead>
													<tr>
														<th class="width100">#</th>
														<th class="width100">ID</th>
														<th class="width100">TITLE</th>
														<th class="width100">BODY</th>
														<th class="width100">REGDT</th>
														<th class="width100">TAGS</th>
														<th class="width100">YEAR</th>
														<th class="width100">TAGS</th>
														<th class="width100">YEAR</th>
														<th class="width100">TAGS</th>
														<th class="width100">YEAR</th>
														<th class="width100">TAGS</th>
														<th class="width100">YEAR</th>
														<th class="width100">TAGS</th>
														<th class="width100">YEAR</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td class="width100">1</td>
														<td class="width100">123</td>
														<td class="width100" style="overflow:hidden;">this is sample</td>
														<td class="width100"><div style="overflow:hidden;">this is sample. this is sample. this is sample. this is sample. this is sample.</div></td>
														<td class="width100">2013-09-01</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
													</tr>
													<tr>
														<td class="width100">2</td>
														<td class="width100">124</td>
														<td class="width100" style="overflow:hidden;">this is sample</td>
														<td class="width100" style="overflow:hidden;">this is sample. this is sample. this is sample. this is sample. this is sample. this is sample. this is sample.</td>
														<td class="width100">2013-09-01</td>
														<td class="width100">sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
													</tr>
													<tr>
														<td class="width100">2</td>
														<td class="width100">124</td>
														<td class="width100">this is sample</td>
														<td class="width100" style="overflow:hidden;">this is sample. this is sample. this is sample. this is sample. this is sample. this is sample. this is sample.</td>
														<td class="width100">2013-09-01</td>
														<td class="width100">sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
														<td class="width100" style="overflow:hidden;">sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search
														,sample,search,sample,search,sample,search</td>
														<td class="width100">2013</td>
													</tr>
													
												</tbody>
											</table>
										</div>
	
										<div class="table-footer">
											<!-- <div class="panel">
												this is sample. this is sample. this is sample. this is sample. this is sample. this is sample. this is sample.
											</div> -->
											<label class="col-md-2 control-label">Selected Data:</label>
											<div class="col-md-10">
												<div class="panel">
												this is sample. this is sample. this is sample. this is sample. this is sample. this is sample. this is sample.
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
				
				
			</div>
		</div>
	</div>
</body>
</html>