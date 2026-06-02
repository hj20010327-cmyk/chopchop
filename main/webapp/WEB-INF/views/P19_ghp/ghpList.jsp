<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">위생 관리</h2>
			<p class="page-subtitle">위생관리기준을 조회하고 새로운 관리기준을 등록하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 위생 관리</p>
			<a class="btn btn-white addBtn"
				href="${pageContext.request.contextPath}/ghp/add">
				기준 등록
			</a>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/ghp/list"
		method="get"
		class="search-box">

		<div class="search-item">
			<label>구분</label>
			<select name="ghpCategorySearch">
				<option value="">전체</option>
				<option value="세척관리" ${search.ghpCategorySearch == '세척관리' ? 'selected' : ''}>세척관리</option>
				<option value="작업환경" ${search.ghpCategorySearch == '작업환경' ? 'selected' : ''}>작업환경</option>
				<option value="개인위생" ${search.ghpCategorySearch == '개인위생' ? 'selected' : ''}>개인위생</option>
				<option value="이물관리" ${search.ghpCategorySearch == '이물관리' ? 'selected' : ''}>이물관리</option>
				<option value="공정위생" ${search.ghpCategorySearch == '공정위생' ? 'selected' : ''}>공정위생</option>
			</select>
		</div>

		<div class="search-item keyword">
			<label>기준코드 / 기준명 / 대상 검색</label>
			<input type="text"
				name="searchKeyword"
				value="${search.searchKeyword}"
				placeholder="내용을 입력하세요.">
		</div>

		<button type="submit" class="btn btn-main">검색</button>
	</form>

	<table class="table">
		<thead>
			<tr>
				<th style="width: 95px;">기준코드</th>
				<th style="width: 280px;">기준명</th>
				<th style="width: 90px;">구분</th>
				<th style="width: 220px;">대상</th>
				<th style="width: 90px;">점검주기</th>
				<th style="width: 90px;">기준값</th>
				<th style="width: 60px;">단위</th>
			</tr>
		</thead>

		<tbody>
			<c:choose>
				<c:when test="${empty ghpList}">
					<tr>
						<td colspan="7" class="empty">
							조회된 GHP 기준정보가 없습니다.
						</td>
					</tr>
				</c:when>

				<c:otherwise>
					<c:forEach var="ghp" items="${ghpList}">
						<tr onclick="location.href='${pageContext.request.contextPath}/ghp/detail?ghpId=${ghp.ghpId}'">
							<td class="ghpId">${ghp.ghpId}</td>
							<td>${ghp.ghpName}</td>
							<td>${ghp.ghpCategory}</td>
							<td>
								<c:choose>
									<c:when test="${ghp.ghpWhType != 0}">
										${ghp.whTypeName}(창고)
									</c:when>
									<c:when test="${ghp.ghpWpType != 0}">
										${ghp.wpTypeName}(작업장)
									</c:when>
									<c:otherwise>
										공통
									</c:otherwise>
								</c:choose>
							</td>
							<td>${ghp.ghpCycle}</td>
							<td>
								<c:choose>
									<c:when test="${not empty ghp.ghpMinValue and not empty ghp.ghpMaxValue}">
										${ghp.ghpMinValue} ~ ${ghp.ghpMaxValue}
									</c:when>
									<c:when test="${not empty ghp.ghpMinValue and empty ghp.ghpMaxValue}">
										${ghp.ghpMinValue} 이상
									</c:when>
									<c:when test="${empty ghp.ghpMinValue and not empty ghp.ghpMaxValue}">
										${ghp.ghpMaxValue} 이하
									</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${not empty ghp.ghpUnit}">
										${ghp.ghpUnit}
									</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
	<jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>

<style>
	.table tbody tr:hover .ghpId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.table tr th:nth-child(3), .table tr td:nth-child(3),
	.table tr th:nth-child(6), .table tr td:nth-child(6),
	.table tr th:nth-child(7), .table tr td:nth-child(7) {
		display: none;
	}
	
	.addBtn {
		margin-left: 20px;
		min-width: 72px;
	}
	
	.table-wrap {
		width: 100%;
		overflow-x: auto;
		overflow-y: hidden;
		-webkit-overflow-scrolling: touch;
	}

	.table {
		min-width: 760px;
		white-space: nowrap;
	}
}
</style>

<script>
	window.addEventListener('load', function() {
		document.querySelector("form").addEventListener("submit", function(e) {

		    const targets = this.querySelectorAll("input[type=text], textarea");

		    for (let i = 0; i < targets.length; i++) {

		        if (targets[i].value.trim() === "") {

		            alert("공백만 입력할 수 없습니다.");

		            targets[i].focus();

		            e.preventDefault();
		            return false;
		        }
		    }
		});
		
		document.querySelectorAll("input, textarea").forEach(el => {
		    el.addEventListener("blur", function() {
		        this.value = this.value.trim();
		    });
		});
	})
</script>