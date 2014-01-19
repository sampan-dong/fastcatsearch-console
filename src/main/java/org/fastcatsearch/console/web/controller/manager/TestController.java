package org.fastcatsearch.console.web.controller.manager;

import java.net.URLDecoder;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.fastcatsearch.console.web.http.ResponseHttpClient.AbstractMethod;
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
	public ModelAndView searchResult(HttpSession session, @RequestParam(required = false) String host, @RequestParam String requestUri
			, @RequestParam String cn, @RequestParam String fl, @RequestParam String se, @RequestParam String ft
			, @RequestParam String gr, @RequestParam String ra, @RequestParam String ht, @RequestParam String sn
			, @RequestParam String ln, @RequestParam String so, @RequestParam String timeout, @RequestParam String ud) throws Exception {
		
		ResponseHttpClient tmpHttpClient = null;
		try {
			PostMethod postMethod = null;
			if (host != null && host.length() > 0) {
				tmpHttpClient = new ResponseHttpClient(host);
				postMethod = tmpHttpClient.httpPost(requestUri);
			} else {
				postMethod = (PostMethod) httpPost(session, requestUri);
			}

			postMethod.addParameter("cn", cn.trim());
			postMethod.addParameter("fl", fl.trim());
			postMethod.addParameter("se", se.trim());
			postMethod.addParameter("ft", ft.trim());
			postMethod.addParameter("gr", gr.trim());
			postMethod.addParameter("ra", ra.trim());
			postMethod.addParameter("ht", ht.trim());
			postMethod.addParameter("sn", sn.trim());
			postMethod.addParameter("ln", ln.trim());
			postMethod.addParameter("so", so.trim());
			postMethod.addParameter("timeout", timeout.trim());
			postMethod.addParameter("ud", ud.trim());

			return searchResult(postMethod);
		} finally {
			if (tmpHttpClient != null) {
				tmpHttpClient.close();
			}
		}
	}
	
	@RequestMapping("searchQueryResult")
	public ModelAndView searchQueryResult(HttpSession session, @RequestParam(required = false) String host, @RequestParam String requestUri, @RequestParam String queryString) throws Exception {
		ResponseHttpClient tmpHttpClient = null;
		try {
			PostMethod postMethod = null;
			if (host != null && host.length() > 0) {
				tmpHttpClient = new ResponseHttpClient(host);
				postMethod = tmpHttpClient.httpPost(requestUri);
			} else {
				postMethod = (PostMethod) httpPost(session, requestUri);
			}

			for (String pair : queryString.split("&")) {
				int eq = pair.indexOf("=");
				if (eq < 0) {
					postMethod.addParameter(pair, "");
				} else {
					// key=value
					String key = pair.substring(0, eq);
					String value = pair.substring(eq + 1);
					try {
						String decodedValue = URLDecoder.decode(value, "utf-8");
						postMethod.addParameter(key, decodedValue);
					} catch (Exception e) {
						postMethod.addParameter(key, value);
					}

				}
			}
			return searchResult(postMethod);
		} finally {
			if (tmpHttpClient != null) {
				tmpHttpClient.close();
			}
		}
	}
	
	public ModelAndView searchResult(AbstractMethod method) throws Exception {
		
		JSONObject jsonObj = method.requestJSON();
		
		ModelAndView mav = new ModelAndView();
		
		int status = -1;
		if(jsonObj != null){
			status = jsonObj.getInt("status");
			
			if(status == 0){
				//OK
			}else{
				//fail
			}
			
			mav.addObject("queryString", method.getQueryString());
			mav.addObject("searchResult", jsonObj);
			
		}else{
			//Exception
		}
		
		
		mav.setViewName("manager/test/searchResult");
		return mav;
	}
	
	
	@RequestMapping("db")
	public ModelAndView db() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/test/db");
		return mav;
	}
	
}
