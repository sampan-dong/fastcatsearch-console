package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.jdom2.Document;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/manager/collections/{collectionId}")
public class CollectionsController {
	
	private static Logger logger = LoggerFactory.getLogger(CollectionsController.class);
	
	@RequestMapping("/schema")
	public ModelAndView schema(HttpSession session, @PathVariable String collectionId, @RequestParam(defaultValue="fields", required=false) String tab) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/schema.xml";
		Document document = null;
		try {
			document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/schema");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		mav.addObject("tab", tab);
		return mav;
	}
	
	@RequestMapping("/data")
	public ModelAndView data(@PathVariable String collectionId, @RequestParam("shardId") String shardId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/data");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/datasource")
	public ModelAndView datasource(@PathVariable String collectionId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasource");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/datasource/file")
	public ModelAndView datasourceFile(@PathVariable String collectionId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceFile");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/datasource/file/edit")
	public ModelAndView datasourceFileEdit(@PathVariable String collectionId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceFileEdit");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/datasource/db")
	public ModelAndView datasourceDB(@PathVariable String collectionId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasourceDB");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/shard")
	public ModelAndView shard(@PathVariable String collectionId) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/shard");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/indexing")
	public ModelAndView indexing(HttpSession session, @PathVariable String collectionId) {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/indexing-status";
		JSONObject indexingStatus = null;
		try {
			indexingStatus = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		logger.debug("indexingStatus >> {}",indexingStatus);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexing");
		mav.addObject("collectionId", collectionId);
		mav.addObject("indexingStatus", indexingStatus);
		return mav;
	}
	
	@RequestMapping("/config")
	public ModelAndView settings(HttpSession session, @PathVariable String collectionId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/config.xml";
		Document document = null;
		try {
			document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/config");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		return mav;
	}
}
