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
			@RequestParam(required=false,defaultValue="1") String pageNo
			) throws Exception {
		
		PageDivider divider = new PageDivider(15,10);
		
		int pageNoInt = Integer.parseInt(pageNo);
		int start = (pageNoInt-1)*divider.rowSize();
		int end = start+divider.rowSize();
		int totalPage = 0;
		int pageStart = 0;
		int pageEnd = 0;
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/notification-history.json?pageNo="+
			pageNo+"&start="+start+"&end="+end;
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		divider.setTotalCount(jsonObj.optInt("totalCount",0));
		
		if(pageNoInt > divider.totalPage()) {
			pageNoInt = divider.totalPage();
		}
		
		totalPage = divider.totalPage();
		start = divider.rowStart(pageNoInt);
		end = divider.rowEnd(pageNoInt);
		pageStart = divider.pageStart(pageNoInt);
		pageEnd = divider.pageEnd(pageNoInt);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notifications");
		mav.addObject("notifications", jsonObj);
		mav.addObject("pageStart",pageStart);
		mav.addObject("pageEnd",pageEnd);
		mav.addObject("totalPage",totalPage);
		mav.addObject("start",start);
		mav.addObject("end",end);
		mav.addObject("rowSize",divider.rowSize());
		mav.addObject("pageSize",divider.pageSize());
		mav.addObject("totalCount",divider.totalCount());
		mav.addObject("pageNo",pageNoInt);
		
		return mav;
	}
	
	@RequestMapping("exceptions")
	public ModelAndView exceptions(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNo) throws Exception {
		
		PageDivider divider = new PageDivider(15,10);
		
		int pageNoInt = Integer.parseInt(pageNo);
		int start = (pageNoInt-1)*divider.rowSize();
		int end = start+divider.rowSize();
		int totalPage = 0;
		int pageStart = 0;
		int pageEnd = 0;
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/exception-history.json?pageNo="+
			pageNo+"&start="+start+"&end="+end;
		
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		divider.setTotalCount(jsonObj.optInt("totalCount",0));
		
		if(pageNoInt > divider.totalPage()) {
			pageNoInt = divider.totalPage();
		}
		
		totalPage = divider.totalPage();
		start = divider.rowStart(pageNoInt);
		end = divider.rowEnd(pageNoInt);
		pageStart = divider.pageStart(pageNoInt);
		pageEnd = divider.pageEnd(pageNoInt);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptions");
		mav.addObject("exceptions", jsonObj);
		mav.addObject("pageStart",pageStart);
		mav.addObject("pageEnd",pageEnd);
		mav.addObject("totalPage",totalPage);
		mav.addObject("start",start);
		mav.addObject("end",end);
		mav.addObject("rowSize",divider.rowSize());
		mav.addObject("pageSize",divider.pageSize());
		mav.addObject("totalCount",divider.totalCount());
		mav.addObject("pageNo",pageNoInt);
		
		return mav;
	}
	
	@RequestMapping("tasks")
	public ModelAndView tasks(HttpSession session,
			@RequestParam(required=false,defaultValue="1") String pageNo) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String getAnalysisPluginListURL = "/management/logs/task-history.json?pageNo="+pageNo;
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/tasks");
		mav.addObject("tasks", jsonObj);
		
		return mav;
	}
}
