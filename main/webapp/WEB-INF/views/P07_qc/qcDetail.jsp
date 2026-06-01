<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib prefix="fmt"
    uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">
                품질검사 상세
            </h2>

            <p class="page-subtitle">
                선택한 품질검사 지시의 상세 정보를 확인하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 품질관리 > 상세
            </p>
        </div>

    </div>

    <div class="btn-row">

        <div class="left">
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/quality/list">
                목록으로
            </a>
        </div>

        <div class="right">
			
			<c:if test="${qc.qcStatus == 10}">
	            <a class="btn btn-main"
	                href="${pageContext.request.contextPath}/quality/edit?qcId=${qc.qcId}">
	                수정
	            </a>
	            <a class="btn btn-red"
	                href="${pageContext.request.contextPath}/quality/delete?qcId=${qc.qcId}"
	                onclick="return confirm('품질검사(${qc.qcId})를 삭제하시겠습니까?');">
	                삭제
	            </a>
			</c:if>

        </div>

    </div>

    <div class="content-content">

        <!-- 기본 정보 -->
        <div class="content-content-content">
        
        	<div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:14px;
            ">

            <div class="content-content-content-title">
                품질 검사 상세정보
            </div>
            <div style="
            	display: flex;
            	align-items: center;
            	gap: 18px;">
            	<c:choose>
            		<c:when test="${qc.qcStatus == 10}">
            			<span class="status-back status-back-warning">
            				• 대기
            			</span>
            		</c:when>
            		<c:when test="${qc.qcStatus == 20}">
            			<span class="status-back status-back-safe">
            				• 진행 중
            			</span>
            		</c:when>
            		<c:when test="${qc.qcStatus == 30}">
            			<span class="status-back status-back-success">
            				• 완료
            			</span>
            		</c:when>
            		<c:when test="${qc.qcStatus == 40}">
            			<span class="status-back status-back-danger">
            				• 중단
            			</span>
            		</c:when>
            		<c:when test="${qc.qcStatus == 0}">
            			<span class="status-back status-back-info">
            				• 보류
            			</span>
            		</c:when>
            	</c:choose>
            		<c:if test="${qc.qcStatus != 30}">
		            	<a href="${pageContext.request.contextPath}/quality/result/add?qcId=${qc.qcId}" class="btn btn-orange">
            				결과 등록
		            	</a>
            		</c:if>
            </div>
         </div>
            

            <div class="info-table-wrap">

                <table class="info-table">

                    <tbody>

                        <tr>
                            <th>검사번호</th>
                            <td>${qc.qcId}</td>

                            <th>검사유형</th>
                            <td>${qc.qcTypeName}</td>
                        </tr>

                        <tr>

                            <th>검사대상 LOT</th>
                            <td>
                            	<a class="toDetail"
                            		href="${pageContext.request.contextPath}/lot/detail?lotId=${qc.qcLot}">
                            		${qc.qcLot}	
                            	</a>
                            </td>
                            <th>품목(코드)</th>
                            <td>
                            	<a class="toDetail"
                            		href="${pageContext.request.contextPath}/item/detail?itemId=${qc.itemId}">
	                            	${qc.itemName}
	    							(${qc.itemId})
                            	</a>
    						</td>
                        </tr>
                        <tr>
                        	<th>입고 수량</th>
                        	<td>
                        		<fmt:formatNumber value="${qc.lotQty}"
                        			pattern="#,###"/>
                        			EA
                        	</td>
                        	<th>LOT 수량</th>
                        	<td>
                        		<fmt:formatNumber value="${qc.lotCqty}"
                        			pattern="#,###"/>
                        			EA
                        	</td>
                        </tr>

                        <tr>

                            <th>검사수량</th>
                            <td>
                                <fmt:formatNumber value="${qc.qcQty}"
                                    pattern="#,###" />
                                EA
                            </td>
                            <th>합격수량</th>
                            <td>
                                <fmt:formatNumber value="${qc.qcPassQty}"
                                    pattern="#,###" />
                                EA
                            </td>

                        </tr>

                        <tr>
                            <th>불량수량</th>
                            <td>
                            	<c:if test="${qc.qcStatus == 10 or qc.qcStatus == 20}">
                            		0 EA
                            	</c:if>
                            	<c:if test="${qc.qcStatus == 30 or qc.qcStatus == 40}">
	                                <fmt:formatNumber value="${qc.failQty}"
	                                    pattern="#,###" />
	                                EA
                            	</c:if>
                            </td>
                            <th>검사일</th>
                            <td>
                            <fmt:formatDate value="${qc.qcDate}" pattern="YYYY-MM-dd"/>
                            </td>
                        </tr>

                        <tr>
                            <th>지시자</th>
                            <td>
                                ${qc.directorName}
                                (${qc.qcDirector})
                            </td>

                            <th>검사자</th>
                            <td>
                                ${qc.workerName}
                                (${qc.qcWorker})
                            </td>
                        </tr>


                    </tbody>

                </table>

            </div>

        </div>

        <!-- 전달사항 -->
        <div class="content-content-content">

            <div class="qc-simple-section">

            <div class="qc-simple-title">
                지시 전달사항
            </div>

            <div class="qc-simple-content">
                <c:choose>
                    <c:when test="${not empty qc.qcDmsg}">
                        ${qc.qcDmsg}
                    </c:when>
                    <c:otherwise>
                        내용없음
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <div class="qc-simple-section">

            <div class="qc-simple-title">
                검사 특이사항
            </div>

            <div class="qc-simple-content">
                <c:choose>
                    <c:when test="${not empty qc.qcWmsg}">
                        ${qc.qcWmsg}
                    </c:when>
                    <c:otherwise>
                        내용없음
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <div class="qc-simple-section">

            <div class="qc-rate-row">
                <div class="qc-simple-title">
                    불량률
                </div>

                <div class="qc-rate-text">
                    <span>${qc.failRate}%</span>
                    (${qc.failQty} / ${qc.qcQty})
                </div>
            </div>

            <div class="qc-progress">
                <div class="qc-progress-fill"
                    style="width:${qc.failRate}%;"></div>
            </div>

        </div>

        <div class="content-content-content" style="margin-top: 30px;">

            <div class="content-content-content-title">
                불량 상세 내역
            </div>

            <div class="qc-defect-wrap">

                <div class="qc-donut-box">
					<div>
				        <div class="qc-donut" id="defectDonut">
				
				            <div class="qc-donut-inner">
				                <div class="qc-donut-rate">
				                    ${qc.failQty}EA
				                </div>
				                <div class="qc-donut-label">
				                    전체 불량
				                </div>
				            </div>
				
				        </div>
				
				        <div id="defectLegend" class="qc-donut-legend"></div>
				    </div>

                </div>

                <div class="table-wrap qc-defect-table">

                    <table class="table">

                        <thead>
                            <tr>
                                <th style="width: 125px;">불량 유형</th>
                                <th style="width: 100px;">불량 수량</th>
                                <th>조치 내용</th>
                                <th style="width: 70px;">폐기</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:choose>
								<c:when test="${empty defLogList}">
									<tr>
										<td colspan="4" style="text-align:center;">
											등록된 불량 상세 내역이 없습니다.
										</td>
									</tr>
								</c:when>
						
								<c:otherwise>
									<c:forEach var="def" items="${defLogList}">
										<tr onclick="location.href='${pageContext.request.contextPath}/defect/detail?defTypeId=${def.defType}'">
											<td class="defTypeName">${def.defTypeName}</td>
											<td>
												<fmt:formatNumber value="${def.defQty}" pattern="#,###" />
												EA
											</td>
											<td>${def.defAction}</td>
											<td>${def.defDiscard}</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </div>

	</div>
</div>

<style>

.qc-simple-section {
    border-bottom: 1px solid var(--dark-gray);
    padding: 18px 12px 28px;
}

.qc-simple-title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 18px;
}

.qc-simple-content {
    font-size: 14px;
    padding-left: 16px;
}

.qc-rate-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.qc-rate-row .qc-simple-title {
    margin-bottom: 20px;
}

.qc-rate-text {
    font-size: 14px;
}

.qc-rate-text span {
    color: var(--danger);
    font-weight: 800;
}

.qc-progress {
    width: 100%;
    height: 10px;
    background-color: #f8cfd2;
    border-radius: 999px;
    overflow: hidden;
}

.qc-progress-fill {
    height: 100%;
    background-color: var(--danger);
    border-radius: 999px;
}

.qc-defect-wrap {
    display: flex;
    align-items: flex-start;
    gap: 30px;
}

.qc-donut-box {
    width: 35%;
    min-width: 320px;
    height: 380px;
    border: 1px solid var(--dark-gray);
    border-radius: 8px;

    display: flex;
    justify-content: center;
    align-items: center;
}

.qc-donut {
    width: 210px;
    height: 210px;
    border-radius: 50%;

    display: flex;
    justify-content: center;
    align-items: center;

    box-shadow:
        0 8px 20px rgba(0,0,0,0.08);
}

.qc-donut-inner {
    width: 130px;
    height: 130px;
    background-color: white;
    border-radius: 50%;

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.qc-donut-rate {
    font-size: 28px;
    font-weight: 800;
}

.qc-donut-label {
    margin-top: 8px;
    font-size: 15px;
    font-weight: 700;
}

.qc-defect-table {
    flex: 1;
}

.table tbody tr:hover .defTypeName {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	.qc-donut-box {
    flex-direction: column;
}

.qc-donut-legend {
    margin-top: 24px;
    width: 230px;
}

.legend-item {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    margin-bottom: 8px;
}

.legend-color {
    width: 14px;
    height: 14px;
    border-radius: 50%;
    box-shadow:0 0 8px rgba(0,0,0,0.15);
    flex-shrink: 0;
}

.legend-name {
    font-weight: 700;
}

.legend-value {
    margin-left: auto;
    color: #666;
}

.legend-empty {
    text-align: center;
    color: #777;
    font-size: 13px;
}


/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.qc-defect-wrap {
		flex-direction: column;
		align-items: center;
	}
}





</style>

<script>
window.addEventListener("load", function () {

    const defectList = [
        <c:forEach var="def" items="${defLogList}" varStatus="st">
            {
                typeName: "${def.defTypeName}",
                qty: Number("${def.defQty}")
            }<c:if test="${!st.last}">,</c:if>
        </c:forEach>
    ];

    const donut = document.querySelector("#defectDonut");
    const legend = document.querySelector("#defectLegend");

    if (!donut || !legend) return;

    const totalFailQty = Number("${qc.failQty}");

    if (totalFailQty <= 0 || defectList.length === 0) {
        donut.style.background = "#eeeeee";
        legend.innerHTML = "<div class='legend-empty'>불량 내역 없음</div>";
        return;
    }

    const grouped = {};

    defectList.forEach(function (def) {
        if (!grouped[def.typeName]) {
            grouped[def.typeName] = 0;
        }
        grouped[def.typeName] += def.qty;
    });

    const colors = [
    	'#0F5132', 
    	'#91C784', 
    	'#DFE1E6',
    	'#FFAB00', 
    	'#0052CC' 
    ];

    let start = 0;
    let gradient = "";
    let legendHtml = "";

    Object.keys(grouped).forEach(function (typeName, index) {
        const qty = grouped[typeName];
        const percent = totalFailQty === 0 ? 0 : (qty / totalFailQty) * 100;
        const end = start + percent;
        const color = colors[index % colors.length];

        gradient += color + " " + start + "% " + end + "%,";
        start = end;

        legendHtml += 
        	'<div class="legend-item">' +
            '<span class="legend-color" style="background-color:' + color + ';"></span>' +
            '<span class="legend-name">' + typeName + '</span>' +
            '<span class="legend-value">' +
                qty + 'EA (' + percent.toFixed(1) + '%)' +
            '</span>' +
        '</div>'
    });

    donut.style.background = "conic-gradient(" + gradient.slice(0, -1) + ")";
    legend.innerHTML = legendHtml;
});
</script>