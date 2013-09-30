package org.fastcatsearch.console.web.http;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.SocketException;
import java.net.URI;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.Consts;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JSONHttpClient {
	private static Logger logger = LoggerFactory.getLogger(JSONHttpClient.class);

	private CloseableHttpClient httpclient;
	private String urlPrefix;
	private boolean isActive;

	private static final ResponseHandler<JSONObject> responseHandler = new JSONResponseHandler();

	public JSONHttpClient(String host) {

		PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
		cm.setMaxTotal(100);
		BasicCookieStore cookieStore = new BasicCookieStore();
		httpclient = HttpClients.custom().setConnectionManager(cm).setDefaultCookieStore(cookieStore).build();

		urlPrefix = "http://" + host;
		isActive = true;

	}

	public boolean isActive() {
		return isActive;
	}

	private String getURL(String uri) {
		return urlPrefix + uri;
	}

	public GetMethod httpGet(String uri) {
		return new GetMethod(this, getURL(uri));
	}

	public PostMethod httpPost(String uri) {
		return new PostMethod(this, getURL(uri));
	}

	public void close() {
		if (httpclient != null) {
			try {
				httpclient.close();
			} catch (IOException e) {
				logger.error("error close httpclient", e);
			}
			httpclient = null;
		}
		isActive = false;
	}

	public static class GetMethod {
		JSONHttpClient jsonHttpClient;
		String url;
		String queryString;
		
		public GetMethod(JSONHttpClient jsonHttpClient, String url) {
			this.jsonHttpClient = jsonHttpClient;
			this.url = url;
		}

		public JSONObject request() throws ClientProtocolException, IOException {
			HttpGet httpget = null;
			
			if(queryString != null){
				httpget = new HttpGet(url + "?" + queryString);
			}else{
				httpget = new HttpGet(url);
			}
			logger.debug("request >> {}", httpget);
			try {
				return jsonHttpClient.httpclient.execute(httpget, responseHandler);
			}catch(SocketException e){
				logger.debug("httpclient socket error! >> {}", e.getMessage());
				jsonHttpClient.close();
			}
			return null;
		}
		
		public GetMethod addParameter(String key, String value) {
			if (queryString == null) {
				queryString = "";
			}
			try {
				queryString += (key + "=" + URLEncoder.encode(value, "UTF-8"));
			} catch (UnsupportedEncodingException e) {
				logger.error("", e);
			}

			return this;
		}

	}

	public static class PostMethod {
		JSONHttpClient jsonHttpClient;
		HttpPost httpost;
		private List<NameValuePair> nvps;

		public PostMethod(JSONHttpClient jsonHttpClient, String url) {
			this.jsonHttpClient = jsonHttpClient;
			httpost = new HttpPost(url);
		}

		public JSONObject request() throws ClientProtocolException, IOException {
			if (nvps != null) {
				httpost.setEntity(new UrlEncodedFormEntity(nvps, Consts.UTF_8));
			}

			logger.debug("request >> {}", httpost);
			try {
				return jsonHttpClient.httpclient.execute(httpost, responseHandler);
			}catch(SocketException e){
				logger.debug("httpclient socket error! >> {}", e.getMessage());
				jsonHttpClient.close();
			}
			return null;
		}

		public PostMethod addParameter(String key, String value) {
			if (nvps == null) {
				nvps = new ArrayList<NameValuePair>();
			}

			nvps.add(new BasicNameValuePair(key, value));

			return this;
		}

	}
}
