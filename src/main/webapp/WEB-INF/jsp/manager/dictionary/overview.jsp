<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%
	JSONArray dictionaryList = (JSONArray) request.getAttribute("list");

	String dictionaryId = (String) request.getAttribute("dictionaryId");
	
%>
<script>
$(document).ready(function() {
	$("input:checkbox").uniform();
	$.uniform.update();
});
</script>

<div class="col-md-12">
<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			<div class="input-group col-md-12">
				<a href="javascript:void(0);" class="btn btn-sm"><span
					class="glyphicon glyphicon-time"></span> Apply Dictionary</a>
			</div>
		</div>
		<table class="table table-hover table-bordered table-checkable">
			<thead>
				<tr>
					<th class="checkbox-column">
						<input type="checkbox" class="uniform">
					</th>
					<th>Name</th>
					<th>Entry Size</th>
					<th>Apply Time</th>
					<th>For Tokening</th>
				</tr>
			</thead>
			<tbody>
				<%
				for(int i = 0; i < dictionaryList.length(); i++){
					JSONObject dictionary = dictionaryList.getJSONObject(i);
				%>
				<tr>
					<td class="checkbox-column">
						<input type="checkbox" class="uniform">
					</td>
					<td><strong><%=dictionary.getString("name") %></strong></td>
					<td><%=dictionary.getInt("entrySize") %></td>
					<td><%=dictionary.getString("syncTime") %></td>
					<td>No</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</div>
</div>			