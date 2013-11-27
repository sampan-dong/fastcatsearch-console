package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/logs")
public class LogsController extends AbstractController {
	
	@RequestMapping("notifications")
	public ModelAndView notifications() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notifications");
		return mav;
	}
	
	@RequestMapping("notificationsDataRaw")
	public ModelAndView notificationsDataRaw(HttpSession session, 
			@RequestParam(defaultValue = "1") Integer pageNo ) throws Exception {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/logs/notification-history-list.json";
		JSONObject notificationData = httpClient.httpGet(requestUrl)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		logger.debug("notificationData >> {}",notificationData);
		JSONArray list = notificationData.getJSONArray("notifications");
		int realSize = list.length();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notificationsDataRaw");
		mav.addObject("start", start + 1);
		mav.addObject("end", start + realSize);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("notifications", notificationData);
		return mav;
	}
	
	@RequestMapping("notificationInfo")
	public ModelAndView notificationInfo(HttpSession session, 
			@RequestParam Integer id ) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/logs/notification-info.json";
		JSONObject notificationInfo = httpClient.httpGet(requestUrl)
					.addParameter("id",String.valueOf(id) )
					.requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notificationInfoRaw");
		mav.addObject("notificationInfo",notificationInfo);
		return mav;
	}
	
	@RequestMapping("exceptions")
	public ModelAndView exceptions(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNo) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptions");
		return mav;
	}
	
	@RequestMapping("exceptionsDataRaw")
	public ModelAndView exceptionssDataRaw(HttpSession session, 
			@RequestParam(defaultValue = "1") Integer pageNo ) throws Exception {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/logs/exception-history-list.json";
		JSONObject exceptionData = httpClient.httpGet(requestUrl)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		logger.debug("exceptionData >> {}",exceptionData);
		JSONArray list = exceptionData.getJSONArray("exceptions");
		int realSize = list.length();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptionsDataRaw");
		mav.addObject("start", start + 1);
		mav.addObject("end", start + realSize);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("exceptions", exceptionData);
		return mav;
	}
	
	@RequestMapping("exceptionInfo")
	public ModelAndView exceptionInfo(HttpSession session, 
			@RequestParam Integer id ) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/logs/exception-info.json";
		JSONObject exceptionInfo = httpClient.httpGet(requestUrl)
					.addParameter("id",String.valueOf(id) )
					.requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptionInfoRaw");
		mav.addObject("exceptionInfo",exceptionInfo);
		return mav;
	}
	
	@RequestMapping("tasks")
	public ModelAndView tasks() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/tasks");
		return mav;
	}
}
