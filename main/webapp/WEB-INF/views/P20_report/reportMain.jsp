<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">리포트 센터</h2>
            <p class="page-subtitle">
                생산, 품질, 설비, 입출고 데이터를 기반으로 운영 현황을 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 리포트 센터
            </p>
        </div>
    </div>

    <div class="report-tab-wrap">
        <a class="report-tab ${type == 'work' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/report/main?type=work">
            작업 실적
        </a>

        <a class="report-tab ${type == 'quality' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/report/main?type=quality">
            품질 분석
        </a>

        <a class="report-tab ${type == 'equipment' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/report/main?type=equipment">
            설비 분석
        </a>

        <a class="report-tab ${type == 'io' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/report/main?type=io">
            입출고 분석
        </a>
    </div>


    <c:choose>

        <c:when test="${type == 'quality'}">

            <form class="search-box"
                  action="${pageContext.request.contextPath}/report/main"
                  method="get">

                <input type="hidden" name="type" value="quality">

                <div class="search-item">
                    <label>시작일</label>
                    <input type="date"
                           name="startDate"
                           value="${searchDTO.startDate}">
                </div>

                <div class="search-item">
                    <label>종료일</label>
                    <input type="date"
                           name="endDate"
                           value="${searchDTO.endDate}">
                </div>

                <div class="search-item keyword">
                    <label>검색어</label>
                    <input type="text"
                           name="searchKeyword"
                           value="${searchDTO.searchKeyword}"
                           placeholder="품목명 / LOT / 검사코드">
                </div>

                <div class="search-btn-area">
                    <button type="submit" class="btn btn-main">조회</button>
                    <a class="btn btn-white"
                       href="${pageContext.request.contextPath}/report/main?type=quality">
                        초기화
                    </a>
                </div>
            </form>


            <div class="report-card-grid">

                <div class="report-card">
                    <p>총 검사 건수</p>
                    <strong>${summary.totalQcCount}</strong>
                    <span>건</span>
                </div>

                <div class="report-card">
                    <p>완료 검사</p>
                    <strong>${summary.completeQcCount}</strong>
                    <span>건</span>
                </div>

                <div class="report-card">
                    <p>불량 발생 검사</p>
                    <strong class="danger">${summary.failQcCount}</strong>
                    <span>건</span>
                </div>

                <div class="report-card">
                    <p>전체 불량률</p>
                    <strong class="danger">${summary.defectRate}</strong>
                    <span>%</span>
                </div>

            </div>


            <div class="ai-report-box">
                <div class="ai-report-title">
                    <strong>AI 품질 분석 코멘트</strong>
                    <span>QC / LOT / DEFECT 기반 분석</span>
                </div>

                <ul>
                    <c:forEach var="comment" items="${aiComments}">
                        <li>${comment}</li>
                    </c:forEach>
                </ul>
            </div>


            <div class="report-section-grid">

                <div class="report-section">
                    <div class="section-title-row">
                        <h3>불량 유형 TOP 5</h3>
                        <span>불량 수량 기준</span>
                    </div>

                    <c:choose>
                        <c:when test="${empty defectTopList}">
                            <p class="empty-text">불량 데이터가 없습니다.</p>
                        </c:when>

                        <c:otherwise>
                            <div class="bar-list">
                                <c:forEach var="def" items="${defectTopList}">
                                    <div class="bar-item">
                                        <div class="bar-label">
                                            <span>${def.defTypeName}</span>
                                            <strong>${def.defCount}건</strong>
                                        </div>

                                        <div class="bar-track">
                                            <div class="bar-fill"
                                                 style="width:${def.defCount * 8 > 100 ? 100 : def.defCount * 8}%;">
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>


                <div class="report-section">
                    <div class="section-title-row">
                        <h3>품목별 불량률 TOP 5</h3>
                        <span>검사 수량 대비</span>
                    </div>

                    <c:choose>
                        <c:when test="${empty itemDefectRateList}">
                            <p class="empty-text">품목별 검사 데이터가 없습니다.</p>
                        </c:when>

                        <c:otherwise>
                            <table class="common-table">
                                <thead>
                                    <tr>
                                        <th>품목명</th>
                                        <th>검사수량</th>
                                        <th>불량수량</th>
                                        <th>불량률</th>
                                    </tr>
                                </thead>

                                <tbody>
                                    <c:forEach var="item" items="${itemDefectRateList}">
                                        <tr>
                                            <td>${item.itemName}</td>
                                            <td>${item.itemTotalQty}</td>
                                            <td>${item.itemDefQty}</td>
                                            <td>
                                                <strong class="danger">
                                                    ${item.itemDefectRate}%
                                                </strong>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>


            <div class="report-section full">
                <div class="section-title-row">
                    <h3>최근 품질 검사 상세</h3>
                    <span>최근 10건</span>
                </div>

                <table class="common-table">
                    <thead>
                        <tr>
                            <th>검사코드</th>
                            <th>LOT</th>
                            <th>품목명</th>
                            <th>검사일</th>
                            <th>검사유형</th>
                            <th>상태</th>
                            <th>검사수량</th>
                            <th>합격수량</th>
                            <th>불량수량</th>
                            <th>불량유형</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${empty qualityDetailList}">
                                <tr>
                                    <td colspan="10">조회된 품질 검사 데이터가 없습니다.</td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="qc" items="${qualityDetailList}">
                                    <tr>
                                        <td>${qc.qcId}</td>
                                        <td>${qc.lotId}</td>
                                        <td>${qc.itemName}</td>
                                        <td>${qc.qcDate}</td>
                                        <td>${qc.qcTypeName}</td>
                                        <td>${qc.qcStatusName}</td>
                                        <td>${qc.qcQty}</td>
                                        <td>${qc.qcPassQty}</td>
                                        <td>
                                            <strong class="danger">
                                                ${qc.qcDefQty}
                                            </strong>
                                        </td>
                                        <td>${qc.defNames}</td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </c:when>


        <c:otherwise>
            <div class="report-ready-box">
                <strong>
                    <c:choose>
                        <c:when test="${type == 'work'}">작업 실적 리포트</c:when>
                        <c:when test="${type == 'equipment'}">설비 분석 리포트</c:when>
                        <c:when test="${type == 'io'}">입출고 분석 리포트</c:when>
                        <c:otherwise>리포트</c:otherwise>
                    </c:choose>
                </strong>

                <p>
                    해당 리포트는 현재 품질 리포트 구조를 기준으로 확장 예정입니다.
                </p>
            </div>
        </c:otherwise>

    </c:choose>

</div>


<style>
    .report-tab-wrap {
        display: flex;
        gap: 8px;
        margin-bottom: 18px;
        padding: 6px;
        border: 1px solid var(--gray);
        border-radius: 10px;
        background: #fff;
    }

    .report-tab {
        min-width: 120px;
        padding: 11px 18px;
        border-radius: 8px;
        color: #555;
        font-size: 14px;
        font-weight: 700;
        text-align: center;
        text-decoration: none;
    }

    .report-tab:hover {
        background: #f5f5f5;
    }

    .report-tab.active {
        background: var(--main-green);
        color: #fff;
    }

    .report-card-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        margin-bottom: 20px;
    }

    .report-card {
        padding: 20px;
        border: 1px solid var(--gray);
        border-radius: 10px;
        background: #fff;
    }

    .report-card p {
        margin: 0 0 10px;
        color: #666;
        font-size: 14px;
        font-weight: 600;
    }

    .report-card strong {
        font-size: 30px;
        color: #222;
    }

    .report-card span {
        margin-left: 4px;
        color: #777;
        font-size: 14px;
    }

    .danger {
        color: #e74c3c !important;
    }

    .ai-report-box {
        margin-bottom: 20px;
        padding: 20px;
        border: 1px solid #f2d2d2;
        border-radius: 10px;
        background: #fff8f8;
    }

    .ai-report-title {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 12px;
    }

    .ai-report-title strong {
        font-size: 17px;
        color: #222;
    }

    .ai-report-title span {
        color: #999;
        font-size: 13px;
    }

    .ai-report-box ul {
        margin: 0;
        padding-left: 20px;
    }

    .ai-report-box li {
        margin: 6px 0;
        color: #444;
        font-size: 14px;
        line-height: 1.5;
    }

    .report-section-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 16px;
        margin-bottom: 20px;
    }

    .report-section {
        padding: 20px;
        border: 1px solid var(--gray);
        border-radius: 10px;
        background: #fff;
    }

    .report-section.full {
        margin-bottom: 30px;
    }

    .section-title-row {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 16px;
    }

    .section-title-row h3 {
        margin: 0;
        font-size: 17px;
        color: #222;
    }

    .section-title-row span {
        color: #999;
        font-size: 13px;
    }

    .bar-list {
        display: flex;
        flex-direction: column;
        gap: 14px;
    }

    .bar-label {
        display: flex;
        justify-content: space-between;
        margin-bottom: 6px;
        font-size: 14px;
    }

    .bar-label strong {
        color: #e74c3c;
    }

    .bar-track {
        height: 9px;
        border-radius: 999px;
        background: #f0f0f0;
        overflow: hidden;
    }

    .bar-fill {
        height: 100%;
        border-radius: 999px;
        background: #e74c3c;
    }

    .empty-text {
        margin: 20px 0;
        color: #999;
        font-size: 14px;
        text-align: center;
    }

    .common-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 14px;
    }

    .common-table th,
    .common-table td {
        padding: 12px 10px;
        border-bottom: 1px solid #eee;
        text-align: center;
    }

    .common-table th {
        background: #fafafa;
        color: #444;
        font-weight: 700;
    }

    .common-table td {
        color: #333;
    }

    .report-ready-box {
        padding: 60px 20px;
        border: 1px dashed #ccc;
        border-radius: 12px;
        background: #fff;
        text-align: center;
    }

    .report-ready-box strong {
        display: block;
        margin-bottom: 10px;
        font-size: 22px;
        color: #222;
    }

    .report-ready-box p {
        margin: 0;
        color: #777;
        font-size: 14px;
    }
</style>