<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
function editPluginSchedule(id){
	//table > tbody > tr > td의 값을 가져와서 modal에 뿌려준다. 
}
</script>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
			<c:param name="lcat" value="analysis" />
			<c:param name="mcat" value="${analysisId}" />
		</c:import>
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

				<div class="widget">
					<div class="widget-header">
						<h4>Overview</h4>
					</div>
					<div class="widget-content">
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
				</div>
					
				<div class="widget">
					<div class="widget-header">
						<h4>Dictionary</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>ID</th>
									<th>Name</th>
									<th>Dictionary File</th>
									<th>Dictionary Type</th>
									<th>Columns</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td><strong>User</strong></td>
									<td>User Dictionary</td>
									<td><i>user.dict</i></td>
									<td><span class="label label-default">Set</span></td>
									<td><a href="javascript:alert('column을 보여주는 modal을 띄운다.')">View</a></td>
								</tr>
								<tr><td>2</td>
									<td><strong>Synonym</strong></td>
									<td>Synonym Dictionary</td>
									<td><i>synonym.dict</i></td>
									<td><span class="label label-default">List</span></td>
									<td><a href="javascript:alert('column을 보여주는 modal을 띄운다.')">View</a></td>
								</tr>
								<tr>
									<td>3</td>
									<td><strong>Stop</strong></td>
									<td>Stop Dictionary</td>
									<td><i>stop.dict</i></td>
									<td><span class="label label-default">Set</span></td>
									<td><a href="javascript:alert('column을 보여주는 modal을 띄운다.')">View</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
							
						
						
				<div class="widget">
					<div class="widget-header">
						<h4>Action</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>URI</th>
									<th>Method</th>
									<th>Class</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td><strong>/analysis/product/synonym</strong></td>
									<td>GET,POST</td>
									<td><i>org.fastcatsearch.plugin.analysis.product.servlet.SynonymDictionaryAction</i></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
							
						
				<div class="widget">
					<div class="widget-header">
						<h4>Schedule</h4>
					</div>
					<div class="widget-content">
						<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Task</th>
									<th>Base Time</th>
									<th>Period</th>
								</tr>
							</thead>
							<tbody>
								<tr id="schedule_1">
									<td>1</td>
									<td><strong>org.fastcatsearch.job.plugin.BackupDictionaryJob</strong></td>
									<td>2011.11.26 09:00</td>
									<td>1 Hour</td>
								</tr>
								<tr id="schedule_2">
									<td>2</td>
									<td><strong>org.fastcatsearch.job.plugin.BackupDictionaryJob</strong></td>
									<td>2011.11.26 09:00</td>
									<td>1 Hour</td>
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