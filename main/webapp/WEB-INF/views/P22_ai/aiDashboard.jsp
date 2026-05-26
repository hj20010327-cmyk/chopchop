<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">AI 대시보드</h2>
            <p class="page-subtitle">
                생산 데이터를 기반으로 품질 위험도를 요약합니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; AI 분석 &gt; AI 대시보드
            </p>
        </div>
    </div>
    
    <div class="weather-card">

	    <div class="weather-top">
	        <h3>현재 외부 환경</h3>
	
	        <span class="weather-state">
	            ${weatherMain}
	        </span>
	    </div>
	
	    <div class="weather-info-wrap">
	
	        <div class="weather-info">
	            <p>🌡 외부 온도</p>
	            <strong>${outsideTemp}℃</strong>
	        </div>
	
	        <div class="weather-info">
	            <p>💧 외부 습도</p>
	            <strong>${outsideHumidity}%</strong>
	        </div>
	
	    </div>
	
	</div>
    
    <c:if test="${predictDashboard.highPredictCount > 0}">
	    <div class="ai-alert-box">
	        <div class="ai-alert-icon">⚠</div>
	
	        <div>
	            <strong>최근 AI 예측 이력 중 HIGH 위험이 감지되었습니다.</strong>
	            <p>
	                온도, 습도, 설비 가동 시간, 야간 작업 여부를 확인하고
	                생산 전 설비 및 작업 환경 점검을 권장합니다.
	            </p>
	        </div>
	    </div>
	</c:if>

    <div class="ai-card-grid">

        <div class="ai-card">
            <p class="ai-card-label">전체 분석 데이터</p>
            <strong class="ai-card-value">${summary.totalCount}</strong>
            <span class="ai-card-desc">건</span>
        </div>

        <div class="ai-card">
            <p class="ai-card-label">HIGH 위험 건수</p>
            <strong class="ai-card-value danger">${summary.highCount}</strong>
            <span class="ai-card-desc">건</span>
        </div>

        <div class="ai-card">
            <p class="ai-card-label">평균 불량률</p>
            <strong class="ai-card-value">${summary.avgDefectRate}</strong>
            <span class="ai-card-desc">%</span>
        </div>

        <div class="ai-card">
            <p class="ai-card-label">최고 위험 설비</p>
            <strong class="ai-card-value">${summary.topRiskEquipmentId}</strong>
            <span class="ai-card-desc">
                평균 불량률 ${summary.topRiskEquipmentRate}%
            </span>
        </div>

    </div>
    
    <div class="ai-card-grid predict-card-grid">

	    <div class="ai-card">
	        <p class="ai-card-label">AI 예측 실행 건수</p>
	        <strong class="ai-card-value">${predictDashboard.totalPredictCount}</strong>
	        <span class="ai-card-desc">건</span>
	    </div>
	
	    <div class="ai-card">
	        <p class="ai-card-label">예측 HIGH 건수</p>
	        <strong class="ai-card-value danger">${predictDashboard.highPredictCount}</strong>
	        <span class="ai-card-desc">건</span>
	    </div>
	
	    <div class="ai-card">
	        <p class="ai-card-label">예측 HIGH 비율</p>
	        <strong class="ai-card-value danger">${predictDashboard.highPredictRate}</strong>
	        <span class="ai-card-desc">%</span>
	    </div>
	
	    <div class="ai-card">
	        <p class="ai-card-label">최근 HIGH 발생 시간</p>
	        <strong class="ai-card-value small-value">${predictDashboard.lastHighCreatedAt}</strong>
	        <span class="ai-card-desc">예측 이력 기준</span>
	    </div>
	
	</div>
    
    <div class="chart-wrap">

	    <div class="chart-card">
	        <h3 class="chart-title">
	            위험도 비율 분석
	        </h3>
	
	        <canvas id="riskChart"></canvas>
	    </div>
	
	</div>
	
	<div class="chart-card" style="margin-top:24px;">

	    <h3 class="chart-title">
	        AI 분석 요약
	    </h3>
	
	    <div class="ai-insight-list">
	
	        <div class="ai-insight-item">
	            HIGH 위험 비율은
	            <strong>
	                ${insight.highRiskRate}%
	            </strong>
	            입니다.
	        </div>
	
	        <div class="ai-insight-item">
	            야간 평균 불량률은
	            <strong>
	                ${insight.nightAvgDefectRate}%
	            </strong>
	            로 주간보다 높습니다.
	        </div>
	
	        <div class="ai-insight-item">
	            최고 위험 설비는
	            <strong>
	                ${insight.topRiskEquipmentId}
	            </strong>
	            입니다.
	        </div>
	
	        <div class="ai-insight-item">
	            온도 30℃ 이상 환경의 평균 불량률은
	            <strong>
	                ${insight.highTempRiskRate}%
	            </strong>
	            입니다.
	        </div>
	
	    </div>
	
	</div>
	
	<div class="chart-card" style="margin-top:24px;">

	    <h3 class="chart-title">
	        최근 AI 예측 이력
	    </h3>
	
	    <table class="ai-history-table">
	        <thead>
	            <tr>
	                <th>예측시간</th>
	                <th>생산량</th>
	                <th>온도</th>
	                <th>습도</th>
	                <th>가동시간</th>
	                <th>근무</th>
	                <th>위험도</th>
	            </tr>
	        </thead>
	
	        <tbody>
	            <c:forEach var="h" items="${recentHistory}">
	                <tr>
	                    <td>${h.createdAt}</td>
	                    <td>${h.prodQty}</td>
	                    <td>${h.temperature}℃</td>
	                    <td>${h.humidity}%</td>
	                    <td>${h.equipmentRuntime}시간</td>
	
	                    <td>
	                        <c:choose>
	                            <c:when test="${h.workShiftNum == 0}">
	                                주간
	                            </c:when>
	                            <c:otherwise>
	                                야간
	                            </c:otherwise>
	                        </c:choose>
	                    </td>
	
	                    <td>
	                        <span class="risk-tag risk-${h.riskLevel}">
	                            ${h.riskLevel}
	                        </span>
	                    </td>
	                </tr>
	            </c:forEach>
	
	            <c:if test="${empty recentHistory}">
	                <tr>
	                    <td colspan="7" class="empty-row">
	                        아직 예측 이력이 없습니다.
	                    </td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	
	</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
    .ai-card-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
    }

    .ai-card {
        padding: 22px;
        border: 1px solid #e5e7eb;
        border-radius: 14px;
        background: #fff;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04);
    }

    .ai-card-label {
        margin: 0 0 12px 0;
        font-size: 14px;
        color: #666;
        font-weight: 600;
    }

    .ai-card-value {
        display: inline-block;
        font-size: 30px;
        line-height: 1;
        color: #222;
        font-weight: 800;
    }

    .ai-card-value.danger {
        color: #d93025;
    }

    .ai-card-desc {
        display: block;
        margin-top: 8px;
        font-size: 13px;
        color: #777;
    }
    
    .chart-wrap {
	    margin-top: 24px;
	}

	.chart-card {
	    padding: 24px;
	    border: 1px solid #e5e7eb;
	    border-radius: 14px;
	    background: #fff;
	    box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04);
	}
	
	.chart-title {
	    margin: 0 0 20px 0;
	    font-size: 18px;
	    font-weight: 700;
	}
	
	.ai-insight-list {
	    display: flex;
	    flex-direction: column;
	    gap: 14px;
	}
	
	.ai-insight-item {
	    padding: 14px 16px;
	
	    border-radius: 10px;
	
	    background-color: #f8fafc;
	
	    font-size: 15px;
	    color: #333;
	
	    line-height: 1.6;
	}
	
	.ai-insight-item strong {
	    color: #d93025;
	}
	
	.ai-history-table {
	    width: 100%;
	    border-collapse: collapse;
	    font-size: 14px;
	}
	
	.ai-history-table th {
	    padding: 12px;
	    border-bottom: 1px solid #e5e7eb;
	    background-color: #f8fafc;
	    color: #555;
	    font-weight: 700;
	    text-align: center;
	}
	
	.ai-history-table td {
	    padding: 12px;
	    border-bottom: 1px solid #f1f5f9;
	    text-align: center;
	    color: #333;
	}
	
	.risk-tag {
	    display: inline-block;
	    min-width: 70px;
	    padding: 5px 10px;
	    border-radius: 999px;
	    font-weight: 800;
	    font-size: 12px;
	}
	
	.risk-LOW {
	    color: #15803d;
	    background-color: #dcfce7;
	}
	
	.risk-MEDIUM {
	    color: #b45309;
	    background-color: #fef3c7;
	}
	
	.risk-HIGH {
	    color: #b91c1c;
	    background-color: #fee2e2;
	}
	
	.empty-row {
	    padding: 28px !important;
	    color: #999 !important;
	}
	
	.predict-card-grid {
	    margin-top: 16px;
	}
	
	.small-value {
	    font-size: 20px;
	}
	
	.ai-alert-box {
	    display: flex;
	    align-items: flex-start;
	    gap: 14px;
	
	    margin-bottom: 20px;
	    padding: 18px 22px;
	
	    border-radius: 14px;
	    border: 1px solid #fecaca;
	    background-color: #fef2f2;
	}
	
	.ai-alert-icon {
	    width: 36px;
	    height: 36px;
	
	    display: flex;
	    align-items: center;
	    justify-content: center;
	
	    flex-shrink: 0;
	
	    border-radius: 50%;
	    background-color: #fee2e2;
	    color: #b91c1c;
	
	    font-size: 20px;
	    font-weight: 900;
	}
	
	.ai-alert-box strong {
	    display: block;
	
	    margin-bottom: 6px;
	
	    color: #991b1b;
	    font-size: 16px;
	}
	
	.ai-alert-box p {
	    margin: 0;
	
	    color: #7f1d1d;
	    font-size: 14px;
	    line-height: 1.6;
	}
	
	.weather-card {
	    margin-bottom: 20px;
	    padding: 24px;
	
	    border-radius: 16px;
	    background: linear-gradient(
	        135deg,
	        #eff6ff,
	        #dbeafe
	    );
	
	    border: 1px solid #bfdbfe;
	}
	
	.weather-top {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	
	    margin-bottom: 18px;
	}
	
	.weather-top h3 {
	    margin: 0;
	
	    font-size: 20px;
	    color: #1e3a8a;
	}
	
	.weather-state {
	    padding: 6px 14px;
	
	    border-radius: 999px;
	    background-color: white;
	
	    color: #2563eb;
	    font-weight: 700;
	}
	
	.weather-info-wrap {
	    display: flex;
	    gap: 16px;
	}
	
	.weather-info {
	    flex: 1;
	
	    padding: 18px;
	
	    border-radius: 12px;
	    background-color: rgba(255,255,255,0.7);
	}
	
	.weather-info p {
	    margin: 0 0 10px 0;
	
	    font-size: 14px;
	    color: #555;
	}
	
	.weather-info strong {
	    font-size: 28px;
	    color: #111827;
	}
</style>

<script>

    const riskLabels = [
        <c:forEach var="r" items="${riskChart}" varStatus="status">
            '${r.riskLevel}'
            <c:if test="${!status.last}">
                ,
            </c:if>
        </c:forEach>
    ];

    const riskCounts = [
        <c:forEach var="r" items="${riskChart}" varStatus="status">
            ${r.count}
            <c:if test="${!status.last}">
                ,
            </c:if>
        </c:forEach>
    ];

    const ctx = document.getElementById('riskChart');

    new Chart(ctx, {
        type: 'doughnut',

        data: {
            labels: riskLabels,

            datasets: [{
                data: riskCounts,

                backgroundColor: [
                    '#16a34a',
                    '#f59e0b',
                    '#dc2626'
                ],

                borderWidth: 0
            }]
        },

        options: {

            responsive: true,

            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });

</script>