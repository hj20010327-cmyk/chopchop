<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">품목 상세</h2>
			<p class="page-subtitle">품목의 상세 정보와 LOT 현황을 알 수 있습니다.</p>
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
							<th>저장 창고 유형</th>
							<td>
								<c:choose>
									<c:when test="${itemDTO.itemWhType == '10'}">
										원자재 냉동창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '20'}">
										원자재 냉장창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '30'}">
										원자재 상온창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '40'}">
										반제품 냉장창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '50'}">
										반제품 냉동창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '60'}">
										완제품 냉동창고
									</c:when>
									<c:when test="${itemDTO.itemWhType == '70'}">
										기타 자재 상온 창고
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
</style>