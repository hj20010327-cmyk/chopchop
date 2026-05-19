<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">

		<div>
			<h2 class="page-title">입출고 이력 등록</h2>

			<p class="page-subtitle">
				새로운 입출고 이력을 등록할 수 있습니다.
			</p>
		</div>

		<div>
			<p class="page-route">
				홈 &gt; 입출고관리 &gt; 등록
			</p>
		</div>

	</div>

	<form action="${pageContext.request.contextPath}/io/insertDo"
		method="post"
		style="width:100%; max-width:1050px;">

		<div style="display:flex; justify-content:flex-end; gap:12px;">

			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/io/list">
				취소
			</a>

			<button type="submit" class="btn btn-main">
				등록
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
							<input type="radio" name="ioType" value="IN" checked>
							입고
						</div>

						<div style="display:flex; align-items:center; gap:7px;">
							<input type="radio" name="ioType" value="OUT">
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
						placeholder="작업자 선택"
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
					품목유형 <span class="red">*</span>
				</label>

				<select id="itemType" name="itemType">
					<option value="" disabled selected>품목유형 선택</option>
					<option value="10">원자재</option>
					<option value="20">반제품</option>
					<option value="30">완제품</option>
				</select>

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					품목 <span class="red">*</span>
				</label>

				<select id="itemId" name="itemId">
					<option value="" disabled selected>품목 선택</option>
				</select>

			</div>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="search-item"
				id="lotArea"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					LOT <span class="red">*</span>
				</label>

				<select id="ioLot" name="ioLot">
					<option value="" disabled selected>LOT 선택</option>
				</select>

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					수량 <span class="red">*</span>
				</label>

				<input type="text"
					name="ioQty"
					placeholder="수량 입력">

			</div>

		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					거래처 타입 <span class="red">*</span>
				</label>

				<select id="vendorType" name="vendorType">
					<option value="" disabled selected>거래처 타입 선택</option>
					<option value="S">공급처</option>
					<option value="C">납품처</option>
					<option value="E">기타</option>
				</select>

			</div>

			<div class="search-item"
				style="display:flex; flex-direction:column; flex:1;">

				<label>
					거래처 <span class="red">*</span>
				</label>

				<select id="ioVendor" name="ioVendor">
					<option value="" disabled selected>거래처명(거래처코드) 선택</option>
				</select>

			</div>

		</div>

		<div class="search-item"
			style="display:flex; flex-direction:column; margin-bottom:26px;">

			<label>
				일시 <span class="red">*</span>
			</label>

			<div>
				<input type="date" name="ioDay" required>
				<input type="time" name="ioTime" required>
			</div>

		</div>

		<div class="search-item"
			style="display:flex; flex-direction:column;">

			<label>
				비고
			</label>

			<textarea name="ioMsg"
				placeholder="비고를 입력하세요."
				style="height:220px;"></textarea>

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

	const ioTypeRadios = document.querySelectorAll("input[name='ioType']");

	const itemTypeSelect = document.querySelector("#itemType");
	const itemSelect = document.querySelector("#itemId");

	const lotArea = document.querySelector("#lotArea");
	let lotTag = document.querySelector("#ioLot");

	const vendorTypeSelect = document.querySelector("#vendorType");
	const vendorSelect = document.querySelector("#ioVendor");

	const qtyInput = document.querySelector("input[name='ioQty']");
	const qtyLabel = qtyInput.closest(".search-item").querySelector("label");

	const form = document.querySelector("form");

	const workerModal =
		document.querySelector("#workerModal");

	const workerSearchBtn =
		document.querySelector("#workerSearchBtn");

	const workerModalClose =
		document.querySelector("#workerModalClose");

	const workerSearchSubmit =
		document.querySelector("#workerSearchSubmit");

	const workerTbody =
		document.querySelector("#workerTbody");

	const workerSelectBtn =
		document.querySelector("#workerSelectBtn");

	const ioWorkerInput =
		document.querySelector("#ioWorker");

	function getIoType() {
		return document.querySelector("input[name='ioType']:checked").value;
	}

	function formatNumber(value) {

		value = String(value).replace(/[^0-9]/g, "");

		if (value === "") {
			return "";
		}

		return Number(value).toLocaleString("ko-KR");
	}

	function setQtyRequired(isRequired) {

		if (isRequired) {
			qtyLabel.innerHTML = '수량 <span class="red">*</span>';
		} else {
			qtyLabel.innerHTML = '수량';
		}

	}

	function changeLotToInput() {

		lotArea.innerHTML =
			'<label>LOT</label>' +
			'<input type="text" id="ioLot" name="ioLot" ' +
			'placeholder="자동생성" readonly>';

		lotTag = document.querySelector("#ioLot");
	}

	function changeLotToSelect() {

		lotArea.innerHTML =
			'<label>LOT <span class="red">*</span></label>' +
			'<select id="ioLot" name="ioLot">' +
				'<option value="" disabled selected>LOT 선택</option>' +
			'</select>';

		lotTag = document.querySelector("#ioLot");

		lotTag.addEventListener("change", function() {

			const selectedOption = this.options[this.selectedIndex];

			const lotQty =
				selectedOption.getAttribute("data-lot-fqty");

			if (lotQty !== null && lotQty !== "") {
				qtyInput.value = formatNumber(lotQty);
			}

		});
	}

	function applyIoTypeMode() {

		qtyInput.value = "";

		if (getIoType() === "IN") {

			changeLotToInput();

			qtyInput.readOnly = false;
			setQtyRequired(true);

		} else {

			changeLotToSelect();

			qtyInput.readOnly = true;
			setQtyRequired(false);

			if (itemSelect.value !== "") {
				loadLotList(itemSelect.value);
			}

		}
	}

	for (let i = 0; i < ioTypeRadios.length; i++) {
		ioTypeRadios[i].addEventListener("change", function() {
			applyIoTypeMode();
		});
	}

	itemTypeSelect.addEventListener("change", function() {

		const itemType = this.value;

		itemSelect.innerHTML =
			'<option value="" disabled selected>품목 선택</option>';

		qtyInput.value = "";

		if (getIoType() === "IN") {
			changeLotToInput();
		} else {
			changeLotToSelect();
		}

		if (itemType === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/itemList?itemType="
			+ encodeURIComponent(itemType))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {

				let html =
					'<option value="" disabled selected>품목 선택</option>';

				for (let i = 0; i < result.length; i++) {
					html += '<option value="' + result[i].itemId + '">';
					html += result[i].itemName + ' (' + result[i].itemId + ')';
					html += '</option>';
				}

				itemSelect.innerHTML = html;
			})
			.catch(function() {
				alert("품목 목록 조회 실패");
			});

	});

	itemSelect.addEventListener("change", function() {

		qtyInput.value = "";

		if (getIoType() === "OUT") {
			loadLotList(this.value);
		}

	});

	function loadLotList(itemId) {

		changeLotToSelect();

		if (itemId === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/lotList?itemId="
			+ encodeURIComponent(itemId))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {

				let html =
					'<option value="" disabled selected>LOT 선택</option>';

				for (let i = 0; i < result.length; i++) {

					html += '<option value="' + result[i].lotId + '" ';
					html += 'data-lot-fqty="' + result[i].lotFqty + '">';
					html += result[i].lotId + ' / 잔량 ' + result[i].lotFqty;
					html += '</option>';

				}

				lotTag.innerHTML = html;
			})
			.catch(function() {
				alert("LOT 목록 조회 실패");
			});
	}

	vendorTypeSelect.addEventListener("change", function() {

		const vendorType = this.value;

		vendorSelect.innerHTML =
			'<option value="" disabled selected>거래처명(거래처코드) 선택</option>';

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
					'<option value="" disabled selected>거래처명(거래처코드) 선택</option>';

				for (let i = 0; i < result.length; i++) {
					html += '<option value="' + result[i].vendorId + '">';
					html += result[i].vendorName + ' (' + result[i].vendorId + ')';
					html += '</option>';
				}

				vendorSelect.innerHTML = html;
			})
			.catch(function() {
				alert("거래처 목록 조회 실패");
			});

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

		});

	}

	workerSelectBtn.addEventListener("click", function() {

		const checked =
			document.querySelector("input[name='workerRadio']:checked");

		if (!checked) {

			alert("작업자를 선택하세요.");
			return;

		}

		const empId =
			checked.value;

		const empName =
			checked.getAttribute("data-name");

		ioWorkerInput.value =
			empName + " (" + empId + ")";

		workerModal.style.display = "none";

	});

	qtyInput.addEventListener("input", function() {

		if (qtyInput.readOnly) {
			return;
		}

		let value = this.value.replace(/[^0-9]/g, "");

		if (value === "") {
			this.value = "";
			return;
		}

		this.value = Number(value).toLocaleString("ko-KR");
	});

	qtyInput.addEventListener("keydown", function(e) {

		if (e.key === "-" || e.key === "e") {
			e.preventDefault();
		}

	});

	form.addEventListener("submit", function() {

		qtyInput.value =
			qtyInput.value.replace(/,/g, "");

		ioWorkerInput.value =
			ioWorkerInput.value.replace(/^.*\((.*)\)$/, "$1");

	});

	applyIoTypeMode();

});
</script>