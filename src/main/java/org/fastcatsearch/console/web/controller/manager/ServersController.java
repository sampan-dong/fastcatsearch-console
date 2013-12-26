package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	@RequestMapping("/server")
	public ModelAndView server(HttpSession session) throws Exception {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String requestUrl = "/management/servers/list.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpPost(session, requestUrl).requestJSON();
//		} catch (Exception e) {
//			logger.error("", e);
//		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/server");
		//mav.addObject("nodeList", jsonObj.getJSONArray("nodeList"));
		return mav;
	}
	
}
