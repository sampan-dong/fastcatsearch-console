package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.jdom2.Document;
import org.jdom2.Element;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/analysis")
public class AnalysisController extends AbstractController {
	private static Logger logger = LoggerFactory.getLogger(AnalysisController.class);

	@RequestMapping("/plugin")
	public ModelAndView plugin(HttpSession session) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String getAnalysisPluginListURL = "/management/analysis/plugin-list";
		JSONObject jsonObj = httpClient.httpGet(getAnalysisPluginListURL).requestJSON();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/plugin");
		mav.addObject("analysisPluginOverview", jsonObj.getJSONArray("pluginList"));
		return mav;
	}

	@RequestMapping("/{analysisId}/index")
	public ModelAndView view(HttpSession session, @PathVariable String analysisId) throws Exception {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String getAnalysisPluginSettingURL = "/management/analysis/plugin-setting.xml?pluginId="+analysisId;
		Document document = httpClient.httpGet(getAnalysisPluginSettingURL).requestXML();
		Element rootElement = document.getRootElement();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/index");
		mav.addObject("analysisId", analysisId);
		mav.addObject("setting",rootElement);
		return mav;
	}
	
	@RequestMapping("/{analysisId}/analyzeTools")
	public ModelAndView analyzeTools(HttpSession session, @PathVariable String analysisId) throws Exception {
		
//		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
//		String getAnalysisPluginSettingURL = "/management/analysis/plugin-setting.xml?pluginId="+analysisId;
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/analyzeTools");
		mav.addObject("analysisId", analysisId);
		mav.addObject("type","");
		return mav;
	}
}
