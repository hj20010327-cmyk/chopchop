<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
				href="${pageContext.request.contextPath}/item/list">
				목록으로
			</a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/item/edit?=itemId=${itemDTO.itemId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/item/delete">
				삭제	
			</a>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				품목 상세정보
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>품목코드</th>
							<td>${itemDTO.itemId}</td>
							<th>퓸목명</th>
							<td>${itemDTO.itemName}</td>
						</tr>
						<tr>
							<th>품목타입</th>
							<td>
								<c:choose>
									<c:when test="${itemDTO.itemType == '10'}">
										원자재
									</c:when>
									<c:when test="${itemDTO.itemType == '20'}">
										반제품
									</c:when>
									<c:when test="${itemDTO.itemType == '30'}">
										완제품
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
							<th>안전재고</th>
							<td>${itemDTO.safetyStock}</td>
						</tr>
						<tr>
							<th>공급처/납품처</th>
							<td>${itemDTO.vendorName}(${itemDTO.itemVendor})</td>
							<th>보관방법</th>
							<td>${itemDTO.itemStorage}</td>
						</tr>
						<tr>
							<th>단위</th>
							<td>${itemDTO.unit}</td>
							<th>규격</th>
							<td>${itemDTO.spec}</td>
							<th>단가</th>
							<td>${itemDTO.unitPrice}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="content-content-content">
			<div class="content-content-content-title">
				LOT 현황
			</div>
			<table class="table">
				<tr>
					<th>LOT 번호</th>
					<th>입고일</th>
					<th>유통기한</th>
					<th>창고위치</th>
					<th>LOT 상태</th>
				</tr>
				<c:forEach var="lot" items="${lotList}">
					<tr>
						<td>${lot.lotId}</td>
						<td>${lot.lotEtw}</td>
						<td>${lot.lotExp}</td>
						<c:if test="${empty lot.lotAwhsec}">
							<td>${lot.lotBwhsec}</td>
						</c:if>
						<c:if test="${not empty lot.lotAwhsec}">
							<td>${lot.lotAwhsec}</td>
						</c:if>
						<td>${lot.lotStatus}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</div>