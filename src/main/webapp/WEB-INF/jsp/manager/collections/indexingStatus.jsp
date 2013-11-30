<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="org.json.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>

<%
	JSONObject indexingStatus = (JSONObject) request.getAttribute("indexingStatus");
	JSONObject indexingResult = (JSONObject) request.getAttribute("indexingResult");

	JSONObject indexNodeStatus = indexingStatus.optJSONObject("indexNode");
	JSONArray dataNodeStatusArray = indexingStatus.optJSONArray("dataNode");
	String collectionId = (String) request.getAttribute("collectionId");
%>
<div class="col-md-12">

	<div class="widget ">
		<div class="widget-header">
			<h4>Index Data Status</h4>
		</div>
		<div class="widget-content">
			<dl class="dl-horizontal">
				<dt>Indexing Node : </dt>
				<dd><%=indexNodeStatus.getString("nodeName") %> (<%=indexNodeStatus.getString("nodeId") %>)</dd>
				<dt>Data Path : </dt>
				<dd><%=indexNodeStatus.getString("dataPath") %></dd>
				<dt>Total Document Size : </dt>
				<dd><%=indexNodeStatus.getInt("documentSize") %></dd>
				<dt>Total Disk Size : </dt>
				<dd><%=indexNodeStatus.getString("diskSize") %></dd>
				<dt>Create Time : </dt>
				<dd><%=indexNodeStatus.getString("createTime") %></dd>
				<dt>Segment Size : </dt>
				<dd><%=indexNodeStatus.getInt("segmentSize") %></dd>
				<dt>Revision UUID : </dt>
				<dd><%=indexNodeStatus.getString("revisionUUID") %></dd>
			</dl>
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>#</th>
						<th>Node(ID)</th>
						<th>Document Size</th>
						<th>Data Path</th>
						<th>Data Disk Size</th>
						<th>Segment Size</th>
						<th>Revision UUID</th>
						<th>Update Time</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=1 %></td>
						<td>* <%=indexNodeStatus.getString("nodeName") %> (<%=indexNodeStatus.getString("nodeId") %>)</td>
						<td><%=indexNodeStatus.optInt("documentSize", -1) %></td>
						<td><%=indexNodeStatus.optString("dataPath", "-") %></td>
						<td><%=indexNodeStatus.optString("diskSize", "-") %></td>
						<td><%=indexNodeStatus.optInt("segmentSize", -1) %></td>
						<%
						String revisionUUID = indexNodeStatus.optString("revisionUUID", "-");
						if(revisionUUID.length() > 10){
							revisionUUID = revisionUUID.substring(0, 10);
						}
						%>
						<td><%=revisionUUID %></td>
						<td><%=indexNodeStatus.optString("createTime", "-") %></td>
					</tr>
				<%
				for(int i=0;i<dataNodeStatusArray.length(); i++){
					JSONObject dataNodeStatus = dataNodeStatusArray.getJSONObject(i);
				%>
					<tr>
						<td><%=i+2 %></td>
						<td><%=dataNodeStatus.getString("nodeName") %> (<%=dataNodeStatus.getString("nodeId") %>)</td>
						<td><%=dataNodeStatus.optInt("documentSize", -1) %></td>
						<td><%=dataNodeStatus.optString("dataPath", "-") %></td>
						<td><%=dataNodeStatus.optString("diskSize", "-") %></td>
						<td><%=dataNodeStatus.optInt("segmentSize", -1) %></td>
						<%
						revisionUUID = dataNodeStatus.optString("revisionUUID", "-");
						if(revisionUUID.length() > 10){
							revisionUUID = revisionUUID.substring(0, 10);
						}
						%>
						<td><%=revisionUUID %></td>
						<td><%=dataNodeStatus.optString("createTime", "-") %></td>
					</tr>
				<%
				}
				%>
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
