<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">AI 예측 결과</h2>

			<p class="page-subtitle">
				Python 머신러닝 서버 예측 결과입니다.
			</p>
		</div>

		<div>
			<p class="page-route">
				홈 &gt; AI 분석 &gt; AI 품질 예측 &gt; 결과
			</p>
		</div>
	</div>

	<c:set var="riskClass" value="risk-low" />

	<c:if test="${predictResult == 'MEDIUM'}">
		<c:set var="riskClass" value="risk-medium" />
	</c:if>

	<c:if test="${predictResult == 'HIGH'}">
		<c:set var="riskClass" value="risk-high" />
	</c:if>

	<div class="predict-result-wrap">

		<div class="predict-result-card">

			<p class="predict-label">
				예측 위험도
			</p>

			<div class="risk-badge ${riskClass}
			    ${predictResult == 'HIGH' ? 'risk-pulse' : ''}">
			    ${predictResult}
			</div>
			
			<div class="ai-reason-box">

			    <h3>AI 분석 사유</h3>
			
			    <ul>
			        <c:forEach var="reason" items="${analysisReasons}">
			            <li>${reason}</li>
			        </c:forEach>
			    </ul>
			
			</div>

			<div class="predict-info-grid">

				<div class="predict-info-item">
					<span>생산량</span>
					<strong>${prodQty}</strong>
				</div>

				<div class="predict-info-item">
					<span>온도</span>
					<strong>${temperature}℃</strong>
				</div>

				<div class="predict-info-item">
					<span>습도</span>
					<strong>${humidity}%</strong>
				</div>

				<div class="predict-info-item">
					<span>설비 가동시간</span>
					<strong>${equipmentRuntime}시간</strong>
				</div>

				<div class="predict-info-item">
					<span>근무 구분</span>

					<strong>
						<c:choose>
							<c:when test="${workShiftNum == 0}">
								주간
							</c:when>
							<c:otherwise>
								야간
							</c:otherwise>
						</c:choose>
					</strong>
				</div>

			</div>

			<div class="predict-btn-area">
				<a class="btn btn-white"
				   href="${pageContext.request.contextPath}/ai/predict-form">
					다시 예측
				</a>

				<a class="btn btn-main"
				   href="${pageContext.request.contextPath}/ai/dashboard">
					대시보드
				</a>
			</div>

		</div>

	</div>

</div>

<style>
	.predict-result-wrap {
		display: flex;
		justify-content: center;
		align-items: center;

		min-height: 420px;
	}

	.predict-result-card {
		width: 640px;
		padding: 36px;

		text-align: center;

		border: 1px solid #e5e7eb;
		border-radius: 18px;
		background-color: #fff;

		box-shadow: 0 4px 14px rgba(0, 0, 0, 0.04);
	}

	.predict-label {
		margin: 0 0 20px 0;

		font-size: 16px;
		color: #666;
		font-weight: 700;
	}

	.risk-badge {
		display: inline-flex;
		justify-content: center;
		align-items: center;

		min-width: 220px;
		height: 96px;
		padding: 0 32px;

		border-radius: 999px;

		font-size: 54px;
		font-weight: 900;
		letter-spacing: 1px;
	}

	.risk-low {
		color: #15803d;
		background-color: #dcfce7;
		border: 1px solid #86efac;
	}

	.risk-medium {
		color: #b45309;
		background-color: #fef3c7;
		border: 1px solid #fcd34d;
	}

	.risk-high {
		color: #b91c1c;
		background-color: #fee2e2;
		border: 1px solid #fca5a5;
	}

	.predict-info-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		gap: 12px;

		margin-top: 32px;
	}

	.predict-info-item {
		padding: 16px;

		text-align: left;

		border-radius: 12px;
		background-color: #f8fafc;
	}

	.predict-info-item span {
		display: block;

		margin-bottom: 8px;

		font-size: 13px;
		color: #777;
		font-weight: 600;
	}

	.predict-info-item strong {
		font-size: 18px;
		color: #222;
	}

	.predict-btn-area {
		display: flex;
		justify-content: center;
		gap: 10px;

		margin-top: 30px;
	}
	
	.ai-reason-box {
	    margin-top: 28px;
	    padding: 22px 26px;
	
	    text-align: left;
	
	    border-radius: 14px;
	    background-color: #f8fafc;
	    border: 1px solid #e5e7eb;
	}
	
	.ai-reason-box h3 {
	    margin: 0 0 14px 0;
	
	    font-size: 18px;
	    color: #222;
	}
	
	.ai-reason-box ul {
	    margin: 0;
	    padding-left: 20px;
	}
	
	.ai-reason-box li {
	    margin-bottom: 8px;
	
	    font-size: 14px;
	    color: #444;
	    line-height: 1.6;
	}
	
	.risk-pulse {
	    animation: riskPulse 1.5s infinite;
	}
	
	@keyframes riskPulse {
	
	    0% {
	        transform: scale(1);
	        box-shadow: 0 0 0 rgba(220, 38, 38, 0.0);
	    }
	
	    50% {
	        transform: scale(1.04);
	        box-shadow: 0 0 18px rgba(220, 38, 38, 0.28);
	    }
	
	    100% {
	        transform: scale(1);
	        box-shadow: 0 0 0 rgba(220, 38, 38, 0.0);
	    }
	}
</style>