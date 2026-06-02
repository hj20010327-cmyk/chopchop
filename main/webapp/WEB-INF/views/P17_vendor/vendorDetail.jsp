<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">거래처 상세</h2>
			<p class="page-subtitle">${vendor.vendorName}(${vendor.vendorId})의 상세 정보를 확인하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 거래처 관리 &gt; 상세</p>
		</div>
	</div>

	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/vendor/list"> 목록 </a>
		</div>

		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/vendor/edit?vendorId=${vendor.vendorId}">
				수정 </a>

			<form action="${pageContext.request.contextPath}/vendor/delete"
				method="post" style="display: inline;"
				onclick="return confirm('거래처(${vendor.vendorId})를 삭제하시겠습니까?');">

				<input type="hidden" name="vendorId" value="${vendor.vendorId}">

				<button type="submit" class="btn btn-red">삭제</button>
			</form>
		</div>
	</div>

	<div class="content-content">

		<div class="content-content-content">
		
			<div class="detail-title-row">
				<div class="content-content-content-title">거래처 상세정보</div>
				<button type="button" class="btn btn-orange" id="imgBtn" onclick="openImgModal()">사업자 등록증</button>		
			</div>


			<div class="info-table-wrap">
				<table class="info-table">

					<tbody>

						<tr>
							<th>거래처</th>
							<td>${vendor.vendorName} (${vendor.vendorId})</td>

							<th>사업자 번호</th>
							<td>${vendor.vendorBRN}</td>
						</tr>

						<tr>
							<th>유형</th>

							<td><c:choose>
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
								</c:choose></td>

							<th>전화번호</th>
							<td>${vendor.vendorTel}</td>
						</tr>

						<tr>
							<th>이메일</th>

							<td><c:choose>
									<c:when test="${not empty vendor.vendorEmail}">
										${vendor.vendorEmail}
									</c:when>

									<c:otherwise>
										-
									</c:otherwise>
								</c:choose></td>

							<th>우편번호</th>

							<td><c:choose>
									<c:when test="${not empty vendor.vendorZipcode}">
										${vendor.vendorZipcode}
									</c:when>

									<c:otherwise>
										-
									</c:otherwise>
								</c:choose></td>
						</tr>

						<tr>
							<th>주소</th>

							<td colspan="3">
								<div class="vendor-address-detail-row">
									<span> <c:choose>
											<c:when test="${not empty vendor.vendorAddr}">
												${vendor.vendorAddr}
												${vendor.vendorAddrDetail}
											</c:when>

											<c:otherwise>
												-
											</c:otherwise>
										</c:choose>
									</span>

									<c:if test="${not empty vendor.vendorAddr}">
										<button type="button" class="btn btn-none"
											id="vendorMapToggleBtn" onclick="showVendorMap()">
											지도보기</button>
									</c:if>
								</div>
							</td>
						</tr>

					</tbody>

				</table>

				<div id="vendorMap"
					style="display: none; width: 80%; height: 350px; margin: 20px auto 0; border-radius: 8px; overflow: hidden;">
				</div>

			</div>

		</div>

		<div class="content-content-content">

			<div class="content-content-content-title">거래처별 입출고 이력</div>

			<div class="table-wrap">

				<table class="table">

					<thead>
						<tr>
							<th>입출고 코드</th>
							<th>입/출고</th>
							<th>품목명</th>
							<th>사유</th>
							<th>입출고 일시</th>
							<th>수량</th>
							<th>LOT 번호</th>
						</tr>
					</thead>

					<tbody>

						<c:forEach var="io" items="${vendorIoList}">

							<tr class="movePage" onclick="window.location.href = 
								'${pageContext.request.contextPath}/io/detail?ioId=${io.ioId}'">

								<td class="ioId">${io.ioId}</td>

								<td><c:choose>
										<c:when test="${io.ioType == 'IN'}">
											<span class="status status-safe">입고</span>
										</c:when>

										<c:when test="${io.ioType == 'OUT'}">
											<span class="status status-warning">출고</span>
										</c:when>

										<c:otherwise>
											<span class="status">${io.ioType}</span>
										</c:otherwise>
									</c:choose></td>

								<td>${io.itemName}(${io.itemId})</td>

								<td>${io.ioReason}</td>

								<td><fmt:formatDate value="${io.ioDate}"
										pattern="yyyy-MM-dd HH:mm" /></td>

								<td>
									<fmt:formatNumber value="${io.ioQty}" pattern="#,###" />
								</td>

								<td>${io.ioLot}</td>

							</tr>

						</c:forEach>

						<c:if test="${empty vendorIoList}">
							<tr>
								<td colspan="7" style="text-align: center;">해당 거래처의 입출고 이력이
									없습니다.</td>
							</tr>
						</c:if>

					</tbody>

				</table>

			</div>
			<jsp:include page="/WEB-INF/views/common/paging.jsp" />
		</div>

	</div>

</div>


<div id="imgModal" class="overlay">
	<div class="modal vendor-img-modal">
		<div class="vendor-img-title-row">
			<div class="modal-title">사업자 등록증</div>

			<button type="button" class="btn btn-white" onclick="closeImgModal()">
				닫기
			</button>
		</div>

		<div class="vendor-img-wrap">
			<c:choose>
				<c:when test="${not empty vendor.vendorImg}">
					<img class="vendor-img"
						src="${pageContext.request.contextPath}${vendor.vendorImg}"
						alt="사업자 등록증">
				</c:when>

				<c:otherwise>
					<div class="vendor-img-empty">
						등록된 사업자 등록증 이미지가 없습니다.
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</div>

<style>
	.vendor-address-detail-row {
		display: inline-flex;
		align-items: center;
		gap: 12px;
		flex-wrap: wrap;
	}
	
	.detail-title-row {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
	}
	
	.detail-title-row .content-content-content-title {
		margin-bottom: 0;
	}
	
	.vendor-img-modal {
		width: 650px;
		max-width: 90vw;
		max-height: 90vh;
	}
	
	.vendor-img-title-row {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20px;
	}
	
	.vendor-img-wrap {
		max-height: 70vh;
		overflow: auto;
		text-align: center;
	}
	
	.vendor-img {
		max-width: 100%;
		height: auto;
	}
	
	.vendor-img-empty {
		padding: 60px 20px;
		text-align: center;
		color: var(--dark-gray);
	}
	
	.movePage:hover .ioId {
		color: var(--main-green);
		text-decoration: underline;
	}
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.table tr th:nth-child(4), .table tr td:nth-child(4),
	.table tr th:nth-child(7), .table tr td:nth-child(7) {
		display: none;
	}
	
}
	
</style>



<script
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=47bbd47c04e70af1e13f9280c52c609b&libraries=services"></script>

<script>
	let vendorMapLoaded = false;
	
	function openImgModal() {
		document.querySelector("#imgModal").classList.add("active");
		document.body.classList.add("modal-open");
	}

	function closeImgModal() {
		document.querySelector("#imgModal").classList.remove("active");
		document.body.classList.remove("modal-open");
	}

	function showVendorMap() {

		const mapBox = document.querySelector("#vendorMap");

		const mapBtn = document.querySelector("#vendorMapToggleBtn");

		if (mapBox.style.display === "block") {

			mapBox.style.display = "none";
			mapBtn.innerText = "지도보기";

			return;
		}

		mapBox.style.display = "block";
		mapBtn.innerText = "지도닫기";

		if (vendorMapLoaded) {
			return;
		}

		const address = "${vendor.vendorAddr}";

		if (!address || address.trim() === "") {

			alert("등록된 주소가 없습니다.");

			mapBox.style.display = "none";
			mapBtn.innerText = "지도보기";

			return;
		}

		const geocoder = new kakao.maps.services.Geocoder();

		geocoder.addressSearch(address, function(result, status) {

			if (status === kakao.maps.services.Status.OK) {

				const coords = new kakao.maps.LatLng(result[0].y, result[0].x);

				const map = new kakao.maps.Map(mapBox, {
					center : coords,
					level : 3
				});

				new kakao.maps.Marker({
					map : map,
					position : coords
				});

				map.setCenter(coords);

				vendorMapLoaded = true;

			} else {

				alert("주소로 지도를 찾을 수 없습니다.");

				mapBox.style.display = "none";
				mapBtn.innerText = "지도보기";
			}
		});
	}
</script>