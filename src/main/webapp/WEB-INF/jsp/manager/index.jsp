<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ROOT_PATH" value=".."/>

<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
</head>
<body>
<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />

<div id="container">
	<c:import url="${ROOT_PATH}/manager/sideMenu.jsp" />
	<div id="content">
	<div class="container">
		<!-- Breadcrumbs line -->
		<div class="crumbs">
			<ul id="breadcrumbs" class="breadcrumb">
				<li><i class="icon-home"></i> <a href="javascript:void(0);">Manager</a>
				</li>
			</ul>

		</div>
		<!-- /Breadcrumbs line -->
		
		<h3>Create Collection Wizard</h3>
		<p>Start <a href="collections/createCollectionWizard.html" class="show-link">collection wizard</a></p>
		
		<h3>Add New Server</h3>
		<p>Go to <a href="servers/settings.html" class="show-link">server setting</a></p>
		
		<h3>Check Logs</h3>
		<p>Go to <a href="logs/exceptions.html" class="show-link">system exceptions</a></p>
		<p>Go to <a href="logs/notifications.html" class="show-link">system notifications</a></p>
		
		
		
	</div>
</div>
</div>
</body>
</html>