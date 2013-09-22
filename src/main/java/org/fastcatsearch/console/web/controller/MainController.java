package org.fastcatsearch.console.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	@RequestMapping("/index")
	public ModelAndView index() {
		
		//TODO 로긴여부 확인.
		//로긴되어있으면 start로, 아니면 login페이지로.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		//mav.setViewName("start");
		return mav;
	}
	
	@RequestMapping("/user/login")
	public ModelAndView login() {
		
		//TODO 로그인 적합성 체크
		
		//로그인이 올바를 경우 메인 화면으로 이동한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("start");
		return mav;
	}
	
	@RequestMapping("/user/logout")
	public ModelAndView logout() {
		
		//TODO 세션삭제를 처리한다.
		
		//로긴 화면으로 이동한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}
	
	@RequestMapping("/start")
	public ModelAndView viewStart() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("start");
		return mav;
	}
	
	@RequestMapping("/dashboard")
	public ModelAndView dashboard() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dashboard");
		return mav;
	}
	
	@RequestMapping("/search")
	public ModelAndView search() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("search");
		return mav;
	}
	
	@RequestMapping("/search/config")
	public ModelAndView searchConfig() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchConfig");
		return mav;
	}
	
	@RequestMapping("/settings")
	public ModelAndView settings() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("settings");
		return mav;
	}
	
	@RequestMapping("/manager")
	public ModelAndView viewManagerIndex() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/index");
		return mav;
	}
	
}
