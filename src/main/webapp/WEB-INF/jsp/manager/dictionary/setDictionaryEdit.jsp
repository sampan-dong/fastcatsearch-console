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
	JSONArray searchableColumnList = (JSONArray) list.getJSONArray("searchableColumnList");
%>
<script>

var wordInputObj;
var wordInputResultObj;
var searchInputObj;
var exactMatchObj;

$(document).ready(function(){
	
	wordInputObj = $("#word_input_${dictionaryId}");
	wordInputResultObj = $("#word_input_result_${dictionaryId}");
	searchInputObj = $("#search_input_${dictionaryId}");
	exactMatchObj = $("#${dictionaryId}ExactMatch");
	
	$("#<%=dictionaryId %>ExactMatch").uniform();
	
	searchInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			var keyword = toSafeString($(this).val());
			console.log("search > ",keyword);
			loadDictionaryTab("set", '<%=dictionaryId %>', 1, keyword, null, exactMatchObj.is(":checked"), true, '<%=targetId%>');
			return;
		}
	});
	searchInputObj.focus();
	
	exactMatchObj.on("change", function(){
		var keyword = toSafeString(searchInputObj.val());
		if(keyword != ""){
			loadDictionaryTab("set", '<%=dictionaryId %>', 1, keyword, null, exactMatchObj.is(":checked"), true, '<%=targetId%>');
		}
	});
	
	//단어추가상자PUT버튼.
	$("#word_input_button_${dictionaryId}").on("click", function(e){
		<%=dictionaryId%>SetInsert();
	});
	//단어추가상자 엔터키. 
	wordInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			<%=dictionaryId%>SetInsert();
		}
	});
	
	$("#<%=dictionaryId%>WordInsertModal").on("hidden.bs.modal", function(){
		<%=dictionaryId%>LoadList();
		searchInputObj.focus();
	});
	$("#<%=dictionaryId%>WordInsertModal").on("shown.bs.modal", function(){
		wordInputObj.focus();
	});
	
	if($("._table_<%=dictionaryId %>")){
		checkableTable("._table_<%=dictionaryId %>");
	}
});
function <%=dictionaryId%>Truncate(){
	if(confirm("Clean all data including invisible entries.")){
		truncateDictionary('${analysisId}', '${dictionaryId}', <%=dictionaryId%>LoadList);
	}
}
function <%=dictionaryId%>LoadList(){
	var keyword = toSafeString(searchInputObj.val());
	loadDictionaryTab("set", '<%=dictionaryId %>', 1, keyword, null, exactMatchObj.is(":checked"), true, '<%=targetId%>');
}
function <%=dictionaryId%>SetInsert(){
	var keyword = toSafeString(wordInputObj.val());
	wordInputObj.val(keyword);
	
	if(keyword == ""){
		wordInputResultObj.text("Keyword is required.");
		return;
	}
	
	requestProxy("POST", { 
			uri: '/management/dictionary/put.json',
			pluginId: '${analysisId}',
			dictionaryId: '${dictionaryId}',
			keyword: keyword
		},
		"json",
		function(response) {
			if(response.success){
				wordInputObj.val("");
				wordInputResultObj.text("\""+keyword+"\" Inserted.");
				wordInputResultObj.removeClass("text-danger-imp");
				wordInputResultObj.addClass("text-success-imp");
				wordInputObj.focus();
			}else{
				var message = "\""+keyword+"\" Insert failed.";
				if(response.errorMessage){
					message = message + " Reason = "+response.errorMessage;
				}
				wordInputResultObj.text(message);
				wordInputResultObj.addClass("text-danger-imp");
				wordInputResultObj.removeClass("text-success-imp");
			}
		},
		function(response){
			wordInputResultObj.text("\""+keyword+"\" Insert error.");
			wordInputResultObj.addClass("text-danger-imp");
			wordInputResultObj.removeClass("text-success-imp");
		}
	);		
}
function go<%=dictionaryId%>DictionaryPage(uri, pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', null, exactMatchObj.is(":checked"), true, '<%=targetId%>');
}
function go<%=dictionaryId%>ViewablePage(pageNo){
	loadDictionaryTab("set", '<%=dictionaryId %>', pageNo, '${keyword}', null, exactMatchObj.is(":checked"), false, '<%=targetId%>');	
}
function <%=dictionaryId%>deleteSelectWord(){
	var idList = new Array();
	$('tr.checked').each(function() {
		var domId = $(this).attr("id");
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
	loadDictionaryTab("set", '<%=dictionaryId %>', '${pageNo}', '${keyword}', null, exactMatchObj.is(":checked"), true, '<%=targetId%>', deleteIdList);	
}
</script>

<div class="col-md-12">
<div class="widget box">
	<div class="widget-content no-padding">
		<div class="dataTables_header clearfix">
			
			<div class="form-inline col-md-6">
				<div class="form-group " style="width:240px">
			        <div class="input-group" >
			            <span class="input-group-addon"><i class="icon-search"></i></span>
			            <input type="text" class="form-control" placeholder="Search" id="search_input_<%=dictionaryId%>" value="${keyword}">
			        </div>
			    </div>
			    <div class="form-group">
			    	&nbsp;
			    	<div class="checkbox">
			    	<label>
			    		<input type="checkbox" class="uniform" id="<%=dictionaryId %>ExactMatch" <c:if test="${exactMatch}">checked</c:if>> Exact Match
			    	</label>
			    	</div>
			    </div>
			</div>
			
			<div class="col-md-6">
				<div class="pull-right">
					<a href="javascript:<%=dictionaryId%>Truncate();"  class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-ban-circle"></span> Clean
					</a>
					&nbsp;
					<a href="javascript:void(0);"  class="btn btn-default btn-sm">
						<span class="icon icon-upload"></span> Upload
					</a>
					&nbsp;
					<div class="btn-group">
						<a href="#<%=dictionaryId%>WordInsertModal" role="button" data-toggle="modal" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
						<a href="javascript:<%=dictionaryId%>deleteSelectWord()" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
						<a href="javascript:go<%=dictionaryId%>DictionaryPage('', '${pageNo}');" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
					</div>
					&nbsp;
					<a href="javascript:go<%=dictionaryId%>ViewablePage('${pageNo}');"  class="btn btn-default btn-sm">
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

				<table class="_table_<%=dictionaryId %> table table-hover table-bordered table-checkable">
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

				<table class="_table_<%=dictionaryId %> table table-hover table-bordered table-checkable">
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
						<tr id="_<%=dictionaryId %>_<%=obj.getInt("ID") %>">
							<td class="checkbox-column">
								<input type="checkbox" class="uniform">
							</td>
							<td><%=obj.getString("KEYWORD") %></td>
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
			 	<jsp:param name="totalSize" value="<%=filteredSize %>" />
				<jsp:param name="pageSize" value="${pageSize }" />
				<jsp:param name="width" value="5" />
				<jsp:param name="callback" value="go${dictionaryId }DictionaryPage" />
				<jsp:param name="requestURI" value="" />
			 </jsp:include>
			</div>
		</div>	
	</div>
</div>
</div>

<div class="modal" id="<%=dictionaryId%>WordInsertModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"><%=dictionaryId.toUpperCase() %> Word Insert</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="input-group col-md-7">
						<input type="text" name="word_input" id="word_input_${dictionaryId}" class="form-control" placeholder="Word">
						<span class="input-group-btn">
			              <button class="btn btn-default" type="button" id="word_input_button_${dictionaryId}">Put</button>
			            </span>
					</div>
				</div>
				<label id="word_input_result_${dictionaryId}" for="word_input" class="help-block" style="word-wrap: break-word;"></label>
			</div>
			<div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
						