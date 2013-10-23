<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="org.json.*"%>
<%
	String dictionaryId = (String) request.getAttribute("dictionaryId");
	JSONObject list = (JSONObject) request.getAttribute("list");
	int totalSize = list.getInt("totalSize");
	int filteredSize = list.getInt("filteredSize");
	JSONArray entryList = (JSONArray) list.getJSONArray(dictionaryId);
	int start = (Integer) request.getAttribute("start");
	String targetId = (String) request.getAttribute("targetId");
%>
<script>
$(document).ready(function(){
	$("#_set_dictionary_search").keyup(function (e) {
		if(e.keyCode == 13){
			var keyword = $(this).val();
			console.log("search > ",keyword);
			loadDictionaryTab("set", '<%=dictionaryId %>', 1, keyword, false, '<%=targetId%>');
			return;
		}
	});
	$("#_set_dictionary_search").focus();
});

function goDictionaryPage(uri, pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', false, '<%=targetId%>');	
}
function goEditablePage(pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', true, '<%=targetId%>');	
}
</script>


<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			
			<div class="input-group col-md-6">
				<span class="input-group-addon "><i class="icon-search"></i></span> <input type="text"
					class="form-control" placeholder="Search" id="_set_dictionary_search" value="${keyword}">
			</div>
			
			<div class="col-md-6">
				<div class="pull-right">
					<div class="btn-group">
						<a href="javascript:goDictionaryPage('', '${pageNo}');" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
					</div>
					&nbsp;
					<a href="javascript:goEditablePage('${pageNo}');"  class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-edit"></span> Edit
					</a>
				</div>
			</div>
		</div>
		
		<%
		if(entryList.length() > 0){
		%>
		<div class="col-md-12" style="overflow:auto">
		
			<div class="col-md-3">

				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th>Word</th>
						</tr>
					</thead>
					<tbody>
					
		<%
		}
		%>
			<%
			int eachColumnSize = 10;
			for(int i=0; i < entryList.length(); i++){
				JSONObject obj = entryList.getJSONObject(i);
			%>
			
			<%
				if(i > 0 && i % eachColumnSize == 0){
			%>
					</tbody>
				</table>
			</div>
			<%
				}
			%>
			
			<%
				if(i > 0 && i % eachColumnSize == 0){
			%>
			<div class="col-md-3">

				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th>Word</th>
						</tr>
					</thead>
					<tbody>
			<%
				}
			%>
						<tr>
							<td id="_<%=dictionaryId %>_<%=obj.getInt("ID") %>"><%=obj.getString("KEYWORD") %></td>
						</tr>
					
			<%
			}
			%>
			
		<%
		if(entryList.length() > 0){
		%>
					</tbody>
				</table>
			</div>
		</div>
		<%
		}
		%>
		<div class="table-footer">
			<div class="col-md-12">
			Rows 
			<% if(entryList.length() > 0) { %>
			<%=start %> - <%=start + entryList.length() - 1 %> of <%=filteredSize %> <% if(filteredSize != totalSize) {%> (filtered from <%=totalSize %> total entries)<% } %>
			<% } else { %>
			Empty
			<% } %>
			
			<jsp:include page="../../inc/pagenation.jsp" >
			 	<jsp:param name="pageNo" value="${pageNo }"/>
			 	<jsp:param name="totalSize" value="<%=totalSize %>" />
				<jsp:param name="pageSize" value="${pageSize }" />
				<jsp:param name="width" value="5" />
				<jsp:param name="callback" value="goDictionaryPage" />
				<jsp:param name="requestURI" value="" />
			 </jsp:include>
			</div>
		</div>	
	</div>
</div>
				