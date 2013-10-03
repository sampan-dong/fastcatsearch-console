package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@RequestMapping("/{analysisId}/index")
	public ModelAndView view(@PathVariable String analysisId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/analysis/index");
		mav.addObject("analysisId", analysisId);
		return mav;
	}
}
