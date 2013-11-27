package org.fastcatsearch.console.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

public class AbstractController {
	
	protected static Logger logger = LoggerFactory.getLogger(AbstractController.class);
	
	/*
	 * exception페이지로 이동한다.
	 * */
	@ExceptionHandler(Throwable.class)
	public ModelAndView handleAllException(Exception ex) {
 
		ModelAndView model = new ModelAndView("error");
		model.addObject("exception", ex);
		return model;
 
	}
}
