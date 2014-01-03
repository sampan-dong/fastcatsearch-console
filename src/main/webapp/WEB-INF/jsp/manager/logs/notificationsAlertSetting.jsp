<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.JSONObject,org.json.JSONArray"%>

<%
	JSONArray settingList = (JSONArray) request.getAttribute("settingList");
	JSONArray codeTypeList = (JSONArray) request.getAttribute("codeTypeList");
%>
<script>
$(document).ready(function(){
	var fnSubmit = function(event){
		event.preventDefault();
		if(! $(this).valid()){
			return false;
		} 

		$.ajax({
			url: PROXY_REQUEST_URI,
			type: "POST",
			dataType: "json",
			data: $(this).serializeArray(),
			success: function(response, statusText, xhr, $form){
				if(response["success"]==true) {
					$("div.modal").modal("hide");
					noty({text: "update success", type: "success", layout:"topRight", timeout: 3000});
					setTimeout(function() {
						loadToTab("notificationsAlertSetting.html", null, "#tab_message_alert_settings");
						
					},1000);
				} else {
					noty({text: "update fail", type: "error", layout:"topRight", timeout: 5000});
				}
				
			}, fail: function() {
				noty({text: "Can't submit data", type: "error", layout:"topRight", timeout: 5000});
			}
			
		});
		return false;
	};
	
	$("#newAlertSettingForm").submit(fnSubmit);
	$(".alertSettingForm").submit(fnSubmit);
	
	$("div.modal div.modal-footer button.btn-danger.pull-left ").click(function() {
		var form = $(this).parents("form")[0];
		form.mode.value="delete";
		$(form).submit();
	});
	
});
</script>
<div class="col-md-12">
	<div class="widget box">
		<div class="widget-content no-padding">
			<div class="dataTables_header clearfix">
				<div class="input-group col-md-12">
					<a data-toggle="modal" data-target="#newAlertSettingModal" data-backdrop="static" class="btn btn-sm"><span
								class="glyphicon glyphicon-plus-sign"></span> Add Alert</a>
				</div>
			</div>
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>#</th>
						<th>Notification Code</th>
						<th>Notification Type</th>
						<th>Alert To</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
				<%
				for(int i=0;i < settingList.length() ;i++){
					
					JSONObject setting = settingList.getJSONObject(i);
					String alertTo = setting.getString("alertTo");
				%>
					<tr>
						<td><%=i+1 %></td>
						<td><strong><%=setting.getString("code") %></strong></td>
						<td><%=setting.getString("codeType") %></td>
						<td>
							<%
							for (String to : alertTo.split(",")) {
								to = to.trim();
								if (to.length() > 0) {
									String[] kv = to.split(":");

									if (kv.length == 2) {
										String type = kv[0].trim();
										String userId = kv[1].trim();
										
										if(type.equalsIgnoreCase("EMAIL")){
											%><div><i class="icon-envelope"></i> <%=userId %></div><%
										}else if(type.equalsIgnoreCase("SMS")){
											%><div><i class="glyphicon glyphicon-phone"></i> <%=userId %></div><%
										}
									}
								}

							}
							%>
						</td>
						<td><a data-toggle="modal" data-target="#alertSettingModal_<%=i %>" href="javascript:void(0);">Edit</a></td>
					</tr>
				<%
				}
				%>
				</tbody>
			</table>
		</div>
	</div>
	
</div>
<%
for(int i=0;i < settingList.length() ;i++){
	JSONObject setting = settingList.optJSONObject(i);
%>
<div class="modal" id="alertSettingModal_<%=i %>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form class="alertSettingForm" id="alertSettingForm_<%=i %>"  method="POST">
				<input type="hidden" name="mode" value=""/>
				<input type="hidden" name="uri" value="/management/logs/update-notification-setting"/>
				<input type="hidden" name="id" value="<%=setting.optInt("id")%>"/>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title"> Alert Setting</h4>
				</div>
				<div class="modal-body">
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-content">
								<div class="row">
									<div class="col-md-12 form-horizontal">
										<div class="form-group">
											<label class="col-md-3 control-label">Notification Type:</label>
											<div class="col-md-9">
											<select name="code" class="select_flat form-control required" name="code">
												<option>:: SELECT ::</option>
												<%
												for(int k = 0; k < codeTypeList.length(); k++){
													JSONObject obj = codeTypeList.getJSONObject(k);
													%><option value="<%=obj.get("code") %>" <%=setting.optString("code").equals(obj.get("code"))?"selected":"" %>><%=obj.get("code") %>: <%=obj.get("codeType")%></option><%
												}
												%>
											</select>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-3 control-label">Alert To:</label>
											<div class="col-md-9">
												<textarea name="alertTo" class="form-control required" placeholder="SMS:swsong, EMAIL:swsong, EMAIL:johndoe"><%=setting.optString("alertTo") %></textarea>
											</div>
										</div>
										
										
									</div>
									
								</div>
							</div>
						</div> <!-- /.widget -->
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger pull-left">Remove</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<%
}
%>
<div class="modal" id="newAlertSettingModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<form id="newAlertSettingForm" method="POST">
				<input type="hidden" name="mode" value=""/>
				<input type="hidden" name="uri" value="/management/logs/update-notification-setting"/>
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title"> Alert Setting</h4>
				</div>
				<div class="modal-body">
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-content">
								<div class="row">
									<div class="col-md-12 form-horizontal">
										<div class="form-group">
											<label class="col-md-3 control-label">Notification Type:</label>
											<div class="col-md-9">
											<select name="code" class="select_flat form-control required" name="code">
												<option>:: SELECT ::</option>
												<%
												for(int k = 0; k < codeTypeList.length(); k++){
													JSONObject obj = codeTypeList.getJSONObject(k);
													%><option value="<%=obj.get("code") %>"><%=obj.get("code") %>: <%=obj.get("codeType")%></option><%
												}
												%>
											</select>
											</div>
										</div>
										
										<div class="form-group">
											<label class="col-md-3 control-label">Alert To:</label>
											<div class="col-md-9">
												<textarea name="alertTo" class="form-control required" placeholder="SMS:swsong, EMAIL:swsong, EMAIL:johndoe"></textarea>
											</div>
										</div>
										
										
									</div>
									
								</div>
							</div>
						</div> <!-- /.widget -->
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					<button type="submit" class="btn btn-primary">Save changes</button>
				</div>
			</form>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>