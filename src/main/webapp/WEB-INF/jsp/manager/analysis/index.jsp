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
						<li class="current"> Analysis</li>
						<li class="current"> Korean</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Korean</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_analysis_overview" data-toggle="tab">Overview</a></li>
						<li class=""><a href="#tab_analysis_dictionary" data-toggle="tab">Dictionary</a></li>
						<li class=""><a href="#tab_analysis_analyzer" data-toggle="tab">Analyzer</a></li>
						<li class=""><a href="#tab_analysis_action" data-toggle="tab">Action</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_analysis_overview">
							<dl class="dl-horizontal">
								<dt>ID</dt>
								<dd>Korean analysis</dd>
								<dt>Namespace</dt>
								<dd>Analysis</dd>
								<dt>Class</dt>
								<dd>org.fastcatsearch.plugin.analysis.ko.KoreanAnalysisPlugin</dd>
								<dt>Name</dt>
								<dd>한국어분석기</dd>
								<dt>Version</dt>
								<dd>1.0</dd>
								<dt>Decription</dt>
								<dd>한국어분석기 및 한국어분석사전을 제공한다.</dd>
							</dl>
						</div>
						
						<!-- === Dictionary -->
						<div class="tab-pane " id="tab_analysis_dictionary">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-plus-sign"></span> Add</a>
												&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-minus-sign"></span> Remove
											</a>
												&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-edit"></span> Edit
											</a>
											<div class="pull-right">
											<a href="javascript:void(0);" class="btn btn-danger btn-sm">
													<span class="glyphicon glyphicon-trash"></span> Clean Data
												</a>
												</div>
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
												<th>Dictionary File</th>
												<th>Dictionary Type</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong>User</strong></td>
												<td>User Dictionary</td>
												<td><i>user.dict</i></td>
												<td><span class="label label-default">Set</span></td>
											</tr>
											<tr><td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong>Synonym</strong></td>
												<td>Synonym Dictionary</td>
												<td><i>synonym.dict</i></td>
												<td><span class="label label-default">List</span></td>
											</tr>
											<tr>
												<td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong>Stop</strong></td>
												<td>Stop Dictionary</td>
												<td><i>stop.dict</i></td>
												<td><span class="label label-default">Set</span></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<!-- tab_analysis_analyzer -->
						<div class="tab-pane" id="tab_analysis_analyzer">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-plus-sign"></span> Add</a>
												&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-minus-sign"></span> Remove
											</a>
											&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-edit"></span> Edit
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
												<th>Class</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong>KoreanAnalyzer</strong></td>
												<td>KoreanAnalyzer</td>
												<td><i>com.fastcatsearch.plugin.analysis.ko.standard.StandardKoreanAnalyzer</i></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>

						</div>
						<!-- //tab_analysis_analyzer -->
						
						<!-- tab_analysis_action -->
						<div class="tab-pane" id="tab_analysis_action">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-plus-sign"></span> Add</a>
												&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-minus-sign"></span> Remove
											</a>
											&nbsp;
											<a href="javascript:void(0);" class="btn btn-sm">
												<span class="glyphicon glyphicon-edit"></span> Edit
											</a>
										</div>
										
									</div>
									<table class="table table-hover table-bordered table-checkable">
										<thead>
											<tr>
												<th class="checkbox-column">
													<input type="checkbox" class="uniform">
												</th>
												<th>URI</th>
												<th>Content Type</th>
												<th>Class</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class="checkbox-column">
													<input type="checkbox" class="uniform">
												</td>
												<td><strong>/analysis/product/synonym</strong></td>
												<td>json</td>
												<td><i>org.fastcatsearch.plugin.analysis.product.servlet.SynonymDictionaryServlet</i></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- //tab_analysis_action -->
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