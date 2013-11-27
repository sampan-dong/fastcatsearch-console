package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/logs")
public class LogsController extends AbstractController {
	
	@RequestMapping("notifications")
	public ModelAndView notifications(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNum) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/notification-history.json?pageNum="+pageNum;
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notifications");
		mav.addObject("notifications", jsonObj);
		
		return mav;
	}
	
	@RequestMapping("exceptions")
	public ModelAndView exceptions(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNum) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/exception-history.json?pageNum="+pageNum;
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptions");
		mav.addObject("exceptions", jsonObj);
		
		return mav;
	}
	
	@RequestMapping("tasks")
	public ModelAndView tasks(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNum) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/task-history.json?pageNum="+pageNum;
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/tasks");
		mav.addObject("tasks", jsonObj);
		
		return mav;
	}
}
