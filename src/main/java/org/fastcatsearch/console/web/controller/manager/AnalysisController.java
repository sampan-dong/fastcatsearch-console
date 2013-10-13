package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/analysis")
public class AnalysisController {
	private static Logger logger = LoggerFactory.getLogger(AnalysisController.class);
	
	@RequestMapping("/plugin")
	public ModelAndView plugin(HttpSession session) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session
				.getAttribute("httpclient");
		String getAnalysisPluginListURL = "/management/analysis/plugin-list";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/plugin");
		mav.addObject("analysisPluginOverview", jsonObj.getJSONArray("pluginList"));
		return mav;
	}

	@RequestMapping("/{analysisId}/index")
	public ModelAndView view(HttpSession session,
			@PathVariable String analysisId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/index");
		mav.addObject("analysisId", analysisId);
		return mav;
	}
}
