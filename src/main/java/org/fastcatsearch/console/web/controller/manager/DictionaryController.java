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
@RequestMapping("/manager/dictionary/{analysisId}")
public class DictionaryController {
	private static Logger logger = LoggerFactory.getLogger(DictionaryController.class);
	
	@RequestMapping("/index")
	public ModelAndView index(HttpSession session, @PathVariable String analysisId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/dictionary/overview.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/index");
		mav.addObject("analysisId", analysisId);
		mav.addObject("list", jsonObj.getJSONArray("overview"));
		return mav;
	}
	
	@RequestMapping("/overview")
	public ModelAndView overview(HttpSession session, @PathVariable String analysisId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/dictionary/overview.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/overview");
		mav.addObject("analysisId", analysisId);
		mav.addObject("list", jsonObj.getJSONArray("overview"));
		return mav;
	}
	
	
	@RequestMapping("/{dictionaryType}/list")
	public ModelAndView listDictionary(HttpSession session, @PathVariable String analysisId, @PathVariable String dictionaryType
			, @RequestParam String dictionaryId
			, @RequestParam(defaultValue = "1") Integer pageNo
			, @RequestParam(required = false) String keyword
			, @RequestParam(required = false) String searchColumn
			, @RequestParam(required = false) Boolean exactMatch
			, @RequestParam(required = false) Boolean isEditable
			, @RequestParam String targetId, @RequestParam(required = false) String deleteIdList) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		Integer deletedSize = 0; 
		logger.debug("deleteIdList >> {}", deleteIdList);
		if(deleteIdList != null && deleteIdList.length() > 0){
			String requestUrl = "/management/dictionary/delete.json";
			try {
				jsonObj = httpClient.httpPost(requestUrl)
						.addParameter("pluginId", analysisId)
						.addParameter("dictionaryId", dictionaryId)
						.addParameter("deleteIdList", deleteIdList)
						.requestJSON();
				
				deletedSize = jsonObj.getInt("result");
			} catch (Exception e) {
				logger.error("", e);
			}
		}
		
		
		
		String requestUrl = "/management/dictionary/list.json";
		
		int PAGE_SIZE = 10;
		if(dictionaryType.equals("set")){
			PAGE_SIZE = 40;
		}
		int start = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE + 1;
		}
		
		try {
			String searchKeyword = null;
			if(exactMatch){
				searchKeyword = keyword;
			}else{
				if(keyword != null && keyword.length() > 0){
					searchKeyword = "%25" + keyword + "%25";
				}
			}
			if(searchColumn.equals("_ALL")){
				searchColumn = null;
			}
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.addParameter("dictionaryId", dictionaryId)
					.addParameter("start", String.valueOf(start))
					.addParameter("length", String.valueOf(PAGE_SIZE))
					.addParameter("search", searchKeyword)
					.addParameter("searchColumns", searchColumn)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		if(isEditable != null && isEditable.booleanValue()){
			mav.setViewName("manager/dictionary/" + dictionaryType + "DictionaryEdit");
		}else{
			mav.setViewName("manager/dictionary/" + dictionaryType + "Dictionary");
		}
		mav.addObject("analysisId", analysisId);
		mav.addObject("dictionaryId", dictionaryId);
		mav.addObject("list", jsonObj);
		mav.addObject("start", start);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("keyword", keyword);
		mav.addObject("searchColumn", searchColumn);
		mav.addObject("exactMatch", exactMatch);
		mav.addObject("targetId", targetId);
		mav.addObject("deletedSize", deletedSize);
		
		return mav;
	}
}
