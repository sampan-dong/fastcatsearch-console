package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/dictionary")
public class DictionaryController {
	private static Logger logger = LoggerFactory.getLogger(DictionaryController.class);
	
	@RequestMapping("/{analysisId}/index")
	public ModelAndView index(@PathVariable String analysisId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/index");
		mav.addObject("analysisId", analysisId);
		return mav;
	}
	
	@RequestMapping("/{analysisId}/set/list")
	public ModelAndView setDictionary(HttpSession session, @PathVariable String analysisId, @RequestParam String dictionaryId
			, @RequestParam(defaultValue = "0") int start, @RequestParam(required = false) int length
			, @RequestParam(required = false) String keyword) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/dictionary/list.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.addParameter("dictionaryId", dictionaryId)
					.addParameter("start", String.valueOf(start))
					.addParameter("length", String.valueOf(length))
					.addParameter("keyword", keyword)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/setDictionary");
		mav.addObject("analysisId", analysisId);
		mav.addObject("dictionaryId", dictionaryId);
		mav.addObject("list", jsonObj);
		mav.addObject("start", start);
		mav.addObject("length", length);
		mav.addObject("keyword", keyword);
		return mav;
	}
}
