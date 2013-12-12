<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
JSONObject analyzedResult = (JSONObject) request.getAttribute("analyzedResult");
String type = (String) request.getParameter("type");
String queryWords = analyzedResult.getString("query");
boolean isSuccess = analyzedResult.getBoolean("success");

if(!isSuccess){
	String errorMessage = analyzedResult.getString("errorMessage");
%>
<table class="table table-bordered table-highlight-head">
	<tbody>
		<tr>
			<td>
				<label>Error Message: </label>
				<div class="col-md-12"><%=errorMessage %></div>
			</td>
		</tr>
	</tbody>
</table>
<%
} else if(type == null || type.equalsIgnoreCase("simple")) {
	JSONArray result = analyzedResult.getJSONArray("result");
	String resultList = "";
	for(int i = 0 ; i < result.length() ; i++ ){
		resultList += result.get(i);
		if(i < result.length() - 1){
			resultList += ", ";
		}
				
	}
%>
<table class="table table-bordered table-highlight-head">
	<thead>
		<tr>
			<th style="padding: 15px 0 15px 10px;">
				<h4><%=queryWords %></h4>
			</th>
		</tr>
	</thead>	
	<tbody>
		<tr>
			<td>
				<label>1. Analyzed Terms: </label>
				<div class="col-md-12"><%=resultList %></div>
			</td>
		</tr>
		<tr>
			<td>
				<label>2. Analyzed Terms List: </label>
				<div class="col-md-12">
					<table class="table table-fixed table-bordered">
						<tr>
						<%
						int i = 0;
						for( i = 0 ; i < result.length() ; i++ ){
						%>
							<td>[<%=i+1 %>] <%=result.get(i) %></td>
						<%
							if(i > 0 && (i+1) % 5 == 0 && i < result.length() - 1){ //마지막 원소면 다음 줄을 만들필요가 없다.
								%></tr><tr><%
							}
						}
						while(i % 5 != 0){
							%><td></td><%
							i++;
						}
						%>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<%

} else if(type.equalsIgnoreCase("detail")) {
	JSONArray result = analyzedResult.getJSONArray("result");
%>							
<table class="table table-bordered table-highlight-head">
	<thead>
		<tr>
			<th style="padding: 15px 0 15px 10px;">
				<h4><%=queryWords %></h4>
			</th>
		</tr>
	</thead>	
	<tbody>
	<%
	for(int i = 0 ; i < result.length() ; i++ ){
		JSONObject object = result.getJSONObject(i);
	%>
		<tr>
			<td>
				<label><%=i+1 %>. <%=object.getString("key") %></label>
				<div class="col-md-12"><%=object.getString("value") %></div>
			</td>
		</tr>
	<%
	}
	%>
		
	<!-- 
		<tr>
			<td>
				<label>1. 전처리(쿼리패턴): 가격비교 </label>
				<div class="col-md-12">Sandisk Extream 원조교제 Z80 USB 16gb</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>2. 불용어: 원조교제 </label>
				<div class="col-md-12">Sandisk Extream Z80 USB 16gb</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>3. 모델명 규칙 </label>
				<div class="col-md-12">Z80 (z, 80, z80)</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>4. 단위명 규칙 </label>
				<div class="col-md-12">16gb (16gb, 16)</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>5. 형태소 분리 결과</label>
				<div class="col-md-12">Sandisk, Extream, 원조교제, Z, 80, Z80</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>6. 동의어 확장: Sandisk, Extream, Z80, USB, 16gb</label>
				<div class="col-md-12">
					<strong>Sandisk</strong> : 샌디스크, 산디스크, sandisk, 센디스크, sendisk, 샌디스크코리아, 산디스크코리아
					<br>
					<strong>Extream</strong> : extream, xtreame, 익스트림
					<br>
					<strong>Z80</strong> : 
					<br>
					<strong>USB</strong> : 유에스비
					<br>
					<strong>16gb</strong> : 16g, 16기가
					<br>
				</div>
			</td>
		</tr>
		 -->
	</tbody>
</table>
<%
}
%>
