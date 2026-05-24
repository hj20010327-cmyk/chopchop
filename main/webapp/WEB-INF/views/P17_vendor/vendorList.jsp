<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">거래처 관리</h2>

			<p class="page-subtitle">
				거래처를 조회하고 새로운 거래처를 등록할 수 있습니다.
			</p>
		</div>
		
		<div>
			<p class="page-route">
				홈 > 거래처 관리
			</p>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/vendor/add">
				거래처 등록
			</a>
		</div>
	</div>

	<form class="search-box"
		action="${pageContext.request.contextPath}/vendor/list"
		method="get">

		<div class="search-item">
			<label>유형</label>

			<select name="searchType">
				<option value="">전체</option>

				<option value="S"
					${search.searchType == 'S' ? 'selected' : ''}>
					공급업체
				</option>

				<option value="C"
					${search.searchType == 'C' ? 'selected' : ''}>
					납품처
				</option>

				<option value="E"
					${search.searchType == 'E' ? 'selected' : ''}>
					기타
				</option>
			</select>
		</div>

		<div class="search-item keyword">
			<label>거래처명 / 코드 검색</label>

			<input type="text"
				name="searchKeyword"
				value="${search.searchKeyword}"
				placeholder="내용을 입력하세요.">
		</div>

		<div class="search-btn-area">
			<button type="submit" class="btn btn-main">
				검색
			</button>
		</div>

	</form>

	<div>

		<div class="table-wrap">
			<table class="table">

				<thead>
					<tr>
						<th>거래처 코드</th>
						<th>거래처명</th>
						<th>유형</th>
						<th>연락처</th>
						<th>주소</th>
					</tr>
				</thead>

				<tbody>

					<c:forEach var="vendor" items="${vendorList}">
						<tr onclick="location.href='${pageContext.request.contextPath}/vendor/detail?vendorId=${vendor.vendorId}'">

							<td>${vendor.vendorId}</td>

							<td>${vendor.vendorName}</td>

							<td>
								<c:choose>

									<c:when test="${vendor.vendorType == 'S'}">
										공급업체
									</c:when>

									<c:when test="${vendor.vendorType == 'C'}">
										납품처
									</c:when>

									<c:when test="${vendor.vendorType == 'E'}">
										기타
									</c:when>

									<c:otherwise>
										-
									</c:otherwise>

								</c:choose>
							</td>

							<td>${vendor.vendorTel}</td>

							<td>${vendor.vendorAddr} ${vendor.vendorAddrDetail}</td>

						</tr>
					</c:forEach>

					<c:if test="${empty vendorList}">
						<tr>
							<td colspan="5" style="text-align: center;">
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