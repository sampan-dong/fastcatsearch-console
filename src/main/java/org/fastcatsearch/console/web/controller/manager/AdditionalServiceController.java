package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
}
