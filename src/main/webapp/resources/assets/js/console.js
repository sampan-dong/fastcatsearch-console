if (typeof console == "undefined") var console = { log: function() {} };

function nl2br(str){
	return $.trim(str).replace(/\n/g,"<br>");
}

function br2nl(str){
	return str.replace(/(<br>)|(<br \/>)|(<p>)|(<\/p>)/g,"\n");
}

function toSafeString(str){
	return $.trim(str).replace(/'/gi, "").replace(/"/gi, "").replace(/\\/gi, "");
}

function submitGet(url, data){
	submitForm(url, data, "GET");
}
function submitPost(url, data){
	submitForm(url, data, "POST");
}
//가상의 폼을 만들어서 sumit한다.
function submitForm(url, data, method){
	
    $('body').append($('<form/>', {
		id : 'jQueryPostItForm',
		method : method,
		action : url
	}));

	for ( var i in data) {
		$('#jQueryPostItForm').append($('<input/>', {
			type : 'hidden',
			name : i,
			value : data[i]
		}));
	}

	$('#jQueryPostItForm').submit();
}

function loadToTab(url, data, id){
	//console.log(url, data, id);
	$.ajax({
		url : url,
		data : data,
		type : "POST",
		success : function(response) {
			$(id).html(response);
		}
	});
} 

var PROXY_REQUEST_URI = window.location.protocol + "//" + window.location.host
		+ "/console/main/request.html";

function requestProxy(methodType, data, resultType, successCallback, failCallback){
	
	$.ajax({
		url : PROXY_REQUEST_URI,
		type : methodType,
		data : data,
		dataType : resultType,
		success: successCallback,
		fail: failCallback
	});
}

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
	(function poll() {
	    $.ajax({
	        url: PROXY_REQUEST_URI,
	        type: "GET",
	        data : {
				uri : "/indexing/task-state",
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


var pollingTimeout = 3000;
var pollingInterval = 1000;
var pollingAllTaskURI = "/management/common/all-task-state.json";
////////////task polling for tasks page

function startPollingAllTaskState(){
	(function poll() {
	    $.ajax({
	        url: PROXY_REQUEST_URI,
	        type: "GET",
	        data : {
				uri : pollingAllTaskURI
			},
	        dataType: "json",
	        complete: function() { setTimeout(function() {poll();}, pollingInterval);},
	        timeout: pollingTimeout,
	        success: function(data) {
	        	console.log("polling task for page", data, data.taskState);
	        	//$("#running_tasks_top").find(".count").text(data.taskState.length);
	        	
	        	//task페이지가 존재하면.
	        	if($("#_logs_tasks_table").length > 0){
	        		$("#_logs_tasks_table").find("tbody tr").remove();
	        	}
	        	
	        	if(data.taskState.length > 0){
	        		
	        		for(var i = 0; i < data.taskState.length; i++){
	        			
			        	if($("#_logs_tasks_table").length > 0){
			        		
			        		var $task = $("<tr><td class=\"_task_num\"></td><td><span class=\"task\"><span class=\"desc\"></span> <span class=\"percent\"></span></span>"
			        			+"<div class=\"progress progress-small progress-striped active\"><div style=\"width: 20%;\" class=\"progress-bar progress-bar-info\"></div></div>"
			        			+"</td><td class=\"_task_eclapsed\"></td><td class=\"_task_startTime\">2013-09-10 12:35:00</td></tr>");
			        		$task.find("._task_num").text(i+1);
			        		$task.find(".desc").text(data.taskState[i].summary);
			        		$task.find("._task_eclapsed").text(data.taskState[i].elapsed);
			        		$task.find("._task_startTime").text(data.taskState[i].startTime);
			        		if(data.taskState[i].progress != -1){
				        		$task.find(".percent").text(data.taskState[i].progress+"%");
				        		$task.find(".progress-bar").css("width", data.taskState[i].progress+"%");
				        	}else{
				        		$task.find(".progress-bar").css("width", "50%");
				        	}
			        		$("#_logs_tasks_table").append($task);
			        	}
			        	
	        		}
	        		
	        	}
	        }
	    });
	})();
}


////////////task polling for taskbar

var pollingAllTaskStateFlagForTaskBar = false;

function startPollingAllTaskStateForTaskBar(){
	if(pollingAllTaskStateFlagForTaskBar){
		return;
	}
	pollingAllTaskStateFlagForTaskBar = true;
	
	(function poll() {
	    $.ajax({
	        url: PROXY_REQUEST_URI,
	        type: "GET",
	        data : {
				uri : pollingAllTaskURI
			},
	        dataType: "json",
	        complete: function() { if(pollingAllTaskStateFlagForTaskBar) {setTimeout(function() {poll();}, pollingInterval); } },
	        timeout: pollingTimeout,
	        success: function(data) {
//	        	console.log("polling task for taskbar", data, data.taskState);
	        	
	        	$("#running_tasks_top").find("li").not(".title").remove();
	        	$("#running_tasks_top").find(".count").text(data.taskState.length);
	        	
	        	if(data.taskState.length > 0){
	        		
	        		for(var i = 0; i < data.taskState.length; i++){
	        			
	        			//상단 task 요약.
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


function stopPollingAllTaskStateForTaskBar(){
	pollingAllTaskStateFlagForTaskBar = false;
}



/////////////////// dictionary
function loadDictionaryTab(dictionaryType, dictionaryId, pageNo, keyword, searchColumn, exactMatch, isEditable, targetId, deleteIdList){
	console.log("loadDictionaryTab", dictionaryType, dictionaryId, pageNo, escape(keyword), searchColumn, exactMatch, isEditable, targetId, deleteIdList);
	loadToTab(dictionaryType + '/list.html', {dictionaryId: dictionaryId, pageNo: pageNo, keyword: keyword, searchColumn: searchColumn, exactMatch: exactMatch, isEditable: isEditable, targetId: targetId, deleteIdList: deleteIdList}, targetId);
}


function truncateDictionary(analysisId, dictionaryId, callback){
	requestProxy("POST", { 
		uri: '/management/dictionary/truncate.json',
		pluginId: analysisId,
		dictionaryId: dictionaryId
	},
	"json",
	function(response) {
		if(response.success){
			alert("Clean data success.");
			callback();
		}else{
			var message = "Clean data error.";
			if(response.errorMessage){
				message = message + " Reason = "+response.errorMessage;
			}
			alert(message);
		}
	},
	function(response){
		alert("Clean data error.");
	});	
}



function checkableTable(tableId) {
	console.log("checkabel ", $(tableId).find( 'thead th.checkbox-column :checkbox' ));
	$(tableId).find(':checkbox').each(function(j, cb_self) {
		$(cb_self).uniform();
		$.uniform.update($(cb_self));
	});
	$(tableId).find( 'thead th.checkbox-column :checkbox' ).on('change', function() {
		var checked = $( this ).prop( 'checked' );
		$( this ).parents('table').children('tbody').each(function(i, tbody) {
			$(tbody).find('.checkbox-column').each(function(j, cb) {
				var cb_self = $( ':checkbox', $(cb) ).prop( "checked", checked ).trigger('change');
				if (cb_self.hasClass('uniform')) {
					$.uniform.update(cb_self);
				}

				$(cb).closest('tr').toggleClass( 'checked', checked );
			});
		});
	});
	$(tableId).find( 'tbody tr td.checkbox-column :checkbox' ).on('change', function() {
		var checked = $( this ).prop( 'checked' );
		$( this ).closest('tr').toggleClass( 'checked', checked );
	});
}


