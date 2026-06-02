<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">창고 정보 수정</h2>
            <p class="page-subtitle">${whDTO.whName}(${whDTO.whId})의 정보를 수정하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 창고 관리 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/warehouse/update"
          method="post"
          class="grid-form"
          onsubmit="return beforeSubmit();">

        <input type="hidden" name="whId" value="${whDTO.whId}">
        <input type="hidden" name="sectionPayload" id="sectionPayload">
        <input type="hidden" name="deleteSecIds" id="deleteSecIds">

		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/warehouse/detail?whId=${whDTO.whId}"
	               onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
	                취소
	            </a>
	
	            <button type="submit" class="btn btn-main">
	                수정
	            </button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>유형 <span class="red">*</span></label>
				<select name="whTypeNo" required>
					<option value="" disabled>창고 유형 선택</option>
	                <option value="10" ${whDTO.whTypeNo == 10 ? 'selected' : ''}>원자재 냉동창고</option>
					<option value="20" ${whDTO.whTypeNo == 20 ? 'selected' : ''}>원자재 냉장창고</option>
					<option value="30" ${whDTO.whTypeNo == 30 ? 'selected' : ''}>원자재 상온창고</option>
					<option value="40" ${whDTO.whTypeNo == 40 ? 'selected' : ''}>반제품 냉장창고</option>
					<option value="50" ${whDTO.whTypeNo == 50 ? 'selected' : ''}>반제품 냉동창고</option>
					<option value="60" ${whDTO.whTypeNo == 60 ? 'selected' : ''}>완제품 냉동창고</option>
					<option value="70" ${whDTO.whTypeNo == 70 ? 'selected' : ''}>기타 자재 상온창고</option>
					<option value="80" ${whDTO.whTypeNo == 80 ? 'selected' : ''}>반품/회수품 보관창고</option>
					<option value="90" ${whDTO.whTypeNo == 90 ? 'selected' : ''}>부적합품 보관창고</option>
					<option value="100" ${whDTO.whTypeNo == 100 ? 'selected' : ''}>폐기 대기창고</option>
	            </select>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>창고 이름 <span class="red">*</span></label>
				<input type="text" name="whName" placeholder="창고 이름 입력" value="${whDTO.whName}" required>
			</div>
			<div class="grid search-item">
				<label>창고 위치 <span class="red">*</span></label>
				<input type="text" name="whLoc" placeholder="창고 위치 입력" value="${whDTO.whLoc}" required>
			</div>
		</div>

		<div class="content-content-content section-config">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 섹션 설정
				</div>
				<div class="right">
					<button type="button" class="btn btn-main" onclick="openAddSecModal()">
						섹션 추가
					</button>
				</div>
			</div>
		
			<div class="section-layout">
				<div class="map-card" style="display: flex; flex-direction: column; align-items:center;">
					<h3>창고 영역도</h3>
					<div id="warehouseMap" class="warehouse-map"></div>
				</div>
		
				<div class="table-wrap">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 120px;">섹션번호</th>
								<th style="width: 115px;">수용량(LOT)</th>
								<th style="width: 105px;">순서</th>
								<th style="width: 80px;">삭제</th>
							</tr>
						</thead>
						<tbody id="sectionTableBody">
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div id="secModal" class="modal-bg">
			<div class="modal-box">
				<div class="modal-title" id="secModalTitle">섹션 추가</div>
		
				<div class="search-item">
					<label id="secModalLabel">섹션 수용량 <span class="red">*</span></label>
					<input type="number" id="modalSecQty" min="1" placeholder="수용량 입력">
				</div>
		
				<div id="modalSecInfo" class="modal-sec-info"></div>
		
				<div class="btn-row modal-btn-row">
					<div class="left"></div>
					<div class="right">
						<button type="button" class="btn btn-white" onclick="closeSecModal()">
							취소
						</button>
						<button type="button" class="btn btn-main" onclick="saveSecModal()">
							저장
						</button>
					</div>
				</div>
			</div>
		</div>

    </form>

</div>

<style>
	.section-config {
		margin-top: 25px;
	}

	.section-layout {
		display: flex;
		align-items: flex-start;
		gap: 15px;
		width: 100%;
	}
	
	.map-card {
		width: 50%;
		height: 445px;
		border: 1px solid #ddd;
		border-radius: 8px;
		padding: 20px;
		background: #fff;
	}
	
	.section-layout > .table-wrap {
		width: 420px;
	}
	
	.warehouse-map {
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		background: #fff;
	}
	
	.wh-svg {
		width: 100%;
		max-width: 620px;
		height: auto;
		display: block;
	}

	.wh-border {
		fill: #fafafa;
		stroke: #777;
		stroke-width: 3;
	}

	.wh-door {
		fill: #fff;
		stroke: #777;
		stroke-width: 2;
	}

	.sec-box {
		fill: #fff;
		stroke: #777;
		stroke-width: 2;
		cursor: pointer;
		transition: 0.15s;
	}

	.sec-text {
		font-size: 14px;
		font-weight: 700;
		text-anchor: middle;
		dominant-baseline: middle;
		fill: #222;
		pointer-events: none;
	}

	.sec-sub-text {
		font-size: 10.5px;
		font-weight: 600;
		text-anchor: middle;
		dominant-baseline: middle;
		fill: #666;
		pointer-events: none;
	}

	.modal-bg {
		display: none;
		position: fixed;
		left: 0;
		top: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.35);
		z-index: 9999;
		justify-content: center;
		align-items: center;
	}

	.modal-bg.show {
		display: flex;
	}

	.modal-box {
		width: 360px;
		background: #fff;
		border-radius: 10px;
		padding: 22px;
		box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
	}

	.modal-title {
		font-size: 18px;
		font-weight: 700;
		margin-bottom: 18px;
	}

	.modal-btn-row {
		margin-top: 20px;
	}

	.order-btn {
		padding: 4px 8px;
		border: 1px solid #ddd;
		background: #fff;
		cursor: pointer;
		border-radius: 4px;
	}

	.order-btn:hover {
		border-color: var(--main-green);
		color: var(--main-green);
	}

	.delete-sec-btn {
		padding: 4px 8px;
		border: 1px solid var(--danger);
		color: var(--danger);
		background: #fff;
		cursor: pointer;
		border-radius: 4px;
	}
	
	.sec-id-link {
		cursor: pointer;
	}
	
	.table tbody tr:hover .sec-id-link {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	.modal-sec-info {
		margin-top: 10px;
		font-size: 13px;
		color: var(--dark-gray);
		line-height: 1.5;
	}
	
	
		
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.section-layout {
		flex-direction : column;
		align-items: center;
	}
	
	.map-card {
		width: 90%;
		height: auto;
	}
	
	.empty-map {
		margin: 50px auto !important;
	}
}
	
	
	
@media screen and (max-width: 480px) {
	.grid-wrap {
		display: flex !important;
		flex-direction: column !important;
		align-items: flex-start;
	}
	
	.grid-wrap input {
		width: 80vw;
	}
	
}
	
	
	
	
</style>

<script>
	let sectionList = [
		<c:forEach var="sec" items="${secList}" varStatus="status">
			{
				secId: "${sec.secId}",
				secQty: ${sec.secQty},
				secPrevQty: ${sec.secPrevQty},
				isNew: false
			}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	let deletedSecIds = [];
	let secModalMode = "add";
	let secEditIndex = -1;

	window.addEventListener("load", function () {
		renderAll();
	});
	
	function openAddSecModal() {
		secModalMode = "add";
		secEditIndex = -1;

		document.querySelector("#secModalTitle").textContent = "섹션 추가";
		document.querySelector("#secModalLabel").innerHTML = '섹션 수용량 <span class="red">*</span>';
		document.querySelector("#modalSecQty").value = "";
		document.querySelector("#modalSecInfo").textContent = "";

		document.querySelector("#secModal").classList.add("show");
		document.querySelector("#modalSecQty").focus();
	}

	function openEditSecModal(index) {
		const sec = sectionList[index];

		secModalMode = "edit";
		secEditIndex = index;

		const displaySecId = sec.isNew ? "신규 섹션" : sec.secId;

		document.querySelector("#secModalTitle").textContent = "섹션 수용량 수정";
		document.querySelector("#secModalLabel").innerHTML = displaySecId + ' 수용량 <span class="red">*</span>';
		document.querySelector("#modalSecQty").value = sec.secQty;

		if (sec.secPrevQty > 0) {
			document.querySelector("#modalSecInfo").textContent =
				"현재 적재량: " + sec.secPrevQty + " LOT / 현재 수용량: " + sec.secQty + " LOT";
		} else {
			document.querySelector("#modalSecInfo").textContent =
				"현재 적재량: 0 LOT / 현재 수용량: " + sec.secQty + " LOT";
		}

		document.querySelector("#secModal").classList.add("show");
		document.querySelector("#modalSecQty").focus();
	}

	function closeSecModal() {
		document.querySelector("#secModal").classList.remove("show");
		secModalMode = "add";
		secEditIndex = -1;
	}

	function saveSecModal() {
		const qtyEl = document.querySelector("#modalSecQty");
		const secQty = Number(qtyEl.value);

		if (!secQty || secQty <= 0) {
			alert("섹션 수용량은 1 이상으로 입력하세요.");
			qtyEl.focus();
			return;
		}

		if (secModalMode === "add") {
			sectionList.push({
				secId: "",
				secQty: secQty,
				secPrevQty: 0,
				isNew: true
			});

			closeSecModal();
			renderAll();
			return;
		}

		if (secModalMode === "edit") {
			const sec = sectionList[secEditIndex];

			if (!sec) {
				alert("수정할 섹션 정보를 찾을 수 없습니다.");
				closeSecModal();
				return;
			}

			if (sec.secPrevQty > secQty) {
				alert("현재 적재량보다 수용량을 작게 수정할 수 없습니다.");
				qtyEl.focus();
				return;
			}

			sec.secQty = secQty;

			closeSecModal();
			renderAll();
		}
	}

	
	function removeSection(index) {
		const sec = sectionList[index];

		if (!confirm("해당 섹션을 삭제하시겠습니까?")) {
			return;
		}

		if (!sec.isNew && sec.secPrevQty > 0) {
			alert("현재 적재량이 있는 섹션은 삭제할 수 없습니다.");
			return;
		}

		if (!sec.isNew) {
			deletedSecIds.push(sec.secId);
		}

		sectionList.splice(index, 1);
		renderAll();
	}

	function moveSectionUp(index) {
		if (index <= 0) return;

		const temp = sectionList[index - 1];
		sectionList[index - 1] = sectionList[index];
		sectionList[index] = temp;

		renderAll();
	}

	function moveSectionDown(index) {
		if (index >= sectionList.length - 1) return;

		const temp = sectionList[index + 1];
		sectionList[index + 1] = sectionList[index];
		sectionList[index] = temp;

		renderAll();
	}

	function renderAll() {
		renderWarehouseMap();
		renderSectionTable();
		updateHiddenInput();
	}

	function renderSectionTable() {
		const tbody = document.querySelector("#sectionTableBody");
		tbody.innerHTML = "";

		if (sectionList.length === 0) {
			tbody.innerHTML =
				'<tr>' +
					'<td colspan="4" style="text-align: center;">등록된 섹션이 없습니다.</td>' +
				'</tr>';
			return;
		}

		for (let i = 0; i < sectionList.length; i++) {
			const sec = sectionList[i];
			const displaySecId = sec.isNew ? "신규" : sec.secId;

			const tr = document.createElement("tr");
			tr.classList.add("sec-row");
			tr.addEventListener("click", function () {
				openEditSecModal(i);
			});

			const tdId = document.createElement("td");
			const secIdSpan = document.createElement("span");
			secIdSpan.classList.add("sec-id-link");
			secIdSpan.textContent = displaySecId;

			tdId.appendChild(secIdSpan);

			const tdQty = document.createElement("td");
			tdQty.textContent = sec.secQty;

			const tdOrder = document.createElement("td");

			const upBtn = document.createElement("button");
			upBtn.type = "button";
			upBtn.classList.add("order-btn");
			upBtn.textContent = "▲";
			upBtn.addEventListener("click", function (event) {
				event.stopPropagation();
				moveSectionUp(i);
			});

			const downBtn = document.createElement("button");
			downBtn.type = "button";
			downBtn.classList.add("order-btn");
			downBtn.textContent = "▼";
			downBtn.addEventListener("click", function (event) {
				event.stopPropagation();
				moveSectionDown(i);
			});

			tdOrder.appendChild(upBtn);
			tdOrder.appendChild(document.createTextNode(" "));
			tdOrder.appendChild(downBtn);

			const tdDelete = document.createElement("td");

			const deleteBtn = document.createElement("button");
			deleteBtn.type = "button";
			deleteBtn.classList.add("delete-sec-btn");
			deleteBtn.textContent = "삭제";
			deleteBtn.addEventListener("click", function (event) {
				event.stopPropagation();
				removeSection(i);
			});

			tdDelete.appendChild(deleteBtn);

			tr.appendChild(tdId);
			tr.appendChild(tdQty);
			tr.appendChild(tdOrder);
			tr.appendChild(tdDelete);

			tbody.appendChild(tr);
		}
	}

	function renderWarehouseMap() {
		const map = document.querySelector("#warehouseMap");
		map.innerHTML = "";

		if (sectionList.length === 0) {
			map.innerHTML = '<div class="empty-map" style="margin-top: 130px;">섹션을 추가하면 구역도가 표시됩니다.</div>';
			return;
		}

		const svgNS = "http://www.w3.org/2000/svg";
		const svg = document.createElementNS(svgNS, "svg");

		svg.setAttribute("viewBox", "0 0 500 360");
		svg.classList.add("wh-svg");

		svg.appendChild(createSvgEl("rect", {
			x: 25,
			y: 25,
			width: 450,
			height: 310,
			rx: 4,
			class: "wh-border"
		}));

		svg.appendChild(createSvgEl("rect", {
			x: 15,
			y: 150,
			width: 20,
			height: 40,
			class: "wh-door"
		}));

		svg.appendChild(createSvgEl("rect", {
			x: 465,
			y: 150,
			width: 20,
			height: 40,
			class: "wh-door"
		}));

		const positions = makeSectionPositions(sectionList.length);

		for (let i = 0; i < sectionList.length; i++) {
			const sec = sectionList[i];
			const pos = positions[i];

			const group = createSvgEl("g", {
				class: "sec-group"
			});

			const rect = createSvgEl("rect", {
				x: pos.x,
				y: pos.y,
				width: pos.w,
				height: pos.h,
				rx: 4,
				class: "sec-box"
			});

			const text = createSvgEl("text", {
				x: pos.x + pos.w / 2,
				y: pos.y + pos.h / 2 - 6,
				class: "sec-text"
			});
			text.textContent = sec.isNew ? "신규" : sec.secId;

			const subText = createSvgEl("text", {
				x: pos.x + pos.w / 2,
				y: pos.y + pos.h / 2 + 15,
				class: "sec-sub-text"
			});
			subText.textContent = sec.secPrevQty + " / " + sec.secQty + " (LOT)";

			group.appendChild(rect);
			group.appendChild(text);
			group.appendChild(subText);
			svg.appendChild(group);
		}

		map.appendChild(svg);
	}

	function createSvgEl(tag, attrs) {
		const svgNS = "http://www.w3.org/2000/svg";
		const el = document.createElementNS(svgNS, tag);

		Object.keys(attrs).forEach(function (key) {
			el.setAttribute(key, attrs[key]);
		});

		return el;
	}

	function makeSectionPositions(count) {
		if (count === 5) {
			return [
				{ x: 65, y: 50,  w: 160, h: 75 },
				{ x: 275, y: 50,  w: 160, h: 75 },
				{ x: 65, y: 150, w: 160, h: 75 },
				{ x: 275, y: 150, w: 160, h: 75 },
				{ x: 65, y: 250, w: 370, h: 60 }
			];
		}

		if (count === 6) {
			return [
				{ x: 55,  y: 55,  w: 115, h: 100 },
				{ x: 192, y: 55,  w: 115, h: 100 },
				{ x: 329, y: 55,  w: 115, h: 100 },
				{ x: 55,  y: 185, w: 115, h: 100 },
				{ x: 192, y: 185, w: 115, h: 100 },
				{ x: 329, y: 185, w: 115, h: 100 }
			];
		}

		if (count === 7) {
			return [
				{ x: 55,  y: 45,  w: 115, h: 85 },
				{ x: 192, y: 45,  w: 115, h: 85 },
				{ x: 329, y: 45,  w: 115, h: 85 },
				{ x: 55,  y: 155, w: 115, h: 85 },
				{ x: 192, y: 155, w: 115, h: 85 },
				{ x: 329, y: 155, w: 115, h: 85 },
				{ x: 80,  y: 265, w: 340, h: 50 }
			];
		}

		if (count === 8) {
			return makeGridPositions(count, 4, 2);
		}

		if (count === 9) {
			return makeGridPositions(count, 3, 3);
		}

		if (count >= 10) {
			const cols = 4;
			const rows = Math.ceil(count / cols);
			return makeGridPositions(count, cols, rows);
		}

		return makeGridPositions(count, 2, Math.ceil(count / 2));
	}

	function makeGridPositions(count, cols, rows) {
		const startX = 50;
		const startY = 45;
		const gap = 14;

		const totalW = 400;
		const totalH = 270;

		const boxW = (totalW - gap * (cols - 1)) / cols;
		const boxH = (totalH - gap * (rows - 1)) / rows;

		const arr = [];

		for (let i = 0; i < count; i++) {
			const row = Math.floor(i / cols);
			const col = i % cols;

			arr.push({
				x: startX + col * (boxW + gap),
				y: startY + row * (boxH + gap),
				w: boxW,
				h: boxH
			});
		}

		return arr;
	}

	function updateHiddenInput() {
		const payload = sectionList.map(function(sec) {
			const secId = sec.isNew ? "NEW" : sec.secId;
			return secId + ":" + sec.secQty;
		}).join(",");

		document.querySelector("#sectionPayload").value = payload;
		document.querySelector("#deleteSecIds").value = deletedSecIds.join(",");
	}

	function beforeSubmit() {
		updateHiddenInput();

		if (sectionList.length === 0) {
			alert("섹션을 최소 1개 이상 유지해야 합니다.");
			return false;
		}

		return true;
	}
</script>