package org.fastcatsearch.console.web.controller.account;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController {
	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@RequestMapping("/account/index")
	public ModelAndView index(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/account/user.html");
		return mav;
	}

	@RequestMapping("/account/user")
	public ModelAndView user(HttpSession session) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/account/user");
		return mav;
	}
	
	@RequestMapping("/account/group")
	public ModelAndView group(HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/account/group");
		return mav;
	}
	
	@RequestMapping("/account/user-list")
	public ModelAndView userList(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/setting/authority/user-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/account/userList");
		return mav;
	}
	
	@RequestMapping("/account/group-list")
	public ModelAndView groupList(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/setting/authority/group-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/account/groupList");
		mav.addObject("list", jsonObj.getJSONArray("groupList"));
		return mav;
	}
	
	@RequestMapping("/account/group-authority-list")
	public ModelAndView groupAuthorityList(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/setting/authority/group-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/account/groupAuthorityList");
		mav.addObject("list", jsonObj.getJSONArray("groupAuthorityList"));
		return mav;
	}
}
