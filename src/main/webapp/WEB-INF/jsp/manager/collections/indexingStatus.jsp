<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="org.json.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>

<%
	JSONObject indexingStatus = (JSONObject) request.getAttribute("indexingStatus");
	JSONObject indexingResult = (JSONObject) request.getAttribute("indexingResult");

	String collectionId = (String) request.getAttribute("collectionId");
%>
<div class="col-md-12">

	<div class="widget ">
		<div class="widget-header">
			<h4>Index Data Status</h4>
		</div>
		<div class="widget-content">
			<dl class="dl-horizontal">
				<dt>Data Path : </dt>
				<dd><%=indexingStatus.getString("dataPath") %></dd>
				<dt>Total Document Size : </dt>
				<dd><%=indexingStatus.getInt("documentSize") %></dd>
				<dt>Total Disk Size : </dt>
				<dd><%=indexingStatus.getString("diskSize") %></dd>
				<dt>Create Time : </dt>
				<dd><%=indexingStatus.getString("createTime") %></dd>
				<dt>Segment Size : </dt>
				<dd><%=indexingStatus.getInt("segmentSize") %></dd>
				<dt>Revision UUID : </dt>
				<dd><%=indexingStatus.getString("revisionUUID") %></dd>
			</dl>
			<table class="table table-hover table-bordered">
							<thead>
								<tr>
									<th>#</th>
									<th>Node</th>
									<th>Document Size</th>
									<th>Data Path</th>
									<th>Data Disk Size</th>
									<th>Segment Size</th>
									<th>Revision ID</th>
									<th>Revision UUID</th>
									<th>Update Time</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>My node1</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
								<tr>
									<td>2</td>
									<td>My node2</td>
									<td>47</td>
									<td>data/index0</td>
									<td>543Mb</td>
									<td>2</td>
									<td>1</td>
									<td>8a51848240</td>
									<td>2013.11.27 12:22:49</td>
								</tr>
							</tbody>
						</table>
		</div>
	</div>
	
	<div class="widget ">
		<div class="widget-header">
			<h4>Indexing Result</h4>
		</div>
		<div class="widget-content">
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>Type</th>
						<th>Result</th>
						<th>Scheduled</th>
						<th>Documents</th>
						<th>Inserts</th>
						<th>Updates</th>
						<th>Deletes</th>
						<th>Start</th>
						<th>End</th>
						<th>Duration</th>
					</tr>
				</thead>
				<tbody>
					<%
					if(indexingResult.has("FULL")){
						JSONObject fullIndexingResult = indexingResult.getJSONObject("FULL");
					%>
					<tr>
						<td><strong>FullIndexing</strong></td>
						<% if(fullIndexingResult != null) { %> 
						<td><%=fullIndexingResult.getString("status") %></td>
						<td><%=fullIndexingResult.getString("isScheduled") %></td>
						<td><%=fullIndexingResult.getInt("docSize") %></td>
						<td><%=fullIndexingResult.getInt("insertSize") %></td>
						<td><%=fullIndexingResult.getInt("updateSize") %></td>
						<td><%=fullIndexingResult.getInt("deleteSize") %></td>
						<td><%=fullIndexingResult.getString("startTime") %></td>
						<td><%=fullIndexingResult.getString("endTime") %></td>
						<td><%=fullIndexingResult.getString("duration") %></td>
						<% } else { %>
						<td colspan="9">No full indexing result.</td>
						<% } %>
					</tr>
					<%
					}
					
					if(indexingResult.has("ADD")){
						JSONObject addIndexingResult = indexingResult.getJSONObject("ADD");
					%>
					<tr>
						<td><strong>AddIndexing</strong></td>
						<% if(addIndexingResult != null) { %> 
						<td><%=addIndexingResult.getString("status") %></td>
						<td><%=addIndexingResult.getString("isScheduled") %></td>
						<td><%=addIndexingResult.getInt("docSize") %></td>
						<td><%=addIndexingResult.getInt("insertSize") %></td>
						<td><%=addIndexingResult.getInt("updateSize") %></td>
						<td><%=addIndexingResult.getInt("deleteSize") %></td>
						<td><%=addIndexingResult.getString("startTime") %></td>
						<td><%=addIndexingResult.getString("endTime") %></td>
						<td><%=addIndexingResult.getString("duration") %></td>
						<% } else { %>
						<td colspan="9">No add indexing result.</td>
						<% } %>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>
