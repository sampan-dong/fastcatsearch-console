<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%
	JSONArray dictionaryList = (JSONArray) request.getAttribute("list");
%>
<script>
$(document).ready(function() {
	checkableTable("._table_dictionary_list");
});

</script>
<div class="col-md-12">
<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			<div class="input-group col-md-12">
				<a href="javascript:applySelectDictionary('${analysisId}');" class="btn btn-sm"><span
					class="glyphicon glyphicon-time"></span> Apply Dictionary</a>
			</div>
		</div>

		<table class="table table-hover table-bordered table-checkable _table_dictionary_list">
			<thead>
				<tr>
					<th class="checkbox-column">
						<input type="checkbox" class="uniform">
					</th>
					<th>Name</th>
					<th>Type</th>
					<th>Working Entry Size</th>
					<th>Modified Time</th>
					<th>Applied Entry Size</th>
					<th>Applied Time</th>
					<th>Token Type</th>
				</tr>
			</thead>
			<tbody>
				<%
				for(int i = 0; i < dictionaryList.length(); i++){
					JSONObject dictionary = dictionaryList.getJSONObject(i);
					String dictionaryId = dictionary.getString("id");
				%>
				<tr>
				<%
				if(dictionary.getString("type").equalsIgnoreCase("system")){
				%>
					<td>&nbsp;</td>
				<%
				} else {
				%>
					<td class="checkbox-column">
						<input type="checkbox" class="uniform">
						<input type="hidden" name="ID" value="<%=dictionaryId%>"/>
					</td>
				<%
				}
				%>
					<td><strong><%=dictionary.getString("name") %></strong></td>
					<td><%=dictionary.getString("type").toUpperCase() %></td>
					<td><%=dictionary.getInt("entrySize") %></td>
					<td><%=dictionary.getString("updateTime") %></td>
					<td><%=dictionary.getInt("applyEntrySize") %></td>
					<td><%=dictionary.getString("applyTime") %></td>
					<td><%=dictionary.getString("tokenType") %></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
</div>
</div>

                
