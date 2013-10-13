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
%>
<script>
$(document).ready(function(){
	$("#_set_dictionary_search").keyup(function (e) {
		if(e.keyCode == 13){
			var keyword = $(this).val();
			loadToTab('set/list.html', {dictionaryId: 'user', length: 40, keyword: keyword }, '#tab_dictionary_overview');
			console.log(keyword);
			return;
		}
	});
	$("#_set_dictionary_search").focus();
	
	
	$("#word_input_button_${dictionaryId}").on("click", function(e){
		alert(e.keyCode);
	});
	$("#word_input_${dictionaryId}").keyup(function (e) {
		if(e.keyCode == 13){
			var keyword = $(this).val();
			if(keyword != ""){
				requestProxy("POST", { 
						uri: '/management/dictionary/put.json',
						pluginId: '${analysisId}',
						dictionaryId: '${dictionaryId}',
						keyword: keyword
					},
					"json",
					function(response) {
						$("#word_input_${dictionaryId}").val("");
						$("#word_input_result_${dictionaryId}").text(response);
					},
					function(response){
						alert("error= " +response);
					}
				);		
			}
			return;
		}
	});
});



</script>
<div class="tab-pane" id="tab_user_dictionary">
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
							<a href="#wordInsertModal" data-toggle="modal" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
							<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
							<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
						</div>
						&nbsp;
						<a href="javascript:void(0);"  class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-edit"></span> Edit
						</a>
						<a href="javascript:void(0);"  class="btn btn-default btn-sm">
							<span class="glyphicon glyphicon-saved"></span> Done
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
				int eachColumnSize = 3;
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
				<%=start + 1%> - <%=start + entryList.length() %> of <%=filteredSize %> <% if(filteredSize != totalSize) {%> (filtered from <%=totalSize %> total entries)<% } %>
				<% } else { %>
				Empty
				<% } %>
				<c:import url="../../inc/pagenation.jsp" >
				 	<c:param name="pageNo" value="3"/>
				 	<c:param name="totalSize" value="100" />
					<c:param name="pageSize" value="5" />
					<c:param name="width" value="5" />
					<c:param name="callback" value="gopage" />
					<c:param name="requestURI" value="/abc" />
				 </c:import>
				</div>
			</div>	
		</div>
	</div>

</div>

<div class="modal" id="wordInsertModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
        <h4 class="modal-title"><%=dictionaryId.toUpperCase() %> Word Insert</h4>
      </div>
      <div class="modal-body">
        <div class="input-group col-md-7">
			<input type="text" id="word_input_${dictionaryId}" class="form-control" placeholder="Word">
			<span class="input-group-btn">
              <button class="btn btn-default" type="button" id="word_input_button_${dictionaryId}">Put</button>
            </span>
		</div>
		<p>
		<div id="word_input_result_${dictionaryId}">result</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div>
						