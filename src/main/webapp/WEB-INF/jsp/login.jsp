<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="inc/common.jsp" />
<%
String redirect = request.getParameter("redirect");
if(redirect == null){
	redirect = "";
} else if (redirect != null && redirect.length() > 0){
	redirect = redirect.replaceAll("<", "& lt;").replaceAll(">", "& gt;");
	redirect = redirect.replaceAll("\\(", "& #40;").replaceAll("\\)", "& #41;");
	redirect = redirect.replaceAll("'", "& #39;");
	redirect = redirect.replaceAll("\"", "& quot;");
	redirect = redirect.replaceAll("&", "& amp;");
	redirect = redirect.replaceAll("%", "% 29;");
	redirect = redirect.replaceAll(";", "");
	redirect = redirect.replaceAll("eval\\((.*)\\)", "");
	redirect = redirect.replaceAll("[\\\"\\\'][\\s]*javascript:(.*)[\\\"\\\']", "\"\"");
	redirect = redirect.replaceAll("script", "");
	redirect = redirect.replaceAll("iframe", "");
}

%>
<html>
<head>
<c:import url="inc/header.jsp" />
<link href="${pageContext.request.contextPath}/resources/assets/css/login.css" rel="stylesheet" type="text/css" />
<script>

$(document).ready(function(){
	$("#login-form").validate({
		onkeyup: function(element) {
			var element_id = $(element).attr('id');
			if (this.settings.rules[element_id] && this.settings.rules[element_id].onkeyup != false) {
				$.validator.defaults.onkeyup.apply(this, arguments);
			}
		},
		rules: {
			host: {
				hostAlive: true,
				onkeyup: false
            }
		}
	});
	
	$.validator.addMethod("hostAlive", function(value, element) {
        var ret = false;
    	$.ajax({
    		url : CONTEXT + "/checkAlive.html",
    		async: false,
    		dataType : "json",
    		data : {host: $(element).val() + ""},
    		type : "POST",
    		success : function(response) {
    			ret = response.success;
    		}
    	});
    	return ret; 
	}, "Host is not alive.");

    $("#login-form").on("submit", function(){
        setCookie("hostAddress", $("form#login-form").find("input[name='host']").val(), 7);
    });
    var hostAddress = getCookie("hostAddress");
    if(hostAddress != null) {
        $("form#login-form").find("input[name='host']").val(hostAddress);
    } else {
        $("form#login-form").find("input[name='host']").val("localhost:8090");
    }
});

</script>
</head>
<body class="login">
	<!-- Logo -->
	<div class="logo">
		<strong>Fastcat</strong>Search
	</div>
	<!-- /Logo -->

	<!-- Login Box -->
	<div class="box">
		<div class="content">
			<!-- Login Formular -->

			<table>
				<tr>
					<td class="left"></td>
					<td class="right">
						<form class="form-vertical login-form" id="login-form"
							action="<c:url value="/doLogin.html"/>" method="post">
							<input type="hidden" name="redirect" value="<%=redirect %>" />
							<!-- Input Fields -->
							<div class="form-group">
								<div class="input-icon">
									<i class="icon-globe"></i> <input type="text" name="host" id="host"
										class="form-control required" placeholder="Address:Port"
										autofocus="autofocus" autocomplete=off value="localhost:8090"/>
								</div>
							</div>
							<div class="form-group">
								<div class="input-icon">
									<i class="icon-user"></i> <input type="text" name="userId"
										class="form-control required" placeholder="Username" />
								</div>
							</div>
							<div class="form-group">
								<div class="input-icon">
									<i class="icon-lock"></i> <input type="password"
										name="password" class="form-control required" placeholder="Password" />
								</div>
							</div>
							<!-- /Input Fields -->

							<!-- Form Actions -->
							<div class="form-actions">
								<!-- <label class="checkbox pull-left"><input type="checkbox"
									class="uniform" name="remember"> Remember me</label> -->
								<button type="submit" class="submit btn btn-primary pull-right">
									Sign In <i class="icon-angle-right"></i>
								</button>
							</div>
						</form>
					</td>
				</tr>
			</table>

		</div>
	</div>
	<!-- /.content -->
	<div class="footer">
		<div class="copy">
			<p class="address">
				Copyright(c) Fastcat. All rights reserved.<br /> <i
					class="icon-envelope-alt"></i> support@fastcat.co<br /> <i
					class="glyphicon glyphicon-phone-alt"></i> +82-2-508-1151<br /> 2F
				Samseong-dong 122-30 Gangnam-gu Seoul, Korea<br />
			</p>
		</div>
	</div>
</body>
</html>