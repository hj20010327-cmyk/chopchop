<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">창고 등록</h2>
            <p class="page-subtitle">새로운 창고를 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 창고 관리 > 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/warehouse/insert"
          method="post"
          enctype="multipart/form-data"
          class="grid-form"
          onsubmit="return beforeSubmit();">
		
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/warehouse/list"
	               onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
	                취소
	            </a>
	
	            <button type="submit" class="btn btn-main">
	                등록
	            </button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>유형 <span class="red">*</span></label>
				<select name="whTypeNo" required>
	                <option value="" selected disabled>창고 유형 선택</option>
	                <option value="10">원자재 냉동창고</option>
	                <option value="20">원자재 냉장창고</option>
	                <option value="30">원자재 상온창고</option>
	                <option value="40">반제품 냉장창고</option>
					<option value="50">반제품 냉동창고</option>
					<option value="60">완제품 냉동창고</option>
					<option value="70">기타 자재 상온창고</option>
					<option value="80">반품/회수품 보관창고</option>
					<option value="90">부적합품 보관창고</option>
					<option value="100">폐기 대기창고</option>
	            </select>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>창고 이름 <span class="red">*</span></label>
				<input type="text" name="whName" placeholder="창고 이름 입력" required>
			</div>
			<div class="grid search-item">
				<label>창고 위치 <span class="red">*</span></label>
				<input type="text" name="whLoc" placeholder="창고 위치 입력" required>
			</div>
		</div>
		
		
		<input type="hidden" name="secQtyList" id="secQtyList">
		
		<div class="content-content-content section-config">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 섹션 설정
				</div>
				<div class="right">
					<button type="button" class="btn btn-main" onclick="openSecModal()">
						섹션 추가
					</button>
				</div>
			</div>
		
			<div class="section-layout">
				<div class="map-card"
						style="display: flex; flex-direction: column; align-items:center;">
					<h3>창고 영역도</h3>
					<div id="warehouseMap" class="warehouse-map"></div>
				</div>
		
				<div class="table-wrap">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 120px;">예상 섹션번호</th>
								<th style="width: 115px;">수용량(LOT)</th>
								<th style="width: 105px;">순서</th>
								<th style="width: 80px;">삭제</th>
							</tr>
						</thead>
						<tbody id="sectionTableBody">
							<tr id="emptySectionRow">
								<td colspan="4" style="text-align: center;">
									등록된 섹션이 없습니다.
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div id="secModal" class="modal-bg">
			<div class="modal-box">
				<div class="modal-title" id="secModalTitle">섹션 추가</div>
		
				<div class="search-item">
					<label>섹션 수용량 <span class="red">*</span></label>
					<input type="number" id="modalSecQty" min="1" placeholder="수용량 입력">
				</div>
		
				<div class="btn-row modal-btn-row">
					<div class="left"></div>
					<div class="right">
						<button type="button" class="btn btn-white" onclick="closeSecModal()">
							취소
						</button>
						<button type="button" class="btn btn-main" id="secModalSaveBtn" onclick="saveSection()">
							추가
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
	
	/* 왼쪽 구역도 크게 */
	.map-card {
		width: 50%;
		height: 445px;
		border: 1px solid #ddd;
		border-radius: 8px;
		padding: 20px;
		background: #fff;
	}
	
	/* 오른쪽 테이블 작게 */
	.section-layout > .table-wrap {
		width: 420px;
	}
	
	/* 구역도 높이 증가 */
	.warehouse-map {
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		background: #fff;
	}
	
	/* SVG 자체도 더 크게 */
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
	
	#sectionTableBody tr:not(#emptySectionRow) {
		cursor: pointer;
	}
	
	#sectionTableBody tr:not(#emptySectionRow):hover .sec-no-cell {
		color: var(--main-green);
		text-decoration: underline;
		text-underline-offset: 3px;
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
	
	
	
	
</style>


<script>
	let sectionList = [];
	let editSecIndex = -1;

	window.addEventListener("load", function () {
		renderAll();
	});

	function openSecModal() {
		editSecIndex = -1;

		document.querySelector("#secModalTitle").innerText = "섹션 추가";
		document.querySelector("#secModalSaveBtn").innerText = "추가";

		document.querySelector("#modalSecQty").value = "";
		document.querySelector("#secModal").classList.add("show");
		document.querySelector("#modalSecQty").focus();
	}
	
	function closeSecModal() {
		document.querySelector("#secModal").classList.remove("show");
		editSecIndex = -1;
	}

	function openEditSecModal(index) {
		editSecIndex = index;

		document.querySelector("#secModalTitle").innerText = "섹션 수정";
		document.querySelector("#secModalSaveBtn").innerText = "수정";

		document.querySelector("#modalSecQty").value = sectionList[index].secQty;
		document.querySelector("#secModal").classList.add("show");
		document.querySelector("#modalSecQty").focus();
	}

	function saveSection() {
		const qtyEl = document.querySelector("#modalSecQty");
		const secQty = Number(qtyEl.value);

		if (!secQty || secQty <= 0) {
			alert("섹션 수용량은 1 이상으로 입력하세요.");
			qtyEl.focus();
			return;
		}

		if (editSecIndex === -1) {
			sectionList.push({
				secQty: secQty
			});
		} else {
			sectionList[editSecIndex].secQty = secQty;
		}

		closeSecModal();
		renderAll();
	}

	function removeSection(index) {
		if (!confirm("해당 섹션을 삭제하시겠습니까?")) {
			return;
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
		updateWhQty();
		updateHiddenInput();
	}

	function updateWhQty() {
		let total = 0;

		for (let i = 0; i < sectionList.length; i++) {
			total += Number(sectionList[i].secQty || 0);
		}

		const whQtyView = document.querySelector("#whQtyView");

		if (whQtyView) {
			whQtyView.value = total;
		}
	}

	function updateHiddenInput() {
		const secQtyList = sectionList.map(function (sec) {
			return sec.secQty;
		}).join(",");

		document.querySelector("#secQtyList").value = secQtyList;
	}

	function renderSectionTable() {
		const tbody = document.querySelector("#sectionTableBody");
		tbody.innerHTML = "";

		if (sectionList.length === 0) {
			tbody.innerHTML =
				'<tr id="emptySectionRow">' +
					'<td colspan="4" style="text-align: center;">등록된 섹션이 없습니다.</td>' +
				'</tr>';
			return;
		}

		for (let i = 0; i < sectionList.length; i++) {
			const expectedSecNo = 11 + i;

			const tr = document.createElement("tr");

			tr.onclick = function () {
				openEditSecModal(i);
			};

			tr.innerHTML =
				'<td class="sec-no-cell">신규-' + expectedSecNo + '</td>' +
				'<td>' + sectionList[i].secQty + '</td>' +
				'<td>' +
					'<button type="button" class="order-btn" onclick="event.stopPropagation(); moveSectionUp(' + i + ')">▲</button> ' +
					'<button type="button" class="order-btn" onclick="event.stopPropagation(); moveSectionDown(' + i + ')">▼</button>' +
				'</td>' +
				'<td>' +
					'<button type="button" class="delete-sec-btn" onclick="event.stopPropagation(); removeSection(' + i + ')">삭제</button>' +
				'</td>';

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
			const expectedSecNo = 11 + i;

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
			text.textContent = "신규-" + expectedSecNo;

			const subText = createSvgEl("text", {
				x: pos.x + pos.w / 2,
				y: pos.y + pos.h / 2 + 15,
				class: "sec-sub-text"
			});
			subText.textContent = "0 / " + sec.secQty + " (LOT)";

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

	function beforeSubmit() {
		updateHiddenInput();

		if (sectionList.length === 0) {
			alert("섹션을 최소 1개 이상 추가하세요.");
			return false;
		}

		return true;
	}
</script>
