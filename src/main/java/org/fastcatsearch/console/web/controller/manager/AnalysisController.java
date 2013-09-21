package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/analysis")
public class AnalysisController {

	@RequestMapping("/plugin")
	public ModelAndView plugin() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/plugin");
		return mav;
	}
	
	@RequestMapping("/{id}/index")
	public ModelAndView view() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/index");
		return mav;
	}
}
