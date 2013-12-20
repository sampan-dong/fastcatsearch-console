package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/additional")
public class AdditionalServiceController extends AbstractController {
	
	@RequestMapping("settings")
	public ModelAndView search(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/additional/settings");
		return mav;
	}
	
	//인기검색어.
	@RequestMapping("popularKeyword")
	public ModelAndView popularKeyword(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/additional/popularKeyword");
		return mav;
	}
	
	//연관검색어.
	@RequestMapping("relateKeyword")
	public ModelAndView relateKeyword(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/additional/relateKeyword");
		return mav;
	}
	
	//키워드 추천(자동완성)
	@RequestMapping("keywordSuggestions")
	public ModelAndView keywordSuggestions(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/additional/keywordSuggestions");
		return mav;
	}
	
	//관리자가 직접 입력하는 광고성 키워드
	@RequestMapping("adKeyword")
	public ModelAndView adKeyword(HttpSession session) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/additional/adKeyword");
		return mav;
	}
	
	@RequestMapping("/{keywordType}/keywordList")
	public ModelAndView index(HttpSession session, 
			@PathVariable String keywordType, 
			@RequestParam String category, 
			@RequestParam(defaultValue="0") int start, 
			@RequestParam int length,
			@RequestParam(defaultValue="") String search) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		ModelAndView mav = null;
		
		if("relate".equals(keywordType)) {
		
			int pageNo=1;
			int pageSize=10;
			
			String requestUrl = "/management/keyword/"+keywordType+"/list.json";
			JSONObject jsonObj = httpClient.httpPost(requestUrl)
						.addParameter("category", category)
						.addParameter("start", String.valueOf(start))
						.addParameter("length", String.valueOf(length))
						.addParameter("search", search)
						.requestJSON();
			
			mav = new ModelAndView();
			mav.setViewName("manager/additional/relateKeywordList");
			mav.addObject("category", category);
			mav.addObject("list", jsonObj);
			mav.addObject("start",start);
			mav.addObject("pageNo", pageNo);
			mav.addObject("pageSize",pageSize);
		}
		return mav;
	}
}
