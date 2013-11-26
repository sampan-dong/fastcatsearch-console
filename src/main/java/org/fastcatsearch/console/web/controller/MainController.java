package org.fastcatsearch.console.web.controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.fastcatsearch.console.web.http.ResponseHttpClient;
import org.fastcatsearch.console.web.http.ResponseHttpClient.AbstractMethod;
import org.jdom2.Document;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController extends AbstractController {
	private static Logger logger = LoggerFactory.getLogger(MainController.class);

	@RequestMapping("/index")
	public ModelAndView index() throws Exception {

		// TODO 로긴여부 확인.
		// 로긴되어있으면 start로, 아니면 login페이지로.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:login.html");
		// 접속에 사용할 client를 셋팅해준다.

		// mav.setViewName("start");
		return mav;
	}
	
	@RequestMapping("/login")
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}

	@RequestMapping(value = "/doLogin", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView doLogin(HttpSession session, @RequestParam("host") String host, @RequestParam("userId") String userId,
			@RequestParam("password") String password) throws Exception {

		logger.debug("login {} : {}:{}", host, userId, password);

		if (host == null || host.length() == 0 || userId.length() == 0 || password.length() == 0) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:login.html");
			return mav;
		}

		// TODO 로그인되었다면 바로 start.html로 간다.

		ResponseHttpClient httpClient = new ResponseHttpClient(host);
		JSONObject loginResult = httpClient.httpPost("/management/login").addParameter("id", userId).addParameter("password", password)
				.requestJSON();
		logger.debug("loginResult > {}", loginResult);
		if (loginResult != null && loginResult.getInt("status") == 0) {
			// 로그인이 올바를 경우 메인 화면으로 이동한다.
			ModelAndView mav = new ModelAndView();
			mav.setViewName("redirect:main/start.html");
			String userName = loginResult.getString("name");
			session.setAttribute("_userName", userName);
			session.setAttribute("httpclient", httpClient);
			return mav;
		}

		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;

	}

	@RequestMapping("/main/logout")
	public ModelAndView logout(HttpSession session) throws Exception {

		//세션삭제를 처리한다.
		ResponseHttpClient httpClient = (ResponseHttpClient) session.getAttribute("httpclient");
		if(httpClient != null){
			httpClient.close();
		}
		session.invalidate();
		// 로긴 화면으로 이동한다.
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login");
		return mav;
	}

	@RequestMapping("/main/start")
	public ModelAndView viewStart() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("start");
		return mav;
	}

	@RequestMapping("/main/dashboard")
	public ModelAndView dashboard() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("dashboard");
		return mav;
	}

	@RequestMapping("/main/search")
	public ModelAndView search() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("search");
		return mav;
	}

	@RequestMapping("/main/search/config")
	public ModelAndView searchConfig() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("searchConfig");
		return mav;
	}

	@RequestMapping("/main/settings")
	public ModelAndView settings() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("settings");
		return mav;
	}

	/**
	 * 검색엔진에 proxy로 호출해준다. &uri=/a/b/c&param1=1&param=2와 같이 파라미터를 전달받으면 재조합해서 uri로 호출한다. 
	 * Get,Post모두 가능. 
	 * */
	@RequestMapping("/main/request")
	@ResponseBody
	public String request(HttpServletRequest request) throws Exception {

		String uri = request.getParameter("uri");
		String dataType = request.getParameter("dataType");
		
		//만약 ? 가 붙어있다면 제거한다.
		int parameterStart = uri.indexOf('?');
		if(parameterStart > 0){
			uri = uri.substring(0, parameterStart);
		}
		
		ResponseHttpClient httpClient = (ResponseHttpClient) request.getSession().getAttribute("httpclient");

		
		AbstractMethod abstractMethod = null;
		if (request.getMethod().equalsIgnoreCase("GET")) {
			abstractMethod = httpClient.httpGet(uri);
		}else if (request.getMethod().equalsIgnoreCase("POST")) {
			abstractMethod = httpClient.httpPost(uri);
		}else{
			//error
			logger.error("Unknown http method >> {}", request.getMethod());
		}
		
		Enumeration<String> enumeration = request.getParameterNames();
		while (enumeration.hasMoreElements()) {
			String key = enumeration.nextElement();
			String value = request.getParameter(key);
			//uri파라미터를 제외한 모든 파라미터를 재전달한다.
			if(!key.equals("uri")){
				abstractMethod.addParameter(key, value);
			}
		}
		
		if(dataType != null){
			if(dataType.equalsIgnoreCase("text")){
				return abstractMethod.requestText();
			}else if(dataType.equalsIgnoreCase("xml")){ 
				try {
					//if you using XML Document object you'll get message below
					//"Document: No DOCTYPE declaration, Root is [Element: ]]"
					//so. use requestText method
					String document = abstractMethod.requestText();
					if(document == null){
						return "";
					}else{
						return document;
					}
				} catch (Exception e) {
					logger.error("", e);
					return "";
				}
			}
		}
		
		//default json
		JSONObject result = null;
		try {
			result = abstractMethod.requestJSON();
			if(result == null){
				return "";
			}else{
				return result.toString();
			}
		} catch (Exception e) {
			logger.error("", e);
			return "";
		}
		
	}

}
