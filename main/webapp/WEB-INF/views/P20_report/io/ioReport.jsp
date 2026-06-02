<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">재고/입출고 리포트</h2>
            <p class="page-subtitle">
                입출고 이력과 LOT, 재고 데이터를 기반으로 재고 위험도를 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 리포팅 &gt; 재고/입출고 리포트</p>
        </div>
    </div>

    <form class="search-tool"
          method="get"
          action="${pageContext.request.contextPath}/report/io">

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
                    <option value="LOW" ${searchDTO.riskLevel eq 'LOW' ? 'selected' : ''}>LOW</option>
                    <option value="WARNING" ${searchDTO.riskLevel eq 'WARNING' ? 'selected' : ''}>WARNING</option>
                    <option value="HIGH" ${searchDTO.riskLevel eq 'HIGH' ? 'selected' : ''}>HIGH</option>
                </select>
            </div>

            <div class="search-item">
                <label>입출고유형</label>
                <select name="ioType">
                    <option value="">전체</option>
                    <option value="IN" ${searchDTO.ioType eq 'IN' ? 'selected' : ''}>IN</option>
                    <option value="OUT" ${searchDTO.ioType eq 'OUT' ? 'selected' : ''}>OUT</option>
                </select>
            </div>

            <div class="search-item">
                <label>입출고사유</label>
                <select name="ioReason">
                    <option value="">전체</option>
                    <option value="구매" ${searchDTO.ioReason eq '구매' ? 'selected' : ''}>구매</option>
                    <option value="생산" ${searchDTO.ioReason eq '생산' ? 'selected' : ''}>생산</option>
                    <option value="판매" ${searchDTO.ioReason eq '판매' ? 'selected' : ''}>판매</option>
                    <option value="폐기" ${searchDTO.ioReason eq '폐기' ? 'selected' : ''}>폐기</option>
                </select>
            </div>

            <div class="search-item keyword">
                <label>품목/LOT 검색</label>
                <input type="text"
                       name="itemKeyword"
                       placeholder="품목명, 품목코드, LOT 검색"
                       value="${searchDTO.itemKeyword}">
            </div>

            <div class="search-btn-area">
                <button type="submit" class="btn btn-main">검색</button>
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/report/io">
                    초기화
                </a>
            </div>
        </div>
    </form>

    <div class="content-content" id="ioReportPdfArea">
        <div class="content-content-content-title">재고/입출고 요약 카드</div>

        <div class="card-grid">
            <div class="card-wrap reportCard">
                <div class="card success">
                    <div class="card-title">총 입출고 수량</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.totalIoQty}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">입출고 합계</div>
                </div>

                <div class="card safe">
                    <div class="card-title">총 LOT 수량</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.totalLotQty}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">LOT 기준 수량</div>
                </div>

                <div class="card warning">
                    <div class="card-title">현재 LOT 잔량</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.totalLotFqty}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">LOT 현재 수량</div>
                </div>

                <div class="card danger">
                    <div class="card-title">HIGH 위험 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.highCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">폐기/유통기한 위험</div>
                </div>

                <div class="card info">
                    <div class="card-title">WARNING 건수</div>
                    <div class="card-value">
                        <fmt:formatNumber value="${summary.warningCount}" pattern="#,###"/>
                    </div>
                    <div class="card-subtitle">주의 재고</div>
                </div>

                <div class="card info">
                    <div class="card-title">HIGH 위험 비율</div>
                    <div class="card-value">${summary.highRate} <span>%</span></div>
                    <div class="card-subtitle">전체 대비</div>
                </div>
            </div>

            <div class="card-wrap aiCard">
                <div class="card ai">
                    <div class="card-title card-title-big">AI 재고 위험도 현황</div>

                    <div class="chart-box risk-chart-box">
                        <canvas id="ioRiskChart"></canvas>
                    </div>

                    <div class="aiType-btn">
                        <button type="button" class="btn btn-type active" data-risk="ALL">전체</button>
                        <button type="button" class="btn btn-type" data-risk="HIGH">HIGH</button>
                        <button type="button" class="btn btn-type" data-risk="WARNING">WARNING</button>
                        <button type="button" class="btn btn-type" data-risk="LOW">LOW</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="card-wrap aiCard">
            <div class="card ai">
                <div class="card-title card-title-big">주차별 재고 위험도 추이</div>
                <div class="chart-box trend-chart-box">
                    <canvas id="ioTrendChart"></canvas>
                </div>
            </div>
        </div>

        <div class="analysis">
            <div class="analysis-title">
                <div class="content-content-content-title">AI 재고/입출고 분석 결과</div>
                <div class="analysis-subtitle">Machine Learning Analysis</div>
            </div>

            <div class="analysis-content">

			    <c:choose>
			
			        <c:when test="${not empty aiResult}">

					    예상 재고 위험도 :
					    <strong>${aiResult.riskLevel}</strong>
					    <br>
					
					    예측 신뢰도 :
					    <strong>
					        <c:choose>
					            <c:when test="${aiResult.riskLevel == 'LOW'}">
					                <fmt:formatNumber value="${aiResult.lowProb}" pattern="0.##"/>%
					            </c:when>
					
					            <c:when test="${aiResult.riskLevel == 'WARNING'}">
					                <fmt:formatNumber value="${aiResult.warningProb}" pattern="0.##"/>%
					            </c:when>
					
					            <c:when test="${aiResult.riskLevel == 'HIGH'}">
					                <fmt:formatNumber value="${aiResult.highProb}" pattern="0.##"/>%
					            </c:when>
					        </c:choose>
					    </strong>
					    <br><br>
					
					    <c:choose>
					
					        <c:when test="${aiResult.riskLevel == 'HIGH'}">
					            재고 위험도가 높게 예측되었습니다.
					            폐기 이력과 유통기한 임박 LOT,
					            예약재고 비율을 우선 확인하세요.
					        </c:when>
					
					        <c:when test="${aiResult.riskLevel == 'WARNING'}">
					            일부 재고 품목에서 주의 패턴이 감지되었습니다.
					            유통기한과 예약재고 현황을 확인하세요.
					        </c:when>
					
					        <c:otherwise>
					            현재 조건에서는
					            재고 위험도가 낮게 예측되었습니다.
					        </c:otherwise>
					
					    </c:choose>
					
					</c:when>
			
			        <c:when test="${not empty aiErrorMessage}">
			            ${aiErrorMessage}
			        </c:when>
			
			        <c:otherwise>
			            AI 분석에 사용할 데이터가 없습니다.
			        </c:otherwise>
			
			    </c:choose>
			
			</div>
        </div>
    </div>

    <div class="content-content">
        <div class="content-content-content-title">재고/입출고 이력</div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 110px;">입출고일</th>
                        <th style="width: 110px;">구분</th>
                        <th style="width: 130px;">LOT</th>
                        <th>품목</th>
                        <th style="width: 120px;">입출고수량</th>
                        <th style="width: 100px;">예약비율</th>
                        <th style="width: 110px;">위험도</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="io" items="${ioList}">
                        <tr>
                            <td>${io.ioDate}</td>
                            <td>${io.ioType}(${io.ioReason})</td>
                            <td>${io.lotId}</td>
                            <td class="item-name-cell">${io.itemName}(${io.itemId})</td>
                            <td>
                                <fmt:formatNumber value="${io.ioQty}" pattern="#,###"/>
                            </td>
                            <td>${io.reserveRate}%</td>
                            <td>
                                <c:choose>
                                    <c:when test="${io.riskLevel == 'LOW'}">
                                        <span class="status status-success">• LOW</span>
                                    </c:when>
                                    <c:when test="${io.riskLevel == 'WARNING'}">
                                        <span class="status status-warning">• WARNING</span>
                                    </c:when>
                                    <c:when test="${io.riskLevel == 'HIGH'}">
                                        <span class="status status-danger">• HIGH</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status status-info">• 미지정</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty ioList}">
                        <tr>
                            <td colspan="8" style="text-align: center;">
                                조회된 재고/입출고 데이터가 없습니다.
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

/* ==============================
   Mobile Layout
============================== */

@media (max-width: 900px) {
    .reportCard {
        grid-template-columns: repeat(2, minmax(0, 1fr));
    }
}

@media screen and (max-width: 940px) {
	
	.card-value {
		font-size: 20px !important;
	}
	
	.reportCard .card {
		width: 150px;
	}
	
	.table tr th:nth-child(3), .table tr td:nth-child(3) {
		display: none;
	}
	
}

@media screen and (max-width: 480px) {
	
	.row1 .btn-row {
		flex-direction: column;
	}
	
	.row2 {
		flex-wrap: wrap;
	}
	
	.card-grid {
		flex-direction: column;
	}
	
	.reportCard {
		display: flex;
		flex-direction: row;
		flex-wrap: nowrap;
 		max-width: 100%;
		overflow-x: auto;
		overflow-y: hidden;
		-webkit-overflow-scrolling: touch;
	}
	
	.reportCard .card {
		min-width: 150px;
	}
	
	.analysis-subtitle {
		display: none;
	}
	
		.table-wrap {
		width: 100%;
		overflow-x: auto;
		overflow-y: hidden;
		-webkit-overflow-scrolling: touch;
	}

	.table {
		min-width: 760px;
		white-space: nowrap;
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
        <c:forEach var="trend" items="${ioTrendList}" varStatus="st">
            '${trend.ioDate}'<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendHighCounts = [
        <c:forEach var="trend" items="${ioTrendList}" varStatus="st">
            ${empty trend.highCount ? 0 : trend.highCount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendWarningCounts = [
        <c:forEach var="trend" items="${ioTrendList}" varStatus="st">
            ${empty trend.warningCount ? 0 : trend.warningCount}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const riskCountNums = riskCounts.map(Number);
    const trendHighNums = trendHighCounts.map(Number);
    const trendWarningNums = trendWarningCounts.map(Number);

    const riskColorMap = {
        LOW: '#2e7d32',
        WARNING: '#f9a825',
        HIGH: '#d32f2f'
    };

    const riskCanvas = document.getElementById('ioRiskChart');
    const trendCanvas = document.getElementById('ioTrendChart');

    let riskChart = null;

    if (riskCanvas) {
        riskChart = new Chart(riskCanvas, {
            type: 'bar',
            data: {
                labels: riskLabels,
                datasets: [{
                    label: '재고 위험도 건수',
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
                        label: 'HIGH',
                        data: trendHighNums,
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

            const pdfArea = document.getElementById('ioReportPdfArea');

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

                pdf.save('재고입출고리포트.pdf');

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