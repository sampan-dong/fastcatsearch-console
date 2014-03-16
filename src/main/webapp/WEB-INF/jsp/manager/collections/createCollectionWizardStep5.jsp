<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<%@page import="org.jdom2.*"%>
<%@page import="org.json.*" %>
<%@page import="java.util.*"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	
%>
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<link href="${contextPath}/resources/assets/css/collection-wizard.css" rel="stylesheet" type="text/css" />
<script>
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
					<li><span class="badge">1</span> Set Collection Information</li>
					<li><span class="badge">2</span> Data Mapping</li>
					<li><span class="badge">3</span> Set Field Schema</li>
					<li><span class="badge">4</span> Confirmation</li>
					<li class="current"><span class="badge">5</span> Finish</li>
				</ul>
				<div class="wizard-content">
					<div class="wizard-card current">
						<form id="collection-config-form">
						<input type="hidden" name="collectionId" value="${collectionId}"/>
							<div class="row">
								<div class="col-md-12">
									<h3>Finished!</h3>
									<p>
										Collection is created and schema fields exist. But index fields are not created yet. To set up indexes, go to  
										<a href="${ROOT_PATH}/manager/collections/${collectionId}/workSchemaEdit.html" class="show-link">Continue to setting index field</a>.
									</p>
									<p>	
										To create another collection, go to <a href="createCollectionWizard.html" class="show-link">Create another collection</a>.
									</p>
								</div>
							</div>
						</form>
					</div>
					
				</div>
			</div>
			<!-- /Page Header -->
		</div>
	</div>
</div>	
</body>
</html>
