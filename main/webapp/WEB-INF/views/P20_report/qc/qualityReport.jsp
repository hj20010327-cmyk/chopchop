<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">품질 리포트</h2>
            <p class="page-subtitle">
                실제 검사 데이터를 기반으로 품질 현황과 위험도를 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 리포팅 &gt; 품질 리포트</p>
        </div>
    </div>

    <form class="search-tool"
   			method="get"
         	action="${pageContext.request.contextPath}/report/quality">
          
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
		                <option value="MEDIUM" ${searchDTO.riskLevel eq 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
		                <option value="HIGH" ${searchDTO.riskLevel eq 'HIGH' ? 'selected' : ''}>HIGH</option>
		            </select>
		        </div>
		        
       			<div class="search-item">
		            <label>품목유형</label>
		            <select name="itemType">
		                <option value="">전체</option>
		
		                <c:forEach var="type" items="${itemTypeList}">
		                    <option value="${type.code}"
		                        <c:if test="${searchDTO.itemType == type.code}">selected</c:if>>
		                        ${type.name}
		                    </option>
		                </c:forEach>
		            </select>
		        </div>
		        
		        <div class="search-item keyword">
		            <label>품목/LOT/QC 검색</label>
		            <input type="text"
		                   name="itemKeyword"
		                   placeholder="내용을 입력하세요."
		                   value="${searchDTO.itemKeyword}">
		        </div>
		        
		        <div class="search-btn-area">
		            <button type="submit" class="btn btn-main">검색</button>
		            <a class="btn btn-white"
		               href="${pageContext.request.contextPath}/report/quality">
		                초기화
		            </a>
		        </div>
          </div>
    </form>
    
    <div class="content-content" id="qualityReportPdfArea">
    	<div class="content-content-content-title">품질검사 요약 카드</div>
	    <div class="card-grid">
		    <div class="card-wrap reportCard">
		        <div class="card success">
		            <div class="card-title">총 검사 수량</div>
		            <div class="card-value">
		            	<fmt:formatNumber value="${summary.totalQcQty}" pattern="#,###"/>
		            </div>
		            <div class="card-subtitle">실제 검사 수량</div>
		        </div>
		
		        <div class="card safe">
		            <div class="card-title">총 합격 수량</div>
		            <div class="card-value">
		            	<fmt:formatNumber value="${summary.totalPassQty}" pattern="#,###"/>
		            </div>
		            <div class="card-subtitle">실제 합격 수량</div>
		        </div>
		
		        <div class="card warning">
		            <div class="card-title">총 불량 수량</div>
		            <div class="card-value">
		            	<fmt:formatNumber value="${summary.totalDefectQty}" pattern="#,###"/>
		            </div>
		            <div class="card-subtitle">실제 불합격 수량</div>
		        </div>
		
		        <div class="card info">
		            <div class="card-title">평균 불량률</div>
		            <div class="card-value">${summary.defectRate} <span>%</span></div>
		            <div class="card-subtitle">전체 평균</div>
		        </div>
		
		        <div class="card danger">
		            <div class="card-title">HIGH 위험 건수</div>
		            <div class="card-value">
		            	<fmt:formatNumber value="${summary.highRiskCount}" pattern="#,###"/>
		            </div>
		            <div class="card-subtitle">AI 기준</div>
		        </div>
		
		        <div class="card info">
		            <div class="card-title">HIGH 위험 비율</div>
		            <div class="card-value">${summary.highRiskRate} <span>%</span></div>
		            <div class="card-subtitle">전체 대비</div>
		        </div>
		    </div>
		    
		    <div class="card-wrap aiCard">
			    <div class="card ai">
			        <div class="card-title card-title-big">AI 위험도 현황</div>
			
			        <div class="chart-box risk-chart-box">
			            <canvas id="riskChart"></canvas>
			        </div>
			
			        <div class="aiType-btn">
					    <button type="button" class="btn btn-type active" data-risk="ALL">전체</button>
					    <button type="button" class="btn btn-type" data-risk="HIGH">HIGH</button>
					    <button type="button" class="btn btn-type" data-risk="MEDIUM">MEDIUM</button>
					    <button type="button" class="btn btn-type" data-risk="LOW">LOW</button>
					</div>
			    </div>
			</div>
	    </div>
	    
	    <div class="card-wrap aiCard">
	    	<div class="card ai">
	    		<div class="card-title card-title-big">날짜별 불량률 추이</div>
	            <div class="chart-box trend-chart-box">
				    <canvas id="defectTrendChart"></canvas>
				</div>
	    	</div>
	    </div>
	    
	    <div class="analysis">
		    <div class="analysis-title">
		        <div class="content-content-content-title">AI 품질 분석 결과</div>
		        <div class="analysis-subtitle">Machine Learning Analysis</div>
		    </div>
		
		    <div class="analysis-content">
		        <c:choose>
		            <c:when test="${not empty aiResult}">
		                예상 위험도 :
		                <strong>${aiResult.riskLevel}</strong>
		                <br>
		
		                LOW
						<fmt:formatNumber value="${aiResult.lowProb}" pattern="0.##"/>%
						/
						MEDIUM
						<fmt:formatNumber value="${aiResult.mediumProb}" pattern="0.##"/>%
						/
						HIGH
						<fmt:formatNumber value="${aiResult.highProb}" pattern="0.##"/>%
		
		                <br>
		
		                <c:choose>
		                    <c:when test="${aiResult.riskLevel == 'HIGH'}">
		                        고위험 품질 패턴이 감지되었습니다. LOT 수량, 검사수량, 생산계획 대비 실적을 우선 확인하세요.
		                    </c:when>
		                    <c:when test="${aiResult.riskLevel == 'MEDIUM'}">
		                        중간 수준의 품질 위험이 감지되었습니다. 최근 검사 조건을 점검하는 것이 좋습니다.
		                    </c:when>
		                    <c:otherwise>
		                        현재 조건에서는 품질 위험도가 낮게 예측되었습니다.
		                    </c:otherwise>
		                </c:choose>
		            </c:when>
		
		            <c:when test="${not empty aiErrorMessage}">
		                ${aiErrorMessage}
		            </c:when>
		
		            <c:otherwise>
		                AI 분석에 사용할 품질 데이터가 없습니다.
		            </c:otherwise>
		        </c:choose>
		    </div>
		</div>
	    
    </div>

    <div class="content-content">
    	<div class="content-content-content-title">불량 발생 이력</div>
    	
        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 120px;">검사일</th>
                        <th style="width: 120px;">QC번호</th>
                        <th style="width: 150px;">LOT</th>
                        <th>품목</th>
                        <th>검사수량</th>
                        <th style="width: 100px;">불량률</th>
                        <th style="width: 120px;">위험도</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="qc" items="${qualityList}">
                        <tr onclick="window.location.href='${pageContext.request.contextPath}/quality/detail?qcId=${qc.qcId}'">
                            <td>${qc.qcDate}</td>
                            <td class="qcId">${qc.qcId}</td>
                            <td>${qc.lotId}</td>
                            <td class="item-name-cell">${qc.itemName}(${qc.itemId})</td>
                            <td>
                            	<fmt:formatNumber value="${qc.qcQty}" pattern="#,###"/>
                            </td>
                            <td>${qc.defectRate}%</td>
                            <td>
                                <c:choose>
                                    <c:when test="${qc.riskLevel == 'LOW'}">
                                        <span class="status status-success">• LOW</span>
                                    </c:when>
                                    <c:when test="${qc.riskLevel == 'MEDIUM'}">
                                        <span class="status status-warning">• MEDIUM</span>
                                    </c:when>
                                    <c:when test="${qc.riskLevel == 'HIGH'}">
                                        <span class="status status-danger">• HIGH</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status status-info">• 미지정</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty qualityList}">
                        <tr>
                            <td colspan="7" style="text-align: center;">
                                조회된 품질 데이터가 없습니다.
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
		font-weigth : 500;
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
	    min-width: 63px;
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

	.table tr:hover .qcId {
		color: var(--main-green);
		text-decoration: underline;
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
        <c:forEach var="trend" items="${defectTrendList}" varStatus="st">
            '${trend.qcDate}'<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const trendRates = [
        <c:forEach var="trend" items="${defectTrendList}" varStatus="st">
            ${empty trend.defectRate ? 0 : trend.defectRate}<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const riskCountNums = riskCounts.map(Number);
    const trendRateNums = trendRates.map(Number);

    const riskColorMap = {
        LOW: '#2e7d32',
        MEDIUM: '#f9a825',
        HIGH: '#d32f2f'
    };

    const riskCanvas = document.getElementById('riskChart');
    const trendCanvas = document.getElementById('defectTrendChart');

    let riskChart = null;

    if (riskCanvas) {
        riskChart = new Chart(riskCanvas, {
            type: 'bar',
            data: {
                labels: riskLabels,
                datasets: [{
                    label: '위험도 건수',
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
                            precision: 0
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
            type: 'line',
            data: {
                labels: trendLabels,
                datasets: [{
                    label: '불량률 (%)',
                    data: trendRateNums,
                    borderColor: '#2e7d32',
                    backgroundColor: 'rgba(46, 125, 50, 0.12)',
                    tension: 0.35,
                    fill: true,
                    borderWidth: 3,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                    pointBackgroundColor: '#2e7d32',
                    pointBorderColor: '#ffffff',
                    pointBorderWidth: 2
                }]
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
                        suggestedMax: 5,
                        ticks: {
                            callback: function(value) {
                                return value + '%';
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
                                return '불량률 ' + context.parsed.y + '%';
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

            const pdfArea = document.getElementById('qualityReportPdfArea');

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

                pdf.save('품질리포트.pdf');

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