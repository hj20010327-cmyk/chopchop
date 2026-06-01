<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">재고 상세</h2>
            <p class="page-subtitle">
                재고 정보와 현재 보유 현황을 확인할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 재고관리 &gt; 상세</p>
        </div>
    </div>

    <div class="btn-row">
        <div>
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/stock/list">
                목록
            </a>
        </div>

        <div>
            <a class="btn btn-red"
                href="${pageContext.request.contextPath}/stock/delete?stockId=${stock.stockId}">
                삭제
            </a>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content">

            <div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:14px;
            ">
                <div class="content-content-content-title">
                    재고 상세정보
                </div>

                <div>
                    <c:choose>
                        <c:when test="${stock.stockStatus == '안전'}">
                            <span class="status status-safe">안전</span>
                        </c:when>

                        <c:when test="${stock.stockStatus == '위험'}">
                            <span class="status status-warning">위험</span>
                        </c:when>

                        <c:when test="${stock.stockStatus == '부족'}">
                            <span class="status status-danger">부족</span>
                        </c:when>

                        <c:otherwise>
                            <span class="status">${stock.stockStatus}</span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-table-wrap">

                <table class="info-table">

                    <tr>
                        <th>재고 코드</th>
                        <td>${stock.stockId}</td>

                        <th>안전재고</th>
                        <td> 
                        	<fmt:formatNumber value="${stock.itemSafetyStock}" pattern="#,###"/> ${stock.itemUnit}
                        </td>
                    </tr>

                    <tr>
                        <th>품목</th>
                        <td><a class="toDetail" href="${pageContext.request.contextPath}/item/detail?itemId=${stock.stockItem}">${stock.itemName} (${stock.stockItem})</a></td>

                        <th>현재재고</th>
                        <td>
                        	<fmt:formatNumber value="${stock.stockAvailQty}" pattern="#,###"/> ${stock.itemUnit}
                        </td>
                    </tr>

                    <tr>
                        <th>규격</th>
                        <td>${stock.itemSpec}</td>

                        <th>가용재고</th>
                        <td>
                        	<fmt:formatNumber value="${stock.stockPrevQty}" pattern="#,###"/> ${stock.itemUnit}
                        </td>
                    </tr>

                    <tr>
                        <th>단위</th>
                        <td>${stock.itemUnit}</td>

                        <th>예약재고</th>
                        <td>
                        	<fmt:formatNumber value="${stock.stockReserveQty}" pattern="#,###"/> ${stock.itemUnit}
                        </td>
                    </tr>

                </table>

            </div>

        </div>

        <div class="content-content-content">

            <div class="content-content-content-title">
                입출고 이력
            </div>

            <div class="table-wrap">

                <table class="table">

                    <thead>
                        <tr>
                            <th style="width:140px;">입출고 코드</th>
                            <th style="width:100px;">입/출고</th>
                            <th>사유</th>
                            <th style="width:180px;">입출고 일시</th>
                            <th style="width:120px;">수량 (${stock.itemUnit})</th>
                            <th style="width:140px;">LOT 번호</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:forEach var="io" items="${ioList}">
                            <tr onclick="location.href='${pageContext.request.contextPath}/io/detail?ioId=${io.ioId}'">
                                <td class="ioId">${io.ioId}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${io.ioType == 'IN'}">
                                            <span class="status status-safe">입고</span>
                                        </c:when>

                                        <c:when test="${io.ioType == 'OUT'}">
                                            <span class="status status-warning">출고</span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status">${io.ioType}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${io.ioReason}</td>
                                <td>
                                	<fmt:formatDate value="${io.ioDate}" pattern="YYYY-MM-dd HH:mm"/>
                                </td>
                                <td>
                                	<fmt:formatNumber value="${io.ioQty}" pattern="#,###"/>
                                </td>
                                <td>${io.ioLot}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty ioList}">
                            <tr>
                                <td colspan="6" style="text-align:center;">
                                    조회된 입출고 이력이 없습니다.
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
	.table tbody tr:hover .ioId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.table tr th:nth-child(3), .table tr td:nth-child(3) {
		width: 100px;
	}
}
	
</style>