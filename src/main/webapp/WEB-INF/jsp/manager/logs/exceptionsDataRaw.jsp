<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="
org.json.JSONObject,
org.json.JSONArray
"%>
<script>
function goExceptionDataRawPage(url, pageNo) {
	loadExceptionTab(pageNo, "#tab_message_list");
}

</script>

<%
int start = (Integer)request.getAttribute("start");
int end = (Integer)request.getAttribute("end");
int pageNo = (Integer)request.getAttribute("pageNo");
int pageSize = (Integer)request.getAttribute("pageSize");
int totalCount = 0;

JSONArray exceptionList = null;

try {
	JSONObject exceptions = (JSONObject)request.getAttribute("exceptions");
	exceptionList = exceptions.optJSONArray("exceptions");
	totalCount = exceptions.optInt("totalCount", 0);
} catch (Exception e) {
}

%>
<div class="col-md-12">
<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			<div class="col-md-7 form-inline">
				<%
				if(exceptionList.length() > 0){
				%>
					<span>Rows ${start} - ${end} of <%=totalCount%></span>
				<%
				}else{
				%>
					<span>Rows 0</span>
				<%
				}
				%>
			</div>
			<div class="col-md-12">
				<div class="btn-group pull-right">
					<jsp:include page="../../inc/pagenationTop.jsp" >
					 	<jsp:param name="pageNo" value="${pageNo }"/>
					 	<jsp:param name="totalSize" value="<%=totalCount %>" />
						<jsp:param name="pageSize" value="${pageSize }" />
						<jsp:param name="width" value="5" />
						<jsp:param name="callback" value="goExceptionDataRawPage" />
						<jsp:param name="requestURI" value="" />
					 </jsp:include>
				</div>
			</div>
		</div>
		<table id="log_table" class="table table-hover table-bordered table-condensed table-checkable">
			<thead>
				<tr>
					<th>#</th>
					<th>Time</th>
					<th>Node</th>
					<th>Message</th>
				</tr>
			</thead>
			<tbody>
			<%
			if(exceptionList!=null && exceptionList.length() > 0) {
			%>
				<%
				for(int inx=0;inx < exceptionList.length(); inx++) {
				%>
					<%
					JSONObject record = exceptionList.optJSONObject(inx);
					%>
					<tr onclick="loadMessage('<%=record.optInt("id")%>')">
						<td><%=record.optInt("id") %></td>
						<td><%=record.optString("regtime") %></td>
						<td><%=record.optString("node") %></td>
						<td><%=record.optString("message") %></td>
					</tr>
				<%
				}
				%>
			<%
			} else {
			%>
				<tr>
					<td colspan="5">No data</td>
				</tr>
			<%
			}
			%>
			</tbody>
		</table>
		<div class="table-footer" id="tab_message_detail"></div>
	</div>
</div>
</div>