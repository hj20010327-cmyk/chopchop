<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<!-- 헤더 -->
	<div class="header-row">

		<div>
			<h2 class="page-title">입출고 이력 등록</h2>

			<p class="page-subtitle">입출고 내역을 작성하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 > 입출고관리 > 등록</p>
		</div>

	</div>

	<!-- 버튼 -->
	<form action="${pageContext.request.contextPath}/io/addDo"
		method="post">

		<div class="btn-row">

			<div></div>

			<div>

				<a class="btn btn-white"
					href="${pageContext.request.contextPath}/io/list"> 취소 </a>

				<button type="submit" class="btn btn-main">등록</button>

			</div>

		</div>

		<!-- 본문 -->
		<div class="content-content"
			style="max-width: 1100px; margin: 0 auto;">

			<div class="content-content-content">

				<div class="grid-form" style="gap: 40px;">

					<!-- 담당자 -->
					<div class="grid-wrap">

						<div style="font-size: 18px; font-weight: 700;">담당자 : 김치시
							(EMP1002)</div>

					</div>

					<!-- 입출고 유형 -->
					<div class="grid-wrap" style="align-items: center;">

						<div style="width: 140px; font-size: 16px; font-weight: 700;">

							입출고 유형 <span class="red">*</span>

						</div>

						<div style="display: flex; align-items: center; gap: 40px;">

							<label
								style="display: flex; align-items: center; gap: 8px; font-size: 15px;">

								<input type="radio" name="ioType" value="입고" required
								style="min-width: auto; width: auto; margin: 0;"> 입고

							</label> <label
								style="display: flex; align-items: center; gap: 8px; font-size: 15px;">

								<input type="radio" name="ioType" value="출고"
								style="min-width: auto; width: auto; margin: 0;"> 출고

							</label>

						</div>

					</div>

					<!-- 품목 -->
					<div class="grid-wrap" style="align-items: center;">

						<div style="width: 140px; font-size: 16px; font-weight: 700;">

							품목 <span class="red">*</span>

						</div>

						<div style="display: flex; gap: 14px; flex-direction: row;"
							class="search-item">

							<select id="itemType" name="itemType"
								style="width: 180px; min-width: 180px;">

								<option value="">품목 유형 선택</option>
								<option value="10">원자재</option>
								<option value="20">반제품</option>
								<option value="30">완제품</option>

							</select> <select id="itemId" name="ioItem"
								style="width: 180px; min-width: 180px;">

								<option value="">품목 선택</option>

							</select> <select id="lotId" name="ioLot"
								style="width: 180px; min-width: 180px;">

								<option value="">LOT 선택</option>

							</select>

						</div>

					</div>

					<!-- 수량 / 일시 -->
					<div class="grid-wrap"
						style="justify-content: space-between; gap: 40px;">

						<!-- 수량 -->
						<div
							style="display: flex; align-items: center; flex-direction: row; justify-content: space-between; gap: 65px;"
							class="search-item">

							<div
								style="width: 100px; font-size: 16px; font-weight: 700; flex-shrink: 0;">

								입출고 수량 <span class="red">*</span>

							</div>

							<input type="number" name="ioQty" placeholder="입출고 수량 입력"
								required style="width: 100%;">

						</div>

						<!-- 일시 -->
						<div
							style="display: flex; align-items: center; flex-direction: row; justify-content: space-between; gap: 25px; flex: 1;"
							class="search-item">

							<div
								style="width: 140px; font-size: 16px; font-weight: 700; flex-shrink: 0;">

								입출고 일시 <span class="red">*</span>

							</div>

							<input type="datetime-local" name="ioDate" style="width: 100%;">

						</div>

					</div>

					<!-- 사유 / 거래처 -->
					<div class="grid-wrap"
						style="justify-content: space-between; gap: 40px;">

						<!-- 사유 -->
						<div
							style="display: flex; align-items: center; flex-direction: row; justify-content: space-between; gap: 25px; flex: 1;"
							class="search-item">

							<div
								style="width: 140px; font-size: 16px; font-weight: 700; flex-shrink: 0;">

								입출고 사유 <span class="red">*</span>

							</div>

							<input type="text" name="ioReason" placeholder="입출고 사유 입력"
								required style="width: 100%; min-width: auto;">

						</div>

						<!-- 거래처 -->
						<div
							style="display: flex; align-items: center; flex-direction: row; justify-content: space-between; gap: 25px; flex: 1;"
							class="search-item">

							<div
								style="width: 140px; font-size: 16px; font-weight: 700; flex-shrink: 0;">

								거래처</div>

							<select name="vendorId" style="width: 100%; min-width: auto;">

								<option value="">거래처 선택</option>

								<c:forEach var="vendor" items="${vendorList}">

									<option value="${vendor.vendorId}">

										${vendor.vendorName} (${vendor.vendorId})</option>

								</c:forEach>

							</select>

						</div>

					</div>

					<!-- 비고 -->
					<div class="grid-wrap"
						style="flex-direction: column; align-items: flex-start; gap: 12px; width: 100%;">

						<div style="font-size: 16px; font-weight: 700;">비고</div>

						<textarea name="ioMsg" placeholder="입출고 특이사항을 입력하세요. (선택)"
							style="width: 100%; height: 220px;"></textarea>

					</div>

				</div>

			</div>

		</div>

	</form>

</div>
<script>
	window.addEventListener("load", function() {

		const itemTypeSelect = document.querySelector("#itemType");
		const itemSelect = document.querySelector("#itemId");
		const lotSelect = document.querySelector("#lotId");

		itemTypeSelect.addEventListener("change", function() {

			const itemType = this.value;

			itemSelect.innerHTML = '<option value="">품목 선택</option>';
			lotSelect.innerHTML = '<option value="">LOT 선택</option>';

			if (itemType === "") {
				return;
			}

			fetch(
					"${pageContext.request.contextPath}/io/itemList?itemType="
							+ encodeURIComponent(itemType)).then(
					function(response) {
						return response.json();
					}).then(function(result) {

				let html = '<option value="">품목 선택</option>';

				for (let i = 0; i < result.length; i++) {
					html += '<option value="' + result[i].itemId + '">';
					html += result[i].itemName + ' (' + result[i].itemId + ')';
					html += '</option>';
				}

				itemSelect.innerHTML = html;
			});
		});

		itemSelect.addEventListener("change", function() {

			const itemId = this.value;

			lotSelect.innerHTML = '<option value="">LOT 선택</option>';

			if (itemId === "") {
				return;
			}

			fetch(
					"${pageContext.request.contextPath}/io/lotList?itemId="
							+ encodeURIComponent(itemId)).then(
					function(response) {
						return response.json();
					}).then(
					function(result) {

						let html = '<option value="">LOT 선택</option>';

						for (let i = 0; i < result.length; i++) {
							html += '<option value="' + result[i].lotId + '">';
							html += result[i].lotId + ' / 재고 '
									+ result[i].lotFqty + 'EA';
							html += '</option>';
						}

						lotSelect.innerHTML = html;
					});
		});

	});
</script>