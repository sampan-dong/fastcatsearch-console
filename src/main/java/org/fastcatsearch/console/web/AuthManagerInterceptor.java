package org.fastcatsearch.console.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.fastcatsearch.console.web.http.JSONHttpClient;
import org.json.JSONObject;

public class AuthManagerInterceptor extends AuthMainInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(!super.preHandle(request, response, handler)){
			return false;
		}
		logger.debug("## AuthManagerInterceptor preHandler!!!");
		JSONHttpClient httpClient = (JSONHttpClient) request.getSession().getAttribute("httpclient");
		String getCollectionListURL = "/management/collections/collection-list";
		JSONObject collectionList = httpClient.httpGet(getCollectionListURL).request();
		logger.debug("intercept collectionList >> {}",collectionList);
		request.setAttribute("collectionList", collectionList.getJSONArray("collectionList"));
		
		String getAnalysisPluginListURL = "/management/analysis/plugin-list";
		JSONObject analysisPluginList = httpClient.httpGet(getAnalysisPluginListURL).request();
		logger.debug("intercept analysisPluginList >> {}",analysisPluginList);
		request.setAttribute("analysisPluginList", analysisPluginList.getJSONArray("pluginList"));
		
		return true;
	}
}
