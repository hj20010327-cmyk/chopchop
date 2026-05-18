<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">LOT 관리</h2>
			<p class="page-subtitle">LOT 목록을 조회할 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 > LOT관리</p>
		</div>
	</div>

	<form class="search-box"
		action="${pageContext.request.contextPath}/lot/list" method="get">

		<div class="search-item">
			<label>유통기한</label>

			<div style="display: flex; align-items: center; gap: 8px;">
				<input type="date" name="startDate" value="${search.startDate}" style="min-width:218px;">

				<span>~</span> <input type="date" name="endDate"
					value="${search.endDate}" style="min-width:218px;">
			</div>
		</div>

		<div class="search-item">
			<label>상태</label> <select name="lotStatus">
				<option value="">전체</option>

				<option value="사용가능" ${search.lotStatus == '사용가능' ? 'selected' : ''}>
					사용가능</option>

				<option value="사용중" ${search.lotStatus == '사용중' ? 'selected' : ''}>
					사용중</option>

				<option value="사용완료" ${search.lotStatus == '사용완료' ? 'selected' : ''}>
					사용완료</option>

				<option value="보류" ${search.lotStatus == '보류' ? 'selected' : ''}>
					보류</option>

				<option value="폐기" ${search.lotStatus == '폐기' ? 'selected' : ''}>
					폐기</option>
			</select>
		</div>

		<div class="search-item keyword">
			<label>품목명/LOT 번호 검색</label> <input type="text" name="searchKeyword"
				value="${search.searchKeyword}" placeholder="내용을 입력하세요." style="min-width:218px;">
		</div>

		<div class="search-btn-area">
			<button type="submit" class="btn btn-main">검색</button>
		</div>
	</form>

	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 130px;">LOT 번호</th>
						<th style="width: 200px;">품목</th>
						<th style="width: 130px;">위치</th>
						<th style="width: 100px;">수량</th>
						<th style="width: 180px;">유통기한</th>
						<th style="width: 100px;">상태</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="lot" items="${lotList}">
						<tr>
							<td>${lot.lotId}</td>
							<td>${lot.lotItem}</td>
							<td>${lot.lotAwhsec}</td>
							<td>${lot.lotFqty}EA</td>
							<td>${lot.lotExp}</td>
							<td>
								<c:choose>

									<c:when test="${lot.lotStatus == '사용가능'}">
										<span class="status status-success"> 사용가능 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '사용중'}">
										<span class="status status-info"> 사용중 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '사용완료'}">
										<span class="status status-warning"> 사용완료 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '폐기'}">
										<span class="status status-danger"> 폐기 </span>
									</c:when>

									<c:otherwise>
										<span class="status"> ${lot.lotStatus} </span>
									</c:otherwise>

								</c:choose>
							</td>
						</tr>
					</c:forEach>

					<c:if test="${empty lotList}">
						<tr>
							<td colspan="6" style="text-align: center;">조회된 LOT가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<jsp:include page="/WEB-INF/views/common/paging.jsp" />

	</div>
</div>