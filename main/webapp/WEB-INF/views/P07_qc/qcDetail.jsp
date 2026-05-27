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

            <a class="btn btn-main"
                href="${pageContext.request.contextPath}/quality/edit?qcId=${qc.qcId}">
                수정
            </a>

            <a class="btn btn-red"
                href="${pageContext.request.contextPath}/quality/delete?qcId=${qc.qcId}"
                onclick="return confirm('품질검사(${qc.qcId})를 삭제하시겠습니까?');">
                삭제
            </a>

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
            	<a href="${pageContext.request.contextPath}/quality/result/add?qcId=${qc.qcId}" class="btn btn-orange">
            	<c:choose>
            		<c:when test="${qc.qcStatus == 30}">
	            	결과 수정
            		</c:when>
            		<c:otherwise>
            		결과 등록
            		</c:otherwise>
            	</c:choose>
            	</a>
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
                            <td>${qc.qcLot}</td>
                            <th>품목(코드)</th>
                            <td>
                            	${qc.itemName}
    							(${qc.itemId})
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

                    <div class="qc-donut"
                        style="background:conic-gradient(var(--danger) 0 ${qc.failRate}%, #f5d1d1 ${qc.failRate}% 100%);">

                        <div class="qc-donut-inner">
                            <div class="qc-donut-rate">
                                ${qc.failRate}%
                            </div>
                            <div class="qc-donut-label">
                                불량률
                            </div>
                        </div>

                    </div>

                </div>

                <div class="table-wrap qc-defect-table">

                    <table class="table">

                        <thead>
                            <tr>
                                <th>불량 유형</th>
                                <th>불량 수량</th>
                                <th>조치 내용</th>
                                <th>폐기</th>
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
										<tr>
											<td>${def.defTypeName}</td>
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
    color: var(--danger);
}

.qc-donut-label {
    margin-top: 8px;
    font-size: 15px;
    font-weight: 700;
}

.qc-defect-table {
    flex: 1;
}

</style>