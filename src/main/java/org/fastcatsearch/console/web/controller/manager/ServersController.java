package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/servers")
public class ServersController {
	private static Logger logger = LoggerFactory.getLogger(ServersController.class);
	
	@RequestMapping("/overview")
	public ModelAndView overview(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/servers/list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl).requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/overview");
		mav.addObject("nodeList", jsonObj.getJSONArray("nodeList"));
		return mav;
	}
	
	@RequestMapping("/server")
	public ModelAndView server(HttpSession session) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String requestUrl = "/management/servers/list.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl).requestJSON();
//		} catch (Exception e) {
//			logger.error("", e);
//		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/servers/server");
		//mav.addObject("nodeList", jsonObj.getJSONArray("nodeList"));
		return mav;
	}
	
}
