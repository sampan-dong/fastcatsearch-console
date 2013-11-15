package org.fastcatsearch.console.web.controller.settings;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AccountController {
	private static final Logger logger = LoggerFactory.getLogger(AccountController.class);
	
	@RequestMapping("/settings/index")
	public ModelAndView index(HttpSession session) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/settings/user.html");
		return modelAndView;
	}

	@RequestMapping("/settings/user")
	public ModelAndView user(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/settings/user");
		String requestUrl = null;
		requestUrl = "/setting/authority/group-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpGet(requestUrl).requestJSON();
			modelAndView.addObject("groupList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		requestUrl = "/setting/authority/user-list.json";
		try {
			jsonObj = httpClient.httpGet(requestUrl).requestJSON();
			modelAndView.addObject("userList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		return modelAndView;
	}
	
	@RequestMapping("/settings/group")
	public ModelAndView group(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/settings/group");
		String requestUrl;
		requestUrl = "/setting/authority/group-authority-list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpGet(requestUrl)
					.addParameter("mode", "all").requestJSON();
			modelAndView.addObject("groupAuthorityList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		requestUrl = "/setting/authority/group-authority-list.json";
		try {
			jsonObj = httpClient.httpGet(requestUrl)
					.addParameter("groupId", "-1").requestJSON();
			modelAndView.addObject("authorityList",jsonObj);
		} catch (Exception e) {
			logger.error("",e);
		}
		
		return modelAndView;
	}
	
//	@RequestMapping("/settings/user-list")
//	@ResponseBody
//	public String userList(HttpSession session) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String requestUrl = "/setting/authority/user-list.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl)
//					.requestJSON();
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		return jsonObj.toString();
//	}
//	
//	@RequestMapping("/settings/group-list")
//	@ResponseBody
//	public String groupList(HttpSession session) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String requestUrl = "/setting/authority/group-list.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl)
//					.requestJSON();
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//	}
//	
//	@RequestMapping("/settings/group-authority-list")
//	@ResponseBody
//	public String groupAuthorityList(HttpSession session, @RequestParam String groupId ) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String requestUrl = "/setting/authority/group-list.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl)
//					.addParameter("groupId", groupId)
//					.requestJSON();
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		return jsonObj.toString();
//	}
//	
//	@RequestMapping("/settings/group-authority-update")
//	@ResponseBody
//	public String groupAuthorityUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		
//		String requestUrl = "/setting/authority/group-authority-update.json";
//		JSONObject jsonObj = null;
//		try {
//			PostMethod post = httpClient.httpPost(requestUrl);
//			
//			for(String key : params.keySet()) {
//				post.addParameter(key, (String)params.get(key));
//			}
//			
//			jsonObj = post.requestJSON();
//			
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//	}
//	
//	@RequestMapping("/settings/group-update")
//	@ResponseBody
//	public String groupUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		
//		String requestUrl = "/setting/authority/group-update.json";
//		JSONObject jsonObj = null;
//		try {
//			PostMethod post = httpClient.httpPost(requestUrl);
//			
//			for(String key : params.keySet()) {
//				post.addParameter(key, (String)params.get(key));
//			}
//			
//			jsonObj = post.requestJSON();
//			
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//	}
//	
//	@RequestMapping("/settings/user-update") 
//	@ResponseBody
//	public String userUpdate(HttpSession session, @RequestParam Map<String,Object> params ) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		
//		String requestUrl = "/setting/authority/user-update.json";
//		JSONObject jsonObj = null;
//		try {
//			PostMethod post = httpClient.httpPost(requestUrl);
//			for(String key : params.keySet()) {
//				post.addParameter(key, (String)params.get(key));
//			}
//			
//			jsonObj = post.requestJSON();
//			
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//	}
//
//	@RequestMapping("/settings/user-delete")
//	@ResponseBody
//	public String userDelete(HttpSession session, @RequestParam String userId) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		
//		String requestUrl = "/setting/authority/user-delete.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl).
//				addParameter("userId", userId)
//				.requestJSON();
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//		
//	}
//	
//	@RequestMapping("/settings/group-delete")
//	@ResponseBody
//	public String groupDelete(HttpSession session, @RequestParam String groupId) {
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		
//		String requestUrl = "/setting/authority/group-delete.json";
//		JSONObject jsonObj = null;
//		try {
//			jsonObj = httpClient.httpPost(requestUrl).
//				addParameter("group", groupId)
//				.requestJSON();
//		} catch (Exception e) {
//			logger.error("",e);
//		}
//		
//		return jsonObj.toString();
//	}
}
