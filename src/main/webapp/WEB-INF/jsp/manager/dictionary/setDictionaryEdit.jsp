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
			loadDictionaryTab("set", '<%=dictionaryId %>', 1, keyword, true, '<%=targetId%>');
			return;
		}
	});
	$("#_set_dictionary_search").focus();
	
	
	//단어추가상자PUT버튼.
	$("#word_input_button_${dictionaryId}").on("click", function(e){
		alert(e.keyCode);
	});
	//단어추가상자 엔터키. 
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
	
	App.init();
	Plugins.init();
	FormComponents.init();
	
	$("#wordInsertModal").on("hide", function(){
		console.log("reload");
	});
});

function goDictionaryPage(uri, pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', true, '<%=targetId%>');
}
function goViewablePage(pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', false, '<%=targetId%>');	
}
function deleteSelectWord(){
	var idList = new Array();
	$('tr.checked').each(function() {
		var domId = $(this).find("td:last").attr("id");
		idList.push(domId.split("_")[2]);
	});
	if(idList.length == 0){
		alert("Please select words.");
		return;
	}
	if(! confirm("Delete "+idList.length+" word?")){
		return;
	}
	var deleteIdList = idList.join(",");
	loadDictionaryTab("set", '<%=dictionaryId %>', '${pageNo}', '${keyword}', true, '<%=targetId%>', deleteIdList);	
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
					<a href="javascript:void(0);"  class="btn btn-default btn-sm">
						<span class="icon icon-upload"></span> Upload
					</a>
					<a href="javascript:void(0);"  class="btn btn-default btn-sm">
						<span class="icon icon-download"></span> Download
					</a>
					</div>
					&nbsp;
					<div class="btn-group">
						<a href="#wordInsertModal" role="button" data-toggle="modal" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
						<a href="javascript:deleteSelectWord()" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
						<a href="javascript:goDictionaryPage('', '${pageNo}');" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
					</div>
					&nbsp;
					<a href="javascript:goViewablePage('${pageNo}');"  class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-eye-open"></span> View
					</a>
				</div>
			</div>
		</div>
		
		<%
		if(entryList.length() > 0){
		%>
		<div class="col-md-12" style="overflow:auto">
		
			<div class="col-md-3">

				<table class="table table-hover table-bordered table-checkable">
					<thead>
						<tr>
							<th class="checkbox-column">
								<input type="checkbox" class="uniform">
							</th>
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

				<table class="table table-hover table-bordered table-checkable">
					<thead>
						<tr>
							<th class="checkbox-column">
								<input type="checkbox" class="uniform">
							</th>
							<th>Word</th>
						</tr>
					</thead>
					<tbody>
			<%
				}
			%>
						<tr>
							<td class="checkbox-column">
								<input type="checkbox" class="uniform">
							</td>
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


<div class="modal" id="wordInsertModal" role="dialog">
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
						