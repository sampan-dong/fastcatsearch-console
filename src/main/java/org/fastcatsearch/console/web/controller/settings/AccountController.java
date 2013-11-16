package org.fastcatsearch.console.web.controller.settings;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController extends AbstractController {
	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@RequestMapping("/settings/index")
	public ModelAndView index(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/settings/group.html");
		return modelAndView;
	}

	@RequestMapping("/settings/user")
	public ModelAndView user(HttpSession session) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/settings/user");
		String requestUrl = null;
		requestUrl = "/settings/authority/get-group-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpGet(requestUrl).requestJSON();
			modelAndView.addObject("groupList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		requestUrl = "/settings/authority/get-user-list.json";
		try {
			jsonObj = httpClient.httpGet(requestUrl).requestJSON();
			modelAndView.addObject("userList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		return modelAndView;
	}
	
	@RequestMapping("/settings/group")
	public ModelAndView group(HttpSession session) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/settings/group");
		String requestUrl;
		requestUrl = "/settings/authority/get-group-authority-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpGet(requestUrl)
					.addParameter("mode", "all").requestJSON();
			modelAndView.addObject("groupAuthorityList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		requestUrl = "/settings/authority/get-group-authority-list.json";
		try {
			jsonObj = httpClient.httpGet(requestUrl)
					.addParameter("groupId", "-1").requestJSON();
			modelAndView.addObject("authorityList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		return modelAndView;
	}
}
