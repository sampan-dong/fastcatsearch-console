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
					</ul>
					<ul class="crumb-buttons">
						<li><a href="<c:url value="/search/config.html"/>" title=""><i class="icon-cog"></i><span>Config</span></a></li>
					</ul>
				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
				</div>
				<!-- /Page Header -->
				
				<!--=== Page Content ===-->
				<div class="row">
					<div class="col-md-12">
						<div class="input-group">
							<input type="text" class="form-control" value="Research" style="border: 3px solid #416cb6;"> 
							<span class="input-group-btn">
								<button class="btn btn-primary" type="button">Search <i class="icon-search"></i></button>
							</span>
							<span class="input-group-btn">
								<button class="btn accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">Options <i class="icon-angle-down"></i></button>
							</span>
						</div>
					</div>
				</div>
				<div id="collapseOne" class="panel-collapse collapse">
					<div class="panel-heading">
						<h3 class="panel-title">Advanced Search Options</h3>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-3">
							<strong>Search</strong> : 
							<input type="checkbox" class="uniform" checked="checked">ALL</input>
							<input type="checkbox" class="uniform" checked="checked">Title</input>
							<input type="checkbox" class="uniform">Body</input>
							</div>
							<div class="col-md-3">
							<strong>Sort</strong> : 
							<button type="button" class="btn btn-primary btn-xs">Accuracy</button>
							<button type="button" class="btn btn-default btn-xs">Recent</button>
							</div>
						</div>
					</div>
				</div>
				<br>	
				<div class="row">
					<div class="col-md-10">
						<div class="tabbable tabbable-custom tabs-left">
							<!-- Only required for left/right tabs -->
							<ul class="nav nav-tabs tabs-left">
								<li class="active"><a href="#tab_3_1" data-toggle="tab"><strong>Total Search</strong></a></li>
								<li ><a href="#tab_3_2" data-toggle="tab"><strong>News</strong></a></li>
								<li><a href="#tab_3_3" data-toggle="tab"><strong>Community</strong></a></li>
								<li><a href="#tab_3_3" data-toggle="tab"><strong>Board</strong></a></li>
								<li><a href="#tab_3_3" data-toggle="tab"><strong>Product</strong></a></li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane active" id="tab_3_1">
									<div class="">
									Search Result 1,480,000,000 (0.16s) 
									</div>
									
									<div class="row col-md-12">
									<h3 style="border-bottom:1px solid #eee;">News</h3>
										<div class="col-md-10">
										<ol>
											<li>
												<h3><a href="javascript:void(0);">Research - Wikipedia, the free encyclopedia</a></h3>
												<div class="r">
												"Research and experimental development (R&D) comprise creative work undertaken on a systematic basis in order to increase the stock of knowledge, ...
												</div>
												<div class="text-muted">2013.09.01 | scopus | Korea</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research</a></h3>
												<div class="r">
												Research – news, analysis, funding and data for the academic research and policy community.
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Microsoft Research - Turning ideas into reality</a></h3>
												<div class="r">
												Since Microsoft Research was established in 1991, it has become one of the largest, fastest-growing, most respected software research organizations in the ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research at Google</a></h3>
												<div class="r">
												Research happens across all of Google, and affects everything we do. Research at Google is unique. Because so much of what we do hasn't been done before, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research in Germany - Home</a></h3>
												<div class="r">
												Automotive & Traffic Technology · Aviation Technologies · Biotechnology · Energy Technologies · Environmental Technology · Health Research · Humanities ...
												</div>
											</li>
										</ol>
										</div>
									</div>
									
									<div class="row col-md-12">
									<h3 style="border-bottom:1px solid #eee;">Community</h3>
										<div class="col-md-10">
										<ol>
											<li>
												<h3><a href="javascript:void(0);">Research - Wikipedia, the free encyclopedia</a></h3>
												<div class="r">
												"Research and experimental development (R&D) comprise creative work undertaken on a systematic basis in order to increase the stock of knowledge, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research</a></h3>
												<div class="r">
												Research – news, analysis, funding and data for the academic research and policy community.
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Microsoft Research - Turning ideas into reality</a></h3>
												<div class="r">
												Since Microsoft Research was established in 1991, it has become one of the largest, fastest-growing, most respected software research organizations in the ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research at Google</a></h3>
												<div class="r">
												Research happens across all of Google, and affects everything we do. Research at Google is unique. Because so much of what we do hasn't been done before, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research in Germany - Home</a></h3>
												<div class="r">
												Automotive & Traffic Technology · Aviation Technologies · Biotechnology · Energy Technologies · Environmental Technology · Health Research · Humanities ...
												</div>
											</li>
										</ol>
										</div>
									</div>
									
								</div>
									
									
								<div class="tab-pane " id="tab_3_2">
									<div class="col-md-10 ires">
									Search Result 1 Page of 1,480,000,000 (0.16s) 
									</div>
									<div class="col-md-10 ires">
										<ol>
											<li>
												<h3><a href="javascript:void(0);">Research - Wikipedia, the free encyclopedia</a></h3>
												<div class="r">
												"Research and experimental development (R&D) comprise creative work undertaken on a systematic basis in order to increase the stock of knowledge, ...
												</div>
												<div class="text-muted">2013.09.01 | scopus | Korea</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research</a></h3>
												<div class="r">
												Research – news, analysis, funding and data for the academic research and policy community.
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Microsoft Research - Turning ideas into reality</a></h3>
												<div class="r">
												Since Microsoft Research was established in 1991, it has become one of the largest, fastest-growing, most respected software research organizations in the ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research at Google</a></h3>
												<div class="r">
												Research happens across all of Google, and affects everything we do. Research at Google is unique. Because so much of what we do hasn't been done before, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research in Germany - Home</a></h3>
												<div class="r">
												Automotive & Traffic Technology · Aviation Technologies · Biotechnology · Energy Technologies · Environmental Technology · Health Research · Humanities ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research - Wikipedia, the free encyclopedia</a></h3>
												<div class="r">
												"Research and experimental development (R&D) comprise creative work undertaken on a systematic basis in order to increase the stock of knowledge, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research</a></h3>
												<div class="r">
												Research – news, analysis, funding and data for the academic research and policy community.
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Microsoft Research - Turning ideas into reality</a></h3>
												<div class="r">
												Since Microsoft Research was established in 1991, it has become one of the largest, fastest-growing, most respected software research organizations in the ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research at Google</a></h3>
												<div class="r">
												Research happens across all of Google, and affects everything we do. Research at Google is unique. Because so much of what we do hasn't been done before, ...
												</div>
											</li>
											<li>
												<h3><a href="javascript:void(0);">Research in Germany - Home</a></h3>
												<div class="r">
												Automotive & Traffic Technology · Aviation Technologies · Biotechnology · Energy Technologies · Environmental Technology · Health Research · Humanities ...
												</div>
											</li>
										</ol>
									</div>
								</div>
								<div class="tab-pane" id="tab_3_3">
									<p>I'm in Section 3.</p>
								</div>
							</div>
						</div>

					</div>

					<div class="col-md-2">
						<div class="panel panel-default">
							<div class="panel-heading">
								<h3 class="panel-title">Popular Keyword</h3>
							</div>
							<div class="panel-body">
								<ol>
									<li>display</li>
									<li>nano</li>
									<li>research</li>
									<li>display</li>
									<li>nano</li>
									<li>research</li>
									<li>display</li>
									<li>nano</li>
									<li>research</li>
									<li>display</li>
								</ol>
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