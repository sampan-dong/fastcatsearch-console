<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.task .percent {
float: right;
display: inline-block;
color: #adadad;
font-size: 11px;
}
</style>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp" />
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Dictionary</li>
						<li class="current"> Korean</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Korean</h3>
					</div>
				</div>
				<!-- /Page Header -->

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_dictionary_overview" data-toggle="tab">Overview</a></li>
						<li class=""><a href="#tab_user_dictionary" data-toggle="tab">User</a></li>
						<li class=""><a href="#tab_synonym_dictionary" data-toggle="tab">Synonym</a></li>
						<li class=""><a href="#tab_stop_dictionary" data-toggle="tab">Stop</a></li>
						<li class=""><a href="#tab_system_dictionary" data-toggle="tab">System</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_dictionary_overview">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										<div class="input-group col-md-12">
											<a href="javascript:void(0);" class="btn btn-sm"><span
												class="glyphicon glyphicon-time"></span> Sync Search Engine</a>
										</div>
									</div>
									<table class="table table-hover table-bordered">
										<thead>
											<tr>
												<th><input type="checkbox" /></th>
												<th>Name</th>
												<th>Size</th>
												<th>Status</th>
												<th>Sync Time</th>
												<th>Action</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><input type="checkbox" /></td>
												<td><strong>User Dictionary</strong></td>
												<td><strong>1500</strong></td>
												<td><i class="glyphicon glyphicon-ok-sign"> Sync-Done</i></td>
												<td>2013.09.01 12:00:00</td>
												<td>
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-upload"></span> Upload
												</a>
												&nbsp;
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-download"></span> Download
												</a>
												</td>
											</tr>
											<tr>
												<td><input type="checkbox" /></td>
												<td><strong>Synonym Dictionary</strong></td>
												<td><strong>500</strong></td>
												<td><i class="glyphicon glyphicon-pencil"> Modified</i></td>
												<td>2013.09.01 12:00:00</td>
												<td>
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-upload"></span> Upload
												</a>
												&nbsp;
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-download"></span> Download
												</a>
												</td>
											</tr>
											<tr>
												<td><input type="checkbox" /></td>
												<td><strong>Stop Dictionary</strong></td>
												<td><strong>30</strong></td>
												<td><i class="glyphicon glyphicon-pencil"> Modified</i></td>
												<td>2013.09.01 12:00:00</td>
												<td>
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-upload"></span> Upload
												</a>
												&nbsp;
												<a href="javascript:void(0);" class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-download"></span> Download
												</a>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						
						<!-- --user dict--- -->
						<div class="tab-pane" id="tab_user_dictionary">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										
										<div class="input-group col-md-6">
											<span class="input-group-addon "><i class="icon-search"></i></span> <input type="text"
												class="form-control" placeholder="Search">
										</div>
										
										<div class="col-md-6">
											<div class="pull-right">
												<div class="btn-group">
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
												</div>
												&nbsp;
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-edit"></span> Edit
												</a>
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-saved"></span> Done
												</a>
											</div>
										</div>
									</div>
									
									<div class="col-md-12" style="overflow:auto">
									<div class="col-md-3">

										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th>Word</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="">가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-3">

										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th class="">Word</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="">가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-3">

										<table class="table table-hover table-bordered">
											<thead>
												<tr>
													<th class="">Word</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td class="">가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
												<tr>
													<td >가나다</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="col-md-3">

										<table class="table table-hover table-bordered" >
											<thead>
												<tr>
													<th style="width:30px">&nbsp;</th>
													<th class="">Word</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td class="">가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
												<tr>
													<td><input type="radio" name="userWordSelect" value="1"></td>
													<td >가나다</td>
												</tr>
											</tbody>
										</table>
									</div>
									
									</div>
									<div class="table-footer">
										<div class="col-md-12">
										Rows 1 - 50 of 2809 (filtered from 8 total entries)
										<ul class="pagination">
											<li class="disabled"><a href="javascript:void(0);">&laquo;</a></li>
											<li class="active"><a href="javascript:void(0);">1</a></li>
											<li><a href="javascript:void(0);">2</a></li>
											<li><a href="javascript:void(0);">3</a></li>
											<li><a href="javascript:void(0);">4</a></li>
											<li><a href="javascript:void(0);">5</a></li>
											<li><a href="javascript:void(0);">&raquo;</a></li>
										</ul>
										</div>
									</div>	
								</div>
							</div>

						</div>
						<!-- //User Dict -->
						
						<!-- Synonym Dict -->
						<div class="tab-pane" id="tab_synonym_dictionary">
							<div class="widget box">
								<div class="widget-content no-padding">
									<div class="dataTables_header clearfix">
										
										
										<div class="input-group col-md-6">
											<span class="input-group-addon"><i class="icon-search"></i></span> <input type="text"
												class="form-control" placeholder="Search">
										</div>
										
										<div class="col-md-6">
											<div class="pull-right">
												<div class="btn-group">
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-plus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-minus"></i></a>
													<a href="javascript:void(0);" class="btn btn-sm" rel="tooltip"><i class="icon-refresh"></i></a>
												</div>
												&nbsp;
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-edit"></span> Edit
												</a>
												<a href="javascript:void(0);"  class="btn btn-default btn-sm">
													<span class="glyphicon glyphicon-saved"></span> Done
												</a>
											</div>
										</div>
									</div>
									

									<table class="table table-hover table-bordered">
										<thead>
											<tr>
												<th style="width:20%">Representative</th>
												<th>Word Entry</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><span class="my_r_tag">가나다</span></td>
												<td>
													<span class="mytag">가나다</span><span class="mytag">마바사</span><span class="mytag">아자차</span><span class="mytag">카타파</span><span class="mytag">하하하</span><span class="mytag">가나다</span><span class="mytag">마바사</span>
												</td>
											</tr>
											<tr>
												<td><span class="my_r_tag">아이폰</span></td>
												<td>
													<span class="mytag">가나다</span><span class="mytag">마바사</span><span class="mytag">아자차</span><span class="mytag">카타파</span><span class="mytag">하하하</span><span class="mytag">가나다</span><span class="mytag">마바사</span>
												</td>
											</tr>
										</tbody>
									</table>
									
									<table id="mytable" class="table table-hover table-bordered">
										<thead>
											<tr>
												<th style="width:30px">&nbsp;</th>
												<th style="width:20%">Representative</th>
												<th>Word Entry</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><label class="radio"><input type="radio" class="uniform" name="wordSelect" value="1"></label></td>
												<td><input type="text" class="form-control mytag_input" value="나다사"></td>
												<td>
													<input type="text" class="tags" value="가나다,라마바사,아자"> 	
												</td>
											</tr>
											<tr>
												<td><div class="form-group"><label class="radio"><input type="radio" class="uniform" name="wordSelect" value="2"></label></div></td>
												<td><input type="text" class="form-control mytag_input" value="아이폰"></td>
												<td><input type="text" class="tags" value="tags,with,autocomplete"> 
												</td>
											</tr>
										</tbody>
									</table>
									
									<div class="table-footer">
									<div class="col-md-6">
											Rows 1 - 50 of 2809 (filtered from 8 total entries)
										</div>
										
										<div class="col-md-6">
											<ul class="pagination">
												<li class="disabled"><a href="javascript:void(0);">&laquo;</a></li>
												<li class="active"><a href="javascript:void(0);">1</a></li>
												<li><a href="javascript:void(0);">2</a></li>
												<li><a href="javascript:void(0);">3</a></li>
												<li><a href="javascript:void(0);">4</a></li>
												<li><a href="javascript:void(0);">5</a></li>
												<li><a href="javascript:void(0);">&raquo;</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- //Synonym Dict -->
						<!-- //tab field -->
						<!-- search indexes -->
						<div class="tab-pane" id="tab_search_indexes">
							<div class="col-md-12">
							
							dddd
							</div>
							
						</div>
						<!-- //search indexes -->
						<!--=== Edit Account ===-->
						<div class="tab-pane active" id="tab_edit_account"></div>
						<!-- /Edit Account -->
					</div>
					<!-- /.tab-content -->
				</div>

						
				<!-- /Page Content -->
			</div>
		</div>
	</div>
</body>
</html>