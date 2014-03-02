<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:import url="inc/common.jsp" />
<html>
<head>
<c:import url="inc/header.jsp" />
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${contextPath}/resources/assets/css/search.css">	
</head>
<body>
<c:import url="inc/mainMenu.jsp" />
<div id="container" class="sidebar-closed">
	<div id="content">
		<div class="container">
			<!--=== Page Header ===-->
			<div class="page-header">
			</div>
			<!-- /Page Header -->
			
			<!--=== Page Content ===-->
			<div class="row bottom-space-sm">
				<div class="col-xs-10 col-sm-4 col-sm-offset-3" style="padding-right: 5px;">
					<input type="text" class="form-control" value="Research" style="border: 5px solid #416cb6;font-size: 18px !important; height:40px;"> 
					<ul class="relate-keyword">
						<li><a href="#">원피스</a></li>
						<li><a href="#">나루토</a></li>
						<li><a href="#">나는 귀족이다</a></li>
					</ul>
				</div>
				<div style="padding-left: 0px;">
					<button class="btn btn-primary" type="button" style=" height:40px;">Search</button>
					<span style="float:right; margin: 0px 15px;"><a href="search/config.html"><i class="icon-cog"></i> Config</a></span>
				</div>
			</div>
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
									<ol class="search-result">
										<li>
											<h3><a href="javascript:void(0);">Research - Wikipedia, the free encyclopedia</a></h3>
											<div class="r">
											"Research and experimental development (R&D) comprise creative work undertaken on a systematic basis in order to increase the stock of knowledge, ...
											</div>
											<div class="">2013.09.01 | scopus | Korea</div>
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
									<ol class="search-result">
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
									<ol class="search-result">
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

				<div class="col-md-2" style="padding-left: 0px;">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title">Popular Keyword</h3>
						</div>
						<div class="panel-body" style="padding: 10px 2px 0px 10px;">
							<ol class="popular-keyword">
								<li><span class="badge badge-sx">1</span> <a href="#">나루토</a><div><i class="icon-arrow-up" style="color:red;"></i> 999</div></li>
								<li><span class="badge badge-sx">2</span> <a href="#">원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
								<li><span class="badge badge-sx">3</span> <a href="#">가나다</a><div><i class="icon-minus"></i></div></li>
								<li><span class="badge badge-sx">4</span> <a href="#">아이폰</a><div><i class="icon-arrow-down" style="color:blue;"></i> 5</div></li>
								<li><span class="badge badge-sx">5</span> <a href="#">mouse</a><div><span class="" style="color:red;">New</span></div></li>
								<li><span class="badge badge-sx">6</span> <a href="#">원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
								<li><span class="badge badge-sx">7</span> <a href="#">원피스원피스원피스원피스원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
								<li><span class="badge badge-sx">8</span> <a href="#">원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
								<li><span class="badge badge-sx">9</span> <a href="#">원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
								<li><span class="badge badge-sx">10</span> <a href="#">원피스</a><div><i class="icon-arrow-up" style="color:red;"></i> 5</div></li>
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