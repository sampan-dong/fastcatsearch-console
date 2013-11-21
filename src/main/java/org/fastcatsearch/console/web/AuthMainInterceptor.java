package org.fastcatsearch.console.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthMainInterceptor extends HandlerInterceptorAdapter {
	
	protected static Logger logger = LoggerFactory.getLogger(AuthMainInterceptor.class);
			
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) request.getSession().getAttribute("httpclient");
		
		if(httpClient == null || !httpClient.isActive()){
			//연결에러..
			
			response.sendRedirect(request.getContextPath() + "/login.html");
			return false;
		}else{
			// /service/isAlive
			String getCollectionListURL = "/service/isAlive";
			JSONObject isAlive = httpClient.httpGet(getCollectionListURL).requestJSON();
			if(isAlive == null){
				response.sendRedirect(request.getContextPath() + "/login.html");
			}
		}
		
		return true;
	}

//	@Override
//	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
//
//	}
//
//	@Override
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
//	}
}
