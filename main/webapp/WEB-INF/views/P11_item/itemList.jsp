<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">품목 관리</h2>
			<p class="page-subtitle">품목 목록을 조회할 수 있습니다.</p>
		</div>
		
		<div>
		<p class="page-route">홈 > 품목 관리</p>
		<a class="btn btn-white"
			href="${pageContext.request.contextPath}/item/add">
			품목 등록	
		</a>
		</div>
	</div>
	
	<form class="search-box"
		action="${pageContext.request.contextPath}/item/list"
		method="get">
		
		<div class="search-item">
			<label>품목유형</label>
			
			<select name="searchType">
				<option value="">전체</option>
			
				<option value="10"
					${search.searchType == '10' ? 'selected' : ''}>
					원자재
				</option>
				
				<option value="20"
					${search.searchType == '20' ? 'selected' : ''}>
					반제품
				</option>
				
				<option value="30"
					${search.searchType == '30' ? 'selected' : ''}>
					완제품
				</option>
				
				<option value="40"
					${search.searchType == '40' ? 'selected' : ''}>
					기타 자재
				</option>
			</select>
		</div>
		
		<div class="search-item keyword">
			<label>품목코드/품목명 검색</label>
			
			<input type="text"
				name="searchKeyword"
				value="${search.searchKeyword}"
				placeholder="내용을 입력하세요.">
		</div>
		
		<div class="search-btn-area">
			<button type="submit" class="btn btn-main">
				검색
			</button>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/item/list">
				초기화
			</a>
		</div>
	</form>
	
	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 130px;">품목 코드</th>
						<th style="width: 200px;">품목명</th>
						<th style="width: 100px;">품목유형</th>
						<th style="width: 130px;">안전재고</th>
						<th style="width: 100px;">단위</th>
						<th style="width: 100px;">규격</th>
						<th style="width: 130px;">단가(원)</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${itemList}">
						<tr onclick="location.href='${pageContext.request.contextPath}/item/detail?itemId=${item.itemId}'">
							<td class="itemId">${item.itemId}</td>
							<td>${item.itemName}</td>
							<td>
								<c:choose>
									<c:when test="${item.itemType == '10'}">
										원자재
									</c:when>
									<c:when test="${item.itemType == '20'}">
										반제품
									</c:when>
									<c:when test="${item.itemType == '30'}">
										완제품
									</c:when>
									<c:when test="${item.itemType == '40'}">
										기타 자재
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
							<td>${item.safetyStock}</td>
							<td>${item.unit}</td>
							<td>${item.spec}</td>
							<td><fmt:formatNumber
									value="${item.unitPrice}" pattern="#,###" /></td>
						</tr>	
					</c:forEach>
					
					<c:if test="${empty itemList}">
						<tr>
							<td colspan="7" style="text-align: center;">
								조회된 품목이 없습니다.
							</td>
						</tr>
					</c:if>				
						
				</tbody>
			</table>
		</div>
		
		<jsp:include page="/WEB-INF/views/common/paging.jsp" />
		
	</div>
</div>
<style>
	.table tbody tr:hover .itemId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
</style>