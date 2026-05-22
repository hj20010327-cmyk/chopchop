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
			<a class="btn btn-main" style="display: none;"
				href="${pageContext.request.contextPath}/warehouse/section/edit?secId=${secDTO.secId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/warehouse/section/delete?secId=${secDTO.secId}"
				onclick="return confirm('섹션(${secDTO.secId})을 삭제하시겠습니까?');">
				삭제
			</a>
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
					<div class="content-content-content-title">섹션 이미지</div>
					<c:if test="${empty secDTO.secImg or secDTO.secImg == ''}">
						<div style="font-size: 14px; color: var(--dark-gray);">섹션 이미지가 없습니다</div>
					</c:if>
					<c:if test="${not empty secDTO.secImg and secDTO.secImg != ''}">
			        	<div class="info-image">
							<img src="${pageContext.request.contextPath}${secDTO.secImg}"
								title="${secDTO.secId}_img" alt="${secDTO.secId}_img"
								 style="width: 100%;">
						</div>
					</c:if>
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
	
</script>