package org.fastcatsearch.console.web.controller.manager;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/test")
public class TestController extends AbstractController {
	
	@RequestMapping("search")
	public ModelAndView search() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/test/search");
		return mav;
	}
	
	@RequestMapping("searchResult")
	public ModelAndView searchResult() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/test/searchResult");
		return mav;
	}
}
