<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="
org.jdom2.Element,
java.util.List
"%>
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
<%
Element element = null;
Element rootElement = (Element) request.getAttribute("setting");

String analyzerName = "";

String description = "";

String namespace = "";

String analyzerClass = "";

String analyzerVersion = "";

boolean usedb = false;

List<Element> dictionaryList = null;
List<Element> scheduleList = null;
List<Element> actionList = null;

if(rootElement!=null) {

	analyzerName = rootElement.getChildText("name");
	
	description = rootElement.getChildText("description");
	
	namespace = rootElement.getAttributeValue("namespace");
	
	analyzerClass = rootElement.getAttributeValue("class");
	
	analyzerVersion = rootElement.getChildText("version");
	
	usedb = "true".equals(rootElement.getChildText("use-db"));
	

	if((element = rootElement.getChild("dictionary-list"))!=null) {
		dictionaryList = element.getChildren();
	}
	
	if((element = rootElement.getChild("schedule-list"))!=null) {
		scheduleList = element.getChildren();
	}
	
	if((element = rootElement.getChild("action-list"))!=null) {
		actionList = element.getChildren();
	}
}

%>
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
							<dd>${analysisId} analysis</dd>
							<dt>Namespace</dt>
							<dd><%=namespace%></dd>
							<dt>Class</dt>
							<dd><%=analyzerClass%></dd>
							<dt>Name</dt>
							<dd><%=analyzerName%></dd>
							<dt>Version</dt>
							<dd><%=analyzerVersion%></dd>
							<dt>Decription</dt>
							<dd><%=description %></dd>
						</dl>
					</div>
				</div>
				<% 
				if (dictionaryList!=null) { 
				%>
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
								<%
								for(int rowInx=0;rowInx<dictionaryList.size();rowInx++) {
								%>
									<%
									Element dictionary = dictionaryList.get(rowInx);
									String dictionaryId = dictionary.getAttributeValue("id");
									String dictionaryName = dictionary.getAttributeValue("name");
									String dictionaryType = dictionary.getAttributeValue("type");
									if(dictionaryType==null) {
										dictionaryType="";
									}
									%>
									<tr>
										<td><%=rowInx+1 %></td>
										<td><strong><%=dictionaryId %></strong></td>
										<td><%=dictionaryName %></td>
										<td><i><%=dictionaryId.toLowerCase() %>.dict</i></td>
										<td><span class="label label-default"><%=dictionaryType %></span></td>
										<td><a href="javascript:alert('column을 보여주는 modal을 띄운다.')">View</a></td>
									</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<%
				}
				%>
							
						
				<%
				if(actionList!=null) {
				%>		
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
								<%
								for(int rowInx=0;rowInx<actionList.size();rowInx++) {
								%>
									<%
									Element action = actionList.get(rowInx);
									String actionClass = action.getAttributeValue("class");
									String actionMethod = action.getAttributeValue("methods");
									String actionUri = action.getAttributeValue("uri");
									%>
									<tr>
										<td><%=rowInx+1 %></td>
										<td><strong><%=actionUri %></strong></td>
										<td><%=actionMethod %></td>
										<td><i><%=actionClass %></i></td>
									</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<%
				}
				%>
							
				<%
				if(scheduleList!=null) {
				%>
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
								<%
								for(int rowInx=0;rowInx<scheduleList.size();rowInx++) {
								%>
									<%
									Element schedule = scheduleList.get(rowInx);
									String scheduleClass = schedule.getAttributeValue("class");
									String startTime = schedule.getAttributeValue("startTime");
									int period = -1;
									String unit = "Minute";
									try {
										period = Integer.parseInt(schedule.getAttributeValue("periodInMinute"));
									} catch (Exception e) {
									}
									if(period > 60) {
										period = period / 60;
										unit = "Hour";
									}
									%>
									
									<tr id="schedule_<%=rowInx+1%>">
										<td><%=rowInx+1 %></td>
										<td><strong><%=scheduleClass %></strong></td>
										<td><%=startTime %></td>
										<td>
										<% if(period != -1) { %>
											<%=period %> <%=unit %>
										<% } %>
										</td>
									</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
				<%
				}
				%>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>