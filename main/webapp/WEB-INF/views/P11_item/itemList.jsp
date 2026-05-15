<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">품목 관리</h2>
			<p class="page-subtitle">품목 목록을 조회할 수 있습니다.</p>
		</div>
		
		<div>
		<p class="page-subtitle">홈 > 품목 관리</p>
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
			
			<select name="itemType">
				<option value="">전체</option>
			
				<option value="10"
					${search.itemType == '10' ? 'selected' : ''}>
					원자재
				</option>
				
				<option value="20"
					${search.itemType == '20' ? 'selected' : ''}>
					반제품
				</option>
				
				<option value="30"
					${search.itemType == '30' ? 'selected' : ''}>
					완제품
				</option>
			</select>
		</div>
		
		<div class="search-item keyword">
			<label>품목코드/품목명 검색</label>
			
			<input type="text"
				name="itemName"
				value="${search.itemName}"
				placeholder="내용을 입력하세요.">
		</div>
		
		<div class="search-btn-area">
			<button type="button" class="btn btn-main">
				검색
			</button>
		</div>
	</form>
	
	<div class="card">
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th>품목 코드</th>
						<th>품목명</th>
						<th>품목유형</th>
						<th>안전재고</th>
						<th>단위</th>
						<th>규격</th>
						<th>단가</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${itemList}">
						<tr>
							<td>${item.itemId}</td>
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
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
							<td>${item.safetyStock}</td>
							<td>${item.unit}</td>
							<td>${item.spec}</td>
							<td>${item.unitPrice}</td>
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