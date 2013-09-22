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
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp">
			<c:param name="lcat" value="logs" />
			<c:param name="mcat" value="exceptions" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Logs</li>
						<li class="current"> Exceptions</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Exceptions</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="widget box">
					<div class="widget-content no-padding">
						<div class="dataTables_header clearfix">
							<div class="col-md-12">
								<span>Rows 1 - 15 of 2809</span>
								<div class="btn-group pull-right">
									<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&laquo;</a>
									<a href="javascript:void(0);" class="btn btn-sm btn-primary"
										rel="tooltip">1</a> <a href="javascript:void(0);"
										class="btn btn-sm" rel="tooltip">2</a> <a
										href="javascript:void(0);" class="btn btn-sm" rel="tooltip">3</a>
									<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">4</a>
									<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">5</a>
									<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip">&raquo;</a>
								</div>
							</div>

						</div>
						<table id="log_table"
							class="table table-hover table-bordered table-condensed table-checkable">
							<thead>
								<tr>
									<th>#</th>
									<th>Time</th>
									<th>Node</th>
									<th>Exception</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>15</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>14</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>13</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>12</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>11</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>10</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>9</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>8</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>7</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>6</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>5</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>4</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>3</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>2</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
								<tr>
									<td>1</td>
									<td>2013-09-10 12:35:00</td>
									<td>node1</td>
									<td>(IRService.java:99) 컬렉션context 로드실패 sample
										org.fastcatsearch.ir.common.SettingException:</td>
								</tr>
							</tbody>
						</table>

						<div class="table-footer">
							<dl class="dl-horizontal col-md-12">
								<dt>Time</dt>
								<dd>2013-09-10 12:35:00</dd>
								<dt>Node</dt>
								<dd>node1</dd>
								<dt>Exception</dt>
								<dd>
									<div class="panel">(IRService.java:99) 컬렉션context 로드실패
										sample org.fastcatsearch.ir.common.SettingException:
										CollectionContext 로드중 에러발생 at
										org.fastcatsearch.util.CollectionContextUtil.load(CollectionContextUtil.java:139)
										~[classes/:na] at
										org.fastcatsearch.ir.IRService.loadCollectionContext(IRService.java:192)
										~[classes/:na] at
										org.fastcatsearch.ir.IRService.doStart(IRService.java:97)
										~[classes/:na] at
										org.fastcatsearch.service.AbstractService.start(AbstractService.java:61)
										[classes/:na] at
										org.fastcatsearch.server.CatServer.start(CatServer.java:183)
										[classes/:na] at
										org.fastcatsearch.server.CatServer.main(CatServer.java:61)
										[classes/:na] Caused by: java.lang.NullPointerException: null
										at
										org.fastcatsearch.util.CollectionContextUtil.load(CollectionContextUtil.java:103)
										~[classes/:na] ... 5 common frames omitted</div>
								</dd>
							</dl>
						</div>
					</div>
				</div>
				<!-- /Page Content -->

			</div>
		</div>
	</div>
</body>
</html>