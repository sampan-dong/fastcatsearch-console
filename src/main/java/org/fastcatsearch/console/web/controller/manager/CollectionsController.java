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
	public ModelAndView data(HttpSession session, @PathVariable String collectionId, @RequestParam("shardId") String shardId
			, @RequestParam(defaultValue = "1") Integer pageNo) {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/index-data.json";
		JSONObject indexData = null;
		try {
			indexData = httpClient.httpGet(requestUrl)
					.addParameter("collectionId", collectionId)
					.addParameter("shardId", shardId)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		logger.debug("indexData >> {}",indexData);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/data");
		mav.addObject("collectionId", collectionId);
		mav.addObject("shardId", shardId);
		mav.addObject("start", start);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("indexDataResult", indexData);
		return mav;
	}
	
	@RequestMapping("/datasource")
	public ModelAndView datasource(HttpSession session, @PathVariable String collectionId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/datasource.xml";
		Document document = null;
		try {
			document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasource");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		return mav;
	}
	
	@RequestMapping("/shard")
	public ModelAndView shard(HttpSession session, @PathVariable String collectionId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/shardList.xml";
		Document document = null;
		try {
			document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/shard");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		return mav;
	}
	
	@RequestMapping("/indexing")
	public ModelAndView indexing(HttpSession session, @PathVariable String collectionId) {
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/indexing-status.json";
		JSONObject indexingStatus = null;
		try {
			indexingStatus = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		logger.debug("indexingStatus >> {}",indexingStatus);
		
		requestUrl = "/management/collections/indexing-result.json";
		JSONObject indexingResult = null;
		try {
			indexingResult = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		logger.debug("indexingResult >> {}",indexingResult);
		
		requestUrl = "/management/collections/indexing-schedule.xml";
		Document indexingSchedule = null;
		try {
			indexingSchedule = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		} catch (Exception e) {
			logger.error("", e);
		}
		logger.debug("indexingSchedule >> {}",indexingSchedule);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexing");
		mav.addObject("collectionId", collectionId);
		mav.addObject("indexingStatus", indexingStatus);
		mav.addObject("indexingResult", indexingResult.getJSONObject("indexingResult"));
		mav.addObject("indexingSchedule", indexingSchedule);
		return mav;
	}
	
	@RequestMapping("/indexing/history")
	public ModelAndView setDictionary(HttpSession session, @PathVariable String collectionId
			, @RequestParam(defaultValue = "1") Integer pageNo) {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE + 1;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/indexing-history.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("collectionId", collectionId)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexingHistory");
		mav.addObject("collectionId", collectionId);
		mav.addObject("start", start);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("list", jsonObj);
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
