package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/dictionary")
public class DictionaryController {
	
	@RequestMapping("/{id}/index")
	public ModelAndView index() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/index");
		return mav;
	}
}
