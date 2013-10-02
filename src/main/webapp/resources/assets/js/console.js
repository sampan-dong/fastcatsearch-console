var PROXY_REQUEST_URI = window.location.protocol + "//" + window.location.host
		+ "/console/main/request.html";

function runIndexing(collectionId, indexingType) {
	if(!indexingStatePollingFlag){
		startPollingIndexTaskState(collectionId);
	}
	
	$.ajax({
		url : PROXY_REQUEST_URI,
		type : "POST",
		data : {
			uri : "/indexing/"+indexingType+"/run",
			collectionId : collectionId
		},
		dataType : "json"

	}).done(function(msg) {
	}).fail(function(jqXHR, textStatus, error) {
		alert("Request failed: " + jqXHR.responseText);
	}).always(function() {
		// alert("complete");
	});
}
function runFullIndexing(collectionId) {
	runIndexing(collectionId, "full");
}
function runAddIndexing(collectionId) {
	runIndexing(collectionId, "add");
}

function stopIndexing(collectionId) {
	
}


var indexingStatePollingFlag = false;

function startPollingIndexTaskState(collectionId){
	indexingStatePollingFlag = true;
	// /indexing/state
	(function poll() {
	    $.ajax({
	        url: PROXY_REQUEST_URI,
	        type: "GET",
	        data : {
				uri : "/indexing/state",
				collectionId : collectionId
			},
	        dataType: "json",
	        complete: function() { if(indexingStatePollingFlag) {setTimeout(function() {poll();}, 2000); } },
	        timeout: 2000,
	        success: function(data) {
	        	console.log("polling ", data, data.indexingState);
	        	if($.isEmptyObject(data.indexingState)){
	        		$("#indexing_type").text("");
	        		$("#indexing_state").text("");
	        		$("#indexing_document_count").text("");
	        		$("#indexing_scheduled").text("");
	        		$("#indexing_start_time").text("");
	        		$("#indexing_elapsed").text("");
//	        		stopPollingIndexTaskState();
	        	} else {
	        		$("#indexing_type").text(data.indexingState.indexingType);
	        		$("#indexing_state").html("<i class=\"icon-spinner icon-spin icon-large\"></i> " + data.indexingState.state);
	        		$("#indexing_document_count").text(data.indexingState.count);
	        		$("#indexing_scheduled").text(data.indexingState.isScheduled);
	        		$("#indexing_start_time").text(data.indexingState.startTime);
	        		$("#indexing_elapsed").text(data.indexingState.elapsed);
	        		
	        	}
	        }
	    });
	})();
}


function stopPollingIndexTaskState(){
	indexingStatePollingFlag = false;
}




////////////task polling

var pollingAllTaskStateFlag = false;

function startPollingAllTaskState(){
	pollingAllTaskStateFlag = true;
	// /indexing/state
	(function poll() {
	    $.ajax({
	        url: PROXY_REQUEST_URI,
	        type: "GET",
	        data : {
				uri : "/common/all-task-state"
			},
	        dataType: "json",
	        complete: function() { if(pollingAllTaskStateFlag) {setTimeout(function() {poll();}, 2000); } },
	        timeout: 2000,
	        success: function(data) {
	        	console.log("polling task", data, data.taskState);
	        	
	        	$("#running_tasks_top").find("li").not(".title").remove();
	        	$("#running_tasks_top").find(".count").text(data.taskState.length);
	        	if(data.taskState.length > 0){
	        		
	        		for(var i = 0; i < data.taskState.length; i++){
	        			
			        	var $task = $("<li><a href=\"javascript:void(0);\"><span class=\"task\"><span class=\"desc\">11</span><span class=\"percent\"></span></span>"
								+"<div class=\"progress progress-small progress-striped active\"><div style=\"width: 1%;\" class=\"progress-bar progress-bar-info\"></div>"
								+"</div></a></li>");
			        	$task.find(".desc").text(data.taskState[i].summary);
			        	if(data.taskState[i].progress != -1){
			        		$task.find(".percent").text(data.taskState[i].progress+"%");
			        		$task.find(".progress-bar").css("width", data.taskState[i].progress+"%");
			        	}else{
			        		$task.find(".progress-bar").css("width", "50%");
			        	}
			        	$("#running_tasks_top").append($task);
	        		}
	        		
	        	}
	        }
	    });
	})();
}


function stopPollingAllTaskState(){
	pollingAllTaskStateFlag = false;
}


