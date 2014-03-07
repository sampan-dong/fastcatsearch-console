<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<%@page import="org.jdom2.*"%>
<%@page import="org.json.*" %>
<%@page import="java.util.*"%>
<%
	String step = (String) request.getAttribute("step");
	JSONObject typeListObj = (JSONObject) request.getAttribute("typeList");
%>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.wizard { padding-left: 0px; margin-bottom: 0px; }

.wizard li {
	padding: 10px 12px 10px;
	margin-right: 5px;
	margin-bottom: 10px;
	background: #efefef;
	position: relative;
	display: inline-block;
	color: #999;
}
.wizard li:hover {
	text-decoration:none;
}
.wizard li:before {
	width: 0;
	height: 0;
	border-top: 20px inset transparent;
	border-bottom: 20px inset transparent;
	border-left: 20px solid #fff;
	position: absolute;
	content: "";
	top: 0;
	left: 0;
}
.wizard li:after {
	width: 0;
	height: 0;
	border-top: 18px inset transparent;
	border-bottom: 20px inset transparent;
	border-left: 20px solid #efefef;
	position: absolute;
	content: "";
	top: 0;
	right: -20px;
	z-index: 2;
}
.wizard li:first-child:before,
.wizard li:last-child:after {
	border: none;
}
.wizard a:first-child {
}
.wizard a:last-child {
}
.wizard .badge {
	margin: 0 5px 0 18px;
	position: relative;
	top: -1px;
}
.wizard li:first-child .badge {
	margin-left: 0;
}
.wizard .current {
	background: #007ACC;
	color: #fff;
}
.wizard .current:after {
	border-left-color: #007ACC;
}
.wizard .current .badge {
	color: #007ACC;
	background-color: #fff;
}

.wizard-content {
	padding: 12px;
	border: 1px solid #efefef;
	margin-bottom: 0px;
	
}
.wizard-bottom {
	/*padding: 10px 20px 10px;*/
	/*background-color: #f5f5f5;*/
	padding: 10px 20px 0px 0px;
	border-top: 1px solid #f5f5f5;
}

.wizard-card {
	display:none;
}
.wizard-card.current {
	display:block;
}
</style>
<script>
function nextStep(obj, next){
	var form = $(obj).parents('form:first');
	form.find("[name='next']").val(next);
	form.submit();
}
$(document).ready(function() {
	var wizardContent = $(".wizard-content");
	//step 구분하여 초기화 스크립트를 진행한다.
	if(wizardContent.hasClass("step_1")) {
	} else if(wizardContent.hasClass("step_2")) {
		//데이터소스를 얻어온다.
		var refreshJDBCFunc = function(object) {
			requestProxy("post", {
				uri:"/management/collections/jdbc-source.xml",dataType:"xml"
			}, "xml", function(data) {
				var jdbcList = data.children[0].children[0].children;
				var selectObj = $("div.form-group select.jdbc-select");
				var options = selectObj[0].options;
				for(var optInx=options.length;optInx >=0;optInx--) {
					options[optInx]=null;
				}
				options.add(document.createElement("option"));
				for(var jdbcInx=0;jdbcInx<jdbcList.length;jdbcInx++) {
					var element = $(jdbcList[jdbcInx]);
					var option = document.createElement("option");
					option.value = element.attr("id");
					option.text = element.attr("name");
					options.add(option);
				}
				if(object) {
					noty({text: "jdbc source refres success ("+jdbcList.length+")", type: "success", layout:"topRight", 
						timeout: 1000});
				}
			});
		};
		
		refreshJDBCFunc();
		
		//드라이버 생성 관련.
		requestProxy("post", {
			uri:"/management/collections/jdbc-support.xml",dataType:"xml"
		}, "xml", function(data) {
			var jdbcList = data.children[0].children[0].children;
			var selectObj = $("form#jdbc-create-form div.form-group select");
			var options = selectObj[0].options;
			options.add(document.createElement("option"));
			var paramMap = {};
			for(var jdbcInx=0;jdbcInx<jdbcList.length;jdbcInx++) {
				var element = $(jdbcList[jdbcInx]);
				var option = document.createElement("option");
				option.value = element.attr("id");
				option.text = element.attr("name");
				options.add(option);
				paramMap[element.attr("id")] = {driver:element.attr("driver"),url:element.attr("urlTemplate")};
			}
			
			selectObj.unbind("change").change(function() {
				var regexHost = /[$][{]host[}]/g;
				var regexPort = /[$][{]port([:]([0-9]+))*[}]/;
				var regexDBName = /[$][{]dbname[}]/g;
				var paramItem = paramMap[$(this).val()];
				var form=$("form#jdbc-create-form");
				var jdbcUrl = paramItem["url"];
				
				var jdbcRefreshFunc = function(url) {
					var jdbcUrl = url;
					form.find("input[name=driver]").val(paramItem["driver"]);
					var host = form.find("input[name=host]").val();
					var port = form.find("input[name=port]").val();
					var defaultPort = regexPort.exec(jdbcUrl)[2];
					if(port=="") {
						port = defaultPort;
						form.find("input[name=port]").val(port);
					}
					var dbName = form.find("input[name=dbName]").val();
					var parameter = form.find("input[name=parameter]").val();
					jdbcUrl = jdbcUrl.replace(regexHost,host);
					jdbcUrl = jdbcUrl.replace(regexPort,port);
					jdbcUrl = jdbcUrl.replace(regexDBName,dbName);
					if(parameter!="") {
						jdbcUrl+="?"+parameter;
					}
					form.find("input[name=url]").val(jdbcUrl);
				};
				form.find("input[name=host]").unbind("blur").blur(function() { jdbcRefreshFunc(jdbcUrl);});
				form.find("input[name=port]").unbind("blur").blur(function() { jdbcRefreshFunc(jdbcUrl);});
				form.find("input[name=dbName]").unbind("blur").blur(function() { jdbcRefreshFunc(jdbcUrl);});
				form.find("input[name=parameter]").unbind("blur").blur(function() { jdbcRefreshFunc(jdbcUrl);});
				jdbcRefreshFunc(jdbcUrl);
			});
		});
		//jdbc 새로생성 버튼
		$("form#jdbc-create-form div.form-group input[value=Create]").click(function() {
			var form = $("form#jdbc-create-form")[0];
			requestProxy("post", {
				uri:"/management/collections/update-jdbc-source.json",
				id:form.id.value,
				name:form.name.value,
				driver:form.driver.value,
				url:form.url.value,
				user:form.user.value,
				password:form.password.value,
				mode:"update"
			}, "json", function(data) {
				$("div#dataSourceCreate").modal("hide");
				noty({text: "jdbc create success ", type: "success", layout:"topRight", 
					timeout: 1000});
				refreshJDBCFunc();
			});
		});
		
		requestProxy("post", {
			uri:"/management/collections/single-source-reader-list.json",
		}, "json", function(data) {
			var selectObj = $("#sourceReaderSelect select");
			var options = selectObj[0].options;
			for(var inx=options.length;inx>=0;inx--) {
				options[inx]=null;
			}
			var list = data["sourceReaderList"];
			var paramMap = {};
			options.add(document.createElement("option"));
			for(var inx=0;inx<list.length;inx++) {
				var option = document.createElement("option");
				option.value = list[inx]["name"];
				option.text = list[inx]["name"];
				options.add(option);
				paramMap[list[inx]["name"]] = list[inx];
			}
			selectObj.unbind("change").change(function() {
				var confirmed = false;
				if( $.trim($("div#sourceTypeConfig").html()).length == 0 ) {
					confirmed = true;
				}
				if(!confirmed && confirm("This form will clear\ndo yon want?")) {
					confirmed = true;
				}
				if(confirmed) {
					var readerId = $(this)[0].value;
					var reader = paramMap[readerId]["reader"];
					var params = paramMap[readerId]["parameters"];
					var htmlStr = "";
					for(var inx=0;inx<params.length;inx++) {
						var param = params[inx];
						var template = $("div#template div."+param["type"]).clone();
						if(!template[0]) {
							template = $("div#template div._DEFAULT_").clone();
						}
						template.find("label.control-label").html(param["name"]);
						template.find("span.help-block").html(param["description"]);
						if(param["required"]) { 
							template.find("input, textarea").addClass("required"); 
							template.find("label.control-label").css("color", "#0066ff");
						}
						template.find("input, textarea, select").attr("name", "value"+inx);
						if(param["defaultValue"]) {
							template.find("input, textarea").attr("value", param["defaultValue"]);
						}
						template.find("input[type=hidden]").attr("name", "key"+inx).attr("value",param["id"]);
						htmlStr += template.html();
					}
					$("div#sourceTypeConfig").html(htmlStr);
					$(this).parents("form")[0].readerClass.value=reader;
					//JDBC 리프레시 버튼의 이벤트를 살려준다.
					$("div.form-group div.btn").each(function(){
			 			if($(this).find("i.icon-refresh")[0]) {
			 				$(this).unbind("click").click(function() {
						 		refreshJDBCFunc($(this));
			 				});
			 			}
					});
				}
			});
		});
	} else if(wizardContent.hasClass("step_3")) {
		
		
	} else if(wizardContent.hasClass("step_4")) {
	}
});

</script>
</head>
<body>
<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
	<div id="content">
		<div class="container">
			<!-- Breadcrumbs line -->
			<div class="crumbs">
				<ul id="breadcrumbs" class="breadcrumb">
					<li><i class="icon-home"></i> <a href="${ROOT_PATH}/manager/index.html">Manager</a></li>
					<li class="current"> Create Collection Wizard</li>
				</ul>
	
			</div>
			
			<h3>Create Collection Wizard</h3>
			<div class="widget">
				<ul class="wizard">
					<li class="<%=step.equals("1") ? "current" : "" %>"><span class="badge">1</span> Set Collection Information</li>
					<li class="<%=step.equals("2") ? "current" : "" %>"><span class="badge">2</span> Data Mapping</li>
					<li class="<%=step.equals("3") ? "current" : "" %>"><span class="badge">3</span> Set Field Schema</li>
					<li class="<%=step.equals("4") ? "current" : "" %>"><span class="badge">4</span> Confirmation</li>
					<li class="<%=step.equals("5") ? "current" : "" %>"><span class="badge">5</span> Finish</li>
				</ul>
				<div class="wizard-content step_${step}">
					<% if("1".equals(step)) {  %>
					<div class="wizard-card <%=step.equals("1") ? "current" : "" %>">
						<form id="collection-config-form" action="" method="get">
							<input type="hidden" name="step" value="1" />
							<input type="hidden" name="next" />
							<div class="row">
								<div class="col-md-12 form-horizontal">
									<div class="form-group">
										<label class="col-md-2 control-label">Collection ID:</label>
										<div class="col-md-10"><input type="text" name="collectionId" class="form-control required fcol2" value=""></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Collection Name:</label>
										<div class="col-md-10"><input type="text" name="collectionName" class="form-control required fcol2" value=""></div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Index Node:</label>
										<div class="col-md-10">
											<select class=" select_flat form-control fcol2">
												<option value="master">master</option>
												<option value="slave1">slave1</option>
												<option value="slave2">slave2</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Search Node:</label>
										<div class="col-md-10">
											<select class=" select_flat form-control fcol2">
												<option value="master">master</option>
												<option value="slave1">slave1</option>
												<option value="slave2">slave2</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-md-2 control-label">Data Node List :</label>
										<div class="col-md-10 form-inline">
											<input type="text" name="dataNodeList" class="form-control fcol2" value="">
											&nbsp;<select class="select_flat form-control fcol2">
												<option value="">:: Add Node ::</option>
												<option value="master">master</option>
												<option value="slave1">slave1</option>
												<option value="slave2">slave2</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							
							<div class="wizard-bottom" >
								<a href="${ROOT_PATH}/manager/index.html" class="btn">Cancel</a>
								<input type="button" value="Next" class="btn btn-primary fcol2" onClick="javascript:nextStep(this, 'next')">
							</div>
						</form>
					</div>
					
					<% } else if ("2".equals(step)) { %>
					
					<div class="wizard-card <%=step.equals("2") ? "current" : "" %>">
						<form id="collection-config-form">
							<input type="hidden" name="step" value="2" />
							<input type="hidden" name="next" />
							<input type="hidden" name="collectionId" value="${collectionId}"/>
							<input type="hidden" name="readerClass" value=""/>
							<div class="row">
								<div class="col-md-12 form-horizontal">
									<div id = "sourceReaderSelect" class="form-group">
										<label class="col-md-2 control-label">Source Type:</label>
										<div class="col-md-10">
											<select class="combobox select_flat form-control fcol2"></select>
										</div>
									</div>
									<div id="sourceTypeConfig"></div>
								</div>
							</div>
							<div class="wizard-bottom" >
								<input type="button" value="Back" class="btn" onClick="javascript:nextStep(this, 'back')">
								<input type="button" value="Next" class="btn btn-primary fcol2" onClick="javascript:nextStep(this, 'next')">
							</div>
						</form>
					</div>
					
					<% } else if ("3".equals(step)) { %>
					<%
					Document document = (Document) request.getAttribute("schemaDocument");
					Element root = document.getRootElement();
					Element el = root.getChild("field-list");
					%>
					<div class="wizard-card <%=step.equals("3") ? "current" : "" %>">
						<form id="collection-config-form">
							<input type="hidden" name="step" value="3" />
							<input type="hidden" name="next" />
							<input type="hidden" name="collectionId" value="${collectionId}"/>
							<div class="row">
								<div class="col-md-12">
									<h3>Fields</h3>
									<table class="table table-bordered table-condensed table-highlight-head">
										<thead>
											<tr>
												<th>#</th>
												<th>ID</th>
												<th>Name</th>
												<th>Type</th>
												<th>Length</th>
												<th>Remove Tags</th>
												<th>Multi Value</th>
												<th>Multi Value<br>Delimiter</th>
											</tr>
										</thead>
										<tbody>
										<% 
										JSONArray typeList = typeListObj.optJSONArray("typeList");
										if(el!=null) { 
											List<Element> fieldList = el.getChildren();
											%>
											<%
											for(int inx = 0; inx <fieldList.size(); inx++){
												String fieldKey = "_fields_"+inx;
												Element field = fieldList.get(inx);
												String id = field.getAttributeValue("id");
												String type = field.getAttributeValue("type");
												String name = field.getAttributeValue("name", "");
												String source = field.getAttributeValue("source", "");
												String size = field.getAttributeValue("size", "");
												String store = field.getAttributeValue("store", "true");
												String removeTag = field.getAttributeValue("removeTag", "");
												String multiValue = field.getAttributeValue("multiValue", "false");
												String multiValueDelimeter = field.getAttributeValue("multiValueDelimeter", "");
											%>
											<input type="hidden" name="KEY_NAME" value="<%=fieldKey%>"/>
											<tr>
												<td><%=inx+1 %></td>
												<td><input type="text" class="form-control" name="<%=fieldKey%>-id" value="<%=id %>" /></td>
												<td><input type="text" class="form-control" name="<%=fieldKey%>-name" value="<%=name %>" /></td>
												<td><select class="select_flat form-control" name="<%=fieldKey%>-type" >
													<%
													for(int typeInx=0;typeInx < typeList.length(); typeInx++) { 
														String typeStr = typeList.optString(typeInx);
													%>
													<option value="<%=typeStr %>" <%=typeStr.equals(type)?"selected":"" %>><%=typeStr %></option>
													<%
													}
													%>
												</select></td>
												<td><input type="text" class="form-control fcol1-1" name="<%=fieldKey%>-size" value="<%=size %>" /></td>
												<td><label class="checkbox"><input type="checkbox" value="true" <%="true".equals(removeTag)?"checked":"" %> name="<%=fieldKey%>-removeTag"></label></td>
												<td><label class="checkbox"><input type="checkbox" value="true" <%="true".equals(multiValue)?"checked":"" %> name="<%=fieldKey%>-multiValue"></label></td>
												<td><input type="text" class="form-control fcol1-1" value="<%=multiValueDelimeter %>" name="<%=fieldKey%>-multiValueDelimeter"/></td>
											</tr>
											<% 
											}
											%>
										<%
										} 
										%>
										</tbody>
									</table>
									
									<h3>Primary Keys</h3>
									<%
									el = root.getChild("primary-key");
									if(el!=null) { 
										List<Element> fieldList = el.getChildren();
										%>
										<%
										for(int inx = 0; inx <fieldList.size(); inx++) {
											String fieldKey = "_constraints_"+inx;
											Element field = fieldList.get(inx);
											String ref = field.getAttributeValue("ref");
										%>
										<input type="hidden" name="KEY_NAME" value="<%=fieldKey%>"/>
										<div class="form-group">
											<input type="text" class="form-control" name="<%=fieldKey%>-ref" value="<%=ref%>" >
										</div>
										<%
										}
										%>
									<%
									}
									%>
									<div class="form-group">
										<input type="button" value="Test Field Mapping.." class="btn" data-target="#testFieldMapping" data-toggle="modal" data-backdrop="static">
									</div>
								</div>
							</div>
							<div class="wizard-bottom" >
								<input type="button" value="Back" class="btn" onClick="javascript:nextStep(this, 'back')">
								<input type="button" value="Next" class="btn btn-primary fcol2" onClick="javascript:nextStep(this, 'next')">
							</div>
						</form>
					</div>
					
					<% } else if ("4".equals(step)) { %>
					
					<div class="wizard-card <%=step.equals("4") ? "current" : "" %>">
						<form id="collection-config-form">
							<input type="hidden" name="step" value="4" />
							<input type="hidden" name="next" />
							<div class="row">
								<div class="col-md-12">
									<h3>Collection Information</h3>
									<dl class="dl-horizontal">
										<dt>Collection ID</dt>
										<dd>vol1</dd>
										<dt>Collection Name</dt>
										<dd>vol1</dd>
										<dt>Index Node</dt>
										<dd>node1</dd>
										<dt>Search Node</dt>
										<dd>node1</dd>
										<dt>Data Node List</dt>
										<dd>node1, node2</dd>
									</dl>
									
									<h3>Data Mapping</h3>
									<dl class="dl-horizontal">
										<dt>Source Type</dt>
										<dd>DBMS</dd>
										<dt>JDBC Connection</dt>
										<dd>book</dd>
										<dt>FetchSize</dt>
										<dd>100</dd>
										<dt>BulkSize</dt>
										<dd>100</dd>
										<dt>DataSQL</dt>
										<dd>select id, title, body, datetime, author from book</dd>
									</dl>
									
									<h3>Fields</h3>
									<table class="table table-bordered table-condensed table-highlight-head">
										<thead>
											<tr>
												<th>#</th>
												<th>ID</th>
												<th>Name</th>
												<th>Type</th>
												<th>Length</th>
												<th>Remove Tags</th>
												<th>Multi Value</th>
												<th>Multi Value<br>Delimiter</th>
											</tr>
										</thead>									
										<tbody>
											<tr>
												<td>1</td>
												<td>id</td>
												<td>id</td>
												<td>INT</td>
												<td></td>
												<td>N</td>
												<td>N</td>
												<td></td>
											</tr>
											<tr>
												<td>2</td>
												<td>title</td>
												<td>title</td>
												<td>STRING</td>
												<td></td>
												<td>N</td>
												<td>N</td>
												<td></td>
											</tr>
											<tr>
												<td>3</td>
												<td>body</td>
												<td>body</td>
												<td>STRING</td>
												<td></td>
												<td>Y</td>
												<td>N</td>
												<td></td>
											</tr>
											<tr>
												<td>4</td>
												<td>date</td>
												<td>date</td>
												<td>DATETIME</td>
												<td></td>
												<td>Y</td>
												<td>N</td>
												<td></td>
											</tr>
											<tr>
												<td>5</td>
												<td>author</td>
												<td>author</td>
												<td>STRING</td>
												<td></td>
												<td>N</td>
												<td>N</td>
												<td></td>
											</tr>
										</tbody>
									</table>
									<br>
									
									<div class="wizard-bottom">
										<input type="button" value="Back" class="btn" onClick="javascript:nextStep(this, 'back')">
										<input type="button" value="Everything is OK, Create Collection" class="btn btn-primary" onClick="javascript:nextStep(this, 'next')">
									</div>
									
								</div>
							</div>
						</form>
					</div>
					
					<% } else if ("5".equals(step)) { %>
					
					<div class="wizard-card <%=step.equals("5") ? "current" : "" %>">
						<form id="collection-config-form">
							<div class="row">
								<div class="col-md-12">
									<h3>Finished!</h3>
									<p>
										Collection is created and schema fields exist. But index fields are not created yet. To set up indexes, go to  
										<a href="${ROOT_PATH}/manager/collections/aaaaa/workSchemaEdit.html" class="show-link">Continue to setting index field</a>.
									</p>
									<p>	
										To create another collection, go to <a href="createCollectionWizard.html" class="show-link">Create another collection</a>.
									</p>
								</div>
							</div>
						</form>
					</div>
					<% } %>
				</div>
			</div>
			<!-- /Page Header -->
		</div>
	</div>
	
	<div class="modal" id="testDataSourceModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-wide">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title"> Query Test</h4>
				</div>
				<div class="modal-body">
					<div class="col-md-12 bottom-space-sm">
						<form>
							<textarea rows="10" name="dataSQL" class="form-control required"></textarea>
							<p class="help-block">* Only top 100 result can be shown.</p>
							<p class="help-block">* '--' comment is supported.</p>
							<input type="button"  value="Run Select" class="btn btn-primary"/>
							<input type="button"  value="Run Update" class="btn btn-primary"/>
							<input type="button" value="Close" class="btn" data-dismiss="modal">
						</form>
					</div>
					<div class="col-md-12">
						<h3>Output</h3>
						<textarea rows="10" name="" class="form-control">
						</textarea>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal" id="dataSourceCreate" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title"> Create Collection</h4>
				</div>
				<div class="modal-body">
					<div class="col-md-12 form-horizontal">
						
						<form id="jdbc-create-form">
							<input type="hidden" name="mode" value="update"/>
							<div class="form-group">
								<label class="col-md-3 control-label">Id:</label>
								<div class="col-md-9"><input type="text" name="id" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Name:</label>
								<div class="col-md-9"><input type="text" name="name" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">DB Vendor:</label>
								<div class="col-md-9">
									<select class=" select_flat form-control fcol2">
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">JDBC Driver:</label>
								<div class="col-md-9"><input type="text" name="driver" class="form-control fcol3" value="com.mysql.driver.Driver"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Host:</label>
								<div class="col-md-9"><input type="text" name="host" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Port:</label>
								<div class="col-md-9"><input type="text" name="port" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">DB Name:</label>
								<div class="col-md-9"><input type="text" name="dbName" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">User:</label>
								<div class="col-md-9"><input type="text" name="user" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Password:</label>
								<div class="col-md-9"><input type="password" name="password" class="form-control fcol2"></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">JDBC Parameter:</label>
								<div class="col-md-9"><input type="text" name="parameter" class="form-control" value=""></div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">JDBC URL:</label>
								<div class="col-md-9">
									<input type="text" name="url" class="form-control" disabled value="">
									<p class="help-block">* This is auto-generated url.</p>
								</div>
							</div>
							<div class="form-group">
								<div class="col-md-9 col-md-offset-3">
									<input type="button" value="Create" class="btn btn-primary">
									<input type="button" value="Test Connection" class="btn">
									<input type="button" value="Cancel" class="btn"  data-dismiss="modal">
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	
	
	<div class="modal" id="testFieldMapping" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title"> Field Mapping Test</h4>
				</div>
				<div class="modal-body">
					<textarea rows="25" name="" class="form-control">
#: 1
id: a0001
title: 제목1입니다.
body : 이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.
date : 2014-03-01 12:00:00.123
author: 유관순

#: 2
id: a0002
title: 제목2입니다.
body : 이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.
date : 2014-03-01 12:00:00.123
author: 유관순

#: 3
id: a0003
title: 제목3입니다.
body : 이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.
date : 2014-03-01 12:00:00.123
author: 유관순

#: 4
id: a0004
title: 제목4입니다.
body : 이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.이것은 본문입니다.
date : 2014-03-01 12:00:00.123
author: 유관순
					</textarea>
					<br/>
					<input type="button" value="Close" class="btn"  data-dismiss="modal">
				</div>
			</div>
		</div>
	</div>	
	
	
	
	
	
	
	
	
</div>
<div id="template" class="hidden">
	<div class="JDBC">
		<div class="form-group">
			<label class="col-md-2 control-label">JDBC Connection:</label>
			<div class="col-md-10">
				<select class=" select_flat form-control fcol2 display-inline jdbc-select" name=""></select>
				<div class="btn"><i class="icon-refresh"></i></div>
				<div class="btn" data-target="#dataSourceCreate" data-toggle="modal" data-backdrop="static">Create New..</div>
				<div class="btn" data-target="#testDataSourceModal" data-toggle="modal" data-backdrop="static">Query Test..</div>
				<input type="hidden" name="" value=""/>
				<span class="help-block"></span>
			</div>
		</div>
	</div>
	<div class="TEXT">
		<div class="form-group">
			<label class="col-md-2 control-label"></label>
			<div class="col-md-10"><textarea rows="4" name="" class="form-control"></textarea>
			<input type="hidden" name="" value=""/>
			<span class="help-block"></span>
			</div>
		</div>
	</div>
	<div class="INT">
		<div class="form-group">
			<label class="col-md-2 control-label"></label>
			<div class="col-md-10"><input type="text" name="" class="form-control fcol2" value="">
			<input type="hidden" name="" value=""/>
			<span class="help-block"></span>
			</div>
		</div>
	</div>
	<div class="STRING">
		<div class="form-group">
			<label class="col-md-2 control-label"></label>
			<div class="col-md-10"><input type="text" name="" class="form-control fcol2" value="">
			<input type="hidden" name="" value=""/>
			<span class="help-block"></span>
			</div>
		</div>
	</div>
	<div class="STRING_LONG">
		<div class="form-group">
			<label class="col-md-2 control-label"></label>
			<div class="col-md-10"><input type="text" name="" class="form-control" value="">
			<input type="hidden" name="" value=""/>
			<span class="help-block"></span>
			</div>
		</div>
	</div>
	<div class="_DEFAULT_">
		<div class="form-group">
			<label class="col-md-2 control-label"></label>
			<div class="col-md-10"><input type="text" name="" class="form-control fcol2" value="">
			<input type="hidden" name="" value=""/>
			<span class="help-block"></span>
			</div>
		</div>
	</div>
</div>
</body>
</html>