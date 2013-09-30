package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	
	@RequestMapping("/index")
	public ModelAndView viewManagerIndex() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("manager/index");
		return mav;
	}
	
	
}
