<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@page import="org.json.*"%>
<%
	String keywordType = (String) request.getAttribute("keywordType");
	String category = (String) request.getAttribute("category");
	JSONObject list = (JSONObject) request.getAttribute("list");
	int totalSize = list.getInt("totalSize");
	int filteredSize = list.getInt("filteredSize");
	JSONArray entryList = (JSONArray) list.getJSONArray("list");
	int start = (Integer) request.getAttribute("start");
%>
<script>

var searchInputObj;
var searchColumnObj;
var exactMatchObj;

$(document).ready(function(){
	
	searchInputObj = $("#search_input_${dictionaryId}");
	searchColumnObj = $("#${dictionaryId}SearchColumn");
	exactMatchObj = $("#${dictionaryId}ExactMatch");
	
	searchInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			var keyword = toSafeString($(this).val());
			return;
		}
	});
	searchInputObj.focus();
	
	searchColumnObj.on("change", function(){
		var keyword = toSafeString(searchInputObj.val());
		if(keyword != ""){
		}
	});
	exactMatchObj.on("change", function(){
		var keyword = toSafeString(searchInputObj.val());
		if(keyword != ""){
		}
	});
});

function go<%=keywordType%>KeywrdPage(pageNo){
	loadKeywordTab('<%=keywordType%>','<%=category%>', false, pageNo);
}

function go<%=keywordType%>EditablePage(pageNo){
	loadKeywordTab('<%=keywordType%>','<%=category%>', true, pageNo);
}

</script>

<div class="col-md-12">
<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			<div class="form-inline col-md-6">
				<div class="form-group">
				</div>
				<div class="form-group " style="width:240px">
			        <div class="input-group" >
			            <span class="input-group-addon"><i class="icon-search"></i></span>
			            <input type="text" class="form-control" placeholder="Search" id="search_input" value="${keyword}">
			        </div>
			    </div>
			    <div class="form-group">
			    	&nbsp;
			    	<div class="checkbox">
			    	</div>
			    </div>
			</div>
				
			<div class="col-md-6">
				<div class="pull-right">
					&nbsp;
					<div class="btn-group">
						<a href="javascript:go<%=keywordType %>KeywordPage('${pageNo}');" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
					</div>
					&nbsp;
					<a href="javascript:go<%=keywordType %>EditablePage('${pageNo}');"  class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-edit"></span> Edit
					</a>
				</div>
			</div>
		</div>
		
		<%
		if(entryList.length() > 0){
		%>
		<div class="col-md-12" style="overflow:auto">
		
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>Keyword</th>
						<th>Value</th>
					</tr>
				</thead>
				<tbody>
					
				<%
				for(int i=0; i < entryList.length(); i++){
					JSONObject obj = entryList.getJSONObject(i);
				%>
					<tr>
						<td class="col-md-2"><%=obj.getString("keyword") %></td>
						<td><%=obj.getString("value") %></td>
					</tr>
					
				<%
				}
				%>
				</tbody>
			</table>
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
			 	<jsp:param name="totalSize" value="<%=filteredSize %>" />
				<jsp:param name="pageSize" value="${pageSize }" />
				<jsp:param name="width" value="5" />
				<jsp:param name="callback" value="goPage" />
				<jsp:param name="requestURI" value="" />
			 </jsp:include>
			</div>
		</div>	
	</div>
</div>
</div>