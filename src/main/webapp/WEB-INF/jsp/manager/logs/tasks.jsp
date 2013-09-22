<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.task .percent {
float: right;
display: inline-block;
color: #adadad;
font-size: 11px;
}
</style>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp">
			<c:param name="lcat" value="logs" />
			<c:param name="mcat" value="tasks" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Logs</li>
						<li class="current"> Tasks</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Tasks</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<table class="table table-hover table-bordered ">
					<thead>
						<tr>
							<th>#</th>
							<th>Task</th>
							<th>Elapsed</th>
							<th>Start</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>2</td>
							<td><span class="task">
								<span class="desc">Collection Vol1 indexing..</span> <span class="percent">20%</span>
								</span>
									<div class="progress progress-small progress-striped active">
										<div style="width: 20%;" class="progress-bar progress-bar-info"></div>
									</div>
							</td>
							<td>1h 20m</td>
							<td>2013-09-10 12:35:00</td>
						</tr>
						<tr>
							<td>1</td>
							<td><span class="task">
								<span class="desc">Apply dictionary</span> <span class="percent">80%</span>
								</span>
									<div class="progress progress-small progress-striped active">
										<div style="width: 80%;" class="progress-bar progress-bar-info"></div>
									</div>
							</td>
							<td>1h</td>
							<td>2013-09-10 12:35:00</td>
						</tr>
					</tbody>
				</table>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>