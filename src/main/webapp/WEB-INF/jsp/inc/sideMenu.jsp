<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.fastcatsearch.console.web.http.ResponseHttpClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.json.*"%>

<%
	JSONArray collectionList = (JSONArray) request.getAttribute("collectionList");
	JSONArray analysisPluginList = (JSONArray) request.getAttribute("analysisPluginList");
%>
	

<div id="sidebar" class="sidebar-fixed">
	<div id="sidebar-content">
		<!--=== Navigation ===-->
		<ul id="nav">
			<li class="<c:if test="${ param.lcat  == 'dictionary'}">current</c:if>"><a href="javascript:void(0);"> <i class="icon-edit"></i>
					Dictionary <span class="label label-info pull-right"><%=analysisPluginList.length() %></span>
			</a>
				<ul class="sub-menu">
					<%
					for(int i=0;i<analysisPluginList.length(); i++){
					%>
					<li class="<c:if test="${ param.mcat  == 'korean'}">current</c:if>"><a href="<c:url value="/manager/dictionary/korean/index.html"/>"> <i
							class="icon-angle-right"></i> <%=analysisPluginList.getJSONObject(i).getString("id") %>
					</a>
					<%
					}
					%>
					
				</ul></li>
				
			<li class="<c:if test="${ param.lcat  == 'collections'}">current</c:if>"><a href="javascript:void(0);"> <i
					class="icon-desktop"></i> Collections <span
					class="label label-info pull-right"><%=collectionList.length() %></span>
			</a>
				<ul class="sub-menu">
					<%
					for(int i=0;i<collectionList.length(); i++){
					%>
					<li class="<c:if test="${ param.mcat  == 'sample'}">current</c:if>"><a href="javascript:void(0);"> <i class="icon-table"></i>
						<%=collectionList.getJSONObject(i).getString("id") %>
					</a>
						<ul class="sub-menu">
							<li class="<c:if test="${ param.scat  == 'schema'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/schema.html"/>"> <i
									class="icon-angle-right"></i> Schema
							</a></li>
							<li class="<c:if test="${ param.scat  == 'data'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/data.html"/>"> <i
									class="icon-angle-right"></i> Data
							</a></li>
							<li class="<c:if test="${ param.scat  == 'datasource'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/datasource.html"/>"> <i
									class="icon-angle-right"></i> DataSource
							</a></li>
							<li class="<c:if test="${ param.scat  == 'shard'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/shard.html"/>"> <i
									class="icon-angle-right"></i> Shard
							</a></li>
							<li class="<c:if test="${ param.scat  == 'indexing'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/indexing.html"/>"> <i
									class="icon-angle-right"></i> Indexing
							</a></li>
							<li class="<c:if test="${ param.scat  == 'settings'}">current</c:if>"><a href="<c:url value="/manager/collections/sample/settings.html"/>"> <i
									class="icon-angle-right"></i> Settings
							</a></li>
						</ul></li>
					<%
					}
					%>
					
				</ul></li>
			<li class="<c:if test="${ param.lcat  == 'analysis'}">current</c:if>"><a href="javascript:void(0);"> <i class="icon-edit"></i>
					Analysis <span class="label label-info pull-right"><%=analysisPluginList.length() %></span>
			</a>
				<ul class="sub-menu">
					<li class="<c:if test="${ param.mcat  == 'plugin'}">current</c:if>"><a href="<c:url value="/manager/analysis/plugin.html"/>"> <i
							class="icon-cogs"></i> Plugin
					</a></li>
					<%
					for(int i=0;i<analysisPluginList.length(); i++){
					%>
					<li class="<c:if test="${ param.mcat  == 'korean'}">current</c:if>"><a href="<c:url value="/manager/analysis/korean/index.html"/>"> <i
							class="icon-angle-right"></i> <%=analysisPluginList.getJSONObject(i).getString("id") %>
					</a></li>
					<%
					}
					%>
				</ul></li>
			
			<li class="<c:if test="${ param.lcat  == 'servers'}">current</c:if>"><a href="<c:url value="/manager/servers/index.html"/>"> <i class="icon-globe"></i>
					Servers <!-- <span class="label label-info pull-right">2</span> -->
			</a>
			</li>
			
			<li class="<c:if test="${ param.lcat  == 'logs'}">current</c:if>"><a href="javascript:void(0);"> <i class="icon-list-ol"></i>
							Logs
			</a>
				<ul class="sub-menu">
					<li class="<c:if test="${ param.mcat  == 'notifications'}">current</c:if>"><a href="<c:url value="/manager/logs/notifications.html"/>">
							<i class="icon-angle-right"></i> Notifications <span class="arrow"></span>
					</a></li>
					<li class="<c:if test="${ param.mcat  == 'exceptions'}">current</c:if>"><a href="<c:url value="/manager/logs/exceptions.html"/>">
							<i class="icon-angle-right"></i> Exceptions <span class="arrow"></span>
					</a></li>
					<li class="<c:if test="${ param.mcat  == 'tasks'}">current</c:if>"><a href="<c:url value="/manager/logs/tasks.html"/>">
							<i class="icon-angle-right"></i> Tasks <span class="arrow"></span>
					</a></li>
				</ul></li>
		</ul>
	
		<!-- /Navigation -->
		<div class="sidebar-title">
			<span>Notifications</span>
		</div>
		<ul class="notifications demo-slide-in">
			<!-- .demo-slide-in is just for demonstration purposes. You can remove this. -->
			<li style="display: none;">
				<!-- style-attr is here only for fading in this notification after a specific time. Remove this. -->
				<div class="col-left">
					<span class="label label-danger"><i
						class="icon-warning-sign"></i></span>
				</div>
				<div class="col-right with-margin">
					<span class="message">Server <strong>#512</strong>
						crashed.
					</span> <span class="time">few seconds ago</span>
				</div>
			</li>
			
			</ul>
	
		</div>
	<div id="divider" class="resizeable_del"></div>
</div>
<!-- /Sidebar -->
