package org.fastcatsearch.console.web.controller.account;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.fastcatsearch.console.web.http.ResponseHttpClient.PostMethod;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController {
	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	private ResponseHttpClient httpClient;
	private JSONObject jsonObj;
	ModelAndView modelAndView;
	
	private void init(HttpSession session) {
		httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		modelAndView = new ModelAndView();
	}
	
	@RequestMapping("/account/index")
	public ModelAndView index(HttpSession session) {
		init(session);
		modelAndView.setViewName("redirect:/account/user.html");
		return modelAndView;
	}

	@RequestMapping("/account/user")
	public ModelAndView user(HttpSession session) {
		init(session);
		modelAndView.setViewName("/account/user");
		return modelAndView;
	}
	
	@RequestMapping("/account/group")
	public ModelAndView group(HttpSession session) {
		init(session);
		String requestUrl = "/setting/authority/group-authority-list.json";
		try {
			jsonObj = httpClient.httpGet(requestUrl)
					.addParameter("mode", "all")
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/group");
		modelAndView.addObject("groupAuthorityList",jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/user-list")
	public ModelAndView userList(HttpSession session) {
		init(session);
		String requestUrl = "/setting/authority/user-list.json";
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/jsonList");
		modelAndView.addObject("list", jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/group-list")
	public ModelAndView groupList(HttpSession session) {
		init(session);
		String requestUrl = "/setting/authority/group-list.json";
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/jsonList");
		modelAndView.addObject("list", jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/group-authority-list")
	public ModelAndView groupAuthorityList(HttpSession session, @RequestParam String groupId ) {
		init(session);
		String requestUrl = "/setting/authority/group-list.json";
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("groupId", groupId)
					.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		modelAndView.setViewName("/account/jsonList");
		modelAndView.addObject("list", jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/group-authority-update")
	public ModelAndView groupAuthorityUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
		init(session);
		
		String requestUrl = "/setting/authority/group-authority-update.json";
		try {
			PostMethod post = httpClient.httpPost(requestUrl);
			
			for(String key : params.keySet()) {
				post.addParameter(key, (String)params.get(key));
			}
			
			jsonObj = post.requestJSON();
			
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/updateResult");
		modelAndView.addObject("result", jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/group-update")
	public ModelAndView groupUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
		init(session);
		
		String requestUrl = "/setting/authority/group-update.json";
		try {
			PostMethod post = httpClient.httpPost(requestUrl);
			
			for(String key : params.keySet()) {
				post.addParameter(key, (String)params.get(key));
			}
			
			jsonObj = post.requestJSON();
			
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/updateResult");
		modelAndView.addObject("result", jsonObj);
		return modelAndView;
	}
	
	@RequestMapping("/account/user-update") 
	public ModelAndView userUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
		init(session);
		
		String requestUrl = "/setting/authority/user-update.json";
		try {
			PostMethod post = httpClient.httpPost(requestUrl);
			for(String key : params.keySet()) {
				post.addParameter(key, (String)params.get(key));
			}
			
			jsonObj = post.requestJSON();
			
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/updateResult");
		modelAndView.addObject("result", jsonObj);
		return modelAndView;
	}

	@RequestMapping("/account/user-delete")
	public ModelAndView userDelete(HttpSession session, @RequestParam String userId) {
		init(session);
		String requestUrl = "/setting/authority/user-delete.json";
		try {
			jsonObj = httpClient.httpPost(requestUrl).
				addParameter("userId", userId)
				.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/updateResult");
		modelAndView.addObject("result", jsonObj);
		return modelAndView;
		
	}
	
	@RequestMapping("/account/group-delete")
	public ModelAndView groupDelete(HttpSession session, @RequestParam String groupId) {
		init(session);
		String requestUrl = "/setting/authority/group-delete.json";
		try {
			jsonObj = httpClient.httpPost(requestUrl).
				addParameter("group", groupId)
				.requestJSON();
		} catch (Exception e) {
			logger.error("",e);
		}
		
		modelAndView.setViewName("/account/updateResult");
		modelAndView.addObject("result", jsonObj);
		return modelAndView;
	}
}
