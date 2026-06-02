<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">대시보드</h2>
			<p class="page-subtitle">전체 현황을 한눈에 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈</p>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				주요 정보 요약
			</div>
			<div class="card-wrap card3-long">
				<div class="card item1">
					<div class="card-title">${not empty sessionScope.loginUser.empName ? sessionScope.loginUser.empName : '-'} 님의 금일 작업목록</div>
					<div class="table-wrap">
						<table class="table workTable">
							<tbody>
								<c:if test="${empty workList or workList == null}">
									<tr>
										<td colspan="3">금일 예정된 작업 없음</td>
									</tr>
								</c:if>	
								
								<c:forEach var="work" items="${workList}">
									<tr class="workTr"
										onclick="window.location.href='${pageContext.request.contextPath}/work/detail?${work.workId}">
										<td class="workId">${work.workId}</td>
										<td>${work.itemName} (${work.item})</td>
										<td>
											<c:choose>
												<c:when test="${work.status == 10}">
													<span class="status status-warning">• 대기</span>
												</c:when>
												<c:when test="${work.status == 20}">
													<span class="status status-success">• 진행 중</span>
												</c:when>
												<c:when test="${work.status == 30}">
													<span class="status status-safe">• 완료</span>
												</c:when>
												<c:when test="${work.status == 40}">
													<span class="status stauts-danger">• 지연</span>
												</c:when>
												<c:when test="${work.status == 0}">
													<span class="status status-info">• 보류</span>
												</c:when>
												<c:otherwise>
													<span class="status status-info">-</span>
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				
				<div class="items">
					<div class="card movePage item2" title="작업관리 페이지로 이동"
							onclick="window.location.href='${pageContext.request.contextPath}/work/list'">
						<div class="card-title">전체 작업 현황</div>
						<div class="circle-chart-box">
							<canvas id="todayWorkProgressChart"></canvas>
							<div class="circle-chart-text">
								<strong>${empty todayProgressSummary.todayWorkProgressRate ? 0 : todayProgressSummary.todayWorkProgressRate} </strong>%
							</div>
						</div>
						<div class="progress-subtitle">
							${empty todayProgressSummary.todayDoneWorkCnt ? 0 : todayProgressSummary.todayDoneWorkCnt}
							/
							${empty todayProgressSummary.todayWorkCnt ? 0 : todayProgressSummary.todayWorkCnt}
							건 완료
						</div>
					</div>
					
					<div class="card movePage item3" title="품질검사 페이지로 이동"
							onclick="window.location.href='${pageContext.request.contextPath}/quality/list'">
						<div class="card-title">전체 품질검사 현황</div>
						<div class="circle-chart-box">
							<canvas id="todayQcProgressChart"></canvas>
							<div class="circle-chart-text">
								<strong>${empty todayProgressSummary.todayQcProgressRate ? 0 : todayProgressSummary.todayQcProgressRate} </strong>%
							</div>
						</div>
						<div>
							<div class="progress-subtitle">
								${empty todayProgressSummary.todayDoneQcCnt ? 0 : todayProgressSummary.todayDoneQcCnt}
								/
								${empty todayProgressSummary.todayQcCnt ? 0 : todayProgressSummary.todayQcCnt}
								건 완료
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				작업환경
			</div>
			<div class="card-wrap card3">
				<div class="card movePage" title="창고 페이지로 이동"
						onclick="window.location.href='${pageContext.request.contextPath}/warehouse/list'">
					<div class="card-title">창고 적재 현황 (전체 ${whStatusChart.totalWhCnt}개)</div>
					<div class="chart-total">
				        냉동 창고: ${whCount.FREE}개<br>냉장 창고: ${whCount.REF}개<br>상온 창고: ${whCount.ROOM}개
				    </div>
					<div class="chart-box">
						<canvas id="whStatusChart" class="chart"></canvas>
					</div>
				</div>
				<div class="card">
					<div class="card-title">창고 온도 현황</div>
					<div class="chart-total">
				        냉동 창고: -18℃ 이하<br>냉장 창고: 0 ~ 10℃<br>상온 창고: 15℃ ~ 25℃
				    </div>
					<div class="chart-box">
						<canvas id="whDegreeChart" class="chart"></canvas>
					</div>
				</div>
				<div class="card">
					<div class="card-title">창고 위생 현황</div>
					<div class="chart-total">
				        청결: 이물, 오염, 악취 없음<br>습도·결로: 결로, 누수, 물고임, 곰팡이 없음<br>해충: 해충, 배설물, 포획 흔적 없음
				    </div>
					<div class="chart-box">
						<canvas id="whCleanChart" class="chart"></canvas>
					</div>
				</div>
			</div>
			<div class="card-wrap card3">
			
				<div class="card movePage" title="설비 페이지로 이동"
						onclick="window.location.href='${pageContext.request.contextPath}/equip/list'">
					<div class="card-title">설비 가동 현황</div>
					
					<div>전체 설비 <span class="eqValue eqValueTotal">${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.totalEqCnt}</span> 대</div>
					
					<div class="eqRow">
						<div class="eqCard">
							<div class="status-back status-back-success">
								• 가동 중
							</div>
							<div><span class="eqValue">${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.runCnt}</span> 대</div>
						</div>
						<div class="eqCard">
							<div class="status-back status-back-info">
								• 정지
							</div>
							<div><span class="eqValue">${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.stopCnt}</span> 대</div>
						</div>
					</div>
					
					<div class="eqRow">
						<div class="eqCard">
							<div class="status-back status-back-warning">
								• 점검 중
							</div>
							<div><span class="eqValue">${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.checkCnt}</span> 대</div>
						</div>
						<div class="eqCard">
							<div class="status-back status-back-danger">
								• 고장
							</div>
							<div><span class="eqValue">${empty eqStatusSummary.totalEqCnt ? 0 : eqStatusSummary.breakCnt}</span> 대</div>
						</div>
					</div>
					
				</div>
				
				<div class="card movePage" title="작업장 페이지로 이동"
						onclick="window.location.href='${pageContext.request.contextPath}/workplace/list'">
					<div class="card-title">작업장 온도 현황</div>
					<div class="chart-total">
				        일반 작업장: 10 ~ 22℃<br>냉각 작업장: 0 ~ 10℃<br>냉동 작업장: -30 ~ -18℃
				    </div>
					<div class="chart-box">
						<canvas id="wpDegreeChart" class="chart"></canvas>
					</div>
				</div>
				<div class="card">
					<div class="card-title">작업장 위생 현황</div>
					<div class="chart-total">
				        청결: 이물, 오염, 악취 없음<br>작업자: 위생복, 위생모, 마스크, 장갑 착용<br>설비·도구: 도구 세척·소독, 용도별 구분 보관
				    </div>
					<div class="chart-box">
						<canvas id="wpCleanChart" class="chart"></canvas>
					</div>
				</div>
				
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				생산 현황
			</div>
			<div class="card-wrap prod card4">
				<div class="card warning">
					<div class="card-title">금일 예정 작업</div>
					<div class="card-value">${todaySummary.todayWorkCnt}<span class="unit"> 건</span></div>
					<div class="card-subtitle">작업예정일이 오늘인 작업 건수</div>
				</div>
				<div class="card success">
					<div class="card-title">완료된 작업</div>
					<div class="card-value">${todaySummary.todayDoneWorkCnt}<span class="unit"> 건</span></div>
					<div class="card-subtitle">금일 예정 작업 중 완료된 작업</div>
				</div>
				<div class="card safe">
					<div class="card-title">품질검사</div>
					<div class="card-value">${todaySummary.todayQcCnt}<span class="unit"> 건</span></div>
					<div class="card-subtitle">금일 완료된 품질검사 건수</div>
				</div>
				<div class="card danger">
					<div class="card-title">불량률</div>
					<div class="card-value">${todaySummary.todayFailRate}<span class="unit"> %</span></div>
					<div class="card-subtitle">품질검사 평균 불량률</div>
				</div>
			</div>
			<div class="card-wrap card2">
				<div class="card">
					<div class="card-title">주간 작업 현황</div>
					<div class="card-value">
						<canvas id="weeklyWorkChart" class="graph"></canvas>
					</div>
				</div>
				<div class="card">
					<div class="card-title">주간 불량 현황</div>
					<div class="card-value">
						<canvas id="weeklyDefectChart" class="graph"></canvas>
					</div>
				</div>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				게시판
			</div>
			<div class="card-wrap card2 userInfo">
				<div class="card">
					<div class="flexSpace">
						<div class="card-title">공지사항</div>
						<div class="goToList toDetail"
								onclick="window.location.href='${pageContext.request.contextPath}/notice/list'">
								전체보기 >
						</div>
					</div>
					<div class="table-wrap">
						<table class="table workTable noticeList">
							<tbody>
								<c:if test="${empty recentNoticeList or recentNoticeList == null}">
									<tr>
										<td>공지사항 없음</td>
									</tr>
								</c:if>	
								
								<c:forEach var="notice" items="${recentNoticeList}">
									<tr class="noticeTr"
										onclick="window.location.href='${pageContext.request.contextPath}/notice/detail?not_no=${notice.notNo}'">
										<td class="notTitle" style="max-width: 230px;"><span class="title">${notice.notTitle}</span></td>
										<td style="width: 70px;">${notice.empName}</td>
										<td style="width: 100px;">
											<fmt:formatDate value="${notice.notCdate}" pattern="yyyy-MM-dd" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				<div class="card">
					<div class="flexSpace">
						<div class="card-title">건의사항</div>
						<div class="goToList toDetail"
								onclick="window.location.href='${pageContext.request.contextPath}/sugg/list'">
								전체보기 >
						</div>
					</div>
					<div class="table-wrap">
						<table class="table workTable suggList">
							<tbody>
								<c:if test="${empty recentSuggList or recentSuggList == null}">
									<tr>
										<td>건의사항 없음</td>
									</tr>
								</c:if>	
								
								<c:forEach var="sugg" items="${recentSuggList}">
									<tr class="suggTr">
										<c:if test="${sugg.suggAnswer == 'Y'}">
											<td style="width: 55px;" class="status status-success">• 완료</td>
										</c:if>
										<c:if test="${sugg.suggAnswer != 'Y'}">
											<td style="width: 55px;" class="status status-info">• 대기</td>
										</c:if>
										<td style="max-width: 180px;"><span class="title">${sugg.suggTitle}</span></td>
										<td style="width: 70px;">${sugg.empName}</td>
										<td style="width: 100px;">
											<fmt:formatDate value="${sugg.suggCdate}" pattern="yyyy-MM-dd" />
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				주요 KPI 지표
			</div>
			<div class="table-wrap kpi">
				<table class="table kpiList">
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
						<c:if test="${empty kpiList}">
							<tr>
								<td colspan="5">내용 없음</td>
							</tr>
						</c:if>
						<c:if test="${not empty kpiList}">
							<c:forEach var="kpi" items="${kpiList}">
								<tr>
									<td>${kpi.kpiName}</td>
									<td>${kpi.thisWeek}%</td>
									<td>${kpi.thisMonth}%</td>
									<td>${kpi.lastMonth}%</td>

									<c:choose>
										<c:when test="${kpi.compareValue > 0}">
											<td  class="${kpi.kpiName != '불량률' ? 'status-success' : 'status-danger'}" >▲ ${kpi.compareValue}%</td>
										</c:when>
										<c:when test="${kpi.compareValue == 0}">
											<td class="status-info">- 0.0%</td>
										</c:when>
										<c:otherwise>
											<td class="${kpi.kpiName == '불량률' ? 'status-success' : 'status-danger'}" >▼ ${kpi.compareValue * -1}%</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>

	
</div>




<style>
	
	.card {
		width: 100%;
		
		display: flex;
		flex-direction: column;
		align-items: center;
		
		gap: 15px;
	}
	
	.card.movePage:hover {
		cursor: pointer;
		box-shadow: 0 0 0 2px var(--main-green) inset;
	}
	
	.card.item2:hover {
		box-shadow: 0 0 0 2px var(--warning) inset;
	}
	
	.card.item3:hover {
		box-shadow: 0 0 0 2px var(--safe) inset;
	}
	
	.card3-long {
		display: flex;
	}
	
	.items {
		display: flex;
		gap: 10px;
	}
	
	.card3-long .item2, .card3-long .item3 {
		flex: 1 1 0;
	}
	
	.card3-long .item1 {
		flex: 2 1 0;
/* 		border: none; */
/* 		padding: 0; */
	}
	
	.table-wrap {
		padding: 0 10px;
	}
	
	.workTable tr, .workTable td {
		height: 32px;
		border: 0px solid gray;
	}
	
	.workTr:hover .workId {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	.kpi .table tr:hover {
		cursor: default;
		background-color: white;
	}
	
	.userInfo .card-title {
		padding-left: 15px;
		
		color: black;
	}
	
	.eqValue {
		font-size: 18px;
		font-weight: 700;
	}
	
	.eqValueTotal {
		font-size: 20px;
		color: var(--main-green);
	}
	
	.eqRow {
		display: flex;
		justify-content: space-evenly;
		
		gap: 40px;
	}
	
	.eqCard {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: 10px;
	}
	
	.card-wrap.prod card-title {
		font-size: 37px;
	}
	
	.unit {
		font-size: 18px;
		color: #666;
	}
	
	
	.chart-box {
		padding: 5px 15px;
	    width: 100%;
	    height: 200px;
	}
	
	.chart-total {
	    text-align: center;
	    font-size: 13px;
	    color: var(--dark-gray);
	}
	
	canvas.chart {
		width: 235px;
	}
	
	canvas.graph {
		width: 400px;
	}
	
	.progress-card-wrap {
		margin-top: 15px;
	}
	
	.progress-card {
		min-height: 230px;
		justify-content: flex-start;
	}
	
	.circle-chart-box {
		position: relative;
		width: 120px;
		height: 120px;
		margin-top: 8px;
	}
	
	.circle-chart-box canvas {
		width: 120px !important;
		height: 120px !important;
		display: block;
	}
	
	.circle-chart-text {
		position: absolute;
		left: 50%;
		top: 50%;
		transform: translate(-50%, -50%);
		z-index: 2;
	
		display: flex;
		align-items: baseline;
		justify-content: center;
	
		font-size: 11px;
		font-weight: 400;
		color: #555;
		line-height: 1;
		pointer-events: none;
	}
	
	.circle-chart-text strong {
		font-size: 27px;
		font-weight: 500;
		letter-spacing: -1.5px;
		color: #444;
		margin-right: 6px;
	}
	
	.progress-subtitle {
		font-size: 11px;
		color: #aaa;
		margin-top: -2px;
	}
	
	.title {
		display: block;
		width: 100%;
		white-space: nowrap;
		overflow: hidden;
		text-overflow: ellipsis;
	}
	
	.noticeTr:hover .notTitle {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	.suggTr:hover {
		cursor: default !important;
		background-color: white !important;
	}
	
	.goToList {
		padding-right: 15px;
		font-size: 12px;
		color: var(--dark-gray);
		cursor: pointer;
	}
	
	.flexSpace {
		width: 100%;
		display: flex;
		justify-content: space-between;
	}
	
	.status {
		padding: 0px;
	}
	
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.card3-long {
		display: flex;
		flex-direction: column;
	}
	
	.card3, .card4, .card2 {
		flex-wrap: wrap;
	}
	.card3 .card, .card4 .card {
		width: 49%;
	}
	
	.table-wrap {
		overflow-x: visible !important;
	}

	.content-content-content {
		overflow-x: visible !important;
	}

	/* common.css의 min-width 제거 */
	.table {
		min-width: 0 !important;
		width: 100% !important;
	}

	.table th,
	.table td {
		white-space: normal !important;
		word-break: keep-all;
	}
	
}

@media screen and (max-width: 600px) {
	.card-wrap {
		flex-wrap: wrap;
	}
	
	.card-wrap .card {
		width: 100%;
	}
	
	.card4 .card {
		max-width: 200px;
	}
	
	.noticeList tr th:nth-child(2), .noticeList tr td:nth-child(2),
	.noticeList tr th:nth-child(3), .noticeList tr td:nth-child(3) {
		display: none;
	}
	
	.suggList tr th:nth-child(4), .suggList tr td:nth-child(4),
	.suggList tr th:nth-child(3), .suggList tr td:nth-child(3) {
		display: none;
	}
	
	.table-wrap.kpi {
		padding: 0px;
	}

	.kpiList tr th:nth-child(4), .kpiList tr td:nth-child(4) {
		display: none;
	}
	
}

</style>




<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	/* =========================
		창고 적재 현황
	========================= */
	const whSafeCnt = Number('${empty whStatusChart.safeWhCnt ? 0 : whStatusChart.safeWhCnt}');
	const whDangerCnt = Number('${empty whStatusChart.dangerWhCnt ? 0 : whStatusChart.dangerWhCnt}');
	const whOverCnt = Number('${empty whStatusChart.overWhCnt ? 0 : whStatusChart.overWhCnt}');
	const whTotalCnt = Number('${empty whStatusChart.totalWhCnt ? 0 : whStatusChart.totalWhCnt}');

	const whStatusCtx = document.getElementById('whStatusChart');

	if (whStatusCtx) {
		new Chart(whStatusCtx, {
			type: 'bar',
			data: {
				labels: ['적정', '위험', '포화'],
				datasets: [
					{
						label: '창고 수',
						data: [whSafeCnt, whDangerCnt, whOverCnt],
						backgroundColor: [
							'#4caf50',
							'#ffb300',
							'#e53935'
						],
						borderRadius: 3,
						barThickness: 36
					}
				]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + '개 / ' + whTotalCnt + '개';
							},
							afterLabel: function(context) {
								const label = context.label;

								if (label === '적정') {
									return '적재율 80% 미만';
								}

								if (label === '위험') {
									return '적재율 80% 이상 ~ 100% 미만';
								}

								if (label === '포화') {
									return '적재율 100% 이상';
								}

								return '';
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						},
						ticks: {
							font: {
								size: 13
							}
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + '개';
							}
						}
					}
				}
			}
		});
	}
	
	/* =========================
		창고 온도 현황
	========================= */
	const whDegreeCtx = document.getElementById('whDegreeChart');

	if (whDegreeCtx) {
		new Chart(whDegreeCtx, {
			type: 'bar',
			data: {
				labels: ['적정', '주의', '초과'],
				datasets: [
					{
						label: '창고 수',
						data: [13, 1, 0],
						backgroundColor: [
							'#4caf50',
							'#ffb300',
							'#e53935'
						],
						borderRadius: 3,
						barThickness: 36
					}
				]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + '개 / ' + whTotalCnt + '개';
							},
							afterLabel: function(context) {
								const label = context.label;

								if (label === '적정') {
									return '안전온도 90% 이내';
								}

								if (label === '주의') {
									return '안전온도 10% 이내';
								}

								if (label === '초과') {
									return '안전온도 초과';
								}

								return '';
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						},
						ticks: {
							font: {
								size: 13
							}
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + '개';
							}
						}
					}
				}
			}
		});
	}

	
	/* =========================
		창고 위생 현황
	========================= */
	const whCleanCtx = document.getElementById('whCleanChart');

	if (whCleanCtx) {
		new Chart(whCleanCtx, {
			type: 'bar',
			data: {
				labels: ['적정', '주의', '위험'],
				datasets: [
					{
						label: '창고 수',
						data: [12, 2, 0],
						backgroundColor: [
							'#4caf50',
							'#ffb300',
							'#e53935'
						],
						borderRadius: 3,
						barThickness: 36
					}
				]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + '개 / ' + whTotalCnt + '개';
							},
							afterLabel: function(context) {
								const label = context.label;

								if (label === '적정') {
									return '모든 항목 정상';
								}

								if (label === '주의') {
									return '경미한 미흡 1~2건';
								}

								if (label === '위험') {
									return '주요 항목 미흡 1건 이상 또는 경미 3건 이상';
								}

								return '';
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						},
						ticks: {
							font: {
								size: 13
							}
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + '개';
							}
						}
					}
				}
			}
		});
	}
	

	/* =========================
		작업장 온도 현황
	========================= */
	const wpDegreeCtx = document.getElementById('wpDegreeChart');

	if (wpDegreeCtx) {
		new Chart(wpDegreeCtx, {
			type: 'bar',
			data: {
				labels: ['적정', '주의', '초과'],
				datasets: [
					{
						label: '작업장 수',
						data: [17, 2, 1],
						backgroundColor: [
							'#4caf50',
							'#ffb300',
							'#e53935'
						],
						borderRadius: 3,
						barThickness: 36
					}
				]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + '개 / ' + whTotalCnt + '개';
							},
							afterLabel: function(context) {
								const label = context.label;

								if (label === '적정') {
									return '안전온도 90% 이내';
								}

								if (label === '주의') {
									return '안전온도 10% 이내';
								}

								if (label === '초과') {
									return '안전온도 초과';
								}

								return '';
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						},
						ticks: {
							font: {
								size: 13
							}
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + '개';
							}
						}
					}
				}
			}
		});
	}
	

	
	/* =========================
		창고 위생 현황
	========================= */
	const wpCleanCtx = document.getElementById('wpCleanChart');

	if (wpCleanCtx) {
		new Chart(wpCleanCtx, {
			type: 'bar',
			data: {
				labels: ['적정', '주의', '위험'],
				datasets: [
					{
						label: '작업장 수',
						data: [18, 0, 2],
						backgroundColor: [
							'#4caf50',
							'#ffb300',
							'#e53935'
						],
						borderRadius: 3,
						barThickness: 36
					}
				]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + '개 / ' + whTotalCnt + '개';
							},
							afterLabel: function(context) {
								const label = context.label;

								if (label === '적정') {
									return '모든 항목 정상';
								}

								if (label === '주의') {
									return '경미한 미흡 1~2건';
								}

								if (label === '위험') {
									return '주요 항목 미흡 1건 이상 또는 경미 3건 이상';
								}

								return '';
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						},
						ticks: {
							font: {
								size: 13
							}
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + '개';
							}
						}
					}
				}
			}
		});
	}
	

	

	/* =========================
		주간 작업 현황
	========================= */
	const weeklyWorkLabels = [
		<c:forEach var="row" items="${weeklyWorkChart}" varStatus="status">
			"${row.dayLabel}"<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyWorkValues = [
		<c:forEach var="row" items="${weeklyWorkChart}" varStatus="status">
			${empty row.value ? 0 : row.value}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyWorkCtx = document.getElementById("weeklyWorkChart");

	if (weeklyWorkCtx) {
		new Chart(weeklyWorkCtx, {
			type: "line",
			data: {
				labels: weeklyWorkLabels,
				datasets: [{
					label: "작업 수량",
					data: weeklyWorkValues,
					borderColor: "#2E6F4E",
					backgroundColor: "rgba(46, 111, 78, 0)",
					tension: 0.35,
					fill: true,
					pointRadius: 3,
					pointHoverRadius: 5
				}]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + "개";
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						}
					},
					y: {
						beginAtZero: true,
						ticks: {
							stepSize: 4,
							callback: function(value) {
								return value + "개";
							}
						}
					}
				}
			}
		});
	}


	/* =========================
		주간 불량 현황
	========================= */
	const weeklyDefectLabels = [
		<c:forEach var="row" items="${weeklyDefectChart}" varStatus="status">
			"${row.dayLabel}"<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyDefectValues = [
		<c:forEach var="row" items="${weeklyDefectChart}" varStatus="status">
			${empty row.value ? 0 : row.value}<c:if test="${!status.last}">,</c:if>
		</c:forEach>
	];

	const weeklyDefectCtx = document.getElementById("weeklyDefectChart");

	if (weeklyDefectCtx) {
		new Chart(weeklyDefectCtx, {
			type: "line",
			data: {
				labels: weeklyDefectLabels,
				datasets: [{
					label: "불량률",
					data: weeklyDefectValues,
					borderColor: "#e53935",
					backgroundColor: "rgba(229, 57, 53, 0)",
					tension: 0.35,
					fill: true,
					pointRadius: 3,
					pointHoverRadius: 5
				}]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					legend: {
						display: false
					},
					tooltip: {
						callbacks: {
							label: function(context) {
								return context.raw + "%";
							}
						}
					}
				},
				scales: {
					x: {
						grid: {
							display: false
						}
					},
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
	}
	
	/* =========================
		금일 작업 / 품질 진행률 원형 차트
	========================= */
	const todayWorkProgressRate = Number('${empty todayProgressSummary.todayWorkProgressRate ? 0 : todayProgressSummary.todayWorkProgressRate}');
	const todayQcProgressRate = Number('${empty todayProgressSummary.todayQcProgressRate ? 0 : todayProgressSummary.todayQcProgressRate}');
	
	const todayWorkCnt = Number('${empty todayProgressSummary.todayWorkCnt ? 0 : todayProgressSummary.todayWorkCnt}');
	const todayDoneWorkCnt = Number('${empty todayProgressSummary.todayDoneWorkCnt ? 0 : todayProgressSummary.todayDoneWorkCnt}');
	
	const todayQcCnt = Number('${empty todayProgressSummary.todayQcCnt ? 0 : todayProgressSummary.todayQcCnt}');
	const todayDoneQcCnt = Number('${empty todayProgressSummary.todayDoneQcCnt ? 0 : todayProgressSummary.todayDoneQcCnt}');
	
	function drawCircleProgressChart(canvasId, rate, doneCnt, totalCnt, labelText, progressColor, trackColor) {
		const canvas = document.getElementById(canvasId);

		if (!canvas) {
			return;
		}

		const rawRate = Math.max(0, Math.min(Number(rate), 100));
		const drawRate = rawRate >= 100 ? 99.2 : rawRate;

		const size = 120;
		const lineWidth = 2;
		const dotRadius = 4;

		const dpr = window.devicePixelRatio || 1;

		canvas.width = size * dpr;
		canvas.height = size * dpr;

		const ctx = canvas.getContext('2d');
		ctx.setTransform(dpr, 0, 0, dpr, 0, 0);
		ctx.clearRect(0, 0, size, size);

		const centerX = size / 2;
		const centerY = size / 2;
		const radius = (size - lineWidth - dotRadius - 2) / 2;

		const startAngle = -Math.PI / 2;
		const endAngle = startAngle - (Math.PI * 2 * drawRate / 100);

		/* 바탕 원 */
		ctx.beginPath();
		ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
		ctx.strokeStyle = trackColor;
		ctx.lineWidth = lineWidth;
		ctx.lineCap = 'round';
		ctx.stroke();

		/* 진행 원 */
		ctx.beginPath();
		ctx.arc(centerX, centerY, radius, startAngle, endAngle, true);
		ctx.strokeStyle = progressColor;
		ctx.lineWidth = lineWidth;
		ctx.lineCap = 'round';
		ctx.stroke();

		/* 끝점 원 */
		const dotX = centerX + Math.cos(endAngle) * radius;
		const dotY = centerY + Math.sin(endAngle) * radius;

		ctx.beginPath();
		ctx.arc(dotX, dotY, dotRadius, 0, Math.PI * 2);
		ctx.fillStyle = progressColor;
		ctx.fill();

		canvas.title = labelText + ' / ' + doneCnt + '건 / ' + totalCnt + '건 완료 / 진행률 ' + rawRate + '%';
	}
	
	drawCircleProgressChart(
		'todayWorkProgressChart',
		todayWorkProgressRate,
		todayDoneWorkCnt,
		todayWorkCnt,
		'금일 작업 진행률',
		'#F9A825',
		'#FFE5BC'
	);
	
	drawCircleProgressChart(
		'todayQcProgressChart',
		todayQcProgressRate,
		todayDoneQcCnt,
		todayQcCnt,
		'금일 품질검사 진행률',
		'#2B8EFF',
		'#C7E1FF'
	);
</script>