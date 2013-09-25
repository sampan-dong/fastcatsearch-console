package org.fastcatsearch.console.web.controller.manager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/collections")
public class CollectionsController {
	
	@RequestMapping("/{id}/schema")
	public ModelAndView schema() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/schema");
		return mav;
	}
	
	@RequestMapping("/{id}/data")
	public ModelAndView data() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/data");
		return mav;
	}
	
	@RequestMapping("/{id}/datasource")
	public ModelAndView datasource() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasource");
		return mav;
	}
	
	@RequestMapping("/{id}/datasource/file")
	public ModelAndView datasourceFile() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceFile");
		return mav;
	}
	
	@RequestMapping("/{id}/datasource/file/edit")
	public ModelAndView datasourceFileEdit() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceFileEdit");
		return mav;
	}
	
	@RequestMapping("/{id}/datasource/db")
	public ModelAndView datasourceDB() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceDB");
		return mav;
	}
	
	@RequestMapping("/{id}/shard")
	public ModelAndView shard() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/shard");
		return mav;
	}
	
	@RequestMapping("/{id}/indexing")
	public ModelAndView indexing() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexing");
		return mav;
	}
	
	@RequestMapping("/{id}/settings")
	public ModelAndView settings() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/settings");
		return mav;
	}
}
