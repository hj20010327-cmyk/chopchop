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
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/warehouse/sec/edit?secId=${secDTO.secId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/warehouse/sec/delete?whId=${secDTO.secWhId}">
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
							<td>${secDTO.secWhId}</td>
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
							<img src="${secDTO.secImg}"
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
							<th style="width: 150px">점검 이력 번호</th>
							<th style="width: 180px">점검자</th>
							<th style="width: 250px">점검 기준</th>
							<th style="width: 120px">점검 결과</th>
							<th style="width: 230px">점검 일시</th>
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
								<td>${glog.glogDate}</td>
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
		moveGlog();
		moveSec();
		drawChart();
	}
	
	function moveSec() {
		const secLists = document.querySelectorAll(".secList");
		
		for (let i=0; i<secLists.length; i++) {
			
			secLists[i].addEventListener("click", () => {
				const secId = secLists[i].querySelector(".secId").textContent.trim();
				console.log ("secId : " + secId);
				
				const url = `${pageContext.request.contextPath}/warehouse/sec/detail?secId=` + secId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
	function moveGlog() {
		const glogLists = document.querySelectorAll(".glogList");
		
		for (let i=0; i<glogLists.length; i++) {
			
			glogLists[i].addEventListener("click", () => {
				const glogId = glogLists[i].querySelector(".glogId").textContent.trim();
				console.log ("glogId : " + glogId);
				
				const url = `${pageContext.request.contextPath}/warehouse/glog/detail?glogId=` + glogId;
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