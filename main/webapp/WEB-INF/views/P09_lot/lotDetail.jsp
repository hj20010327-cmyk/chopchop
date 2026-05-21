<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">

		<div>
			<h2 class="page-title">LOT 상세</h2>
			<p class="page-subtitle">LOT 정보와 사용 이력을 확인할 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 > LOT관리 > 상세</p>
		</div>

	</div>

	<div class="btn-row">

		<div>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/lot/list"> 목록 </a>
		</div>

	</div>

	<div class="content-content">

		<!-- LOT 상세 -->
		<div class="content-content-content">

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">

				<div class="content-content-content-title"
					style="display: flex; gap: 30px;">
					LOT 상세정보 <span class="btn btn-main" style="cursor: cursor;">
						QR 코드 </span>
				</div>

				<div>
					<c:choose>
						<c:when test="${lot.lotStatus == '10'}">
							<span class="status-back status-back-success"> • 사용가능 </span>
						</c:when>

						<c:when test="${lot.lotStatus == '20'}">
							<span class="status-back status-back-safe"> • 사용중 </span>
						</c:when>

						<c:when test="${lot.lotStatus == '30'}">
							<span class="status-back status-back-info"> • 사용완료 </span>
						</c:when>

						<c:when test="${lot.lotStatus == '40'}">
							<span class="status-back status-back-warning"> • 검사 전 </span>
						</c:when>

						<c:when test="${lot.lotStatus == '0'}">
							<span class="status-back status-back-danger"> • 폐기 </span>
						</c:when>

						<c:otherwise>
							<span class="status-back"> ${lot.lotStatus} </span>
						</c:otherwise>

					</c:choose>

				</div>

			</div>

			<div class="info-table-wrap">

				<table class="info-table">

					<tr>
						<th>LOT 번호</th>
						<td>${lot.lotId}</td>

						<th>품목</th>
						<td>${lot.lotItemName}</td>
					</tr>

					<tr>
						<th>거래처이름(코드)</th>
						<td>${lot.lotVendorName}(${lot.lotVendor})</td>

						<th>제조일시</th>
						<td>
							<c:choose>
								<c:when test="${lot.lotQc == 'Y'}">
									<fmt:formatDate value="${lot.lotMfd}"
										pattern="yyyy-MM-dd HH:mm"/>
								</c:when>
								<c:when test="${lot.lotQc == 'N'}">
									-
								</c:when>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th>입고일시</th>
						<td>
						<fmt:formatDate value="${lot.lotEtw}"
							pattern="yyyy-MM-dd HH:mm"/>
						</td>

						<th>입고수량</th>
						<td>${lot.lotQty}EA</td>
					</tr>

					<tr>
						<th>출고일시</th>
						<td>
							-					
						</td>

						<th>가용 수량</th>
						<td>${lot.lotFqty}EA</td>
					</tr>

					<tr>
						<th>유통기한</th>
						<td><fmt:formatDate value="${lot.lotExp}"
									pattern="yyyy-MM-dd HH:mm"/></td>

						<th>위치</th>
						<td>
							<c:choose>
								<c:when test="${lot.lotQc == 'Y'}">
									${lot.lotAwhsec}
								</c:when>
								<c:when test="${lot.lotQc == 'N'}">
									${lot.lotBwhsec}
								</c:when>
							</c:choose>
						</td>
					</tr>

				</table>

			</div>

		</div>

		<!-- 사용이력 -->
		<div class="content-content-content">

			<div class="content-content-content-title">
				<c:choose>
					<c:when test="${historyType == 'IO'}">
						LOT 입출고 기록
					</c:when>
					<c:otherwise>
						LOT 사용 기록
					</c:otherwise>
				</c:choose>
			</div>

			<div class="table-wrap">

				<table class="table">

					<thead>
						<tr>
							<th style="width: 140px;">작업 코드</th>
							<th style="width: 140px;">사용수량</th>
							<th style="width: 160px;">사용일</th>
							<th style="width: 140px;">사용유형</th>
							<th>비고</th>
						</tr>
					</thead>

					<tbody>

						<c:choose>

							<c:when test="${historyType == 'IO'}">

								<c:forEach var="io" items="${ioList}">

									<tr onclick="location.href='${pageContext.request.contextPath}/io/detail?ioId=${io.ioId}'">
										<td class="ioId">${io.ioId}</td>

										<td>${io.ioQty}EA</td>

										<td><fmt:formatDate value="${io.ioDate}"
												pattern="yyyy-MM-dd" /></td>

										<td>
											<c:choose>
												<c:when test="${io.ioType == 'IN'}">
													입고
												</c:when>
												<c:when test="${io.ioType == 'OUT'}">
													출고
												</c:when>
												<c:otherwise>
													${io.ioType}
												</c:otherwise>
											</c:choose>
										</td>

										<td>
											<c:choose>
												<c:when test="${empty io.ioMsg}">
													-
												</c:when>
												<c:otherwise>
													${io.ioMsg}
												</c:otherwise>
											</c:choose>
										</td>
									</tr>

								</c:forEach>

								<c:if test="${empty ioList}">
									<tr>
										<td colspan="5" style="text-align: center;">조회된 입출고 이력이
											없습니다.</td>
									</tr>
								</c:if>

							</c:when>

							<c:otherwise>

								<c:forEach var="use" items="${useList}">

									<tr>
										<td>${use.useWork}</td>

										<td>${use.useQty}EA</td>

										<td><fmt:formatDate value="${use.useDate}"
												pattern="yyyy-MM-dd" /></td>

										<td>${use.useType}</td>

										<td>
											<c:choose>
												<c:when test="${empty use.useMemo}">
													-
												</c:when>
												<c:otherwise>
													${use.useMemo}
												</c:otherwise>
											</c:choose>
										</td>
									</tr>

								</c:forEach>

								<c:if test="${empty useList}">
									<tr>
										<td colspan="5" style="text-align: center;">조회된 LOT 사용
											이력이 없습니다.</td>
									</tr>
								</c:if>

							</c:otherwise>

						</c:choose>

					</tbody>

				</table>

			</div>

		</div>

	</div>

</div>
<style>
	.table tbody tr:hover .ioId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
</style>