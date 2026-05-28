<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="dashboard-container">

		<div class="dashboard-header">
			<div>
				<h2 class="page-title">대시보드</h2>
				<p class="page-subtitle">전체 현황을 한눈에 확인하세요.</p>
			</div>

			<p class="page-route">홈 &gt; 대시보드</p>
		</div>

		<div class="dashboard-grid">

			<!-- 창고 적재 현황 -->
			<div class="dashboard-box warehouse-card">
				<div class="dashboard-box-title">창고 적재 현황</div>

				<div class="warehouse-list">
					<c:choose>
						<c:when test="${empty warehouseTopList}">
							<div class="empty-msg">창고 데이터가 없습니다.</div>
						</c:when>

						<c:otherwise>
							<c:forEach var="wh" items="${warehouseTopList}">
								<div class="warehouse-row">
									<div class="warehouse-info">
										<span class="warehouse-name">${wh.whName} (${wh.whId})</span>
										<span class="warehouse-rate">
											<fmt:formatNumber value="${wh.whUsageRate}" pattern="0.00" />%
										</span>
									</div>

									<div class="warehouse-bar">
										<div class="warehouse-bar-fill"
											style="width:${wh.whUsageRate}%;"></div>
									</div>
								</div>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<!-- 설비 가동 현황 -->
			<div class="dashboard-box machine-card">
				<div class="dashboard-box-title">설비 가동 현황</div>

				<div class="eq-summary">
				<div class="eq-total">
					전체 설비
					<strong>
						${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.totalEqCnt}
					</strong>대
				</div>
				
				<div class="eq-status-list">
				
					<div>
						<span class="status-back status-back-success">
							가동중
						</span>
				
						<strong>
							${empty eqStatusSummary.runCnt ? 0 : eqStatusSummary.runCnt}대
						</strong>
					</div>
				
					<div>
						<span class="status-back status-back-info">
							정지
						</span>
				
						<strong>
							${empty eqStatusSummary.stopCnt ? 0 : eqStatusSummary.stopCnt}대
						</strong>
					</div>
				
					<div>
						<span class="status-back status-back-warning">
							점검중
						</span>
				
						<strong>
							${empty eqStatusSummary.checkCnt ? 0 : eqStatusSummary.checkCnt}대
						</strong>
					</div>
				
					<div>
						<span class="status-back status-back-danger">
							고장
						</span>
				
						<strong>
							${empty eqStatusSummary.breakCnt ? 0 : eqStatusSummary.breakCnt}대
						</strong>
					</div>
				
				</div>
				</div>
			</div>

			<!-- 오늘 요약 카드 -->
			<div class="card success dashboard-kpi-card">
				<div class="card-title">일일 생산 LOT</div>
				<div class="card-value">
					${empty todaySummary.todayProdLotCnt ? 0 : todaySummary.todayProdLotCnt}
					<span class="dashboard-unit">LOT</span>
				</div>
				<div class="card-subtitle">오늘 작업 기준 LOT</div>
			</div>
			
			<div class="card safe dashboard-kpi-card">
				<div class="card-title">작업 완료 LOT</div>
				<div class="card-value">
					${empty todaySummary.todayDoneLotCnt ? 0 : todaySummary.todayDoneLotCnt}
					<span class="dashboard-unit">LOT</span>
				</div>
				<div class="card-subtitle">오늘 완료 작업지시</div>
			</div>
			
			<div class="card warning dashboard-kpi-card">
				<div class="card-title">일일 검사 LOT</div>
				<div class="card-value">
					${empty todaySummary.todayQcLotCnt ? 0 : todaySummary.todayQcLotCnt}
					<span class="dashboard-unit">LOT</span>
				</div>
				<div class="card-subtitle">오늘 품질검사 LOT</div>
			</div>
			
			<div class="card danger dashboard-kpi-card">
				<div class="card-title">일일 불량률</div>
				<div class="card-value">
					${empty todaySummary.todayFailRate ? 0 : todaySummary.todayFailRate}
					<span class="dashboard-unit">%</span>
				</div>
				<div class="card-subtitle">오늘 불량수량 / 검사수량</div>
			</div>

			<!-- 주간 작업 현황 -->
			<div class="dashboard-box graph-card">
				<div class="dashboard-box-title">주간 작업 현황</div>

				<div class="chart-box">
					<canvas id="weeklyWorkChart"></canvas>
				</div>
			</div>

			<!-- 주간 불량률 현황 -->
			<div class="dashboard-box graph-card">
				<div class="dashboard-box-title">주간 불량률 현황</div>

				<div class="chart-box">
					<canvas id="weeklyDefectChart"></canvas>
				</div>
			</div>

		</div>

		<div class="dashboard-bottom-grid">

			<!-- 공지사항 -->
			<div class="dashboard-box bottom-card">
				<div class="dashboard-card-head">
					<div class="dashboard-box-title">공지사항</div>
					<a href="${pageContext.request.contextPath}/notice/list"
						class="dashboard-more">전체 보기 &gt;</a>
				</div>
			
				<ul class="dashboard-list">
					<c:choose>
						<c:when test="${empty recentNoticeList}">
							<li>등록된 공지사항이 없습니다.</li>
						</c:when>
			
						<c:otherwise>
							<c:forEach var="n" items="${recentNoticeList}">
								<li>
									<a href="${pageContext.request.contextPath}/notice/detail?not_no=${n.notNo}">
										${n.notTitle}
									</a>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>

			<!-- 금일 예정 작업 -->
			<div class="dashboard-box bottom-card bottom-work-card">
				<div class="dashboard-card-head">
					<div class="dashboard-box-title">금일 예정 작업</div>
					<a href="${pageContext.request.contextPath}/work/list"
						class="dashboard-more">전체 보기 &gt;</a>
				</div>

				<div class="table-wrap">
					<table class="table dashboard-small-table">
						<thead>
							<tr>
								<th>일자</th>
								<th>작업코드</th>
								<th>상태</th>
							</tr>
						</thead>

						<tbody>
							<c:choose>
								<c:when test="${empty todayWorkList}">
									<tr>
										<td colspan="3">금일 예정 작업이 없습니다.</td>
									</tr>
								</c:when>

								<c:otherwise>
									<c:forEach var="w" items="${todayWorkList}">
										<tr>
											<td>${w.workDate}</td>
											<td>
												<a class="dashboard-link"
													href="${pageContext.request.contextPath}/work/detail?workId=${w.workId}">
													${w.workId}
												</a>
											</td>
											<td>
												<c:choose>
													<c:when test="${w.workStatus eq 10}">
														<span class="status-back status-back-info">
															${w.workStatusName}
														</span>
													</c:when>

													<c:when test="${w.workStatus eq 20}">
														<span class="status-back status-back-warning">
															${w.workStatusName}
														</span>
													</c:when>

													<c:when test="${w.workStatus eq 30}">
														<span class="status-back status-back-success">
															${w.workStatusName}
														</span>
													</c:when>

													<c:when test="${w.workStatus eq 40}">
														<span class="status-back status-back-danger">
															${w.workStatusName}
														</span>
													</c:when>

													<c:otherwise>
														<span class="status-back status-back-info">
															${w.workStatusName}
														</span>
													</c:otherwise>
												</c:choose>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>
			</div>

		</div>

		<div class="dashboard-kpi-title">주요 KPI 지표</div>

		<div class="table-wrap">
			<table class="table dashboard-kpi-table">
				<thead>
					<tr>
						<th>구분</th>
						<th>이번 주</th>
						<th>이번 달</th>
						<th>전월</th>
						<th>전월 대비</th>
					</tr>
				</thead>

				<tbody>
					<c:choose>
						<c:when test="${empty kpiList}">
							<tr>
								<td colspan="5">KPI 데이터가 없습니다.</td>
							</tr>
						</c:when>

						<c:otherwise>
							<c:forEach var="kpi" items="${kpiList}">
								<tr>
									<td>${kpi.kpiName}</td>
									<td>${kpi.thisWeek}%</td>
									<td>${kpi.thisMonth}%</td>
									<td>${kpi.lastMonth}%</td>

									<c:choose>
										<c:when test="${kpi.compareValue >= 0}">
											<td class="status-success">▲ ${kpi.compareValue}%</td>
										</c:when>

										<c:otherwise>
											<td class="status-danger">▼ ${kpi.compareValue * -1}%</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>

	</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	const weeklyWorkLabels = [
		<c:forEach var="row" items="${weeklyWorkChart}" varStatus="status">
			"${row.dayLabel}"<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyWorkValues = [
		<c:forEach var="row" items="${weeklyWorkChart}" varStatus="status">
			${row.value}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyDefectLabels = [
		<c:forEach var="row" items="${weeklyDefectChart}" varStatus="status">
			"${row.dayLabel}"<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyDefectValues = [
		<c:forEach var="row" items="${weeklyDefectChart}" varStatus="status">
			${row.value}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	new Chart(document.getElementById("weeklyWorkChart"), {
		type: "line",
		data: {
			labels: weeklyWorkLabels,
			datasets: [{
				data: weeklyWorkValues,
				borderColor: "#2E6F4E",
				backgroundColor: "rgba(46, 111, 78, 0.08)",
				tension: 0.35,
				fill: true,
				pointRadius: 3
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			plugins: {
				legend: {
					display: false
				}
			},
			scales: {
				y: {
					beginAtZero: true
				}
			}
		}
	});

	new Chart(document.getElementById("weeklyDefectChart"), {
		type: "line",
		data: {
			labels: weeklyDefectLabels,
			datasets: [{
				data: weeklyDefectValues,
				borderColor: "#2E6F4E",
				backgroundColor: "rgba(46, 111, 78, 0.08)",
				tension: 0.35,
				fill: true,
				pointRadius: 3
			}]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			plugins: {
				legend: {
					display: false
				}
			},
			scales: {
				y: {
					beginAtZero: true,
					ticks: {
						callback: function(value) {
							return value + "%";
						}
					}
				}
			}
		}
	});
</script>

<style>
.dashboard-container{
	width:100%;
	max-width:1040px;
	min-height:837px;
	margin:0 auto;
}

.dashboard-header{
	display:flex;
	justify-content:space-between;
	align-items:flex-start;
	margin-bottom:10px;
}

.dashboard-header .page-title{
	font-size:24px;
	margin:0 0 5px;
}

.dashboard-header .page-subtitle{
	font-size:13px;
	margin:0;
}

.dashboard-header .page-route{
	font-size:11px;
	margin:0;
}

.dashboard-grid{
	display:grid;
	grid-template-columns:repeat(4, 1fr);
	gap:8px;
}

.dashboard-box{
	background:#fff;
	border:1px solid var(--gray);
	border-radius:6px;
	padding:10px;
	box-sizing:border-box;
	overflow:hidden;
}

.dashboard-box-title{
	font-size:12px;
	font-weight:700;
	color:#222;
	margin-bottom:7px;
}

.warehouse-card{
	grid-column:span 3;
	height:170px;
}

.machine-card{
	grid-column:span 1;
	height:170px;
}

.warehouse-list{
	display:flex;
	flex-direction:column;
	gap:5px;
}

.warehouse-row{
	width:100%;
}

.warehouse-info{
	display:flex;
	justify-content:space-between;
	align-items:center;
	font-size:10px;
	margin-bottom:2px;
}

.warehouse-name{
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
	max-width:75%;
	font-weight:600;
}

.warehouse-rate{
	font-weight:700;
	color:var(--main-green);
}

.warehouse-bar{
	width:100%;
	height:6px;
	background:var(--light-gray);
	border-radius:10px;
	overflow:hidden;
}

.warehouse-bar-fill{
	height:100%;
	background:var(--main-green);
	border-radius:10px;
}

/* 설비 가동 현황 */
.eq-summary{
	height:130px;
	display:flex;
	flex-direction:column;
	gap:6px;
}

.eq-total{
	height:26px;
	font-size:11px;
	display:flex;
	align-items:center;
}

.eq-total strong{
	font-size:19px;
	color:var(--main-green);
	margin:0 3px;
}

.eq-status-list{
	flex:1;
	display:grid;
	grid-template-columns:1fr 1fr;
	gap:5px;
}

.eq-status-list div{
	height:45px;
	border:1px solid var(--light-gray);
	border-radius:6px;
	padding:5px;
	box-sizing:border-box;

	display:flex;
	flex-direction:column;
	justify-content:center;
	align-items:center;
	gap:3px;
}

.eq-status-list .status-back{
	min-width:45px;
	height:18px;
	padding:0 6px;
	font-size:9px;

	display:flex;
	align-items:center;
	justify-content:center;
}

.eq-status-list strong{
	font-size:13px;
	font-weight:800;
	line-height:1;
}

.dashboard-kpi-card{
	height:112px;
	padding:10px;
}

.dashboard-kpi-card .card-title{
	font-size:12px;
	margin-bottom:7px;
}

.dashboard-kpi-card .card-value{
	font-size:36px;
	line-height:1;
}

.dashboard-unit{
	font-size:16px;
	font-weight:700;
	color:#111;
}

.dashboard-kpi-card .card-subtitle{
	font-size:11px;
	margin-top:8px;
}

.graph-card{
	grid-column:span 2;
	height:165px;
}

.chart-box{
	height:125px;
}

.dashboard-bottom-grid{
	display:grid;
	grid-template-columns:1fr 1fr;
	gap:8px;
	margin-top:12px;
}

.bottom-card{
	height:140px;
	padding:10px;
	overflow:hidden;
}

.dashboard-card-head{
	display:flex;
	justify-content:space-between;
	align-items:center;
}

.dashboard-card-head .dashboard-box-title{
	margin-bottom:6px;
}

.dashboard-more{
	font-size:9px;
	color:var(--dark-gray);
}

.dashboard-list{
	margin:0;
	padding:0;
}

.dashboard-list li{
	height:21px;
	line-height:21px;
	font-size:10.5px;
	border-bottom:1px solid var(--light-gray);
	white-space:nowrap;
	overflow:hidden;
	text-overflow:ellipsis;
}

.dashboard-small-table{
	table-layout:fixed;
	font-size:9px;
}

.dashboard-small-table th{
	height:22px;
	font-size:9px;
	padding:0 4px;
}

.dashboard-small-table td{
	height:19px;
	font-size:9px;
	padding:0 4px;
}

.dashboard-small-table .status-back{
	font-size:9px;
	padding:2px 6px;
}

.dashboard-kpi-title{
	margin:16px 0 7px;
	font-size:15px;
	font-weight:700;
}

.dashboard-kpi-table{
	table-layout:fixed;
	font-size:10.5px;
}

.dashboard-kpi-table th{
	height:28px;
	font-size:10.5px;
	padding:0 5px;
}

.dashboard-kpi-table td{
	height:28px;
	font-size:10.5px;
	padding:0 5px;
}

.empty-msg{
	height:100px;
	display:flex;
	align-items:center;
	justify-content:center;
	font-size:12px;
	color:var(--dark-gray);
}

.table tbody tr:hover{
	background:#fff;
	cursor:default;
}

/* 창고 적재 현황만 스크롤 허용 */
.warehouse-card{
	overflow:hidden;
}

.warehouse-list{
	max-height:135px;
	overflow-y:auto;
	padding-right:4px;
}

/* 금일 예정 작업만 스크롤 허용 */
.bottom-work-card{
	overflow:hidden;
}

.bottom-work-card .table-wrap{
	max-height:105px;
	overflow-y:auto;
}

/* 스크롤 생겨도 테이블 헤더 고정 */
.bottom-work-card .dashboard-small-table thead th{
	position:sticky;
	top:0;
	z-index:1;
}

/* 창고 적재 현황: 카드 높이는 유지하고 내부만 압축 */
.warehouse-card{
	overflow:hidden;
}

.warehouse-list{
	max-height:140px;
	overflow-y:auto;
	padding-right:6px;
	padding-bottom:4px;
	gap:4px;
}

.warehouse-row{
	padding-bottom:1px;
}

.warehouse-info{
	font-size:9.5px;
	margin-bottom:1px;
	line-height:14px;
}

.warehouse-bar{
	height:5px;
	margin-bottom:1px;
}

/* 대시보드 작업코드 링크 */
.dashboard-link{
	color: inherit;
	text-decoration: none;
	cursor: pointer;
}

.dashboard-link:hover{
	color: var(--main-green);
	text-decoration: underline;
}
</style>