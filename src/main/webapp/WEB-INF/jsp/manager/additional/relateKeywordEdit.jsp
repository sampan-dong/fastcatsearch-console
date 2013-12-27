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

var wordInputObj;
var valueInputObj;
var wordInputResultObj;
var searchInputObj;
var searchColumnObj;
var exactMatchObj;

$(document).ready(function(){
	
	wordInputObj = $("#word_input_${keywordType}");
	valueInputObj = $("#value_input_${keywordType}");
	wordInputResultObj = $("#word_input_result_${keywordType}");
	searchInputObj = $("#search_input_${keywordType}");
	searchColumnObj = $("#${keywordType}SearchColumn");
	exactMatchObj = $("#${keywordType}ExactMatch");
	
	searchInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			var keyword = toSafeString($(this).val());
			
			loadKeywordTab("${keywordType}","${category}", isEditable, 1);
			return;
		}
	});
	searchInputObj.focus();
	
	searchColumnObj.on("change", function(){
		var keyword = toSafeString(searchInputObj.val());
		if(keyword != ""){
			//loadKeywordTab()
		}
	});
	exactMatchObj.on("change", function(){
		var keyword = toSafeString(searchInputObj.val());
		if(keyword != ""){
			//loadKeywordTab()
		}
	});
	
	//단어추가상자PUT버튼.
	$("#word_input_button_${keywordType}").on("click", function(e){
		<%=keywordType%>ValueInsert();
	});
	//단어추가상자 엔터키. 
	wordInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			<%=keywordType%>ValueInsert();
		}
	});
	valueInputObj.keydown(function (e) {
		if(e.keyCode == 13){
			<%=keywordType%>ValueInsert();
		}
	});
	
	$("#<%=keywordType%>WordInsertModal").on("hidden.bs.modal", function(){
		<%=keywordType%>LoadList();
		searchInputObj.focus();
	});
	
	$("#<%=keywordType%>WordInsertModal").on("shown.bs.modal", function(){
		wordInputObj.focus();
	});
	
	if($("._table_<%=keywordType %>")){
		checkableTable("._table_<%=keywordType %>");
	}
	
	//사전 업로드.
	var fileInputObj = $("#<%=keywordType %>_file_upload");
	
	fileInputObj.on("change", function(){
		console.log("val=","["+$(this).val()+"]");
		if($(this).val() != ""){
			fileInputObj.parents("form:first").ajaxSubmit({
				dataType:  "json", 
				success: function(resp){
					console.log("upload response ", resp);
					if(resp.success){
						noty({text: "File upload success", type: "success", layout:"topRight", timeout: 3000});
						$("#<%=keywordType%>WordInsertModal").modal("hide");
					}else{
						noty({text: "File upload fail. "+resp.errorMessage, type: "error", layout:"topRight", timeout: 5000});
					}
				}
				, error: function(a){
					noty({text: "File upload error!", type: "error", layout:"topRight", timeout: 5000});
				}
				, complete: function(){
					//지워준다.
					$("#<%=keywordType %>_file_upload").val("");
				}
			});
		}
	});
});
function <%=keywordType%>Truncate(){
	if(confirm("Clean all data including invisible entries.")){
		truncateKeyword('${analysisId}', '${keywordType}', <%=keywordType%>LoadList);
	}
}
function <%=keywordType%>LoadList(){
	var keyword = toSafeString(searchInputObj.val());
	loadKeywordTab("map", '<%=keywordType %>', 1, keyword, searchColumnObj.val(), exactMatchObj.is(":checked"))
}
function <%=keywordType%>ValueInsert(){
	var keyword = toSafeString(wordInputObj.val());
	wordInputObj.val(keyword);
	var value = toSafeString(valueInputObj.val());
	valueInputObj.val(value);
	
	if(keyword == ""){
		wordInputResultObj.text("Keyword is required.");
		return;
	}
	if(value == ""){
		wordInputResultObj.text("Value is required.");
		return;
	}
	
	requestProxy("POST", {
			uri: '/management/keyword/put.json',
			category: '${category}',
			keywordType: '${keywordType}',
			KEYWORD: keyword,
			VALUE: value
		},
		"json",
		function(response) {
			
			if(response.success){
				wordInputObj.val("");
				valueInputObj.val("");
				if(keyword != ""){
					wordInputResultObj.text("\""+keyword+" > "+value+"\" Inserted.");
				}else{
					wordInputResultObj.text("\"" + value+"\" Inserted.");
				}
				wordInputResultObj.removeClass("text-danger-imp");
				wordInputResultObj.addClass("text-success-imp");
				wordInputObj.focus();
			}else{
				var message = "\""+keyword+" > "+value+"\" Insert failed.";
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

function <%=keywordType%>WordUpdate(id){
	console.log("wordupdate : "+id);
	
	var trObj = $("#_${keywordType}-"+id);
	//console.log("update", id, trObj);
	
	var data = { 
		uri: '/management/dictionary/update.json',
		pluginId: '${analysisId}',
		keywordType: '${keywordType}'
	};
	
	trObj.find("input[type=text],input[type=hidden]").each(function() {
		var name = $(this).attr("name");
		var value = toSafeString($(this).val());
		if(name != ""){
			data[name] = value;
		}
	});
	//console.log("data ",data);
	
	if(data.KEYWORD == ""){
		noty({text: "Keyword is required.", type: "warning", layout:"topRight", timeout: 2000});
		return;
	}
	
	if(data.VALUE == ""){
		noty({text: "Value is required.", type: "warning", layout:"topRight", timeout: 2000});
		return;
	}
	
	requestProxy("POST", 
		data,
		"json",
		function(response) {
			
			if(response.success){
				noty({text: "Update Success", type: "success", layout:"topRight", timeout: 1000});
			}else{
				noty({text: "Update Fail", type: "error", layout:"topRight", timeout: 2000});
			}
		},
		function(response){
			noty({text: "Update Error", type: "error", layout:"topRight", timeout: 2000});
		}
	);
}
function go<%=keywordType%>KeywordPage(uri, pageNo){
	loadKeywordTab("map", '<%=keywordType %>', pageNo, '${keyword}', searchColumnObj.val(), exactMatchObj.is(":checked"), true);
}
function go<%=keywordType%>ViewablePage(pageNo){
	loadKeywordTab("map", '<%=keywordType %>', pageNo, '${keyword}', searchColumnObj.val(), exactMatchObj.is(":checked"), false);	
}
function <%=keywordType%>deleteOneWord(deleteId){
	if(confirm("Are you sure to delete?")){
		loadKeywordTab("map", '<%=keywordType %>', '${pageNo}', '${keyword}', searchColumnObj.val(), exactMatchObj.is(":checked"), true, deleteId);
	}
}
function <%=keywordType%>deleteSelectWord(){
	var idList = new Array();
	$("._table_${keywordType}").find('tr.checked').each(function() {
		var id = $(this).find("td input[name=ID]").val();
		idList.push(id);
	});
	if(idList.length == 0){
		alert("Please select words.");
		return;
	}
	if(! confirm("Delete "+idList.length+" word?")){
		return;
	}
	var deleteIdList = idList.join(",");
	loadKeywordTab("map", '<%=keywordType %>', '${pageNo}', '${keyword}', searchColumnObj.val(), exactMatchObj.is(":checked"), true, deleteIdList);	
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
					<a href="javascript:<%=keywordType %>Truncate();"  class="btn btn-danger btn-sm">
						<span class="glyphicon glyphicon-ban-circle"></span> Clean
					</a>
					&nbsp;
					<div class="btn-group">
						<a href="#WordInsertModal" role="button" data-toggle="modal" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
						<a href="javascript:deleteSelectWord()" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
						<a href="javascript:go<%=keywordType %>KeywordPage('', '${pageNo}');" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
					</div>
					&nbsp;
					<a href="javascript:go<%=keywordType%>ViewablePage('${pageNo}');"  class="btn btn-default btn-sm">
						<span class="glyphicon glyphicon-eye-open"></span> View
					</a>
				</div>
			</div>
		</div>
		
		<%
		if(entryList.length() > 0){
		%>
		<div class="col-md-12" style="overflow:auto">
		
			<table class="table table-hover table-bordered table-checkable table-condensed">
				<thead>
					<tr>
						<th class="checkbox-column">
							<input type="checkbox"/>
						</th>
						<th>Keyword</th>
						<th>Value</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					
				<%
				for(int i=0; i < entryList.length(); i++){
					JSONObject obj = entryList.getJSONObject(i);
				%>
					<tr id="_<%=keywordType %>-<%=obj.getInt("ID") %>">
						<td class="checkbox-column">
							<input type="checkbox" class="edit"/>
							<input type="hidden" name="ID" value="<%=obj.getInt("ID") %>"/>
						</td>
						<td class="col-md-2">
							<input type="text" name="KEYWORD" value="<%=obj.getString("KEYWORD") %>" class="form-control"/>
						</td>
						<td><input type="text" name="VALUE" value="<%=obj.getString("VALUE") %>" class="form-control"/></td>
						<td class="col-md-2"><a href="javascript:<%=keywordType %>WordUpdate(<%=obj.getInt("ID") %>);" class="btn btn-sm"><i class="glyphicon glyphicon-saved"></i></a>
						<a href="javascript:<%=keywordType %>deleteOneWord(<%=obj.getInt("ID") %>);" class="btn btn-sm"><i class="glyphicon glyphicon-remove"></i></a></td>
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

<div class="modal" id="WordInsertModal" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title"> Word Insert</h4>
			</div>
			<div class="modal-body">
				<div class="form-inline">
					<div class="form-group">
						<input type="text" id="word_input_${keywordType}" class="form-control" placeholder="Keyword">
					</div>
					<div class="form-group" style="width:370px">
						<div class="input-group" >
							<input type="text" id="value_input_${keywordType}" class="form-control" placeholder="Value">
							<span class="input-group-btn">
								<button class="btn btn-default" type="button" id="word_input_button_${keywordType}">Put</button>
							</span>
						</div>
					</div>
				</div>
				<label id="word_input_result_${keywordType}" for="word_input" class="help-block" style="word-wrap: break-word;"></label>
			</div>
			<div class="modal-footer">
				<form action="synonym/upload.html" method="POST" enctype="multipart/form-data" style="display: inline;">
					<input type="hidden" name="keywordType" value="${keywordType}"/>
					<span class="fileContainer btn btn-primary"><span class="icon icon-upload"></span> File Upload ...<input type="file" name="filename" id="${keywordType}_file_upload"></span>
				</form>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		  	</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div>
