<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">
    
    <div class="header-row">
        <div>
            <h2 class="page-title">불량 유형 상세</h2>

            <p class="page-subtitle">
                선택한 불량 유형의 상세 정보를 확인하세요.
            </p>
        </div>
        
        <div>
            <p class="page-route">
                홈 &gt; 불량 유형 관리 &gt; 상세
            </p>
        </div>
    </div>

    <div class="btn-row">
        
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/defect/list">
                목록으로
            </a>
        </div>

        <div class="right">
            
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/defect/edit?defTypeId=${def.defTypeId}">
                수정
            </a>

            <a class="btn btn-red"
               href="${pageContext.request.contextPath}/defect/delete?defTypeId=${def.defTypeId}"
               onclick="return confirm('불량유형(${def.defTypeId})을 삭제하시겠습니까?');">
                삭제
            </a>

        </div>

    </div>
    
    <div class="content-content">
        
        <div class="content-content-content">
            
            <div class="content-content-content-title">
                불량 유형 상세정보
            </div>

            <div class="info-table-wrap">
                <table class="info-table">
                    <tbody>

                        <tr>
                            <th>불량 유형명</th>
                            <td>${def.defTypeName}</td>

                            <th>불량 유형 코드</th>
                            <td>${def.defTypeId}</td>
                        </tr>

                        <tr>
                            <th colspan="4">
                                기준 조치
                            </th>
                        </tr>
						<tr>
                            <td colspan="4"
                                class="def-top-align">

                                <div class="def-detail-text"><c:choose><c:when test="${not empty def.defStandardAction}">${def.defStandardAction}</c:when><c:otherwise>-</c:otherwise></c:choose></div>

                            </td>
                        </tr>

                    </tbody>
                </table>
            </div>

        </div>
        
        <div class="content-content-content">
            <div class="content-content-content-title">
                불량 누적 현황
            </div>
            
        </div>
        
        <div class="def-summary-grid">

                <div class="card def-total-card">
                    <div class="card-title">전체 누적 개수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${totalDefectCnt}" pattern="#,###" /><span> 건</span>
                    </div>
                    <div class="card-subtitle">
                        전체 누적 발생 수량
                    </div>
                </div>

                <div class="card def-chart-card">
                    <div class="def-chart-head">
                        <div>
                            <div class="card-title">발생 추이</div>
                            <div class="card-subtitle">최근 6개월 월별 발생 수량</div>
                        </div>
                    </div>

                    <div class="def-chart-wrap">
                        <canvas id="defTrendChart"></canvas>
                    </div>

                    <div id="defTrendData" style="display:none;">
                        <c:forEach var="trend" items="${trendList}">
                            <span class="trend-item"
                                  data-label="${trend.trendDate}"
                                  data-count="${trend.trendCnt}">
                            </span>
                        </c:forEach>
                    </div>
                </div>

            </div>

            <div class="def-history-area">

                <div class="content-content-content-title def-history-title">
                    발생 이력
                </div>

                <div class="table-wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th style="width: 120px;">이력번호</th>
						        <th style="width: 120px;">검사번호</th>
						        <th style="width: 120px;">불량수량</th>
						        <th style="width: 140px;">검사일</th>
						        <th>조치내용</th>
						        <th>폐기여부</th>
                            </tr>
                        </thead>

                        <tbody>
						    <c:forEach var="his" items="${historyList}">
						        <tr class="defHistoryRow"
						            data-qc-id="${his.qcId}">
						            <td>${his.dlogId}</td>
						            <td class="toDetail">${his.qcId}</td>
						            <td>
					                    <fmt:formatNumber value="${his.defCnt}" pattern="#,###" />
						            </td>
						            <td>${his.qcDate}</td>
						            <td>${empty his.dlogAction ? '-' : his.dlogAction}</td>
						            <td>${empty his.dlogDispose ? '-' : his.dlogDispose}</td>
						        </tr>
						    </c:forEach>
						
						    <c:if test="${empty historyList}">
						        <tr>
						            <td colspan="6" style="text-align:center;">
						                발생 이력이 없습니다.
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

.def-top-align {
    vertical-align: top !important;
}

.def-detail-text {
    min-height: 80px;

    padding: 12px 0;

    line-height: 1.6;

    white-space: pre-wrap;
    text-align: left;
}

.def-top-align {
    vertical-align: top !important;
}

.def-detail-text {
    min-height: 80px;
    padding: 12px 0;
    line-height: 1.6;
    white-space: pre-wrap;
    text-align: left;
}

.def-summary-grid {
    display: flex;
	gap: 20px;
	align-items: flex-start;
	
    margin-top: 20px;
    padding: 0 20px;
}

.card {
	padding: 20px;
}

.card-title {
	font-size: 16px;
	margin-bottom: 10px;
}

.card-value {
	font-size: 36px;
}

.card-value span {
	font-size: 22px;
}

.def-total-card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    
    gap: 20px;
    
    padding: 30px;
    
    min-width: 210px;
}

.def-chart-head {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.def-chart-wrap {
    width: 100%;
    height: 210px;
    margin-top: 10px;
}

#defTrendChart {
    width: 100%;
    height: 100%;
}

.def-history-area {
    margin-top: 30px;
    padding: 0 20px;
}

.def-history-title {
    margin-top: 10px;
}

.def-history-content {
    max-width: 260px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.defHistoryRow {
    cursor: pointer;
}

.defHistoryRow:hover .toDetail {
    color: var(--main-green);
    text-decoration: underline;
}

@media screen and (max-width: 900px) {
    .def-summary-grid {
        grid-template-columns: 1fr;
    }

    .def-total-card {
        min-height: 160px;
    }
}

</style>

<script>

window.addEventListener("load", function () {
    drawDefTrendChart();
    bindDefHistoryRows();
});

window.addEventListener("resize", function () {
    drawDefTrendChart();
});

function bindDefHistoryRows() {
    const rows = document.querySelectorAll(".defHistoryRow");

    for (let i = 0; i < rows.length; i++) {
        rows[i].addEventListener("click", function () {
            const qcId = this.dataset.qcId;

            if (!qcId) {
                return;
            }

            location.href = contextPath + "/quality/detail?qcId=" + qcId;
        });
    }
}

function drawDefTrendChart() {
    const canvas = document.querySelector("#defTrendChart");

    if (!canvas) {
        return;
    }

    const items = document.querySelectorAll(".trend-item");

    const labels = [];
    const values = [];

    for (let i = 0; i < items.length; i++) {
        labels.push(items[i].dataset.label);
        values.push(Number(items[i].dataset.count));
    }

    const ctx = canvas.getContext("2d");

    const parent = canvas.parentElement;
    canvas.width = parent.clientWidth;
    canvas.height = parent.clientHeight;

    const width = canvas.width;
    const height = canvas.height;

    ctx.clearRect(0, 0, width, height);

    if (labels.length === 0) {
        ctx.font = "14px sans-serif";
        ctx.fillStyle = "#aaa";
        ctx.textAlign = "center";
        ctx.fillText("최근 6개월 발생 데이터가 없습니다.", width / 2, height / 2);
        return;
    }

    const paddingLeft = 30;
    const paddingRight = 30;
    const paddingTop = 20;
    const paddingBottom = 40;

    const chartWidth = width - paddingLeft - paddingRight;
    const chartHeight = height - paddingTop - paddingBottom;

    const maxValue = Math.max.apply(null, values);
    const safeMax = maxValue <= 0 ? 1 : maxValue;

    // y축 + x축
    ctx.strokeStyle = "#ddd";
    ctx.lineWidth = 1;

    ctx.beginPath();
    ctx.moveTo(paddingLeft, paddingTop);
    ctx.lineTo(paddingLeft, paddingTop + chartHeight);
    ctx.lineTo(paddingLeft + chartWidth, paddingTop + chartHeight);
    ctx.stroke();

    // 가로 보조선
    ctx.font = "11px sans-serif";
    ctx.fillStyle = "#999";
    ctx.textAlign = "right";

    for (let i = 0; i <= 4; i++) {
        const y = paddingTop + chartHeight - (chartHeight / 4 * i);
        const labelValue = Math.round(safeMax / 4 * i);

        ctx.strokeStyle = "#eee";
        ctx.beginPath();
        ctx.moveTo(paddingLeft, y);
        ctx.lineTo(paddingLeft + chartWidth, y);
        ctx.stroke();

        ctx.fillStyle = "#999";
        ctx.fillText(labelValue, paddingLeft - 8, y + 4);
    }

    const gap = labels.length === 1 ? chartWidth : chartWidth / (labels.length - 1);

    const points = [];

    for (let i = 0; i < labels.length; i++) {
        const x = labels.length === 1
            ? paddingLeft + chartWidth / 2
            : paddingLeft + gap * i;

        const y = paddingTop + chartHeight - (values[i] / safeMax * chartHeight);

        points.push({
            x: x,
            y: y,
            value: values[i],
            label: labels[i]
        });
    }

    // 선
    ctx.strokeStyle = "#2E6F4E";
    ctx.lineWidth = 2;

    ctx.beginPath();

    for (let i = 0; i < points.length; i++) {
        if (i === 0) {
            ctx.moveTo(points[i].x, points[i].y);
        } else {
            ctx.lineTo(points[i].x, points[i].y);
        }
    }

    ctx.stroke();

    // 점 + 값
    for (let i = 0; i < points.length; i++) {
        ctx.fillStyle = "#2E6F4E";
        ctx.beginPath();
        ctx.arc(points[i].x, points[i].y, 4, 0, Math.PI * 2);
        ctx.fill();

        ctx.font = "11px sans-serif";
        ctx.fillStyle = "#333";
        ctx.textAlign = "center";
        ctx.fillText(points[i].value, points[i].x, points[i].y - 10);
    }

    // x축 월 라벨
    ctx.font = "11px sans-serif";
    ctx.fillStyle = "#777";
    ctx.textAlign = "center";

    for (let i = 0; i < points.length; i++) {
        ctx.fillText(points[i].label, points[i].x, paddingTop + chartHeight + 22);
    }
}

</script>