<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">점검 리포트</h2>
            <p class="page-subtitle">
                설비 점검과 GHP 점검 이력을 기반으로 점검 위험도를 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 리포팅 &gt; 점검 리포트</p>
        </div>
    </div>

    <form class="search-tool"
          method="get"
          action="${pageContext.request.contextPath}/report/inspection">

        <div class="search-row row1">
            <div class="btn-row">
                <div class="left">
                    <button type="button" class="btn btn-white" id="pdfBtn">pdf 다운로드</button>
                </div>

                <div class="search-item right">
                    <label>기간</label>
                    <div>
                        <input type="date" name="startDate" value="${searchDTO.startDate}">
                        ~
                        <input type="date" name="endDate" value="${searchDTO.endDate}">
                    </div>
                </div>
            </div>
        </div>

        <div class="search-row row2">
            <div class="search-item">
                <label>위험도</label>
                <select name="riskLevel">
                    <option value="">전체</option>
                    <option value="NORMAL" ${searchDTO.riskLevel eq 'NORMAL' ? 'selected' : ''}>NORMAL</option>
                    <option value="WARNING" ${searchDTO.riskLevel eq 'WARNING' ? 'selected' : ''}>WARNING</option>
                    <option value="RISK" ${searchDTO.riskLevel eq 'RISK' ? 'selected' : ''}>RISK</option>
                </select>
            </div>

            <div class="search-item keyword">
                <label>점검 검색</label>
                <input type="text"
                       name="equipKeyword"
                       placeholder="점검유형/대상/결과/사유 검색"
                       value="${searchDTO.equipKeyword}">
            </div>

            <div class="search-btn-area">
                <button type="submit" class="btn btn-main">검색</button>
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/report/inspection">
                    초기화
                </a>
            </div>
        </div>
    </form>

    <div class="content-content" id="inspectionReportPdfArea">
        <div class="content-content-content-title">점검 요약 카드</div>

        <div class="card-grid">
            <div class="card-wrap reportCard">
                <div class="card success">
                    <div class="card-title">총 점검 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.totalInspectionCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">설비 + GHP</div>
                </div>

                <div class="card safe">
                    <div class="card-title">NORMAL 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.normalCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">정상 점검</div>
                </div>

                <div class="card warning">
                    <div class="card-title">WARNING 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.warningCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">주의 점검</div>
                </div>

                <div class="card danger">
                    <div class="card-title">RISK 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.riskCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">위험 점검</div>
                </div>

                <div class="card info">
                    <div class="card-title">WARNING 비율</div>
                    <div class="card-value">${summary.warningRate} <span>%</span></div>
                    <div class="card-subtitle">전체 대비</div>
                </div>

                <div class="card info">
                    <div class="card-title">RISK 비율</div>
                    <div class="card-value">${summary.riskRate} <span>%</span></div>
                    <div class="card-subtitle">전체 대비</div>
                </div>
            </div>

            <div class="card-wrap aiCard">
                <div class="card ai">
                    <div class="card-title card-title-big">AI 점검 위험도 현황</div>

                    <div class="chart-box risk-chart-box">
                        <canvas id="inspectionRiskChart"></canvas>
                    </div>

                    <div class="aiType-btn">
                        <button type="button" class="btn btn-type active" data-risk="ALL">전체</button>
                        <button type="button" class="btn btn-type" data-risk="RISK">RISK</button>
                        <button type="button" class="btn btn-type" data-risk="WARNING">WARNING</button>
                        <button type="button" class="btn btn-type" data-risk="NORMAL">NORMAL</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-wrap aiCard">
            <div class="card ai">
                <div class="card-title card-title-big">주차별 점검 위험도 추이</div>
                <div class="chart-box trend-chart-box">
                    <canvas id="inspectionTrendChart"></canvas>
                </div>
            </div>
        </div>

        <div class="analysis">
            <div class="analysis-title">
                <div class="content-content-content-title">AI 점검 분석 결과</div>
                <div class="analysis-subtitle">Machine Learning Analysis</div>
            </div>

            <div class="analysis-content">
			    <c:choose>
			        <c:when test="${not empty aiResult}">
			            예상 점검 위험도 :
			            <strong>${aiResult.riskLevel}</strong>
			            <br>
			
			            NORMAL
			            <fmt:formatNumber value="${aiResult.normalProb}" pattern="0.##"/>%
			            /
			            WARNING
			            <fmt:formatNumber value="${aiResult.warningProb}" pattern="0.##"/>%
			            /
			            RISK
			            <fmt:formatNumber value="${aiResult.riskProb}" pattern="0.##"/>%
			
			            <br>
			
			            <c:choose>
			                <c:when test="${aiResult.riskLevel == 'RISK'}">
			                    점검 위험도가 높게 예측되었습니다. 설비 이상 사유와 GHP 부적합 조치 내역을 우선 확인하세요.
			                </c:when>
			                <c:when test="${aiResult.riskLevel == 'WARNING'}">
			                    일부 점검 조건에서 주의 패턴이 예측되었습니다. 반복 발생 대상과 점검 결과를 확인하세요.
			                </c:when>
			                <c:otherwise>
			                    현재 조건에서는 점검 위험도가 낮게 예측되었습니다.
			                </c:otherwise>
			            </c:choose>
			        </c:when>
			
			        <c:when test="${not empty aiErrorMessage}">
			            ${aiErrorMessage}
			        </c:when>
			
			        <c:otherwise>
			            AI 분석에 사용할 점검 데이터가 없습니다.
			        </c:otherwise>
			    </c:choose>
			</div>
        </div>
    </div>

    <div class="content-content">
        <div class="content-content-content-title">점검 이력</div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 120px;">점검일</th>
                        <th style="width: 220px;">대상</th>
                        <th style="width: 120px;">점검유형</th>
                        <th>점검결과</th>
                        <th style="width: 180px">점검사유/조치</th>
                        <th style="width: 110px;">위험도</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="inspection" items="${inspectionList}">
                        <tr>
                            <td>${inspection.inspectionDate}</td>
                            <td>${inspection.targetName}</td>
							<td>
							    <c:choose>
							
							        <c:when test="${inspection.inspectionType == 'EQUIPMENT'}">
							            설비점검
							        </c:when>
							
							        <c:when test="${inspection.inspectionType == 'GHP'}">
							            위생점검
							        </c:when>
							
							        <c:otherwise>
							            ${inspection.inspectionType}
							        </c:otherwise>
							
							    </c:choose>
							</td>
                            <td>${inspection.inspectionResult}</td>
                            <td>${inspection.inspectionReason}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${inspection.riskLevel == 'NORMAL'}">
                                        <span class="status status-success">• NORMAL</span>
                                    </c:when>
                                    <c:when test="${inspection.riskLevel == 'WARNING'}">
                                        <span class="status status-warning">• WARNING</span>
                                    </c:when>
                                    <c:when test="${inspection.riskLevel == 'RISK'}">
                                        <span class="status status-danger">• RISK</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status status-info">• 미지정</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty inspectionList}">
                        <tr>
                            <td colspan="6" style="text-align: center;">
                                조회된 점검 데이터가 없습니다.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <jsp:include page="/WEB-INF/views/common/paging.jsp" />
    </div>

</div>

<style>
    .content {
        min-width: 0;
        overflow-x: hidden;
    }

    .content-content {
        padding-bottom: 0;
    }

    .btn-row {
        width: 100%;
        align-items: flex-end;
    }

    .search-tool {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .search-row {
        display: flex;
        gap: 10px;
        align-items: flex-end;
        justify-content: flex-end;
    }

    .content-content>div {
        margin-bottom: 15px;
    }

    .content-content-content-title {
        margin: 20px auto 20px;
    }

    .card-grid {
        display: flex;
        gap: 15px;
        align-items: stretch;
    }

    .card-wrap {
        margin: 0;
    }

    .reportCard {
        flex: 0 0 50%;
        max-width: 50%;
        flex-wrap: wrap;
        flex-direction: flex-start;
    }

    .aiCard {
        flex: 1;
        min-width: 0;
        display: flex;
    }

    .card {
        width: 200px;
        display: flex;
        flex-direction: column;
        align-items : center;
        gap: 15px;
    }

    .card-value span {
        font-weight : 500;
        font-size: 18px;
    }

    .card-title-big {
        width: 100%;
        font-size: 17px;
        color: black;
        padding-left:15px;
    }

    .card.ai {
        width: 100%;
        justify-content: space-between;
    }

    .aiType-btn {
        display: flex;
        gap: 10px;
        margin-bottom: 20px;
    }

    .btn-type {
        font-weight: 500;
        border: 1px solid var(--dark-gray);
        border-radius: 28px;
        padding: 5px 13px;
        height: 30px;
        min-width: 75px;
        color: var(--dark-gray);
    }

    .btn-type.active {
        color: var(--main-green);
        border: 1px solid var(--main-green);
    }

    .btn-type:hover {
        background-color: var(--white-hover);
    }

    .analysis {
        width: 100%;
        padding: 20px 25px;
        color: var(--success);
        border: 1px solid var(--success);
        border-radius: 5px;
        background-color: #d0f4d163;
    }

    .analysis-title {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 15px;
    }

    .analysis-title .content-content-content-title {
        margin: 0;
    }

    .analysis-subtitle {
        color: var(--success);
        font-weight: 600;
    }

    .analysis-content {
        font-size: 14px;
        padding-left: 10px;
    }

    .chart-box {
        width: 100%;
        height: 260px;
        padding: 10px 20px;
        box-sizing: border-box;
    }

    .trend-chart-box {
        height: 300px;
    }

    @media (max-width: 900px) {
        .reportCard {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/html2canvas@1.4.1/dist/html2canvas.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jspdf@2.5.1/dist/jspdf.umd.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function () {

    const riskLabels = [
        <c:forEach var="risk" items="${riskChartList}" varStatus="st">
            '${risk.riskLevel}'<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const riskCounts = [
        <c:forEach var="risk" items="${riskChartList}" varStatus="st">
            ${risk.riskCount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendLabels = [
        <c:forEach var="trend" items="${inspectionTrendList}" varStatus="st">
            '${trend.inspectionDate}'<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendRiskCounts = [
        <c:forEach var="trend" items="${inspectionTrendList}" varStatus="st">
            ${empty trend.riskCount ? 0 : trend.riskCount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendWarningCounts = [
        <c:forEach var="trend" items="${inspectionTrendList}" varStatus="st">
            ${empty trend.warningCount ? 0 : trend.warningCount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const riskCountNums = riskCounts.map(Number);
    const trendRiskNums = trendRiskCounts.map(Number);
    const trendWarningNums = trendWarningCounts.map(Number);

    const riskColorMap = {
        NORMAL: '#2e7d32',
        WARNING: '#f9a825',
        RISK: '#d32f2f'
    };

    const riskCanvas = document.getElementById('inspectionRiskChart');
    const trendCanvas = document.getElementById('inspectionTrendChart');

    let riskChart = null;

    if (riskCanvas) {
        riskChart = new Chart(riskCanvas, {
            type: 'bar',
            data: {
                labels: riskLabels,
                datasets: [{
                    label: '점검 위험도 건수',
                    data: riskCountNums,
                    backgroundColor: riskLabels.map(label => riskColorMap[label] || '#999'),
                    borderColor: riskLabels.map(label => riskColorMap[label] || '#999'),
                    borderWidth: 1,
                    borderRadius: 8,
                    barThickness: 45,
                    maxBarThickness: 60
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        grid: {
                            display: false
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0,
                            callback: function(value) {
                                return value + '건';
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.parsed.y.toLocaleString() + '건';
                            }
                        }
                    }
                }
            }
        });
    }

    const originRiskLabels = [...riskLabels];
    const originRiskCounts = [...riskCountNums];

    document.querySelectorAll('.aiType-btn .btn-type').forEach(function(btn) {
        btn.addEventListener('click', function() {

            document.querySelectorAll('.aiType-btn .btn-type').forEach(function(b) {
                b.classList.remove('active');
            });

            this.classList.add('active');

            const selectedRisk = this.dataset.risk;

            let filteredLabels = [];
            let filteredCounts = [];

            if (selectedRisk === 'ALL') {
                filteredLabels = originRiskLabels;
                filteredCounts = originRiskCounts;
            } else {
                originRiskLabels.forEach(function(label, index) {
                    if (label === selectedRisk) {
                        filteredLabels.push(label);
                        filteredCounts.push(originRiskCounts[index]);
                    }
                });
            }

            if (!riskChart) {
                return;
            }

            riskChart.data.labels = filteredLabels;
            riskChart.data.datasets[0].data = filteredCounts;
            riskChart.data.datasets[0].backgroundColor =
                filteredLabels.map(label => riskColorMap[label] || '#999');
            riskChart.data.datasets[0].borderColor =
                filteredLabels.map(label => riskColorMap[label] || '#999');

            riskChart.update();
        });
    });

    if (trendCanvas) {
        new Chart(trendCanvas, {
            type: 'bar',
            data: {
                labels: trendLabels,
                datasets: [
                    {
                        label: 'RISK',
                        data: trendRiskNums,
                        backgroundColor: '#d32f2f',
                        borderColor: '#d32f2f',
                        borderWidth: 1,
                        borderRadius: 6,
                        barThickness: 18
                    },
                    {
                        label: 'WARNING',
                        data: trendWarningNums,
                        backgroundColor: '#f9a825',
                        borderColor: '#f9a825',
                        borderWidth: 1,
                        borderRadius: 6,
                        barThickness: 18
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    mode: 'index',
                    intersect: false
                },
                scales: {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            maxTicksLimit: 10
                        }
                    },
                    y: {
                        beginAtZero: true,
                        ticks: {
                            precision: 0,
                            callback: function(value) {
                                return value + '건';
                            }
                        }
                    }
                },
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom'
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return context.dataset.label + ' ' + context.parsed.y.toLocaleString() + '건';
                            }
                        }
                    }
                }
            }
        });
    }

    const pdfBtn = document.getElementById('pdfBtn');

    if (pdfBtn) {
        pdfBtn.addEventListener('click', async function () {

            const pdfArea = document.getElementById('inspectionReportPdfArea');

            if (!pdfArea) {
                alert('PDF 저장 영역을 찾을 수 없습니다.');
                return;
            }

            pdfBtn.disabled = true;
            pdfBtn.innerText = 'PDF 생성 중...';

            try {
                const { jsPDF } = window.jspdf;

                const canvas = await html2canvas(pdfArea, {
                    scale: 2,
                    backgroundColor: '#ffffff',
                    useCORS: true,
                    scrollX: 0,
                    scrollY: 0
                });

                const imgData = canvas.toDataURL('image/png');

                const pdf = new jsPDF('p', 'mm', 'a4');

                const pageWidth = 210;
                const pageHeight = 297;
                const margin = 8;

                const imgWidth = pageWidth - margin * 2;
                const imgHeight = canvas.height * imgWidth / canvas.width;

                let heightLeft = imgHeight;
                let position = margin;

                pdf.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                heightLeft -= pageHeight - margin * 2;

                while (heightLeft > 0) {
                    position = heightLeft - imgHeight + margin;
                    pdf.addPage();
                    pdf.addImage(imgData, 'PNG', margin, position, imgWidth, imgHeight);
                    heightLeft -= pageHeight - margin * 2;
                }

                pdf.save('점검리포트.pdf');

            } catch (e) {
                console.error(e);
                alert('PDF 생성 중 오류가 발생했습니다.');
            } finally {
                pdfBtn.disabled = false;
                pdfBtn.innerText = 'pdf 다운로드';
            }
        });
    }

});
</script>