<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.jdom2.*"%>
<%@page import="org.json.*"%>
<%@page import="org.fastcatsearch.console.web.util.*"%>

<%
	Document indexingSchedule = (Document) request.getAttribute("indexingSchedule");
	Element rootElement = indexingSchedule.getRootElement();
	Element fullElement = rootElement.getChild("full-indexing-schedule");
	Element addElement = rootElement.getChild("add-indexing-schedule");
	String fullActive = "true".equals(fullElement.getAttributeValue("active")) ? "checked='checked'" : "";
	String addActive = "true".equals(addElement.getAttributeValue("active")) ? "checked='checked'" : "";
	String[] fullStartDateTime = fullElement.getAttributeValue("start").split(" ");
	String fullStartDate = fullStartDateTime[0].replaceAll("-", ".");
	String[] fullStartTimes = fullStartDateTime[1].split(":");
	String fullStartHour = fullStartTimes[0];
	String fullStartMinute = fullStartTimes[1];
	
	String[] addStartDateTime = addElement.getAttributeValue("start").split(" ");
	String addStartDate = addStartDateTime[0].replaceAll("-", ".");
	String[] addStartTimes = addStartDateTime[1].split(":");
	String addStartHour = addStartTimes[0];
	String addStartMinute = addStartTimes[1];
	
	
	int[] fullTimeUnits = WebUtils.convertSecondsToTimeUnits(Integer.parseInt(fullElement.getAttributeValue("periodInSecond")));
	int[] addTimeUnits = WebUtils.convertSecondsToTimeUnits(Integer.parseInt(addElement.getAttributeValue("periodInSecond")));
%>
<script>
$(document).ready(function(){
	$( ".datepicker" ).datepicker({ dateFormat: "yy.mm.dd", showAnim: ""});
	
	$("#collection-indexing-schedule").validate({
		errorLabelContainer: "#messageBox",
		submitHandler: function(form) {
			//$(form).ajaxSubmit();
			alert("a");
		}
	});
});
</script>
<div class="col-md-12">
<p id="messageBox" class="has-error"></p>
	<form id="collection-indexing-schedule" >
		<div class="widget">
		
			<div class="widget-header">
				<h4>Full Indexing</h4>
			</div>
			<div class="widget-content">
				<div class="row form-horizontal">
					<div class="col-md-12">
						<div class="form-group">
							<label class="col-md-2 control-label">Scheduled:</label>
							<div class="col-md-10">
								<span class="checkbox"><label><input type="checkbox" name="fullIndexingScheduled" <%=fullActive %>> Yes</label></span>
							</div>
						</div>
						
						<div class="form-group form-inline">
							<label class="col-md-2 control-label">Base Date:</label>
							<div class="col-md-10">
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Date</span>
									<input type="text" name="fullBaseDate" class="datepicker form-control input-width-small" placeholder="Date" value="<%=fullStartDate %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Hr</span>
									<input type="text" name="fullBaseHour" class="form-control input-width-small digits" placeholder="Hour" value="<%=fullStartHour %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Min</span>
									<input type="text" name="fullBaseMin" class="form-control input-width-small digits" placeholder="Minute" value="<%=fullStartMinute %>">
								</div>
							</div>
						</div>
							
						<div class="form-group form-inline">
							<label class="col-md-2 control-label">Period:</label>
							<div class="col-md-10">
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Day</span>
									<input type="text" name="fullPeriodDay" class="form-control input-width-small digits" value="<%=fullTimeUnits[0] %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Hr</span>
									<input type="text" name="fullPeriodHour" class="form-control input-width-small digits" value="<%=fullTimeUnits[1] %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Min</span>
									<input type="text" name="fullPeriodMin" class="form-control input-width-small digits" value="<%=fullTimeUnits[2] %>">
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
		</div> <!-- /.widget -->
		
		<div class="widget">
			<div class="widget-header">
				<h4>Add Indexing</h4>
			</div>
			<div class="widget-content">
				<div class="row form-horizontal">
					<div class="col-md-12">
						<div class="form-group">
							<label class="col-md-2 control-label">Scheduled:</label>
							<div class="col-md-10">
								<span class="checkbox"><label><input type="checkbox" name="addIndexingScheduled" <%=addActive %>> Yes</label></span>
							</div>
						</div>
						
						<div class="form-group form-inline">
							<label class="col-md-2 control-label">Base Date:</label>
							<div class="col-md-10">
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Date</span>
									<input type="text" name="addBaseDate" class="datepicker form-control input-width-small" placeholder="Date" value="<%=addStartDate %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Hr</span>
									<input type="text" name="addBaseHour" class="form-control input-width-small digits" placeholder="Hour" value="<%=addStartHour %>">
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<span class="input-group-addon">Min</span>
									<input type="text" name="addBaseMin" class="form-control input-width-small digits" placeholder="Minute" value="<%=addStartMinute %>">
								</div>
							</div>
						</div>
							
						<div class="form-group form-inline">
							<label class="col-md-2 control-label">Period:</label>
							<div class="col-md-10">
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[0] %>">
									<span class="input-group-addon">Day</span>
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[1] %>">
									<span class="input-group-addon">Hr</span>
								</div>
								<div class="input-group col-md-1" style="padding-left: 0px;">
									<input type="number" name="regular" class="form-control input-width-small" value="<%=addTimeUnits[2] %>">
									<span class="input-group-addon">Min</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
		</div> <!-- /.widget -->
		
		<div class="form-actions">
			<input type="submit" value="Update Schedule" class="btn btn-primary ">
		</div>
	
	</form>
</div>
