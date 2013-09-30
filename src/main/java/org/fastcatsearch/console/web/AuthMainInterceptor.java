package org.fastcatsearch.console.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fastcatsearch.console.web.http.JSONHttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthMainInterceptor extends HandlerInterceptorAdapter {
	
	protected static Logger logger = LoggerFactory.getLogger(AuthMainInterceptor.class);
			
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		JSONHttpClient httpClient = (JSONHttpClient) request.getSession().getAttribute("httpclient");
		System.out.println(" ********************* Request Attribute is  Pre handler "+httpClient +", handler="+handler);
		
		if(httpClient == null || !httpClient.isActive()){
			//연결에러..
			return false;
		}
		
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		System.out.println(" ******************* Request Attribute is  Post handler ");

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		System.out.println(" ****************** Request Attribute is  After completion  ");
	}
}
