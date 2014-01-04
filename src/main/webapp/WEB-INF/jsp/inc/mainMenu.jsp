<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
$(document).ready(function(){
	/* $('#indexing_tab a[href!="#tab_indexing_run"]').click(function() {
		stopPollingIndexTaskState();
		console.log("stop polling ${collectionId}");
	});
	$('#indexing_tab a[href="#tab_indexing_run"]').click(function() {
		startPollingIndexTaskState('${collectionId}');
		console.log("start polling ${collectionId}");
	}); */
	
	$('#running_tasks_dropdown').on('show.bs.dropdown', function () {
		startPollingAllTaskStateForTaskBar();
	});
	$('#running_tasks_dropdown').on('hide.bs.dropdown', function () {
		stopPollingAllTaskStateForTaskBar();
	});
});
</script>
<!-- Header -->
<header class="header navbar navbar-fixed-top" role="banner">
	<!-- Top Navigation Bar -->
	<div class="container">

		<!-- Only visible on smartphones, menu toggle -->
		<!-- <ul class="nav navbar-nav">
			<li class="nav-toggle"><a href="javascript:void();" title=""><i
					class="icon-reorder"></i></a></li>
		</ul> -->

		<!-- Logo -->
		<a class="navbar-brand" href="<c:url value="/start.html" />"> <strong>Fastcat</strong>Search
		</a>
		<!-- /logo -->

		<!-- Sidebar Toggler -->
		<!-- <a href="#" class="toggle-sidebar bs-tooltip" data-placement="bottom"
				data-original-title="Toggle navigation"> <i class="icon-reorder"></i>
			</a> -->
		<!-- /Sidebar Toggler -->

		<!-- Top Left Menu -->
		<ul class="nav navbar-nav navbar-left">
				<li><a href="<c:url value="/main/start.html"/>"> Start </a></li>
				<li><a href="<c:url value="/main/dashboard.html"/>"> Dashboard </a></li>
				<%-- <li><a href="<c:url value="/main/search.html"/>"> Search </a></li> --%>
				<li><a href="<c:url value="/manager/index.html"/>"> Manager </a></li>
			</ul>
		<!-- /Top Left Menu -->


		<!-- Top Right Menu -->
		<ul class="nav navbar-nav navbar-right">
			<!-- Notifications -->
			<%-- <li class="dropdown hidden-xs"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"> <i class="icon-bell"></i> <span
					class="badge"></span>
			</a>
				<ul class="dropdown-menu extended notification">
					<li class="title">
						<p>You have 2 new notifications</p>
					</li>
					<li><a href="javascript:void(0);"> <span
							class="label label-danger"><i class="icon-warning-sign"></i></span>
							<span class="message">High CPU load on cluster #2.</span> <span
							class="time">5 mins</span>
					</a></li>
					<li><a href="javascript:void(0);"> <span
							class="label label-info"><i class="icon-bell"></i></span> <span
							class="message">New items are in queue.</span> <span class="time">25
								mins</span>
					</a></li>
					<li class="footer"><a href="<c:url value="/manager/logs/notifications.html"/>">View all
							notifications</a></li>
				</ul></li> --%>

			<!-- Tasks -->
			<li class="dropdown hidden-xs" id="running_tasks_dropdown"><a href="#"
				class="dropdown-toggle" data-toggle="dropdown"> <i
					class="icon-tasks"></i> <span class="badge"></span>
			</a>
				<ul class="dropdown-menu extended notification" id="running_tasks_top">
					<li class="title">
						<p>You have <span class="count"></span> running tasks</p>
					</li>
					<%-- <li class="footer"><a href="<c:url value="/manager/logs/tasks.html"/>">View all
							tasks</a></li> --%>
				</ul></li>

			<!-- Messages -->
			<!-- <li class="dropdown hidden-xs hidden-sm"><a href="#"
				class="dropdown-toggle" data-toggle="dropdown"> <i
					class="icon-envelope"></i> <span class="badge">1</span>
			</a>
				<ul class="dropdown-menu extended notification">
					<li class="title">
						<p>You have 3 new messages</p>
					</li>
					<li><a href="javascript:void(0);"> <span class="photo"><img
								src="assets/img/demo/avatar-1.jpg" alt="" /></span> <span
							class="subject"> <span class="from">Bob Carter</span> <span
								class="time">Just Now</span>
						</span> <span class="text"> Consetetur sadipscing elitr... </span>
					</a></li>
					<li class="footer"><a href="javascript:void(0);">View all
							messages</a></li>
				</ul></li> -->

			<!-- .row .row-bg Toggler -->
			<li><a href="<c:url value="/settings/index.html"/>" class="dropdown-toggle"> <i class="icon-cog"></i>
			</a></li>

			<!-- User Login Dropdown -->
			<li class="dropdown user"><a href="#" class="dropdown-toggle"
				data-toggle="dropdown"> <!--<img alt="" src="assets/img/avatar1_small.jpg" />-->
					<i class="icon-male"></i> <span class="username">${_userName}</span> <i
					class="icon-caret-down small"></i>
			</a>
				<ul class="dropdown-menu">
					<li><a href="<c:url value="/main/profile.html"/>"><i class="icon-user"></i>
							My Profile</a></li>
					<li><a href="<c:url value="/main/logout.html" />"><i class="icon-key"></i> Log Out</a></li>
				</ul>
			</li>
			<!-- /user login dropdown -->
		</ul>
		<!-- /Top Right Menu -->
	</div>
	<!-- /top navigation bar -->

</header>
<!-- /.header -->


