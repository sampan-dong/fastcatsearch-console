package org.fastcatsearch.console.web.controller.manager;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.Charset;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
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
@RequestMapping("/manager/dictionary/{analysisId}")
public class DictionaryController {
	private static Logger logger = LoggerFactory.getLogger(DictionaryController.class);
	
	@RequestMapping("/index")
	public ModelAndView index(HttpSession session, @PathVariable String analysisId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/dictionary/overview.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/index");
		mav.addObject("analysisId", analysisId);
		mav.addObject("list", jsonObj.getJSONArray("overview"));
		return mav;
	}
	
	@RequestMapping("/overview")
	public ModelAndView overview(HttpSession session, @PathVariable String analysisId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		String requestUrl = "/management/dictionary/overview.json";
		JSONObject jsonObj = null;
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/overview");
		mav.addObject("analysisId", analysisId);
		mav.addObject("list", jsonObj.getJSONArray("overview"));
		return mav;
	}
	
	@RequestMapping("/system/list")
	public ModelAndView listSystemDictionary(HttpSession session, @PathVariable String analysisId,
			@RequestParam String keyword
			, @RequestParam String targetId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		String requestUrl = "/management/dictionary/system.json";
		
		try {
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.addParameter("search", keyword)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/dictionary/systemDictionary");
		mav.addObject("analysisId", analysisId);
		mav.addObject("list", jsonObj);
		mav.addObject("keyword", keyword);
		mav.addObject("targetId", targetId);
		
		return mav;
	}
	
	
	@RequestMapping("/{dictionaryType}/list")
	public ModelAndView listDictionary(HttpSession session, @PathVariable String analysisId, @PathVariable String dictionaryType
			, @RequestParam String dictionaryId
			, @RequestParam(defaultValue = "1") Integer pageNo
			, @RequestParam(required = false) String keyword
			, @RequestParam(required = false) String searchColumn
			, @RequestParam(required = false) Boolean exactMatch
			, @RequestParam(required = false) Boolean isEditable
			, @RequestParam String targetId, @RequestParam(required = false) String deleteIdList) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		Integer deletedSize = 0; 
		logger.debug("deleteIdList >> {}", deleteIdList);
		if(deleteIdList != null && deleteIdList.length() > 0){
			String requestUrl = "/management/dictionary/delete.json";
			try {
				jsonObj = httpClient.httpPost(requestUrl)
						.addParameter("pluginId", analysisId)
						.addParameter("dictionaryId", dictionaryId)
						.addParameter("deleteIdList", deleteIdList)
						.requestJSON();
				
				deletedSize = jsonObj.getInt("result");
			} catch (Exception e) {
				logger.error("", e);
			}
		}
		
		
		
		String requestUrl = "/management/dictionary/list.json";
		
		int PAGE_SIZE = 10;
		if(dictionaryType.equals("set")){
			PAGE_SIZE = 40;
		}
		int start = 0;
		
		if(pageNo > 0){
			start = (pageNo - 1) * PAGE_SIZE + 1;
		}
		
		try {
			String searchKeyword = null;
			if(exactMatch){
				searchKeyword = keyword;
			}else{
				if(keyword != null && keyword.length() > 0){
					searchKeyword = "%25" + keyword + "%25";
				}
			}
			if(searchColumn.equals("_ALL")){
				searchColumn = null;
			}
			jsonObj = httpClient.httpPost(requestUrl)
					.addParameter("pluginId", analysisId)
					.addParameter("dictionaryId", dictionaryId)
					.addParameter("start", String.valueOf(start))
					.addParameter("length", String.valueOf(PAGE_SIZE))
					.addParameter("search", searchKeyword)
					.addParameter("searchColumns", searchColumn)
					.requestJSON();
		} catch (Exception e) {
			logger.error("", e);
		}
		
		ModelAndView mav = new ModelAndView();
		if(isEditable != null && isEditable.booleanValue()){
			mav.setViewName("manager/dictionary/" + dictionaryType + "DictionaryEdit");
		}else{
			mav.setViewName("manager/dictionary/" + dictionaryType + "Dictionary");
		}
		mav.addObject("analysisId", analysisId);
		mav.addObject("dictionaryId", dictionaryId);
		mav.addObject("list", jsonObj);
		mav.addObject("start", start);
		mav.addObject("pageNo", pageNo);
		mav.addObject("pageSize", PAGE_SIZE);
		mav.addObject("keyword", keyword);
		mav.addObject("searchColumn", searchColumn);
		mav.addObject("exactMatch", exactMatch);
		mav.addObject("targetId", targetId);
		mav.addObject("deletedSize", deletedSize);
		
		return mav;
	}
	
	
	
	@RequestMapping("/{dictionaryType}/download")
	public void downloadDictionary(HttpSession session, HttpServletResponse response, @PathVariable String analysisId, @PathVariable String dictionaryType
			, @RequestParam String dictionaryId, @RequestParam(required = false) Boolean forView) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		
		String requestUrl = "/management/dictionary/list.json";
		
		int totalReadSize = 0;
		int PAGE_SIZE = 100;
		
		response.setContentType("text/plain");
		response.setCharacterEncoding("utf-8");
		if(forView != null && forView.booleanValue()){
			//다운로드 하지 않고 웹페이지에서 보여준다.
		}else{
			logger.debug("dictionaryId > {}", dictionaryId);
			response.setHeader("Content-disposition", "attachment; filename=\""+dictionaryId+".txt\"");
		}
		PrintWriter writer = null;
		try{
			writer = response.getWriter();
			int pageNo = 1;
			while(true){
				int start = 0;
				if(pageNo > 0){
					start = (pageNo - 1) * PAGE_SIZE + 1;
				}
				
				try {
					jsonObj = httpClient.httpPost(requestUrl)
							.addParameter("pluginId", analysisId)
							.addParameter("dictionaryId", dictionaryId)
							.addParameter("start", String.valueOf(start))
							.addParameter("length", String.valueOf(PAGE_SIZE))
							.requestJSON();
				} catch (Exception e) {
					logger.error("", e);
					throw new IOException(e);
				}
			
				JSONArray columnList = jsonObj.getJSONArray("columnList");
				JSONArray array = jsonObj.getJSONArray(dictionaryId);
				int readSize = array.length();
				totalReadSize += readSize;
				
				for(int i =0; i<array.length(); i++){
					JSONObject obj = array.getJSONObject(i);
					for(int j =0; j<columnList.length(); j++){
						String columnName = columnList.getString(j);
						String value = obj.getString(columnName);
						writer.append(value);
						if(j<columnList.length() - 1){
							//컬럼끼리 구분자는 탭이다.
							writer.append("\t");
						}
					}
					writer.append("\n");
					
				}
			
				int totalSize = jsonObj.getInt("totalSize");
				if(totalReadSize >= totalSize){
					break;
				}
				pageNo++;
			}
		}catch(IOException e){
			logger.error("download error", e);
		} finally {
			if(writer != null){
				writer.close();
			}
		}
	}
	
	@RequestMapping("/{dictionaryType}/upload")
	public void uploadDictionary(HttpSession session, HttpServletResponse response, @PathVariable String analysisId, @PathVariable String dictionaryType
			, @RequestParam String dictionaryId) {
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		
		JSONObject jsonObj = null;
		
		String requestUrl = "/management/dictionary/list.json";
		
		int totalReadSize = 0;
		int PAGE_SIZE = 100;
		
		PrintWriter writer = null;
		try{
			writer = response.getWriter();
			int pageNo = 1;
			while(true){
				int start = 0;
				if(pageNo > 0){
					start = (pageNo - 1) * PAGE_SIZE + 1;
				}
				
				try {
					jsonObj = httpClient.httpPost(requestUrl)
							.addParameter("pluginId", analysisId)
							.addParameter("dictionaryId", dictionaryId)
							.addParameter("start", String.valueOf(start))
							.addParameter("length", String.valueOf(PAGE_SIZE))
							.requestJSON();
				} catch (Exception e) {
					logger.error("", e);
					throw new IOException(e);
				}
			
				JSONArray columnList = jsonObj.getJSONArray("columnList");
				JSONArray array = jsonObj.getJSONArray(dictionaryId);
				int readSize = array.length();
				totalReadSize += readSize;
				
				for(int i =0; i<array.length(); i++){
					JSONObject obj = array.getJSONObject(i);
					for(int j =0; j<columnList.length(); j++){
						String columnName = columnList.getString(j);
						String value = obj.getString(columnName);
						writer.append(value);
						if(j<columnList.length() - 1){
							//컬럼끼리 구분자는 탭이다.
							writer.append("\t");
						}
					}
					writer.append("\n");
					
				}
			
				int totalSize = jsonObj.getInt("totalSize");
				if(totalReadSize >= totalSize){
					break;
				}
				pageNo++;
			}
		}catch(IOException e){
			logger.error("download error", e);
		} finally {
			if(writer != null){
				writer.close();
			}
		}
	}
}
