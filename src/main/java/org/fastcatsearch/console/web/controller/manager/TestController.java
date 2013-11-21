package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.fastcatsearch.console.web.http.ResponseHttpClient.PostMethod;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/test")
public class TestController extends AbstractController {
	
	@RequestMapping("search")
	public ModelAndView search() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/test/search");
		return mav;
	}
	
	@RequestMapping("searchResult")
	public ModelAndView searchResult(HttpSession session, @RequestParam String requestUri, @RequestParam String queryString) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		try {
			PostMethod postMethod = (PostMethod) httpClient.httpPost(requestUri).addParameterString(queryString);
			jsonObj = postMethod.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		
		int status = -1;
		if(jsonObj != null){
			status = jsonObj.getInt("status");
			
			if(status == 0){
				//OK
				
				
			}else{
				//fail
				
			}
			mav.addObject("queryString", queryString);
			mav.addObject("searchResult", jsonObj);
			
		}else{
			//Exception
			
			
		}
		
		
		mav.setViewName("manager/test/searchResult");
		return mav;
	}
}
