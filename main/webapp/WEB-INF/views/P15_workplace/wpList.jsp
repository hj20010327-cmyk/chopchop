<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">작업장 관리</h2>
			<p class="page-subtitle">작업장 목록을 조회할 수 있습니다.</p>
		</div>
		
		<div>
		<p class="page-route">홈 > 작업장 관리</p>
		<a class="btn btn-white"
			href="${pageContext.request.contextPath}/workplace/add">
			작업장 등록	
		</a>
		</div>
	</div>
	
	<form class="search-box"
		action="${pageContext.request.contextPath}/workplace/list"
		method="get">
		
		<div class="search-item">
			<label>유형</label>
			
			<select name="wpTypeId">
				<option value="">전체</option>
			
				<option value="10"
					${search.wpTypeId == '10' ? 'selected' : ''}>
					전처리
				</option>
				<option value="20"
					${search.wpTypeId == '20' ? 'selected' : ''}>
					배합
				</option>
				<option value="30"
					${search.wpTypeId == '30' ? 'selected' : ''}>
					반죽
				</option>
				<option value="40"
					${search.wpTypeId == '40' ? 'selected' : ''}>
					제피
				</option>
				<option value="50"
					${search.wpTypeId == '50' ? 'selected' : ''}>
					성형
				</option>
				<option value="60"
					${search.wpTypeId == '60' ? 'selected' : ''}>
					증숙
				</option>
				<option value="70"
					${search.wpTypeId == '70' ? 'selected' : ''}>
					냉각
				</option>
				<option value="80"
					${search.wpTypeId == '80' ? 'selected' : ''}>
					급속냉동
				</option>
				<option value="90"
					${search.wpTypeId == '90' ? 'selected' : ''}>
					포장
				</option>
				<option value="100"
					${search.wpTypeId == '100' ? 'selected' : ''}>
					검사
				</option>
			</select>
		</div>
		
		<div class="search-item keyword">
			<label>작업장 번호/작업장명 검색</label>
			
			<input type="text"
				name="wpKeyword"
				value="${search.wpKeyword}"
				placeholder="내용을 입력하세요.">
		</div>
		
		<div class="search-btn-area">
			<button type="button" class="btn btn-main">
				검색
			</button>
		</div>
	</form>
	
	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th>작업장 번호</th>
						<th>작업장명</th>
						<th>유형</th>
						<th>관리 기준</th>
						<th>설명</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="wp" items="${wpList}">
						<tr>
							<td>${wp.wpId}</td>
							<td>${wp.wpName}</td>
							<td>${wp.wpType}</td>
							<td>${item.safetyStock}</td>
							<td>${item.unit}</td>
						</tr>	
					</c:forEach>
					
					<c:if test="${empty itemList}">
						<tr>
							<td colspan="7" style="text-align: center;">
								조회된 거래처가 없습니다.
							</td>
						</tr>
					</c:if>				
						
				</tbody>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/common/paging.jsp" />
		
	</div>
</div>