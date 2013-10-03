<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.fastcatsearch.console.web.http.ResponseHttpClient"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.json.*"%>

<%
	String collectionId = (String) request.getAttribute("collectionId");
	JSONArray collectionList = (JSONArray) request.getAttribute("collectionList");
	JSONArray analysisPluginList = (JSONArray) request.getAttribute("analysisPluginList");
	String lcat = request.getParameter("lcat");
	String mcat = request.getParameter("mcat");
	String scat = request.getParameter("scat");
%>
	

<div id="sidebar" class="sidebar-fixed">
	<div id="sidebar-content">
		<!--=== Navigation ===-->
		<ul id="nav">
			<%
				boolean lcatCurrent = "dictionary".equals(lcat);
			%>
			<li class="<%=lcatCurrent ? "current" :"" %>"><a href="javascript:void(0);"> <i class="icon-edit"></i>
					Dictionary <span class="label label-info pull-right"><%=analysisPluginList.length() %></span>
			</a>
				<ul class="sub-menu">
					<%
					for(int i=0;i<analysisPluginList.length(); i++){
						String id = analysisPluginList.getJSONObject(i).getString("id");
						boolean maybeCurrent = lcatCurrent && id.equals(mcat);
					%>
					<li class="<%=maybeCurrent ? "current" : "" %>"><a href="<c:url value="/manager/dictionary/"/><%=id %>/index.html"> <i
							class="icon-angle-right"></i> <%=id %>
					</a>
					<%
					}
					%>
					
				</ul></li>
			<%
				lcatCurrent = "collections".equals(lcat);
			%>
			<li class="<%=lcatCurrent ? "current" :"" %>">
				<a href="javascript:void(0);"> <i class="icon-desktop"></i> Collections 
					<span class="label label-info pull-right"><%=collectionList.length() %></span>
				</a>
				<ul class="sub-menu">
					<%
					for(int i=0;i<collectionList.length(); i++){
						String id = collectionList.getJSONObject(i).getString("id");
						boolean maybeCurrent = lcatCurrent && id.equals(mcat);
					%>
					<li class="<%=maybeCurrent ? "current" :"" %>"><a href="javascript:void(0);"> <i class="icon-table"></i>
						<%=id %>
					</a>
						<ul class="sub-menu">
							<li class="<%=(maybeCurrent && "schema".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/schema.html"> <i
									class="icon-angle-right"></i> Schema
							</a></li>
							<li class="<%=(maybeCurrent && "data".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/data.html"> <i
									class="icon-angle-right"></i> Data
							</a></li>
							<li class="<%=(maybeCurrent && "datasource".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/datasource.html"> <i
									class="icon-angle-right"></i> DataSource
							</a></li>
							<li class="<%=(maybeCurrent && "shard".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/shard.html"> <i
									class="icon-angle-right"></i> Shard
							</a></li>
							<li class="<%=(maybeCurrent && "indexing".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/indexing.html"> <i
									class="icon-angle-right"></i> Indexing
							</a></li>
							<li class="<%=(maybeCurrent && "config".equals(scat)) ? "current" : "" %>"><a href="<c:url value="/manager/collections/"/><%=id %>/config.html"> <i
									class="icon-angle-right"></i> Config
							</a></li>
						</ul></li>
					<%
					}
					%>
					
				</ul></li>
				
			<%
				lcatCurrent = "analysis".equals(lcat);
			%>
			<li class="<%=lcatCurrent ? "current" :"" %>"><a href="javascript:void(0);"> <i class="icon-edit"></i>
					Analysis <span class="label label-info pull-right"><%=analysisPluginList.length() %></span>
			</a>
				<ul class="sub-menu">
					<li class="<%=(lcatCurrent && "plugin".equals(mcat)) ? "current" : "" %>"><a href="<c:url value="/manager/analysis/plugin.html"/>"> <i
							class="icon-cogs"></i> Plugin
					</a></li>
					<%
					for(int i=0;i<analysisPluginList.length(); i++){
						String id = analysisPluginList.getJSONObject(i).getString("id");
					%>
					<li class="<%=(lcatCurrent && id.equals(mcat)) ? "current" : "" %>"><a href="<c:url value="/manager/analysis/"/><%=id %>/index.html"> <i
							class="icon-angle-right"></i> <%=id %>
					</a></li>
					<%
					}
					%>
				</ul></li>
			
			<li class="<%="servers".equals(lcat) ? "current" :"" %>"><a href="<c:url value="/manager/servers/index.html"/>"> <i class="icon-globe"></i>
					Servers
			</a>
			</li>
			
			<%
				lcatCurrent = "logs".equals(lcat);
			%>
			<li class="<%=lcatCurrent ? "current" : "" %>"><a href="javascript:void(0);"> <i class="icon-list-ol"></i>
							Logs
			</a>
				<ul class="sub-menu">
					<li class="<%=(lcatCurrent && "notifications".equals(mcat)) ? "current" : "" %>"><a href="<c:url value="/manager/logs/notifications.html"/>">
							<i class="icon-angle-right"></i> Notifications <span class="arrow"></span>
					</a></li>
					<li class="<%=(lcatCurrent && "exceptions".equals(mcat)) ? "current" : "" %>"><a href="<c:url value="/manager/logs/exceptions.html"/>">
							<i class="icon-angle-right"></i> Exceptions <span class="arrow"></span>
					</a></li>
					<li class="<%=(lcatCurrent && "tasks".equals(mcat)) ? "current" : "" %>"><a href="<c:url value="/manager/logs/tasks.html"/>">
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
