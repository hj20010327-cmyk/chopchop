<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">

		<div>
			<h2 class="page-title">입출고 이력 수정</h2>

			<p class="page-subtitle">
				입출고 이력 정보를 수정할 수 있습니다.
			</p>
		</div>

		<div>
			<p class="page-route">
				홈 &gt; 입출고관리 &gt; 수정
			</p>
		</div>

	</div>

	<form action="${pageContext.request.contextPath}/io/updateDo"
		method="post"
		style="width:100%; max-width:1050px;">

		<input type="hidden" name="ioId" value="${io.ioId}">

		<div style="display:flex; justify-content:flex-end; gap:12px;">

			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/io/detail?ioId=${io.ioId}">
				취소
			</a>

			<button type="submit" class="btn btn-main">
				수정
			</button>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="grid-wrap">

				<div class="grid search-item"
					style="display:flex; flex-direction:row; align-items:center; gap:25px;">

					<label>
						입출고 유형 <span class="red">*</span>
					</label>

					<div style="display:flex; justify-content:flex-start; gap:20px; font-size:14px;">

						<div style="display:flex; align-items:center; gap:7px;">
							<input type="radio"
								name="ioType"
								value="IN"
								<c:if test="${io.ioType == 'IN'}">checked</c:if>>
							입고
						</div>

						<div style="display:flex; align-items:center; gap:7px;">
							<input type="radio"
								name="ioType"
								value="OUT"
								<c:if test="${io.ioType == 'OUT'}">checked</c:if>>
							출고
						</div>

					</div>

				</div>

			</div>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					입출고 사유 <span class="red">*</span>
				</label>

				<input type="text"
					name="ioReason"
					value="${io.ioReason}"
					placeholder="입출고 사유 입력">

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					담당자 <span class="red">*</span>
				</label>

				<div style="display:flex; gap:10px;">

					<input type="text"
						id="ioWorker"
						name="ioWorker"
						value="${io.workerName} (${io.ioWorker})"
						placeholder="담당자 선택"
						readonly>

					<button type="button"
						class="btn btn-main"
						id="workerSearchBtn">
						작업자 조회
					</button>

				</div>

			</div>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					LOT
				</label>

				<input type="text"
					name="ioLot"
					value="${io.ioLot}"
					placeholder="LOT 번호 입력"
					readonly>

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					수량
				</label>

				<input type="text"
					name="ioQty"
					value="${io.ioQty}"
					placeholder="수량 입력"
					readonly>

			</div>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					거래처 타입 <span class="red">*</span>
				</label>

				<select id="vendorType">

					<option value="">
						거래처 타입 선택
					</option>

					<option value="S"
						<c:if test="${vendorType == 'S'}">selected</c:if>>
						공급처
					</option>

					<option value="C"
						<c:if test="${vendorType == 'C'}">selected</c:if>>
						납품처
					</option>

					<option value="E"
						<c:if test="${vendorType == 'E'}">selected</c:if>>
						기타
					</option>

				</select>

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					거래처 <span class="red">*</span>
				</label>

				<select id="ioVendor"
					name="ioVendor">

					<option value="${io.ioVendor}">
						${io.vendorName} (${io.ioVendor})
					</option>

				</select>

			</div>

		</div>

		<div class="search-item"
			style="display:flex; flex-direction:column; margin-bottom:26px;">

			<label>
				일시
			</label>

			<div>
				<input type="date"
					name="ioDay"
					value="${io.ioDay}"
					placeholder="입출고 날짜"
					required>

				<input type="time"
					name="ioTime"
					value="${io.ioTime}"
					placeholder="입출고 시간"
					required>
			</div>

		</div>

		<div class="search-item"
			style="display:flex; flex-direction:column;">

			<label>
				비고
			</label>

			<textarea name="ioMsg"
				placeholder="비고를 입력하세요."
				style="height:220px;">${io.ioMsg}</textarea>

		</div>

	</form>

</div>

<!-- 작업자 조회 모달 -->
<div id="workerModal"
	style="
		display:none;
		position:fixed;
		top:0;
		left:0;
		width:100%;
		height:100%;
		background:rgba(0,0,0,0.35);
		z-index:9999;
		justify-content:center;
		align-items:center;
	">

	<div style="
		width:620px;
		background:white;
		border-radius:10px;
		padding:30px;
		box-sizing:border-box;
	">

		<h2 style="
			margin-bottom:10px;
			font-size:28px;
			font-weight:700;
		">
			작업자 조회
		</h2>

		<p style="
			color:#888;
			margin-bottom:25px;
		">
			작업자를 조회 후 선택해주세요.
		</p>

		<div style="
			display:flex;
			gap:10px;
			margin-bottom:20px;
		">

			<input type="text"
				id="workerKeyword"
				placeholder="이름/사원번호 검색"
				style="flex:1;">

			<button type="button"
				class="btn btn-main"
				id="workerSearchSubmit">
				검색
			</button>

		</div>

		<table class="list-table">

			<thead>
				<tr>
					<th>사원번호</th>
					<th>사원명</th>
					<th>선택</th>
				</tr>
			</thead>

			<tbody id="workerTbody">
			</tbody>

		</table>

		<div style="
			display:flex;
			justify-content:center;
			gap:10px;
			margin-top:25px;
		">

			<button type="button"
				class="btn btn-white"
				id="workerModalClose">
				취소
			</button>

			<button type="button"
				class="btn btn-main"
				id="workerSelectBtn">
				선택
			</button>

		</div>

	</div>

</div>

<style>
	input[type="radio"] {
		width:15px;
		min-width:15px;
		height:15px;
	}
</style>

<script>
window.addEventListener("load", function() {

	const qtyInput = document.querySelector("input[name='ioQty']");
	const form = document.querySelector("form");

	const vendorTypeSelect = document.querySelector("#vendorType");
	const vendorSelect = document.querySelector("#ioVendor");

	const currentVendorType = "${vendorType}";
	const currentVendorId = "${io.ioVendor}";

	const workerModal = document.querySelector("#workerModal");
	const workerSearchBtn = document.querySelector("#workerSearchBtn");
	const workerModalClose = document.querySelector("#workerModalClose");
	const workerSearchSubmit = document.querySelector("#workerSearchSubmit");
	const workerTbody = document.querySelector("#workerTbody");
	const workerSelectBtn = document.querySelector("#workerSelectBtn");
	const ioWorkerInput = document.querySelector("#ioWorker");

	function loadVendorList(vendorType, selectedVendorId) {

		vendorSelect.innerHTML =
			'<option value="">거래처명(거래처코드) 선택</option>';

		if (vendorType === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/item/vendorList?vendorType="
			+ encodeURIComponent(vendorType))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {

				let html =
					'<option value="">거래처명(거래처코드) 선택</option>';

				for (let i = 0; i < result.length; i++) {

					let selected = "";

					if (selectedVendorId === result[i].vendorId) {
						selected = "selected";
					}

					html += '<option value="' + result[i].vendorId + '" ' + selected + '>';
					html += result[i].vendorName + ' (' + result[i].vendorId + ')';
					html += '</option>';
				}

				vendorSelect.innerHTML = html;
			})
			.catch(function() {
				alert("거래처 목록 조회 실패");
			});
	}

	if (currentVendorType !== "") {
		vendorTypeSelect.value = currentVendorType;
		loadVendorList(currentVendorType, currentVendorId);
	}

	vendorTypeSelect.addEventListener("change", function() {
		loadVendorList(this.value, "");
	});

	workerSearchBtn.addEventListener("click", function() {
		workerModal.style.display = "flex";
		loadWorkerList("");
	});

	workerModalClose.addEventListener("click", function() {
		workerModal.style.display = "none";
	});

	workerSearchSubmit.addEventListener("click", function() {

		const keyword =
			document.querySelector("#workerKeyword").value;

		loadWorkerList(keyword);
	});

	function loadWorkerList(keyword) {

		fetch(
			"${pageContext.request.contextPath}/io/workerList?keyword="
			+ encodeURIComponent(keyword)
		)
		.then(function(response) {
			return response.json();
		})
		.then(function(result) {

			let html = "";

			for (let i = 0; i < result.length; i++) {

				html += "<tr>";

				html += "<td>" + result[i].empId + "</td>";

				html += "<td>" + result[i].empName + "</td>";

				html += "<td>";
				html += "<input type='radio' ";
				html += "name='workerRadio' ";
				html += "value='" + result[i].empId + "' ";
				html += "data-name='" + result[i].empName + "'>";
				html += "</td>";

				html += "</tr>";
			}

			workerTbody.innerHTML = html;
		})
		.catch(function() {
			alert("작업자 목록 조회 실패");
		});
	}

	workerSelectBtn.addEventListener("click", function() {

		const checked =
			document.querySelector("input[name='workerRadio']:checked");

		if (!checked) {
			alert("작업자를 선택하세요.");
			return;
		}

		const empId = checked.value;
		const empName = checked.getAttribute("data-name");

		ioWorkerInput.value =
			empName + " (" + empId + ")";

		workerModal.style.display = "none";
	});

	function formatComma(inputTag) {

		let firstValue = inputTag.value.replace(/[^0-9]/g, "");

		if (firstValue !== "") {
			inputTag.value = Number(firstValue).toLocaleString("ko-KR");
		}

		inputTag.addEventListener("input", function() {

			let value = this.value.replace(/[^0-9]/g, "");

			if (value === "") {
				this.value = "";
				return;
			}

			this.value = Number(value).toLocaleString("ko-KR");
		});
	}

	function preventNegative(inputTag) {

		inputTag.addEventListener("keydown", function(e) {

			if (e.key === "-" || e.key === "e") {
				e.preventDefault();
			}

		});
	}

	formatComma(qtyInput);
	preventNegative(qtyInput);

	form.addEventListener("submit", function() {

		qtyInput.value =
			qtyInput.value.replace(/,/g, "");

		ioWorkerInput.value =
			ioWorkerInput.value.replace(/^.*\((.*)\)$/, "$1");

	});

});
</script>