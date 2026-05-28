<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">품질 리포트</h2>
            <p class="page-subtitle">
                실제 검사 데이터를 기반으로 품질 현황과 위험도를 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 리포트 &gt; 품질 리포트</p>
        </div>
    </div>

    <form class="search-box"
          action="${pageContext.request.contextPath}/report/quality"
          method="get">

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

        <div class="search-item">
            <label>위험도</label>
            <select name="riskLevel">
                <option value="">전체</option>
                <option value="LOW"
                    <c:if test="${searchDTO.riskLevel == 'LOW'}">selected</c:if>>
                    LOW
                </option>
                <option value="MEDIUM"
                    <c:if test="${searchDTO.riskLevel == 'MEDIUM'}">selected</c:if>>
                    MEDIUM
                </option>
                <option value="HIGH"
                    <c:if test="${searchDTO.riskLevel == 'HIGH'}">selected</c:if>>
                    HIGH
                </option>
            </select>
        </div>

        <div class="search-item search-grow">
            <label>검색어</label>
            <input type="text"
                   name="itemKeyword"
                   placeholder="품목명, 품목코드, LOT, QC"
                   value="${searchDTO.itemKeyword}">
        </div>

        <div class="btn-row report-search-btns">
            <button type="submit" class="btn btn-main">조회</button>
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/report/quality">
                초기화
            </a>
        </div>
    </form>

    <div class="report-card-grid">

        <div class="report-card">
            <p class="report-card-title">총 검사 수량</p>
            <strong class="report-card-value">${summary.totalQcQty}</strong>
        </div>

        <div class="report-card">
            <p class="report-card-title">총 합격 수량</p>
            <strong class="report-card-value">${summary.totalPassQty}</strong>
        </div>

        <div class="report-card">
            <p class="report-card-title">총 불량 수량</p>
            <strong class="report-card-value">${summary.totalDefectQty}</strong>
        </div>

        <div class="report-card">
            <p class="report-card-title">평균 불량률</p>
            <strong class="report-card-value">${summary.defectRate}%</strong>
        </div>

        <div class="report-card">
            <p class="report-card-title">HIGH 위험 건수</p>
            <strong class="report-card-value danger-text">${summary.highRiskCount}</strong>
        </div>

        <div class="report-card">
            <p class="report-card-title">HIGH 위험 비율</p>
            <strong class="report-card-value danger-text">${summary.highRiskRate}%</strong>
        </div>

    </div>

    <div class="grid-wrap">
        <table>
            <thead>
                <tr>
                    <th>검사일</th>
                    <th>QC 코드</th>
                    <th>LOT</th>
                    <th>품목명</th>
                    <th>검사수량</th>
                    <th>합격수량</th>
                    <th>불량수량</th>
                    <th>불량률</th>
                    <th>위험도</th>
                    <th>검사자</th>
                </tr>
            </thead>

            <tbody>
                <c:choose>
                    <c:when test="${empty qualityList}">
                        <tr>
                            <td colspan="10">조회된 품질 데이터가 없습니다.</td>
                        </tr>
                    </c:when>

                    <c:otherwise>
                        <c:forEach var="qc" items="${qualityList}">
                            <tr>
                                <td>${qc.qcDate}</td>
                                <td>${qc.qcId}</td>
                                <td>${qc.lotId}</td>
                                <td class="text-left">${qc.itemName}</td>
                                <td>${qc.qcQty}</td>
                                <td>${qc.qcPassQty}</td>
                                <td>${qc.defectQty}</td>
                                <td>${qc.defectRate}%</td>
                                <td>
                                    <span class="risk-badge risk-${qc.riskLevel}">
                                        ${qc.riskLevel}
                                    </span>
                                </td>
                                <td>${qc.workerName}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>

<style>
    .search-grow {
        flex: 1;
        min-width: 220px;
    }

    .report-search-btns {
        align-items: flex-end;
        margin-left: auto;
        gap: 8px;
    }

    .report-card-grid {
        display: grid;
        grid-template-columns: repeat(6, minmax(0, 1fr));
        gap: 12px;
        margin-bottom: 20px;
    }

    .report-card {
        background-color: #fff;
        border: 1px solid var(--gray);
        border-radius: 8px;
        padding: 16px;
        box-sizing: border-box;
    }

    .report-card-title {
        margin: 0 0 8px 0;
        color: #666;
        font-size: 13px;
        font-weight: 500;
    }

    .report-card-value {
        font-size: 22px;
        font-weight: 700;
        color: #222;
    }

    .danger-text {
        color: #d93025;
    }

    .text-left {
        text-align: left;
    }

    .risk-badge {
        display: inline-block;
        min-width: 70px;
        padding: 4px 8px;
        border-radius: 999px;
        font-size: 12px;
        font-weight: 700;
        text-align: center;
    }

    .risk-LOW {
        background-color: #e8f7ef;
        color: #168a4a;
    }

    .risk-MEDIUM {
        background-color: #fff4df;
        color: #b56a00;
    }

    .risk-HIGH {
        background-color: #fdecec;
        color: #d93025;
    }

    @media (max-width: 1200px) {
        .report-card-grid {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
    }
</style>