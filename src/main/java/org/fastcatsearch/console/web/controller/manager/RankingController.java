package org.fastcatsearch.console.web.controller.manager;

import org.apache.http.client.ClientProtocolException;
import org.fastcatsearch.console.web.controller.AbstractController;
import org.jdom2.Document;
import org.jdom2.Element;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/manager/ranking")
public class RankingController extends AbstractController {
	
	@RequestMapping("/overview")
	public ModelAndView overview(HttpSession session) throws Exception {
		String getAnalysisPluginListURL = "/management/ranking/profile-list";
		JSONObject jsonObj = httpPost(session, getAnalysisPluginListURL).requestJSON();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/ranking/overview");
		mav.addObject("rankingProfileOverview", jsonObj.getJSONArray("profileList"));
		return mav;
	}

	@RequestMapping("/{profileId}/index")
	public ModelAndView index(HttpSession session, @PathVariable String profileId) throws Exception {
		
		String getProfileSettingURL = "/management/ranking/profile-setting.xml";
		Document document = httpPost(session, getProfileSettingURL).addParameter("pluginId", profileId).requestXML();
		Element rootElement = document.getRootElement();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/ranking/index");
		mav.addObject("profileId", profileId);
		mav.addObject("setting",rootElement);
		logger.debug("rootElement {} >> {}", profileId, rootElement);
		return mav;
	}

	@RequestMapping("/{profileId}/keywordBoost")
	public ModelAndView keywordBoost(HttpSession session, @PathVariable String profileId) throws Exception {
		String getKeywordBoostURL = "/management/ranking/keywordBoost.json";
		JSONObject jsonObj = httpPost(session, getKeywordBoostURL)
				.addParameter("profileId", profileId).requestJSON();
				
		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/ranking/keywordBoost");
		mav.addObject("keywordBoost", jsonObj);
		return mav;
	}

	@RequestMapping("/{profileId}/searchBoost")
	public ModelAndView searchBoost(HttpSession session, @PathVariable String profileId) throws Exception {
		String getSearchBoostURL = "/management/ranking/searchBoost.json";
		JSONObject jsonObj = httpPost(session, getSearchBoostURL)
				.addParameter("profileId", profileId).requestJSON();

		ModelAndView mav = new ModelAndView();
		mav.setViewName("manager/ranking/searchBoost");
		mav.addObject("searchBoost", jsonObj);
		return mav;
	}
}
