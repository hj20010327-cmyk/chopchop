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
          method="get"
          action="${pageContext.request.contextPath}/report/quality">

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
                <option value="LOW" ${searchDTO.riskLevel eq 'LOW' ? 'selected' : ''}>LOW</option>
                <option value="MEDIUM" ${searchDTO.riskLevel eq 'MEDIUM' ? 'selected' : ''}>MEDIUM</option>
                <option value="HIGH" ${searchDTO.riskLevel eq 'HIGH' ? 'selected' : ''}>HIGH</option>
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
    </form>

    <div class="card-wrap reportCard">
        <div class="card success">
            <div class="card-title">총 검사 수량</div>
            <div class="card-value">${summary.totalQcQty}</div>
            <div class="card-subtitle">QC 기준</div>
        </div>

        <div class="card safe">
            <div class="card-title">총 합격 수량</div>
            <div class="card-value">${summary.totalPassQty}</div>
            <div class="card-subtitle">합격</div>
        </div>

        <div class="card warning">
            <div class="card-title">총 불량 수량</div>
            <div class="card-value">${summary.totalDefectQty}</div>
            <div class="card-subtitle">검사 - 합격</div>
        </div>

        <div class="card info">
            <div class="card-title">평균 불량률</div>
            <div class="card-value">${summary.defectRate}%</div>
            <div class="card-subtitle">전체 평균</div>
        </div>

        <div class="card danger-card">
            <div class="card-title">HIGH 위험 건수</div>
            <div class="card-value">${summary.highRiskCount}</div>
            <div class="card-subtitle">AI 기준</div>
        </div>

        <div class="card danger-card">
            <div class="card-title">HIGH 위험 비율</div>
            <div class="card-value">${summary.highRiskRate}%</div>
            <div class="card-subtitle">전체 대비</div>
        </div>
    </div>

    <div>
        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 120px;">검사일</th>
                        <th style="width: 120px;">QC 코드</th>
                        <th style="width: 150px;">LOT</th>
                        <th>품목명</th>
                        <th style="width: 120px;">검사수량</th>
                        <th style="width: 120px;">합격수량</th>
                        <th style="width: 120px;">불량수량</th>
                        <th style="width: 100px;">불량률</th>
                        <th style="width: 100px;">위험도</th>
                        <th style="width: 120px;">검사자</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="qc" items="${qualityList}">
                        <tr>
                            <td>${qc.qcDate}</td>
                            <td>${qc.qcId}</td>
                            <td>${qc.lotId}</td>
                            <td class="item-name-cell">${qc.itemName}</td>
                            <td>${qc.qcQty}</td>
                            <td>${qc.qcPassQty}</td>
                            <td>${qc.defectQty}</td>
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
                            <td>${qc.workerName}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty qualityList}">
                        <tr>
                            <td colspan="10" style="text-align: center;">
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

    .reportCard {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
        gap: 12px;
        margin-bottom: 12px;
    }

    .reportCard .card {
        min-width: 0;
        box-sizing: border-box;
    }

    .reportCard .card-value {
        font-size: 22px;
        word-break: keep-all;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .danger-card .card-value {
        color: #d93025;
    }

    .table-wrap {
        width: 100%;
        max-width: 100%;
        overflow-x: auto;
        box-sizing: border-box;
    }

    .table {
        width: 100%;
        min-width: 0;
        table-layout: fixed;
    }

    .table th,
    .table td {
        white-space: nowrap;
        vertical-align: middle;
        text-align: center;
    }

    .table .item-name-cell {
        text-align: left;
        white-space: normal;
        word-break: keep-all;
        line-height: 1.4;
    }

    .table th:nth-child(1),
    .table td:nth-child(1) {
        width: 90px;
    }

    .table th:nth-child(2),
    .table td:nth-child(2) {
        width: 90px;
    }

    .table th:nth-child(3),
    .table td:nth-child(3) {
        width: 100px;
    }

    .table th:nth-child(4),
    .table td:nth-child(4) {
        width: 180px;
    }

    .table th:nth-child(5),
    .table td:nth-child(5),
    .table th:nth-child(6),
    .table td:nth-child(6),
    .table th:nth-child(7),
    .table td:nth-child(7) {
        width: 90px;
    }

    .table th:nth-child(8),
    .table td:nth-child(8),
    .table th:nth-child(9),
    .table td:nth-child(9),
    .table th:nth-child(10),
    .table td:nth-child(10) {
        width: 80px;
    }

    .search-btn-area {
        display: flex;
        gap: 8px;
        align-items: flex-end;
    }

    @media (max-width: 1200px) {
        .reportCard {
            grid-template-columns: repeat(3, minmax(0, 1fr));
        }
    }

    @media (max-width: 900px) {
        .reportCard {
            grid-template-columns: repeat(2, minmax(0, 1fr));
        }
    }
</style>