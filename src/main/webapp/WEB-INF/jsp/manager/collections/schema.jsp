<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ROOT_PATH" value="../.." />
<c:import url="${ROOT_PATH}/inc/common.jsp" />
<html>
<head>
<c:import url="${ROOT_PATH}/inc/header.jsp" />
<style>
.fcol1 {
	width: 30px;
}

.fcol2 {
	width: 150px;
}

.fcol3 {
	width: 150px;
}

.fcol4 {
	width: 150px;
}

.fcol5 {
	width: 150px;
}

</style>
</head>
<body>
	<c:import url="${ROOT_PATH}/inc/mainMenu.jsp" />
	<div id="container">
		<c:import url="${ROOT_PATH}/inc/sideMenu.jsp">
			<c:param name="lcat" value="collections" />
			<c:param name="mcat" value="sample" />
			<c:param name="scat" value="schema" />
		</c:import>
		<div id="content">
			<div class="container">
				<!-- Breadcrumbs line -->
				<div class="crumbs">
					<ul id="breadcrumbs" class="breadcrumb">
						<li><i class="icon-home"></i> Manager</li>
						<li class="current"> Collections</li>
						<li class="current"> VOL</li>
						<li class="current"> Schema</li>
					</ul>

				</div>
				<!-- /Breadcrumbs line -->

				<!--=== Page Header ===-->
				<div class="page-header">
					<div class="page-title">
						<h3>Schema</h3>
					</div>
				</div>
				<!-- /Page Header -->
				
				
				<!--=== Page Content ===-->

				<div class="tabbable tabbable-custom tabbable-full-width">
					<ul class="nav nav-tabs">
						<li class="active"><a href="#tab_field" data-toggle="tab">Fields</a></li>
						<li class=""><a href="#tab_search_indexes" data-toggle="tab">Search
								Indexes</a></li>
						<li class=""><a href="#tab_field_indexes" data-toggle="tab">Field
								Indexes</a></li>
						<li class=""><a href="#tab_group_indexes" data-toggle="tab">Group
								Indexes</a></li>
					</ul>
					<div class="tab-content row">

						<!--=== Overview ===-->
						<div class="tab-pane active" id="tab_field">
							<div class="col-md-12">
								<div class="widget box">

									<div class="widget-content no-padding">
										<div class="row">
											<div class="dataTables_header clearfix">
												<div class="col-md-6">
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
												<div class="col-md-6">
													<div class="pull-right">
													<a href="javascript:void(0);">Expand Table</a> &nbsp;|&nbsp;
													<a href="javascript:void(0);">Shrink Table</a>
													</div>
												</div>
											</div>
										</div>
										<div>
											<div style="margin-right: 15px">
												<table class="table table-bordered">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol2">Field</th>
															<th class="fcol3">Type</th>
															<th class="fcol4">Length</th>
															<th class="fcol5">Key</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow: auto; height: 300px;">

												<table id="schema_table" class="table table-bordered table-checkable">
													<tbody>
														<tr>
															<td class="fcol1">1</td>
															<td class="fcol2">id</td>
															<td class="fcol3"><span class="label label-default">Int</span></td>
															<td class="fcol4">4</td>
															<td class="fcol5"><span class="label label-success">Yes</span></td>
														</tr>
														<tr>
															<td>2</td>
															<td>title</td>
															<td><span class="label label-default">String</span></td>
															<td class="hidden-xs">20</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>3</td>
															<td>body</td>
															<td><span class="label label-default">String</span></td>
															<td class="hidden-xs">8</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td><span class="label label-default">AString</span></td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td><span class="label label-default">AString</span></td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td><span class="label label-default">AString</span></td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td>char</td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td>char</td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td>char</td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td>char</td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
														<tr>
															<td>4</td>
															<td>tags</td>
															<td>char</td>
															<td class="hidden-xs">4</td>
															<td>&nbsp;</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										
										
										<!-- ---- -->
										<div>
											<div style="margin-right: 15px">
												<table class="table table-bordered">
													<thead>
														<tr>
															<th class="fcol1">#</th>
															<th class="fcol2">Field</th>
															<th class="fcol3">Type</th>
															<th class="fcol4">Length</th>
															<th class="fcol5">Key</th>
														</tr>
													</thead>
												</table>
											</div>
											<div class="innera" style="overflow: auto; height: 300px;">

												<table id="schema_table2" class="table table-bordered table-checkable">
													<tbody>
														<tr>
															<td class="fcol1">1</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>2</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>3</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>4</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>5</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>6</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>7</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>8</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
														<tr>
															<td>9</td>
															<td class="fcol2"><input type="text" class="form-control"></td>
															<td class="fcol3">
															<select class="select2">
																<option value="int">Int</option>
																<option value="int">String</option>
																<option value="int">AString</option>
																<option value="int">Long</option>
																<option value="int">Datetime</option>
															</select>
															</td>
															<td class="fcol4"><div class="col-md-10 input-width-small"><input type="text" class="form-control" ></input></div></td>
															<td class="fcol5"><input type="checkbox" class="uniform"></input></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										
										<!-- --- -->

										<div class="row form-horizontal">
											<div class="table-footer ">
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Store:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="uniform" value="" checked="true" > Yes
															</label>
														</div>
													</div>
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value:</label>
														<div class="col-md-9">
															<label class="checkbox"> <input type="checkbox"
																class="uniform" value=""> Yes
															</label>
														</div>
													</div>
													
												</div>
												<div class="col-md-12">
													<div class="form-group">
														<label class="col-md-3 control-label">Multi Value
															Delimiter: </label>
														<div class="col-md-9">
															<input type="text" name="regular" class="form-control">
														</div>
													</div>
												</div>
											</div>
										</div>

									</div>
								</div>

							</div>
						</div>
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