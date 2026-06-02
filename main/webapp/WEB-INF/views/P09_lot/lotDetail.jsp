<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:choose>
	<c:when test="${lot.lotQc == 'Y'}">
		<c:set var="currentSecId" value="${lot.lotAwhsec}" />
	</c:when>
	<c:otherwise>
		<c:set var="currentSecId" value="${lot.lotBwhsec}" />
	</c:otherwise>
</c:choose>

<div class="content">

	<div class="header-row">

		<div>
			<h2 class="page-title">LOT 상세</h2>
			<p class="page-subtitle">LOT(${lot.lotId})의 상세 정보와 수량을 확인하세요.</p>
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
					style="display: flex; gap: 30px; align-items: center;">
					LOT 상세정보
					<button type="button" class="btn btn-main" id="openLotQrModalBtn" data-sec-id="${currentSecId}">
						QR 코드
					</button>
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
						<td>
							<a class="toDetail" href="${pageContext.request.contextPath}/item/detail?itemId=${lot.lotItem}">${lot.lotItemName} (${lot.lotItem})</a>
						</td>
					</tr>

					<tr>
						<th>거래처</th>
						<td>
							<c:choose>
								<c:when test="${not empty lot.lotVendor}">
									<a class="toDetail" href="${pageContext.request.contextPath}/vendor/detail?vendorId=${lot.lotVendor}">${lot.lotVendorName}(${lot.lotVendor})</a>
								</c:when>
								<c:otherwise>
									-
								</c:otherwise>
							</c:choose>
						</td>

						<th>제조일시</th>
						<td>
							<c:choose>
								<c:when test="${lot.lotQc == 'Y'}">
									<fmt:formatDate value="${lot.lotEtw}"
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
						<td>
							<fmt:formatNumber value="${lot.lotQty}"
							pattern="#,###"/>
						EA</td>
					</tr>

					<tr>
						<th>출고일시</th>
						<td>
							-					
						</td>

						<th>가용 수량</th>
						<td>
							<fmt:formatNumber value="${lot.lotFqty}"
							pattern="#,###"/>
						EA</td>
					</tr>

					<tr>
						<th>유통기한</th>
						<td><fmt:formatDate value="${lot.lotExp}"
									pattern="yyyy-MM-dd HH:mm"/></td>

						<th>위치</th>
						<td>
							<c:choose>
								<c:when test="${lot.lotQc == 'Y'}">
									<a class="toDetail"
									href="${pageContext.request.contextPath}/warehouse/section/detail?secId=${lot.lotAwhsec}">${lot.lotAwhsec}</a>
								</c:when>
								<c:when test="${lot.lotQc == 'N'}">
									<a class="toDetail"
									href="${pageContext.request.contextPath}/warehouse/section/detail?secId=${lot.lotBwhsec}">${lot.lotBwhsec}</a>
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
							<th style="width: 160px;">사용일시</th>
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

									<tr onclick="location.href='${pageContext.request.contextPath}/work/detail?workId=${use.useWork}'">
										<td class="workId">${use.useWork}</td>

										<td>
											<fmt:formatNumber value="${use.useQty}"
												pattern="#,###"/> EA
										</td>

										<td><fmt:formatDate value="${use.useDate}"
												pattern="yyyy-MM-dd HH:mm" /></td>

										<td>
											<c:if test="${use.useType == 10}">
												작업투입
											</c:if>
										</td>

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

<div class="overlay" id="lotQrModal">
	<div class="modal lot-qr-modal">

		<div class="modal-header">
			<div>
				<h3 class="modal-title">LOT 추적 QR 코드</h3>
				<p class="modal-subTitle" id="lotQrModalSubTitle">
					${lot.lotItemName}(${lot.lotId})
				</p>
			</div>

			<button type="button"
					class="modal-close"
					id="closeLotQrModalBtn">
				×
			</button>
		</div>

		<div class="lot-qr-modal-body">
			<img id="lotQrImage"
				 alt="LOT QR 코드"
				 class="lot-qr-image">
		</div>
		
		<div class="lot-qr-info-wrap" style="margin-top: 15px;">
			<table class="info-table lot-qr-info-table">
				<tbody>
					<tr>
						<th>LOT 번호</th>
						<td>${lot.lotId}</td>
					</tr>

					<tr>
						<th>품목</th>
						<td><a href="${pageContext.request.contextPath}/item/detail?itemId=${lot.lotItem}">${lot.lotItemName} (${lot.lotItem})</a></td>
					</tr>

					<tr>
						<th>현재 위치</th>
						<td>
							<a href="${pageContext.request.contextPath}/warehouse/section/detail?secId=${currentSecId}">
								${currentSecId}
							</a>
						</td>
					</tr>

					<tr>
						<th>현재 상태</th>
						<td>
							<c:choose>
								<c:when test="${lot.lotStatus == '10'}">사용가능</c:when>
								<c:when test="${lot.lotStatus == '20'}">사용중</c:when>
								<c:when test="${lot.lotStatus == '30'}">사용완료</c:when>
								<c:when test="${lot.lotStatus == '40'}">검사 전</c:when>
								<c:when test="${lot.lotStatus == '0'}">폐기</c:when>
								<c:otherwise>${lot.lotStatus}</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th>가용 수량</th>
						<td>
							<fmt:formatNumber value="${lot.lotFqty}"
								pattern="#,###"/>
								EA
						</td>
					</tr>

					<tr>
						<th>유통기한</th>
						<td>
							<fmt:formatDate value="${lot.lotExp}"
								pattern="yyyy-MM-dd HH:mm"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		
	</div>
</div>




<style>
	.table tbody tr:hover .ioId, 
	.table tbody tr:hover .workId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	.lot-qr-modal {
		width: 400px;
		max-width: calc(100vw - 40px);
	}
	
	.modal-header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		gap: 20px;
		margin-bottom: 20px;
	}
	
	.modal-close {
		font-size: 20px;
		cursor: pointer;
		line-height: 1;
	}
	
	.lot-qr-modal-body {
		min-height: 260px;
	
		display: flex;
		align-items: center;
		justify-content: center;
	
		border: 1px dashed var(--gray);
		border-radius: 8px;
		background-color: #fafafa;
	}
	
	.lot-qr-placeholder {
		color: var(--dark-gray);
		font-size: 14px;
	}
	
	.lot-qr-image {
		width: 240px;
		height: 240px;
		display: block;
	}
	
	.lot-qr-info-wrap {
		flex: 1;
	}
	
	.lot-qr-info-table th {
		width: 110px;
	}
	
	.lot-qr-info-table td {
		width: auto;
	}
	
	.lot-qr-info-table a:hover {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	
</style>


<script>
	document.addEventListener("DOMContentLoaded", function() {
	
		const openLotQrModalBtn = document.getElementById("openLotQrModalBtn");
		const lotQrModal = document.getElementById("lotQrModal");
		const closeLotQrModalBtn = document.getElementById("closeLotQrModalBtn");
		const lotQrImage = document.getElementById("lotQrImage");
	
		const contextPath = "${pageContext.request.contextPath}";
	
		if (!openLotQrModalBtn || !lotQrModal || !closeLotQrModalBtn || !lotQrImage) {
			return;
		}
	
		openLotQrModalBtn.addEventListener("click", function() {
			const secId = openLotQrModalBtn.dataset.secId;
	
			if (!secId) {
				alert("LOT의 현재 위치 정보가 없습니다.");
				return;
			}

			lotQrImage.src = contextPath + "/lot/qr?secId=" + encodeURIComponent(secId);
	
			openModal(lotQrModal);
		});
	
		closeLotQrModalBtn.addEventListener("click", function() {
			closeLotQrModal();
		});
	
		lotQrModal.addEventListener("click", function(e) {
			if (e.target === lotQrModal) {
				closeLotQrModal();
			}
		});
	
		function closeLotQrModal() {
			closeModal(lotQrModal);
			lotQrImage.removeAttribute("src");
		}
	});
</script>