<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="org.json.*"%>
<%
	String collectionId = (String) request.getAttribute("collectionId");
	JSONObject indexingManagementStatus = (JSONObject) request.getAttribute("indexingManagementStatus");
	JSONArray indexDataArray = indexingManagementStatus.optJSONArray("indexData");
	JSONArray restorableIndexDataArray = indexingManagementStatus.optJSONArray("restorableIndexData");
%>
<script>
$(document).ready(function(){
	$("#copyDataButton").on("click", function(){
		copyApplyIndexData('<%=collectionId%>');
	});
});

</script>
<div class="col-md-12">
								
	<div class="widget ">
		<div class="widget-header">
			<h4>Index Copy</h4>
		</div>
		<div class="widget-content">
			<table id="indexCopyTable" class="table table-bordered table-checkable">
				<thead>
				<tr>
					<th>Node</th>
					<th>Data Path</th>
					<th>UUID</th>
					<th>Documents</th>
					<th>Disk Size</th>
					<th>Create Time</th>
					<th class="checkbox-column">Source</th>
					<th class="checkbox-column">Destination</th>
				</tr>
				</thead>
				<tbody>
				<%
				for(int i=0;i<indexDataArray.length(); i++){
					JSONObject dataNodeStatus = indexDataArray.getJSONObject(i);
				%>
					<tr>
						<td><%=dataNodeStatus.getString("nodeName") %> (<%=dataNodeStatus.getString("nodeId") %>)</td>
						<td><%=dataNodeStatus.optString("dataPath", "-") %></td>
						<%
						String revisionUUID = dataNodeStatus.optString("revisionUUID", "-");
						if(revisionUUID.length() > 10){
							revisionUUID = revisionUUID.substring(0, 10);
						}
						%>
						<td><%=revisionUUID %></td>
						<td><%=dataNodeStatus.optInt("documentSize", -1) %></td>
						<td><%=dataNodeStatus.optString("diskSize", "-") %></td>
						<td><%=dataNodeStatus.optString("createTime", "-") %></td>
						<td><input type="radio" name="source" value="<%=dataNodeStatus.getString("nodeId") %>"></td>
						<td class="checkbox-column">
							<input type="checkbox">
							<input type="hidden" name="ID" value="<%=dataNodeStatus.getString("nodeId") %>"/>
						</td>
					</tr>
				<%
				}
				%>
				</tbody>
			</table>
			<a href="javascript:void(0);" id="copyDataButton" class="btn btn-primary">Copy Data</a>
		</div>
	</div>
	
	
	<div class="widget ">
		<div class="widget-header">
			<h4>Index Restore</h4>
		</div>
		<div class="widget-content">
			<table class="table table-bordered table-checkable">
				<thead>
				<tr>
					<th class="checkbox-column">
						<!-- <input type="checkbox"> -->
					</th>
					<th>Node</th>
					<th>Data Path</th>
					<th>UUID</th>
					<th>Documents</th>
					<th>Disk Size</th>
				</tr>
				</thead>
				<tbody>
				<%
				for(int i=0;i<indexDataArray.length(); i++){
					JSONObject dataNodeStatus = indexDataArray.getJSONObject(i);
					JSONObject restorableStatus = restorableIndexDataArray.getJSONObject(i);
				%>
					<tr>
						<td class="checkbox-column">
							<input type="checkbox">
						</td>
						<td><%=restorableStatus.getString("nodeName") %> (<%=dataNodeStatus.getString("nodeId") %>)</td>
						<td><%=restorableStatus.optString("dataPath", "-") %></td>
						<%
						String revisionUUID = restorableStatus.optString("revisionUUID", "-");
						if(revisionUUID.length() > 10){
							revisionUUID = revisionUUID.substring(0, 10);
						}
						%>
						<td><%=revisionUUID %></td>
						<td><%=restorableStatus.optInt("documentSize", -1) %></td>
						<td><%=restorableStatus.optString("diskSize", "-") %></td>
					</tr>
				<%
				}
				%>
				
				<!-- <tr>
					<td class="checkbox-column">
						<input type="checkbox">
						<input type="hidden" name="ID" value=""/>
					</td>
					<td>Node1</td>
					<td>data/index1</td>
					<td>adec2d3d03</td>
					<td>145000</td>
					<td>data/index0</td>
					<td>gdse2d3d03</td>
					<td>130000</td>
				</tr>
				<tr>
					<td class="checkbox-column">
						<input type="checkbox">
						<input type="hidden" name="dest" value=""/>
					</td>
					<td>Node2</td>
					<td>data/index1</td>
					<td>adec2d3d03</td>
					<td>145000</td>
					<td>data/index0</td>
					<td>gdse2d3d03</td>
					<td>130000</td>
				</tr> -->
				</tbody>
			</table>
			<a href="#" class="btn btn-primary">Restore</a>
		</div>
	</div>
</div>
