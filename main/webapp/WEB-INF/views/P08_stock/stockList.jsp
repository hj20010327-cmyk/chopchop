<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">재고 관리</h2>
            <p class="page-subtitle">
                재고 현황을 조회하고 등록할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 재고관리
            </p>
        </div>

    </div>

    <!-- 재고 카드 -->
    <div style="
        display:flex;
        justify-content:space-between;
        gap:40px;
        margin:50px 0 35px;
    ">

        <div style="
            width:200px;
            height:130px;
            border:1px solid var(--dark-gray);
            border-radius:8px;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            gap:15px;
        ">
            <div style="font-size:18px; font-weight:700;">전체 재고 목록</div>
            <div style="font-size:42px; font-weight:800;">${stockTotalCount}</div>
        </div>

        <div style="
            width:200px;
            height:130px;
            border-radius:8px;
            background-color:var(--safe);
            color:#fff;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            gap:15px;
        ">
            <div style="font-size:18px; font-weight:700;">안전 재고</div>
            <div style="font-size:42px; font-weight:800;">${safeCount}</div>
        </div>

        <div style="
            width:200px;
            height:130px;
            border-radius:8px;
            background-color:var(--warning);
            color:#fff;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            gap:15px;
        ">
            <div style="font-size:18px; font-weight:700;">위험 재고</div>
            <div style="font-size:42px; font-weight:800;">${warningCount}</div>
        </div>

        <div style="
            width:200px;
            height:130px;
            border-radius:8px;
            background-color:var(--danger);
            color:#fff;
            display:flex;
            flex-direction:column;
            justify-content:center;
            align-items:center;
            gap:15px;
        ">
            <div style="font-size:18px; font-weight:700;">부족 재고</div>
            <div style="font-size:42px; font-weight:800;">${dangerCount}</div>
        </div>

    </div>

    <!-- 검색 -->
    <form class="search-box"
        action="${pageContext.request.contextPath}/stock/list"
        method="get"
        style="
            width:100%;
            justify-content:space-between;
        ">

        <div style="display:flex; gap:20px;">

            <div class="search-item">
                <label>품목유형</label>

                <select name="itemType">
                    <option value="">전체</option>

                    <option value="원자재"
                        ${search.itemType == '원자재' ? 'selected' : ''}>
                        원자재
                    </option>

                    <option value="반제품"
                        ${search.itemType == '반제품' ? 'selected' : ''}>
                        반제품
                    </option>

                    <option value="완제품"
                        ${search.itemType == '완제품' ? 'selected' : ''}>
                        완제품
                    </option>
                </select>
            </div>

            <div class="search-item">
                <label>상태</label>

                <select name="stockStatus">
                    <option value="">전체</option>

                    <option value="안전"
                        ${search.stockStatus == '안전' ? 'selected' : ''}>
                        안전
                    </option>

                    <option value="위험"
                        ${search.stockStatus == '위험' ? 'selected' : ''}>
                        위험
                    </option>

                    <option value="부족"
                        ${search.stockStatus == '부족' ? 'selected' : ''}>
                        부족
                    </option>
                </select>
            </div>

        </div>

        <div style="
            display:flex;
            align-items:flex-end;
            gap:8px;
        ">

            <div class="search-item">
                <label>재고 코드/품목명/품목코드 검색</label>

                <input type="text"
                    name="searchKeyword"
                    value="${search.searchKeyword}"
                    placeholder="내용을 입력하세요."
                    style="
                        width:360px;
                    ">
            </div>

            <button type="submit"
                class="btn btn-main"
                style="
                    height:36px;
                ">
                검색
            </button>

        </div>

    </form>

    <!-- 테이블 -->
    <div class="table-wrap">

        <table class="table">

            <thead>
                <tr>
                    <th style="width:140px;">재고코드</th>
                    <th style="width:140px;">품목유형</th>
                    <th>품목</th>
                    <th style="width:140px;">현재수량</th>
                    <th style="width:140px;">안전재고</th>
                    <th style="width:120px;">상태</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="stock" items="${stockList}">

                    <tr onclick="location.href='${pageContext.request.contextPath}/stock/detail?stockId=${stock.stockId}'">

                        <td>${stock.stockId}</td>

                        <td>${stock.itemType}</td>

                        <td>
                            ${stock.itemName}(${stock.stockItem})
                        </td>

                        <td>
                            ${stock.stockAvailQty}
                        </td>

                        <td>
                            ${stock.itemSafetyStock}
                        </td>

                        <td>
                            <c:choose>

                                <c:when test="${stock.stockStatus == '안전'}">
                                    <span class="status status-safe">
                                        안전
                                    </span>
                                </c:when>

                                <c:when test="${stock.stockStatus == '위험'}">
                                    <span class="status status-warning">
                                        위험
                                    </span>
                                </c:when>

                                <c:when test="${stock.stockStatus == '부족'}">
                                    <span class="status status-danger">
                                        부족
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status">
                                        ${stock.stockStatus}
                                    </span>
                                </c:otherwise>

                            </c:choose>
                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty stockList}">
                    <tr>
                        <td colspan="6"
                            style="text-align:center;">
                            조회된 재고가 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>

        </table>

    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>