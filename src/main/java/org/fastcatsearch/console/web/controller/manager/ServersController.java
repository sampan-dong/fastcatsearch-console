package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/servers")
public class ServersController extends AbstractController {
	
	@RequestMapping("/overview")
	public ModelAndView overview(HttpSession session) throws Exception {
		String requestUrl = "/management/servers/list.json";
		JSONObject serverList = httpPost(session, requestUrl).requestJSON();
		
		requestUrl = "/management/servers/systemInfo.json";
		JSONObject systemInfo = httpPost(session, requestUrl).requestJSON();
		
		requestUrl = "/management/servers/systemHealth.json";
		JSONObject systemHealth = httpPost(session, requestUrl).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/overview");
		mav.addObject("nodeList", serverList.getJSONArray("nodeList"));
		mav.addObject("systemInfo", systemInfo);
		mav.addObject("systemHealth", systemHealth);
		return mav;
	}
	
	@RequestMapping("/settings")
	public ModelAndView settings(HttpSession session) throws Exception {
		String requestUrl = "/management/servers/list.json";
		JSONObject jsonObj = httpPost(session, requestUrl).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/settings");
		mav.addObject("nodeList", jsonObj.getJSONArray("nodeList"));
		return mav;
	}
	
	
	private static final String[] serviceClasses = {
		"org.fastcatsearch.ir.IRService",
		"org.fastcatsearch.cluster.NodeService",
		"org.fastcatsearch.db.DBService",
		"org.fastcatsearch.control.JobService",
		"org.fastcatsearch.management.SystemInfoService",
		"org.fastcatsearch.http.HttpRequestService",
		"org.fastcatsearch.notification.NotificationService"
	};
	
	@RequestMapping("/server")
	public ModelAndView server(HttpSession session, @RequestParam("id") String nodeId) throws Exception {
		String requestUrl = "";
		
		StringBuilder serviceClassStr = new StringBuilder();
		for(String serviceClass : serviceClasses) {
			if(serviceClassStr.length() > 0) {
				serviceClassStr.append(",");
			}
			serviceClassStr.append(serviceClass);
		}
		
		
		requestUrl = "/management/servers/list.json";
		JSONObject nodeInfo = httpPost(session, requestUrl)
				.addParameter("nodeId", nodeId).requestJSON();
		
		requestUrl = "/management/servers/systemHealth.json";
		JSONObject systemHealth = httpPost(session, requestUrl)
				.addParameter("nodeId", nodeId).requestJSON();
		
		requestUrl = "/management/common/all-task-state.json";
		JSONObject taskStatus = httpPost(session, requestUrl)
				.addParameter("start", "0").addParameter("end", "5").requestJSON();
		
		requestUrl = "/management/servers/systemInfo.json";
		JSONObject systemInfo = httpPost(session, requestUrl)
				.addParameter("nodeId", nodeId).requestJSON();
		
		requestUrl = "/management/collections/all-collection-indexing-status.json";
		JSONObject indexStatus = httpPost(session, requestUrl)
				.addParameter("nodeId", nodeId).requestJSON();
		
		requestUrl = "/management/analysis/plugin-analyzer-list.json";
		JSONObject pluginStatus = httpPost(session, requestUrl).requestJSON();
		
		requestUrl = "/management/common/modules-running-state.json";
		JSONObject moduleStatus = httpPost(session, requestUrl)
				.addParameter("services", serviceClassStr.toString()).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/server");
		mav.addObject("nodeInfo", nodeInfo);
		mav.addObject("systemHealth", systemHealth);
		mav.addObject("taskStatus", taskStatus);
		mav.addObject("systemInfo", systemInfo);
		mav.addObject("indexStatus", indexStatus);
		mav.addObject("pluginStatus", pluginStatus);
		mav.addObject("moduleStatus", moduleStatus);
		mav.addObject("nodeId", nodeId);
		mav.addObject("serviceClasses", serviceClasses);
		return mav;
	}
	
}
