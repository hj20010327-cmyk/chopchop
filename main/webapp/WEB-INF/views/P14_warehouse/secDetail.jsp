<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">창고 내 섹션 상세</h2>
			<p class="page-subtitle">선택한 섹션의 상세 정보를 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈 > 창고 관리 > 섹션 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/warehouse/detail?whId=${secDTO.secWhId}">
				창고 상세
			</a>
		</div>
		<div class="right">
<!-- 			<a class="btn btn-main" style="display: none;" -->
<%-- 				href="${pageContext.request.contextPath}/warehouse/section/edit?secId=${secDTO.secId}"> --%>
<!-- 				수정 -->
<!-- 			</a> -->
<!-- 			<a class="btn btn-red" -->
<%-- 				href="${pageContext.request.contextPath}/warehouse/section/delete?secId=${secDTO.secId}" --%>
<%-- 				onclick="return confirm('섹션(${secDTO.secId})을 삭제하시겠습니까?');"> --%>
<!-- 				삭제 -->
<!-- 			</a> -->
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				섹션 상세정보
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>섹션번호</th>
							<td>${secDTO.secId}</td>
							<th>소속 창고</th>
							<td>
								<a class="toDetail"
									href="${pageContext.request.contextPath}/warehouse/detail?whId=${secDTO.secWhId}">
									${secDTO.secWhName} (${secDTO.secWhId})
								</a>
							</td>
						</tr>
						<tr>
							<th>수용량</th>
							<td>${secDTO.secQty} LOT</td>
							<th>적재량</th>
							<td>${secDTO.secPrevQty} LOT</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					섹션 위치 및 현황
				</div>
			</div>
			
			<div style="display: flex; align-items: flex-start; gap: 15px;">
				<div class="card" style="width: 50%; padding: 20px;">
					<div class="content-content-content-title">창고 영역도</div>
				
					<div id="warehouseMap"
						class="warehouse-map"
						data-context-path="${pageContext.request.contextPath}"
						data-current-sec-id="${secDTO.secId}">
				
						<c:forEach var="sec" items="${secList}">
							<div class="sec-data"
								data-sec-id="${sec.secId}"
								data-sec-qty="${sec.secQty}"
								data-lot-cnt="${sec.secPrevQty}">
							</div>
						</c:forEach>
				
					</div>
				</div>
				
				<div class="card" style="width: 50%; padding: 20px;">
					<div class="content-content-content-title">섹션 적재 현황</div>
					<div style="display: flex; gap: 15px;">
						<div class="chart-box">
						    <canvas id="sectionDonutChart"></canvas>
						</div>
						<div class="qtyInfo search-item">
							<div>
								<label>수용량</label>
								<div>${secDTO.secQty} <span class="unit">LOT</span></div>
							</div>
							<div>
								<label>현재 적재량</label>
								<div>${secDTO.secPrevQty} <span class="unit">LOT</span></div>
							</div>
							<div>
								<label>여유 수용량</label>
								<div>${secDTO.secQty - secDTO.secPrevQty} <span class="unit">LOT</span></div>
							</div>
							<div>
								<label>현재 적재율</label>
								<div>${secDTO.secUsageRate} <span class="unit">%</span></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					LOT 현황
				</div>
			</div>
			
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th>LOT 번호</th>
							<th>품목</th>
							<th>현재수량</th>
							<th>입고일</th>
							<th>유통기한</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="lot" items="${lotList}">
							<tr class="lotList">
								<td class="lotId">${lot.lotId}</td>
								<td>${lot.lotItemName} (${lot.lotItem})</td>
								<td>${lot.lotFqty}</td>
								<td>${lot.lotEtw}</td>
								<td>${lot.lotExp}</td>
								<td>
									<c:if test="${lot.lotStatus == 10}">
										<span style="color: var(--success)">• 사용가능</span>
									</c:if>
									<c:if test="${lot.lotStatus == 20}">
										<span style="color: var(--success)">• 사용중</span>
									</c:if>
									<c:if test="${lot.lotStatus != 10 && lot.lotStatus != 20}">
										<span style="color: var(--error)">• 사용불가</span>
									</c:if>
								</td>
							</tr>	
						</c:forEach>
						
						<c:if test="${empty lotList}">
							<tr>
								<td colspan="6" style="text-align: center;">
									조회된 내역이 없습니다.
								</td>
							</tr>
						</c:if>	
					</tbody>
				</table>
			</div>
			
			<jsp:include page="/WEB-INF/views/common/paging.jsp" />
		</div>
	</div>
	
</div>

<style>
	.table tbody tr:hover .lotId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	.chart-box {
	    width: 260px;
	    height: 260px;
	    padding: 20px;
	    background: #fff;
	    border: 1px solid #e5e7eb;
	    border-radius: 12px;
	}
	
	.unit {
		font-size: 14px;
	}
	
	.search-item>div>div {
		padding-left: 10px;
	}
	
	
	
	
	
	.warehouse-map {
		width: 100%;
		min-height: 300px;
		display: flex;
		justify-content: center;
		align-items: center;
		background: #fff;
	}
	
	.wh-svg {
		width: 100%;
		max-width: 420px;
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
	
	.sec-empty,
	.sec-low,
	.sec-mid,
	.sec-high {
		fill: #fff;
	}
	
	.sec-selected {
		fill: #e8f4ee !important;
		stroke: var(--main-green) !important;
		stroke-width: 2 !important;
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
	
	.sec-group:hover .sec-box {
		stroke: var(--main-green);
		stroke-width: 3;
	}
	
	.sec-group:hover .sec-text {
		fill: var(--main-green);
	}
	
	.sec-group:hover .sec-selected {
		stroke-width: 4;
	}
	
	.empty-map {
		color: #999;
		font-size: 14px;
	}
	
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
	
	window.addEventListener ("load", () => {
		init();
	})
	
	function init() {
		bind();
	}
	
	function bind() {
		moveLot();
		drawChart();
		initWarehouseMap();
	}
	
	function moveLot() {
		const lotLists = document.querySelectorAll(".lotList");
		
		for (let i=0; i<lotLists.length; i++) {
			
			lotLists[i].addEventListener("click", () => {
				const lotId = lotLists[i].querySelector(".lotId").textContent.trim();
				console.log ("lotId : " + lotId);
				
				const url = `${pageContext.request.contextPath}/lot/detail?lotId=` + lotId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
	function drawChart() {
		const totalQty = Number("${secDTO.secQty}");
	    const currentQty = Number("${secDTO.secPrevQty}");
	    const remainQty = totalQty - currentQty;

	    const ctx = document.getElementById("sectionDonutChart");

	    new Chart(ctx, {
	        type: "doughnut",
	        data: {
	            labels: ["사용 중", "잔여"],
	            datasets: [{
	                data: [currentQty, remainQty],
	                backgroundColor: [
	                    "#F9A825",
	                    "#2B8EFF"
	                ],
	                borderWidth: 0
	            }]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            cutout: "65%",
	            plugins: {
	                legend: {
	                    position: "bottom",
	                    labels: {
	                    	padding: 20
	                    }
	                },
	                tooltip: {
	                    callbacks: {
	                        label: function(context) {
	                            return context.label + ": " + context.raw + " LOT";
	                        }
	                    }
	                }
	            }
	        }
	    });
	}
	
	function initWarehouseMap() {
		const map = document.querySelector("#warehouseMap");

		if (!map) return;

		const contextPath = map.dataset.contextPath || "";
		const currentSecId = map.dataset.currentSecId || "";

		const secList = Array.from(map.querySelectorAll(".sec-data")).map(el => {
			const secQty = Number(el.dataset.secQty || 0);
			const secPrevQty = Number(el.dataset.lotCnt || 0);

			return {
				secId: el.dataset.secId,
				secQty: secQty,
				secPrevQty: secPrevQty,
				rate: secQty > 0 ? Math.round((secPrevQty / secQty) * 1000) / 10 : 0
			};
		});

		map.innerHTML = "";

		if (secList.length === 0) {
			map.innerHTML = '<div class="empty-map">등록된 섹션이 없습니다.</div>';
			return;
		}

		const svgNS = "http://www.w3.org/2000/svg";

		const svg = document.createElementNS(svgNS, "svg");
		svg.setAttribute("viewBox", "0 0 500 360");
		svg.classList.add("wh-svg");

		const border = createSvgEl("rect", {
			x: 25,
			y: 25,
			width: 450,
			height: 310,
			rx: 4,
			class: "wh-border"
		});
		svg.appendChild(border);

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

		const positions = makeSectionPositions(secList.length);

		secList.forEach((sec, index) => {
			const pos = positions[index];

			const link = createSvgEl("a", {
				href: contextPath + "/warehouse/section/detail?secId=" + encodeURIComponent(sec.secId)
			});

			const group = createSvgEl("g", {
				class: "sec-group"
			});

			let rectClass = getSectionClass(sec.rate);

			if (sec.secId === currentSecId) {
				rectClass += " sec-selected";
			}

			const rect = createSvgEl("rect", {
				x: pos.x,
				y: pos.y,
				width: pos.w,
				height: pos.h,
				rx: 4,
				class: rectClass
			});

			const text = createSvgEl("text", {
				x: pos.x + pos.w / 2,
				y: pos.y + pos.h / 2 - 6,
				class: "sec-text"
			});
			text.textContent = sec.secId;

			const subText = createSvgEl("text", {
				x: pos.x + pos.w / 2,
				y: pos.y + pos.h / 2 + 15,
				class: "sec-sub-text"
			});
			subText.textContent = sec.secPrevQty + " / " + sec.secQty + " (LOT)";

			group.appendChild(rect);
			group.appendChild(text);
			group.appendChild(subText);
			link.appendChild(group);
			svg.appendChild(link);
		});

		map.appendChild(svg);
	}

	function createSvgEl(tag, attrs) {
		const svgNS = "http://www.w3.org/2000/svg";
		const el = document.createElementNS(svgNS, tag);

		Object.keys(attrs).forEach(key => {
			el.setAttribute(key, attrs[key]);
		});

		return el;
	}

	function getSectionClass(rate) {
		if (rate >= 80) return "sec-box sec-high";
		if (rate >= 50) return "sec-box sec-mid";
		if (rate > 0) return "sec-box sec-low";
		return "sec-box sec-empty";
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
	
</script>