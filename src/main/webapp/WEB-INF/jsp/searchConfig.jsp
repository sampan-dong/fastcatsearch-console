<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> <a href="javascript:void(0);">Search</a>
						</li>
						<li class="current">
							<a href="pages_calendar.html" title="">Settings</a>
						</li>
					</ul>
					<ul class="crumb-buttons">
						<li><a href="<c:url value="/search.html"/>" title=""><i class="icon-mail-reply"></i><span>Return to Search</span></a></li>
					</ul>
					
				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Search Page Config</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				<!--=== Page Content ===-->
				<div class="row">
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<h4>Search</h4>
							</div>
							<div class="widget-content">
							---
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<h4>Sort</h4>
							</div>
							<div class="widget-content">
							---
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<h4>Filter</h4>
							</div>
							<div class="widget-content">
							---
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="widget">
							<div class="widget-header">
								<h4>Group</h4>
							</div>
							<div class="widget-content">
							---
							</div>
						</div>
					</div>
				</div>
				<!-- /Page Content -->
			</div>
			<!-- /.container -->

		</div>
</div>
</body>
</html>