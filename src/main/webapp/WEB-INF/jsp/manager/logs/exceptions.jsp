<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="
org.json.JSONObject,
org.json.JSONArray
"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<script>
function goPage(pageNum) {
	var uri = window.location.pathname+"?pageNum="+pageNum;
	location.href=uri;
}
</script>
</head>
<%
int totalSize = 1;
int totalPage = 1;
int pageNum = 1;
int rowSize = 15;
int pageSize = 10;
int rowStarts = 1;
int rowFinish = 15;
int pageStarts = 1;
int pageFinish = 1;
JSONArray exceptionList = null;

try {
	JSONObject exceptionHistory = (JSONObject)request.getAttribute("exceptions");
	totalSize = exceptionHistory.optInt("totalSize",totalSize);
	pageNum = exceptionHistory.optInt("pageNum", pageNum);
	rowSize = exceptionHistory.optInt("rowSize", rowSize);
	pageSize = exceptionHistory.optInt("pageSize", pageSize);
	rowStarts = exceptionHistory.optInt("rowStarts", rowStarts);
	rowFinish = exceptionHistory.optInt("rowFinish", rowFinish);
	totalPage = exceptionHistory.optInt("totalPage",totalPage);
	pageStarts = exceptionHistory.optInt("pageStarts",pageStarts);
	pageFinish = exceptionHistory.optInt("pageFinish",pageFinish);
	exceptionList = exceptionHistory.optJSONArray("exceptionHistory");
} catch (Exception e) {
}

%>

<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/manager/sideMenu.jsp">
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
								<span>Rows <%=rowStarts %> - <%=rowFinish %> of <%=totalSize %></span>
								<div class="btn-group pull-right">
									<a href="javascript:goPage(<%=pageNum-1 %>);" class="btn btn-sm" rel="tooltip">&laquo;</a>
									<% for(int pageInx=pageStarts;pageInx <=pageFinish; pageInx++) { %>
									<a href="javascript:goPage(<%=pageInx %>);" class="btn btn-sm <%=pageInx==pageNum?"btn-primary":"" %>" rel="tooltip"><%=pageInx %></a>
									<% } %>
									<a href="javascript:goPage(<%=pageNum+1 %>);" class="btn btn-sm" rel="tooltip">&raquo;</a>
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
								<%
								if(exceptionList!=null && exceptionList.length() > 0) {
								%>
									<%
									for(int inx=0;inx < exceptionList.length(); inx++) {
									JSONObject record = exceptionList.optJSONObject(inx);
									%>
									<tr>
										<td><%=record.optInt("id") %></td>
										<td><%=record.optString("regtime") %></td>
										<td><%=record.optString("node") %></td>
										<td><%=record.optString("message") %></td>
									</tr>
									<%
									}
									%>
								<%
								} else {
								%>
									<tr>
										<td colspan="4">No data</td>
									</tr>
								<%
								}
								%>
							</tbody>
						</table>
<!--
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
-->
					</div>
				</div>
				<!-- /Page Content -->

			</div>
		</div>
	</div>
</body>
</html>