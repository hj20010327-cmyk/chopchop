<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">입출고 이력 등록</h2>
			<p class="page-subtitle">새로운 입출고 이력을 등록할 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 입출고관리 &gt; 등록</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/io/insertDo"
		method="post"
		style="width:100%; max-width:1050px;">

		<div style="display:flex; justify-content:flex-end; gap:12px;">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/io/list">취소</a>

			<button type="submit" class="btn btn-main" id="submitBtn">등록</button>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">
			<div class="grid-wrap">
				<div class="grid search-item"
					style="display:flex; flex-direction:row; align-items:center; gap:25px;">
					<label>입출고 유형 <span class="red">*</span></label>

					<div style="display:flex; justify-content:flex-start; gap:20px; font-size:14px;">
						<div style="display:flex; align-items:center; gap:7px;">
							<input type="radio" name="ioType" value="IN" checked> 입고
						</div>

						<div style="display:flex; align-items:center; gap:7px;">
							<input type="radio" name="ioType" value="OUT"> 출고
						</div>
					</div>
				</div>
			</div>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">
			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>입출고 사유 <span class="red">*</span></label>
				<select name="ioReason" id="ioReason"></select>
<!-- 				<input type="text" name="ioReason" placeholder="입출고 사유 입력"> -->
			</div>

			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>담당자 <span class="red">*</span></label>

				<input type="text"
					id="ioWorkerView"
					value="${sessionScope.loginUser.empName} (${sessionScope.loginUser.empId})"
					readonly>

				<input type="hidden"
					id="ioWorker"
					name="ioWorker"
					value="${sessionScope.loginUser.empId}">
			</div>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">
			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>품목유형 <span class="red">*</span></label>

				<select id="itemType" name="itemType">
					<option value="" disabled selected>품목유형 선택</option>
					<option value="10">원자재</option>
					<option value="20">반제품</option>
					<option value="30">완제품</option>
					<option value="40">기타 자재</option>
				</select>
			</div>

			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>품목 <span class="red">*</span></label>

				<select id="itemId" name="itemId">
					<option value="" disabled selected>품목 선택</option>
				</select>
			</div>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;" id="warehouseArea">
			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>창고 <span class="red">*</span></label>

				<select id="warehouse" name="whId">
					<option value="" disabled selected>창고 선택</option>
				</select>
			</div>

			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>창고 섹션 <span class="red">*</span></label>

				<select name="whSec" id="whSec">
					<option value="" disabled selected>섹션 선택</option>
				</select>
			</div>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">
			<div class="search-item" id="lotArea"
				style="display:flex; flex-direction:column; flex:1;">
				<label>LOT</label>
				<input type="text" id="ioLot" name="ioLot" placeholder="자동생성" readonly>
			</div>

			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>수량 <span class="red">*</span></label>
				<input type="text" name="ioQty" placeholder="수량 입력">
			</div>
		</div>

		<div style="display:flex; gap:40px; margin-bottom:26px;">
			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>거래처 타입</label>

				<select id="vendorType" name="vendorType">
					<option value="" disabled selected>거래처 타입 선택</option>
					<option value="S">공급처</option>
					<option value="C">납품처</option>
					<option value="E">기타</option>
				</select>
			</div>

			<div class="search-item" style="display:flex; flex-direction:column; flex:1;">
				<label>거래처</label>

				<select id="ioVendor" name="ioVendor">
					<option value="" disabled selected>거래처명(거래처코드) 선택</option>
				</select>
			</div>
		</div>

		<div class="search-item"
			style="display:flex; flex-direction:column; margin-bottom:26px;">
			<label>일시 <span class="red">*</span></label>

			<div>
				<input type="date" name="ioDay">
				<input type="time" name="ioTime">
			</div>
		</div>

		<div class="search-item" style="display:flex; flex-direction:column;">
			<label>비고</label>

			<textarea name="ioMsg"
				placeholder="비고를 입력하세요."
				style="height:220px;"></textarea>
		</div>

	</form>
</div>

<style>
	input[type="radio"] {
		width:15px;
		min-width:15px;
		height:15px;
	}

	select:disabled {
		background-color: var(--light-gray);
		color: #000;
		cursor: not-allowed;
		outline: none;
	}
</style>

<script>
window.addEventListener("load", function() {

	let submitLock = false;

	const ioTypeRadios = document.querySelectorAll("input[name='ioType']");
	const itemTypeSelect = document.querySelector("#itemType");
	const itemSelect = document.querySelector("#itemId");
	
	const ioReason = document.querySelector("#ioReason");

	const lotArea = document.querySelector("#lotArea");
	let lotTag = document.querySelector("#ioLot");

	const vendorTypeSelect = document.querySelector("#vendorType");
	const vendorSelect = document.querySelector("#ioVendor");

	const qtyInput = document.querySelector("input[name='ioQty']");
	const qtyLabel = qtyInput.closest(".search-item").querySelector("label");

	const form = document.querySelector("form");
	const submitBtn = document.querySelector("#submitBtn");

	const warehouseArea = document.querySelector("#warehouseArea");
	const warehouseSelect = document.querySelector("#warehouse");
	const whSecSelect = document.querySelector("#whSec");

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
			'<input type="text" id="ioLot" name="ioLot" placeholder="자동생성" readonly>';

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
			const lotQty = selectedOption.getAttribute("data-lot-fqty");

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

			warehouseArea.style.display = "flex";
			
			ioReason.innerHTML = `
				<option value='' dsiabled>입고 사유 선택</option>
				<option value='구매'>구매</option>
				<option value='생산'>생산</option>
			`;
		} else {
			changeLotToSelect();

			qtyInput.readOnly = true;
			setQtyRequired(false);

			warehouseArea.style.display = "none";

			if (itemSelect.value !== "") {
				loadLotList(itemSelect.value);
			}
			
			ioReason.innerHTML = `
				<option value='' dsiabled>출고 사유 선택</option>
				<option value='판매'>판매</option>
				<option value='폐기'>폐기</option>
			`;
			
			
		}
	}

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
				let html = '<option value="" disabled selected>LOT 선택</option>';

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

	function loadWarehouseList(itemId) {
		warehouseSelect.innerHTML =
			'<option value="" disabled selected>창고 선택</option>';

		whSecSelect.innerHTML =
			'<option value="" disabled selected>섹션 선택</option>';

		if (itemId === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/warehouseList?itemId="
			+ encodeURIComponent(itemId))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {
				let html = '<option value="" disabled selected>창고 선택</option>';

				for (let i = 0; i < result.length; i++) {
					html += '<option value="' + result[i].whId + '">';
					html += result[i].whName + ' (' + result[i].whId + ')';
					html += '</option>';
				}

				warehouseSelect.innerHTML = html;
			})
			.catch(function() {
				alert("창고 목록 조회 실패");
			});
	}

	function loadWhSecList(whId) {
		whSecSelect.innerHTML =
			'<option value="" disabled selected>섹션 선택</option>';

		if (whId === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/whSecList?whId="
			+ encodeURIComponent(whId))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {
				let html = '<option value="" disabled selected>섹션 선택</option>';

				for (let i = 0; i < result.length; i++) {
					html += '<option value="' + result[i].secId + '">';
					html += result[i].secId;
					html += ' (' + result[i].secPrevQty + '/' + result[i].secQty + ')';
					html += '</option>';
				}

				whSecSelect.innerHTML = html;
			})
			.catch(function() {
				alert("창고 섹션 조회 실패");
			});
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

		warehouseSelect.innerHTML =
			'<option value="" disabled selected>창고 선택</option>';

		whSecSelect.innerHTML =
			'<option value="" disabled selected>섹션 선택</option>';

		if (itemType === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/itemList?itemType="
			+ encodeURIComponent(itemType))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {
				let html = '<option value="" disabled selected>품목 선택</option>';

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

		loadWarehouseList(this.value);

		if (getIoType() === "OUT") {
			loadLotList(this.value);
		}
	});

	warehouseSelect.addEventListener("change", function() {
		loadWhSecList(this.value);
	});

	vendorTypeSelect.addEventListener("change", function() {
		const vendorType = this.value;

		vendorSelect.innerHTML =
			'<option value="" disabled selected>거래처명(거래처코드) 선택</option>';

		if (vendorType === "") {
			return;
		}

		fetch("${pageContext.request.contextPath}/io/vendorList?vendorType="
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

	form.addEventListener("submit", function(e) {
		if (submitLock) {
			e.preventDefault();
			return;
		}

		const requiredLabels = document.querySelectorAll("label .red");

		for (let i = 0; i < requiredLabels.length; i++) {
			const label = requiredLabels[i].closest("label");

			if (label.offsetParent === null) {
				continue;
			}

			let target = label.nextElementSibling;

			if (target && !target.matches("input, select, textarea")) {
				target = target.querySelector("input, select, textarea");
			}

			if (!target) {
				continue;
			}

			if (target.offsetParent === null) {
				continue;
			}

			if (target.value.trim() === "") {
				alert(label.innerText.replace("*", "").trim() + " 항목을 입력하세요.");
				target.focus();

				e.preventDefault();
				return;
			}
		}

		if (getIoType() === "IN") {
			if (warehouseSelect.value === "") {
				alert("창고를 선택하세요.");
				warehouseSelect.focus();

				e.preventDefault();
				return;
			}

			if (whSecSelect.value === "") {
				alert("창고 섹션을 선택하세요.");
				whSecSelect.focus();

				e.preventDefault();
				return;
			}
		}

		qtyInput.value = qtyInput.value.replace(/,/g, "");

		submitLock = true;

		if (submitBtn) {
			submitBtn.disabled = true;
			submitBtn.innerText = "등록 중...";
		}
	});

	applyIoTypeMode();
});
</script>