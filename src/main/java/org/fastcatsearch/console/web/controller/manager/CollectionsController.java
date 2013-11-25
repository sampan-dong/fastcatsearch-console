package org.fastcatsearch.console.web.controller.manager;

import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.controller.AbstractController;
import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.jdom2.Document;
import org.json.JSONArray;
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
public class CollectionsController extends AbstractController {
	
	private static Logger logger = LoggerFactory.getLogger(CollectionsController.class);
	
	@RequestMapping("/schema")
	public ModelAndView schema(HttpSession session, @PathVariable String collectionId, @RequestParam(defaultValue="fields", required=false) String tab) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/schema.xml";
		Document document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/schema");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		mav.addObject("tab", tab);
		return mav;
	}
	
	@RequestMapping("/data")
	public ModelAndView data(HttpSession session, @PathVariable String collectionId) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/data");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
			
	@RequestMapping("/dataRaw")
	public ModelAndView dataRaw(HttpSession session, @PathVariable String collectionId
			, @RequestParam(defaultValue = "1") Integer pageNo, @RequestParam String targetId) throws Exception {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
//		String requestUrl = "/management/collections/index-data-status.json";
//		JSONObject indexDataStatus = httpClient.httpGet(requestUrl)
//					.addParameter("collectionId", collectionId)
//					.requestJSON();
//		logger.debug("indexDataStatus >> {}", indexDataStatus);
		
		String requestUrl = "/management/collections/index-data.json";
		JSONObject indexData = httpClient.httpGet(requestUrl)
					.addParameter("collectionId", collectionId)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		logger.debug("indexData >> {}",indexData);
		JSONArray list = indexData.getJSONArray("indexData");
		int realSize = list.length();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/dataRaw");
		mav.addObject("collectionId", collectionId);
		mav.addObject("start", start + 1);
		mav.addObject("end", start + realSize);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("indexDataResult", indexData);
		mav.addObject("targetId", targetId);
		return mav;
	}
	
	@RequestMapping("/dataSearch")
	public ModelAndView dataSearch(HttpSession session, @PathVariable String collectionId,
			@RequestParam(value="se", required=false) String se, @RequestParam(value="ft", required=false) String ft, @RequestParam(value="gr", required=false) String gr,
			@RequestParam(defaultValue = "1") Integer pageNo, @RequestParam String targetId) throws Exception {
		
		int PAGE_SIZE = 10;
		int start = (pageNo - 1) * PAGE_SIZE + 1;
			
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		String requestUrl = "/management/collections/index-data-status.json";
		JSONObject indexDataStatus = httpClient.httpGet(requestUrl)
					.addParameter("collectionId", collectionId)
					.requestJSON();
		logger.debug("indexDataStatus >> {}", indexDataStatus);
		
		requestUrl = "/service/search.json";
		JSONObject searchResult = httpClient.httpGet(requestUrl)
					.addParameter("cn", collectionId)
					.addParameter("fl", "Title") //FIXME
					.addParameter("se", se)
					.addParameter("ft", ft)
					.addParameter("gr", gr)
					.addParameter("sn", String.valueOf(start))
					.addParameter("ln", String.valueOf(PAGE_SIZE))
					.requestJSON();
		logger.debug("searchResult >> {}",searchResult);
		JSONArray list = searchResult.getJSONArray("result");
		int realSize = list.length();
		//TODO group_result.group_list
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/dataSearch");
		mav.addObject("collectionId", collectionId);
		mav.addObject("start", start);
		mav.addObject("end", start + realSize - 1);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("searchResult", searchResult);
		mav.addObject("indexDataStatus", indexDataStatus);
		mav.addObject("targetId", targetId);
		return mav;
	}
	
	@RequestMapping("/datasource")
	public ModelAndView datasource(HttpSession session, @PathVariable String collectionId) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/datasource.xml";
		Document document = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/datasource");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		return mav;
	}
	
	@RequestMapping("/indexing")
	public ModelAndView indexing(HttpSession session, @PathVariable String collectionId) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexing");
		mav.addObject("collectionId", collectionId);
		return mav;
	}
	
	@RequestMapping("/indexing/status")
	public ModelAndView indexingStatus(HttpSession session, @PathVariable String collectionId) throws Exception {
		
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
		JSONObject indexingResult = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestJSON();
		logger.debug("indexingResult >> {}",indexingResult);
		
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexingStatus");
		mav.addObject("collectionId", collectionId);
		mav.addObject("indexingStatus", indexingStatus);
		mav.addObject("indexingResult", indexingResult.getJSONObject("indexingResult"));
		return mav;
	}
	
	@RequestMapping("/indexing/schedule")
	public ModelAndView indexingSchedule(HttpSession session, @PathVariable String collectionId) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/indexing-schedule.xml";
		Document indexingSchedule = httpClient.httpGet(requestUrl).addParameter("collectionId", collectionId).requestXML();
		logger.debug("indexingSchedule >> {}",indexingSchedule);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/indexingSchedule");
		mav.addObject("collectionId", collectionId);
		mav.addObject("indexingSchedule", indexingSchedule);
		return mav;
	}
	
	@RequestMapping("/indexing/history")
	public ModelAndView indexingHistory(HttpSession session, @PathVariable String collectionId
			, @RequestParam(defaultValue = "1") Integer pageNo) throws Exception {
		
		int PAGE_SIZE = 10;
		int start = 0;
		int end = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE + 1;
			end = start + PAGE_SIZE - 1;
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/indexing-history.json";
		JSONObject jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("collectionId", collectionId)
					.addParameter("start", String.valueOf(start))
					.addParameter("end", String.valueOf(end))
					.requestJSON();
		
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
	public ModelAndView settings(HttpSession session, @PathVariable String collectionId) throws Exception {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/collections/config.xml";
		Document document = httpClient.httpPost(requestUrl).addParameter("collectionId", collectionId).requestXML();
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/collections/config");
		mav.addObject("collectionId", collectionId);
		mav.addObject("document", document);
		return mav;
	}
	
}
