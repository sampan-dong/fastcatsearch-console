<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
//JSONObject indexDataStatusResult = (JSONObject) request.getAttribute("indexDataStatus");
JSONObject indexDataResult = (JSONObject) request.getAttribute("indexDataResult");
//JSONArray indexDataStatusList = indexDataStatusResult.getJSONArray("indexDataStatus");
%>
<script>

function goIndexDataRawPage(url, pageNo){
	loadDataRawTab("${collectionId}", "${pkValue}", pageNo, "#tab_raw_data");
}

function selectRawFieldValue(value){
	$("#selectedDataRawPanel").text(value);
}

$(document).ready(function(){
	$("#idRawSearchForm").on("submit", function(e){
		var pkValue = $(this).find("textarea[name=searchID]").val();
		pkValue = pkValue.replace(/\n+/g, " ");
		loadDataRawTab("${collectionId}", pkValue, 1, "#tab_raw_data");
		e.preventDefault();
	});
	$("#idRawSearchForm").find("textarea[name=searchID]").focus();
});

</script>
<div class="col-md-12">
	<div class="form-group">
		<form method="post" id="idRawSearchForm">
			<div class="row col-md-12">
				<div style="float:left; width:600px">
					<textarea class="form-control" name="searchID" placeholder="ID">${pkValue }</textarea>
				</div>
				<div style="float:left;margin-left:10px">
					<button class="btn btn-sm">Search ID</button>
				</div>
			</div>
		</form>
	</div>
	<div class="widget box">

		<div class="widget-content no-padding">
			<div class="dataTables_header clearfix">
				<div class="col-md-7 form-inline">

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
							<jsp:param name="callback" value="goIndexDataRawPage" />
							<jsp:param name="requestURI" value="" />
						 </jsp:include>
					 </div>
				</div>
			</div>
			<div style="overflow: scroll; height: 400px;">

				<%
				if(indexDataList.length() > 0){
				%>
				<table class="table table-hover table-bordered" style="white-space:nowrap;table-layout:fixed; ">
					<thead>
						<tr>
							<%
							for( int i = 0 ; i < fieldList.length() ; i++ ){
							%>
							<th class="dataWidth"><%=fieldList.getString(i) %></th>
							<%
							}
							%>
						</tr>
					</thead>
					<tbody>
					<%
					for( int i = 0 ; i < indexDataList.length() ; i++ ){
						JSONObject indexData = indexDataList.getJSONObject(i);
						JSONObject row = indexData.getJSONObject("row");
						boolean isDeleted = row.getBoolean("isDeleted");
						String idColor = isDeleted ? "danger" : "";
					%>
						<tr class="<%=idColor %>">
							<%
							for( int j = 0 ; j < fieldList.length() ; j++ ){
								String fieldName = fieldList.getString(j);
								String value = row.getString(fieldName).replaceAll("<", "&lt;").replaceAll(">", "&gt;");
							%>
							<td class="dataWidth" style="overflow:hidden; cursor:pointer" onclick="javascript:selectRawFieldValue($(this).text())"><%=value %></td>
							<%
							}
							%>
						</tr>
					<%
					}
					%>
						
					</tbody>
				</table>
				<%
				}
				%>
			</div>

			<div class="table-footer">
				<label class="col-md-2 control-label">Selected Column Data:</label>
				<div class="col-md-10">
					<div id="selectedDataRawPanel" class="panel"></div>
				</div>
			</div>
		</div>
	</div>
</div>

