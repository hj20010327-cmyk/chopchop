<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">창고 상세</h2>
			<p class="page-subtitle">${whDTO.whName}(${whDTO.whId})의 상세 정보와 하위 섹션, 점검이력을 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈 > 창고 관리 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/warehouse/list">
				목록으로
			</a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/warehouse/edit?whId=${whDTO.whId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/warehouse/delete?whId=${whDTO.whId}"
				onclick="return confirm('창고(${whDTO.whId})를 삭제하시겠습니까?');">
				삭제
			</a>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				창고 상세정보
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>창고</th>
							<td>${whDTO.whName} (${whDTO.whId})</td>
							<th>유형</th>
							<td>${whDTO.whTypeName}</td>
						</tr>
						<tr>
							<th>창고 위치</th>
							<td>${whDTO.whLoc}</td>
							<th>설명</th>
							<td>${whDTO.whTypeContent}</td>
						</tr>
						<tr>
							<th>수용량</th>
							<td>${whDTO.whQty} LOT</td>
							<th>적재율</th>
							<td>${whDTO.whUsageRate} %</td>
						</tr>
						<tr>
							<th>적재량</th>
							<td>${whDTO.whPrevQty} LOT</td>
							<th>마지막 점검</th>
							<c:if test="${not empty whDTO.lastGlogDate}">
								<td>${whDTO.lastGlogDate}</td>
							</c:if>
							<c:if test="${empty whDTO.lastGlogDate}">
								<td>-</td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 내 섹션 정보
				</div>
				<div class="right">
<!-- 					<a class="btn btn-main" -->
<%-- 						href="${pageContext.request.contextPath}/warehouse/section/add?whId=${whDTO.whId}"> --%>
<!-- 						섹션 추가 -->
<!-- 					</a> -->
				</div>
			</div>
			
			<div class="section" style="display: flex; align-items: flex-start; gap: 15px;">
				<div class="map-card">
					<h3>창고 영역도</h3>
				
					<div id="warehouseMap"
						class="warehouse-map"
						data-context-path="${pageContext.request.contextPath}">
				
						<c:forEach var="sec" items="${secList}">
							<div class="sec-data"
								data-sec-id="${sec.secId}"
								data-sec-qty="${sec.secQty}"
								data-lot-cnt="${sec.secPrevQty}">
							</div>
						</c:forEach>
				
					</div>
				</div>
				
				<div class="table-wrap">
					<table class="table">
						<thead>
							<tr>
								<th>섹션번호</th>
								<th>수용량(LOT)</th>
								<th>적재량(LOT)</th>
								<th>적재율(%)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="sec" items="${secList}">
								<tr class="secList">
									<td class="secId">${sec.secId}</td>
									<td>${sec.secQty}</td>
									<td>${sec.secPrevQty}</td>
									<td id="qtyPer"
										style="font-weight: 700; 
										<c:if test="${sec.secUsageRate <= 0}">
											color: var(--info);
										</c:if>
										<c:if test="${sec.secUsageRate > 0 && sec.secUsageRate < 80}">
											color: var(--safe);
										</c:if>
										<c:if test="${sec.secUsageRate >= 80 && sec.secUsageRate < 100}">
											color: var(--warning);
										</c:if>
										<c:if test="${sec.secUsageRate > 100}">
											color: var(--danger);
										</c:if>
									">
									    <c:choose>
										    <c:when test="${wh.whQty != 0}">
										        <fmt:formatNumber value="${sec.secUsageRate}" pattern="0.00" />
										    </c:when>
										    <c:otherwise>
										        0.00
										    </c:otherwise>
										</c:choose>
									</td>
								</tr>	
							</c:forEach>
							
							<c:if test="${empty secList}">
								<tr>
									<td colspan="4" style="text-align: center;">
										조회된 내역이 없습니다.
									</td>
								</tr>
							</c:if>	
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 위생점검 이력
				</div>
				<div class="right">
					<a class="btn btn-main"
						href="${pageContext.request.contextPath}/warehouse/glog/add?whId=${whDTO.whId}">
						점검 이력 추가
					</a>
				</div>
			</div>
			
			<div class="table-wrap">
				<table class="table glog">
					<thead>
						<tr>
							<th style="width: 140px">점검 이력 번호</th>
							<th style="width: 140px">점검자</th>
							<th style="width: 250px">점검 기준</th>
							<th style="width: 110px">점검 결과</th>
							<th style="width: 200px">점검 일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="glog" items="${glogList}">
							<tr class="glogList">
								<td class="glogId">${glog.glogId}</td>
								<td>${glog.glogWName} (${glog.glogWorker})</td>
								<td>${glog.ghpName} (${glog.ghpId})</td>
								<c:if test="${glog.glogResult eq 'pass'}">
									<td>적합</td>
								</c:if>
								<c:if test="${glog.glogResult eq 'fail'}">
									<td>부적합</td>
								</c:if>
								<c:if test="${glog.glogResult != 'fail' && glog.glogResult != 'pass'}">
									<td>-</td>
								</c:if>
								<td>
									<fmt:formatDate value="${glog.glogDate}" pattern="YYYY-MM-dd HH:mm" />
								</td>
							</tr>	
						</c:forEach>
						
						<c:if test="${empty glogList}">
							<tr>
								<td colspan="5" style="text-align: center;">
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
	.table tbody tr:hover .secId,  .table tbody tr:hover .glogId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	
	
	.map-card {
		width: 100%;
		border: 1px solid #ddd;
		border-radius: 8px;
		padding: 20px;
		background: #fff;
	}
	
	.map-card h3 {
		margin-bottom: 18px;
		font-size: 18px;
		font-weight: 700;
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
		stroke: #777;
		stroke-width: 2;
		cursor: pointer;
		transition: 0.15s;
	}
	
	.sec-empty {
		fill: #fff;
	}
	
	.sec-low {
		fill: #fff;
	}
	
	.sec-mid {
		fill: #fff;
	}
	
	.sec-high {
		fill: #fff;
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
	
	.empty-map {
		color: #999;
		font-size: 14px;
	}
	
	    
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.section {
		flex-direction : column;
	}
	
	.glog tr th:nth-child(2), .glog tr td:nth-child(2) {
		display: none;
	}
	
}

</style>

<script>
	
	window.addEventListener ("load", () => {
		init();
	})
	
	function init() {
		bind();
	}
	
	function bind() {
		moveGlog();
		moveSec();
	}
	
	function moveSec() {
		const secLists = document.querySelectorAll(".secList");
		
		for (let i=0; i<secLists.length; i++) {
			
			secLists[i].addEventListener("click", () => {
				const secId = secLists[i].querySelector(".secId").textContent.trim();
				console.log ("secId : " + secId);
				
				const contextPath = document.querySelector("#warehouseMap").dataset.contextPath;
				const url = contextPath + "/warehouse/section/detail?secId=" + encodeURIComponent(secId);
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
	function moveGlog() {
		const glogLists = document.querySelectorAll(".glogList");
		const contextPath = document.querySelector("#warehouseMap").dataset.contextPath;
		
		for (let i=0; i<glogLists.length; i++) {
			
			glogLists[i].addEventListener("click", () => {
				const glogId = glogLists[i].querySelector(".glogId").textContent.trim();
				console.log ("glogId : " + glogId);
				
				const url = contextPath + "/warehouse/glog/detail?glogId=" + encodeURIComponent(glogId);
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
	document.addEventListener("DOMContentLoaded", function () {
		initWarehouseMap();
	});

	function initWarehouseMap() {
		const map = document.querySelector("#warehouseMap");

		if (!map) return;

		const contextPath = map.dataset.contextPath || "";

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
			map.innerHTML = `<div class="empty-map">등록된 섹션이 없습니다.</div>`;
			return;
		}

		const svgNS = "http://www.w3.org/2000/svg";

		const svg = document.createElementNS(svgNS, "svg");
		svg.setAttribute("viewBox", "0 0 500 360");
		svg.classList.add("wh-svg");

		// 외곽
		const border = createSvgEl("rect", {
			x: 25,
			y: 25,
			width: 450,
			height: 310,
			rx: 4,
			class: "wh-border"
		});
		svg.appendChild(border);

		// 좌우 출입구 느낌
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

			const rect = createSvgEl("rect", {
				x: pos.x,
				y: pos.y,
				width: pos.w,
				height: pos.h,
				rx: 4,
				class: getSectionClass(sec.rate)
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
		// 5개: 2x2 + 하단 긴 섹션
		if (count === 5) {
			return [
				{ x: 65, y: 50,  w: 160, h: 75 },
				{ x: 275, y: 50,  w: 160, h: 75 },
				{ x: 65, y: 150, w: 160, h: 75 },
				{ x: 275, y: 150, w: 160, h: 75 },
				{ x: 65, y: 250, w: 370, h: 60 }
			];
		}

		// 6개: 3x2
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

		// 7개: 3x2 + 하단 긴 섹션
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

		// 8개: 4x2
		if (count === 8) {
			return makeGridPositions(count, 4, 2);
		}

		// 9개: 3x3
		if (count === 9) {
			return makeGridPositions(count, 3, 3);
		}

		// 10개 이상: 4열 자동
		if (count >= 10) {
			const cols = 4;
			const rows = Math.ceil(count / cols);
			return makeGridPositions(count, cols, rows);
		}

		// 그 외: 기본 2열
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