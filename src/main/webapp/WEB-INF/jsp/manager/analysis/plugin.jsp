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
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="analysis" />
			<c:param name="mcat" value="plugin" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Analysis</li>
						<li class="current"> Plugin</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Plugin</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="input-group col-md-12">
								<a href="javascript:void(0);" class="btn btn-sm"><span
									class="glyphicon glyphicon-plus-sign"></span> Add Plugin</a>
									&nbsp;
								<a href="javascript:void(0);" class="btn btn-sm">
									<span class="glyphicon glyphicon-minus-sign"></span> Remove Plugin
								</a>
							</div>
							
						</div>
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th><input type="checkbox" /></th>
									<th>ID</th>
									<th>Name</th>
									<th>Version</th>
									<th>Decription</th>
									<th>Class</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><input type="checkbox" /></td>
									<td><strong>Korean</strong></td>
									<td>한국어분석기</td>
									<td>1.0</td>
									<td>한국어분석기 및 한국어분석사전을 제공한다.</td>
									<td>org.fastcatsearch.plugin.analysis.ko.KoreanAnalysisPlugin</td>
								</tr>
								<tr>
									<td><input type="checkbox" /></td>
									<td><strong>Product</strong></td>
									<td>상품명분석기</td>
									<td>1.0</td>
									<td>상품명분석기 및 분석사전을 제공한다.</td>
									<td>org.fastcatsearch.plugin.analysis.ProductAnalysisPlugin</td>
								</tr>
								<tr>
									<td><input type="checkbox" /></td>
									<td><strong>English</strong></td>
									<td>English Analysis</td>
									<td>1.0</td>
									<td>English dictionary and analyzer</td>
									<td>org.fastcatsearch.plugin.analysis.EnglishAnalysisPlugin</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>