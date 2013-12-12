<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="org.json.*"%>
<%@page import="java.util.*"%>
<%
//JSONObject analyzedResult = (JSONObject) request.getAttribute("analyzedResult");
String type = (String) request.getParameter("type");
%>
<%
if(type == null || type.equalsIgnoreCase("simple")){
%>
<table class="table table-bordered table-highlight-head">
	<thead>
		<tr>
			<th style="padding: 15px 0 15px 10px;">
				<h4>Sandisk Extream 원조교제 Z80 USB 16gb 가격비교</h4>
			</th>
		</tr>
	</thead>	
	<tbody>
		<tr>
			<td>
				<label>1. Analyzed Terms: </label>
				<div class="col-md-12">Sandisk, Extream, 원조교제, Z, 80, Z80</div>
			</td>
		</tr>
		<tr>
			<td>
				<label>2. Analyzed Terms List: </label>
				<div class="col-md-12">
					<table class="table table-fixed" style="border:0px">
						<tr>
							<td>[1] Sandisk</td>
							<td>[2] Extream</td>
							<td>[3] 원조교제</td>
							<td>[4] Z</td>
							<td>[5] 80</td>
						</tr>
						<tr>
							<td>[6] Z80</td>
							<td>[7] USB</td>
							<td>[8] 16gb</td>
							<td>[9] 16</td>
							<td></td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</tbody>
</table>
<%

} else if(type.equalsIgnoreCase("detail")){
	
%>							
<table class="table table-bordered table-highlight-head">
	<thead>
		<tr>
			<th style="padding: 15px 0 15px 10px;">
				<h4>Sandisk Extream 원조교제 Z80 USB 16gb 가격비교</h4>
			</th>
		</tr>
	</thead>	
	<tbody>
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
	</tbody>
</table>
<%
}
%>
