<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
JSONObject indexDataResult = (JSONObject) request.getAttribute("indexDataResult");
%>
<script>

function goIndexDataAnalyzedPage(url, pageNo){
	loadDataAnalyzedTab("${collectionId}", pageNo, "#tab_analyzed_data");
}

</script>
<div class="col-md-12">
	
	<div class="widget box">

		<div class="widget-content no-padding">
			<div class="dataTables_header clearfix">
				<div class="col-md-7 form-inline">
					<div class="form-group">
						<input type="text" class="form-control fcol2-1" name="se" placeholder="ID">
					</div>
					<div class="form-group">
					&nbsp;
					<%
					JSONArray indexDataList = indexDataResult.getJSONArray("indexData");
					JSONArray fieldList = indexDataResult.getJSONArray("fieldList");
					
					if(indexDataList.length() > 0){
					%>
						<span>Rows ${start} - ${end} of <%=indexDataResult.getInt("documentSize") %></span>
					<%
					}else{
					%>
						<span>Rows 0</span>
					<%
					}
					%>
					</div>
				</div>
				
				<div class="col-md-5">
					<div class="pull-right">
						<jsp:include page="../../inc/pagenationTop.jsp" >
						 	<jsp:param name="pageNo" value="${pageNo }"/>
						 	<jsp:param name="totalSize" value="<%=indexDataResult.getInt("documentSize") %>" />
							<jsp:param name="pageSize" value="${pageSize }" />
							<jsp:param name="width" value="5" />
							<jsp:param name="callback" value="goIndexDataAnalyzedPage" />
							<jsp:param name="requestURI" value="" />
						 </jsp:include>
					 </div>
				</div>
			</div>
			<div style="">

				<%
				if(indexDataList.length() > 0){
				%>
				<table class="table table-bordered" >
					<thead>
						<tr class="active">
							<th>Index ID</th>
							<th class="col-md-5">Data</th>
							<th class="col-md-6">Analyzed</th>
						</tr>
					</thead>
					<tbody>
					
					<%
					for( int i = 0 ; i < indexDataList.length() ; i++ ){
						JSONObject indexData = indexDataList.getJSONObject(i);
						
						JSONObject primaryKeys = indexData.getJSONObject("primaryKeys");
						Iterator iterator = primaryKeys.keys();
						while(iterator.hasNext()){
						%>
						<tr class="active">
							<%
							String id = (String) iterator.next();
							String value = primaryKeys.getString(id);
							%>
							<td>* <%=id %></td>
							<td><%=value %></td>
							<td> - </td>
						</tr>
						<%
						}
						%>
							<%
							JSONObject row = indexData.getJSONObject("row");
							
							for( int j = 0 ; j < fieldList.length() ; j++ ){
								String fieldName = fieldList.getString(j);
								String value = row.getString(fieldName).replaceAll("<", "&lt;").replaceAll(">", "&gt;");
								String analyzedKeyName = fieldName + "-ANALYZED";
								String analyzedValue = row.getString(analyzedKeyName);
							%>
							<tr>
								<td class=""><%=fieldName %></td>
								<td class=""><%=value %></td>
								<td class=""><%=analyzedValue %></td>
							</tr>
							<%
							}
							%>
					<%
					}
					%>
						
					</tbody>
				</table>
				<%
				}
				%>
			</div>
		</div>
	</div>
</div>

