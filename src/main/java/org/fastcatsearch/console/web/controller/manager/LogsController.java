package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/logs")
public class LogsController {
	
	@RequestMapping("notifications")
	public ModelAndView notifications() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/notifications");
		return mav;
	}
	
	@RequestMapping("exceptions")
	public ModelAndView exceptions() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/exceptions");
		return mav;
	}
	
	@RequestMapping("tasks")
	public ModelAndView tasks() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/logs/tasks");
		return mav;
	}
}
