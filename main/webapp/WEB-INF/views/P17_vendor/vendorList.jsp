<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">거래처 관리</h2>

			<p class="page-subtitle">
				거래처 목록을 조회하고 등록하세요.
			</p>
		</div>
		
		<div>
			<p class="page-route">
				홈 &gt; 거래처 관리
			</p>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/vendor/add">
				거래처 등록
			</a>
		</div>
	</div>

	<c:set var="supplierCount" value="0" />
	<c:set var="customerCount" value="0" />
	<c:set var="etcCount" value="0" />

	<c:forEach var="summary" items="${vendorTypeSummary}">
		<c:if test="${summary.vendorType == 'S'}">
			<c:set var="supplierCount" value="${summary.vendorTypeCount}" />
		</c:if>

		<c:if test="${summary.vendorType == 'C'}">
			<c:set var="customerCount" value="${summary.vendorTypeCount}" />
		</c:if>

		<c:if test="${summary.vendorType == 'E'}">
			<c:set var="etcCount" value="${summary.vendorTypeCount}" />
		</c:if>
	</c:forEach>

	<div class="card-wrap vendorCard">

		<div class="card info vendor-all"
			 data-type="all">
			<div class="card-title">전체</div>
			<div class="card-value">${totalVendorCount}</div>
			<div class="card-subtitle">전체 거래처</div>
		</div>

		<div class="card success vendor-card"
			 data-type="S">
			<div class="card-title">공급업체</div>
			<div class="card-value">${supplierCount}</div>
			<div class="card-subtitle">자재/원료 공급</div>
		</div>

		<div class="card safe vendor-card"
			 data-type="C">
			<div class="card-title">납품처</div>
			<div class="card-value">${customerCount}</div>
			<div class="card-subtitle">제품 납품 대상</div>
		</div>

		<div class="card warning vendor-card"
			 data-type="E">
			<div class="card-title">기타</div>
			<div class="card-value">${etcCount}</div>
			<div class="card-subtitle">기타 거래처</div>
		</div>

	</div>

	<form class="search-box"
		id="vendorSearchForm"
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
			
			<a class="btn btn-white"
			   href="${pageContext.request.contextPath}/vendor/list">
			    초기화
			</a>
		</div>

	</form>

	<div>

		<div class="table-wrap">
			<table class="table">

				<thead>
					<tr>
						<th>거래처</th>
						<th>사업자 번호</th>
						<th>유형</th>
						<th>연락처</th>
						<th>주소</th>
					</tr>
				</thead>

				<tbody>

					<c:forEach var="vendor" items="${vendorList}">
						<tr class="vendorTr" onclick="location.href='${pageContext.request.contextPath}/vendor/detail?vendorId=${vendor.vendorId}'">

							<td class="vendorId">${vendor.vendorName} (${vendor.vendorId})</td>

							<td>${vendor.vendorBRN}</td>

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

<style>
	.vendorCard .card {
		width: 155px;
		cursor: pointer;

		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		gap: 10px;
	}

	.vendorCard .card.info {
		border: 1px solid var(--dark-gray);
	}

	.vendorCard .card.info .card-value {
		color: var(--dark-gray);
	}

	.vendorCard .card.info:hover,
	.vendorCard .card.info.active {
		background-color: var(--dark-gray);
	}

	.vendorCard .card.success:hover,
	.vendorCard .card.success.active {
		background-color: var(--success);
	}

	.vendorCard .card.safe:hover,
	.vendorCard .card.safe.active {
		background-color: var(--safe);
	}

	.vendorCard .card.warning:hover,
	.vendorCard .card.warning.active {
		background-color: var(--warning);
	}

	.vendorCard .card:hover div,
	.vendorCard .card.active div {
		color: white !important;
	}
	
	.vendorTr:hover .vendorId {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.table tr th:nth-child(4), .table tr td:nth-child(4) {
		display: none;
	}
	
}
	
</style>

<script>
window.addEventListener("load", function() {
	bindVendorCardFilter();
});

function bindVendorCardFilter() {
	const allCard = document.querySelector(".vendorCard .vendor-all");
	const typeCards = document.querySelectorAll(".vendorCard .vendor-card");
	const form = document.querySelector("#vendorSearchForm");

	if (!allCard || !typeCards.length || !form) {
		return;
	}

	const params = new URLSearchParams(window.location.search);
	const selectedTypes = params.getAll("searchTypes");

	if (selectedTypes.length === 0) {
		allCard.classList.add("active");
	} else {
		allCard.classList.remove("active");

		typeCards.forEach(function(card) {
			const type = card.dataset.type;

			if (selectedTypes.includes(type)) {
				card.classList.add("active");
			}
		});
	}

	allCard.addEventListener("click", function() {
		typeCards.forEach(function(card) {
			card.classList.remove("active");
		});

		allCard.classList.add("active");

		submitVendorFilter([]);
	});

	typeCards.forEach(function(card) {
		card.addEventListener("click", function() {
			card.classList.toggle("active");
			allCard.classList.remove("active");

			const activeCards =
				document.querySelectorAll(".vendorCard .vendor-card.active");

			const selectedValues = [];

			activeCards.forEach(function(activeCard) {
				selectedValues.push(activeCard.dataset.type);
			});

			if (selectedValues.length === 0) {
				allCard.classList.add("active");
				submitVendorFilter([]);
				return;
			}

			submitVendorFilter(selectedValues);
		});
	});

	function submitVendorFilter(selectedValues) {
		form.querySelectorAll("input[name='searchTypes']").forEach(function(input) {
			input.remove();
		});

		selectedValues.forEach(function(type) {
			const input = document.createElement("input");

			input.type = "hidden";
			input.name = "searchTypes";
			input.value = type;

			form.appendChild(input);
		});

		form.submit();
	}
}
</script>