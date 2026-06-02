<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">품목 상세</h2>
			<p class="page-subtitle">${itemDTO.itemName}(${itemDTO.itemId})의 상세 정보를 확인하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 > 품목 관리 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/item/list"> 목록으로 </a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/item/edit?itemId=${itemDTO.itemId}">
				수정 </a> 
				<a class="btn btn-red"
				href="${pageContext.request.contextPath}/item/delete?itemId=${itemDTO.itemId}"
				onclick="return confirm('품목을 삭제하시겠습니까?');"> 삭제 </a>
		</div>
	</div>

	<div class="content-content">
		<div class="content-content-content">
		<div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:14px;
            ">
			<div class="content-content-content-title">품목 상세정보</div>
					<div>
							<c:choose>
									<c:when test="${itemDTO.itemType == '10'}">
										<span class="status-back status-back-success">
											• 원자재
										</span>
									</c:when>
									<c:when test="${itemDTO.itemType == '20'}">
										<span class="status-back status-back-warning">
										• 반제품
										</span>
									</c:when>
									<c:when test="${itemDTO.itemType == '30'}">
										<span class="status-back status-back-safe">
										• 완제품
										</span>
									</c:when>
									<c:when test="${itemDTO.itemType == '40'}">
										<span class="status-back status-back-info">
										• 기타 자재
										</span>
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</div>
					</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>품목코드</th>
							<td>${itemDTO.itemId}</td>
							<th>품목명</th>
							<td>${itemDTO.itemName}</td>
						</tr>
						<tr>
							<th>창고 유형</th>
							<td>
								<c:choose>
									<c:when test="${itemDTO.itemWhType == '10'}">
										냉동창고(원)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '20'}">
										냉장창고(원)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '30'}">
										상온창고(원)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '40'}">
										냉장창고(반)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '50'}">
										냉동창고(반)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '60'}">
										냉동창고(완)
									</c:when>
									<c:when test="${itemDTO.itemWhType == '70'}">
										상온창고(기타)
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
							<th>안전재고</th>
							<td>
							<fmt:formatNumber value="${itemDTO.safetyStock}"
									pattern="#,###" />
							</td>
						</tr>
						<tr>
							<th>규격</th>
							<td colspan="3">${itemDTO.spec}</td>
						</tr>
						<tr>
							<th>단위</th>
							<td>${itemDTO.unit}</td>
							<th>단가(원)</th>
							<td><fmt:formatNumber value="${itemDTO.unitPrice}"
									pattern="#,###" /></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="content-content-content">
			<div class="content-content-content-title">LOT 현황</div>
			<table class="table">
				<tr>
					<th>LOT 번호</th>
					<th>입고일시</th>
					<th>유통기한</th>
					<th>창고위치</th>
					<th>LOT 상태</th>
				</tr>
				<c:if test="${not empty lotList}">
					<c:forEach var="lot" items="${lotList}">
						<tr onclick="location.href='${pageContext.request.contextPath}/lot/detail?lotId=${lot.lotId}'">
							<td class="lotId">${lot.lotId}</td>
							<td>
							<fmt:formatDate value="${lot.lotEtw}"
								pattern="yyyy-MM-dd HH:mm" />
							</td>
							<td>
							<fmt:formatDate value="${lot.lotExp}"
								pattern="yyyy-MM-dd HH:mm" />
							</td>
							<c:if test="${empty lot.lotAwhsec}">
								<td>${lot.lotBwhsec}</td>
							</c:if>
							<c:if test="${not empty lot.lotAwhsec}">
								<td>${lot.lotAwhsec}</td>
							</c:if>
							<td>
								<c:choose>
	
										<c:when test="${lot.lotStatus == '10'}">
											<span class="status status-success"> • 사용가능 </span>
										</c:when>
	
										<c:when test="${lot.lotStatus == '20'}">
											<span class="status status-safe"> • 사용중 </span>
										</c:when>
	
										<c:when test="${lot.lotStatus == '30'}">
											<span class="status status-info"> • 사용완료 </span>
										</c:when>
										
										<c:when test="${lot.lotStatus == '40'}">
											<span class="status status-warning"> • 보류 </span>
										</c:when>
	
										<c:when test="${lot.lotStatus == '0'}">
											<span class="status status-danger"> • 폐기 </span>
										</c:when>
	
										<c:otherwise>
											<span class="status"> ${lot.lotStatus} </span>
										</c:otherwise>
	
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${empty lotList}">
					<tr>
						<td colspan="5">조회된 LOT가 없습니다</td>
					</tr>
				</c:if>
			</table>
		</div>
		<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	</div>

</div>
<style>
	.table tbody tr:hover .lotId {
	    color: var(--main-green);
	    text-decoration: underline;
	}

	.info-table-wrap {
		width: 100%;
		overflow-x: auto;
	}

	.table {
		min-width: 760px;
	}

/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {

	.content {
		padding: 10px;
		box-sizing: border-box;
	}

	.header-row {
		flex-direction: column;
		align-items: flex-start;
		gap: 14px;
	}

	.header-row > div:last-child {
		width: 100%;
		align-items: flex-end;
	}

	.page-title {
		font-size: 22px;
	}

	.page-subtitle {
		font-size: 13px;
		line-height: 1.5;
	}

	.page-route {
		font-size: 12px;
	}

	.btn-row {
		gap: 10px;
		align-items: stretch;
	}

	.btn-row .left,
	.btn-row .right {
		width: 38%;
		display: flex;
		gap: 8px;
		justify-content: space-around;
	}

	.btn-row .btn {
		text-align: center;
	}

	.content-content {
		width: 100%;
	}

	.content-content-content {
		width: 100%;
		padding: 16px;
		box-sizing: border-box;
	}

	.content-content-content > div:first-child {
		align-items: flex-start !important;
		gap: 10px;
	}

	.content-content-content-title {
		font-size: 18px;
	}

	.info-table-wrap {
		overflow-x: visible;
	}


	.info-table {
		width: 100%;
		table-layout: fixed;
	}

	.info-table th,
	.info-table td {
		padding: 10px 8px;
		font-size: 13px;
		word-break: break-word;
	}

	.info-table th {
		width: 20%;
		font-size: 12px;
		white-space: nowrap;
	}

	.info-table td {
		width: 25%;
		font-size: 10px;
	}

	/* 규격 행 */
	.info-table td[colspan="3"] {
		width: 75%;
	}

	.content-content-content:nth-of-type(2) {
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
	}

	.table {
		min-width: 620px;
	}

	.table th,
	.table td {
		white-space: nowrap;
/* 		font-size: 12px; */
/* 		padding: 10px 8px; */
		padding: 6px 4px;
		font-size: 11px;
		line-height: 1.2;
	}
	
	.table th {
		font-size: 10px;
		font-weight: 600;
	}

	.status {
		font-size: 10px;
		padding: 2px 6px;
	}

	.table tr {
		height: 36px;
	}

	.lotId {
		font-size: 11px;
	}

	.status-back {
		white-space: nowrap;
		font-size: 9px;
	}
}
</style>