package org.fastcatsearch.console.web.controller.manager;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.Iterator;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONWriter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
	
	@RequestMapping({"/system/list", "SYSTEM/list"})
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
		if(dictionaryType.equalsIgnoreCase("set")){
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
			mav.setViewName("manager/dictionary/" + dictionaryType.toLowerCase() + "DictionaryEdit");
		}else{
			mav.setViewName("manager/dictionary/" + dictionaryType.toLowerCase() + "Dictionary");
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
							.addParameter("sortAsc", "true") //다운로드시에는 역순이 아닌 id 1번 부터 순서대로 파일에 기록해준다.
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
						String value = String.valueOf(obj.get(columnName));
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
	public void uploadDictionary(HttpSession session, MultipartHttpServletRequest request, HttpServletResponse response, @PathVariable String analysisId, @PathVariable String dictionaryType
			, @RequestParam String dictionaryId) {
		
		Iterator<String> itr = request.getFileNames();
		String fileName = null;
		try{
			fileName = itr.next();
		}catch(Exception ignore){
		}
		logger.debug("fileName {}", fileName);
		
		boolean isSuccess = false;
		String errorMessage = null;
		int totalCount = 0;
		
		if(fileName != null){
			
			MultipartFile multipartFile = request.getFile(fileName);
			logger.debug("uploaded {}", multipartFile.getOriginalFilename());
			
			BufferedReader reader = null;
			
			try {
				// just temporary save file info into ufile
				logger.debug("len {}", multipartFile.getBytes().length);
				logger.debug("getBytes {}", new String(multipartFile.getBytes()));
				logger.debug("getContentType {}", multipartFile.getContentType());
				logger.debug("getOriginalFilename {}", multipartFile.getOriginalFilename());
	
				String contentType = multipartFile.getContentType();
				
				if(!contentType.contains("text")){
					
					isSuccess = false;
					errorMessage = "File must be plain text.";
				}else{
			
					ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
					
					String requestUrl = "/management/dictionary/bulkPut.json";
				
					
					int bulkSize = 100;
					
					reader = new BufferedReader(new InputStreamReader(multipartFile.getInputStream()));
					
					StringBuilder list = new StringBuilder();
					int count = 0;
					
					String line = null;
					do {
						while((line = reader.readLine()) != null){
							if(list.length() > 0){
								list.append("\n");
							}
							list.append(line);
							count++;
							if(count == bulkSize){
								break;
							}
						}
						
						if(count > 0){
							try {
								JSONObject jsonObj = httpClient.httpPost(requestUrl)
										.addParameter("pluginId", analysisId)
										.addParameter("dictionaryId", dictionaryId)
										.addParameter("entryList", list.toString())
										.requestJSON();
								
								list = new StringBuilder();
								
								if(!jsonObj.getBoolean("success")){
									throw new IOException(jsonObj.getString("errorMessage"));
								}
								
								totalCount += jsonObj.getInt("count");
								//초기화.
								count = 0;
							} catch (Exception e) {
								throw new IOException(e);
							}
						}
						
					} while(line != null);
					
				}
				
				isSuccess = true;
				
			} catch (IOException e) {
				isSuccess = false;
				errorMessage = e.getMessage();
			} finally {
				if(reader != null){
					try {
						reader.close();
					} catch (IOException ignore) {
					}
				}
			}
			
		}else{
			isSuccess = false;
			errorMessage = "Filename is empty.";
		}
		
		try{
			Writer writer = response.getWriter();
			JSONWriter jsonWriter = new JSONWriter(writer);
			jsonWriter.object()
				.key("success").value(isSuccess)
				.key("count").value(totalCount);
			
			if(errorMessage != null){
				jsonWriter.key("errorMessage").value(errorMessage);
			}
			jsonWriter.endObject();
			writer.close();
		}catch(Exception e){
			logger.error("", e);
		}
	
	}
}
