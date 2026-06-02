<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">재고 관리</h2>
            <p class="page-subtitle">
                모든 품목의 재고 현황을 조회하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 재고관리
            </p>
        </div>

    </div>

    
    
    <div class="card-wrap stockCard">
		<div class="card info stock-all ${empty search.stockStatusList ? 'active' : ''}"
	         data-card-type="all">
	        <div class="card-title">전체 재고 목록</div>
	        <div class="card-value">${stockTotalCount}</div>
	        <div class="card-subtitle">모든 품목에 대한 재고</div>
	    </div>
	
	    <div class="card safe stock-card ${fn:contains(search.stockStatusList, '안전') ? 'active' : ''}"
	         data-card-type="safe">
	        <div class="card-title">안전 재고</div>
	        <div class="card-value">${safeCount}</div>
	        <div class="card-subtitle">안전재고 수량 110% 이상 보유</div>
	    </div>
	
	    <div class="card warning stock-card ${fn:contains(search.stockStatusList, '위험') ? 'active' : ''}"
	         data-card-type="warning">
	        <div class="card-title">위험 재고</div>
	        <div class="card-value">${warningCount}</div>
	        <div class="card-subtitle">안전재고 수량 100% 이상 110% 미만 보유</div>
	    </div>
	
	    <div class="card danger stock-card ${fn:contains(search.stockStatusList, '부족') ? 'active' : ''}"
	         data-card-type="danger">
	        <div class="card-title">부족 재고</div>
	        <div class="card-value">${dangerCount}</div>
	        <div class="card-subtitle">안전재고 수량 100% 미만 보유</div>
	    </div>
	</div>

    <!-- 검색 -->
    <form class="search-box"
        action="${pageContext.request.contextPath}/stock/list"
        method="get"
        style="
            width:100%;
            justify-content:flex-end;
        ">

        <div style="display:flex; gap:20px;">

            <div class="search-item">
                <label>품목유형</label>

                <select name="itemType">
                    <option value="">전체</option>

                    <option value="10"
                        ${search.itemType == '10' ? 'selected' : ''}>
                        원자재
                    </option>

                    <option value="20"
                        ${search.itemType == '20' ? 'selected' : ''}>
                        반제품
                    </option>

                    <option value="30"
                        ${search.itemType == '30' ? 'selected' : ''}>
                        완제품
                    </option>
                    
                    <option value="40"
                        ${search.itemType == '40' ? 'selected' : ''}>
                        기타 자재
                    </option>
                </select>
            </div>
		<div id="statusHiddenArea"></div>

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

                        <td class="stockId">${stock.stockId}</td>

                        <td>
                        	<c:choose>
                        		<c:when test="${stock.itemType == 10}">
                        			원자재
                        		</c:when>
                        		<c:when test="${stock.itemType == 20}">
                        			반제품
                        		</c:when>
                        		<c:when test="${stock.itemType == 30}">
                        			완제품
                        		</c:when>
                        		<c:when test="${stock.itemType == 40}">
                        			기타 자재
                        		</c:when>
                        	</c:choose>
                        </td>

                        <td>
                            ${stock.itemName}(${stock.stockItem})
                        </td>

                        <td>
                            <fmt:formatNumber value="${stock.stockAvailQty}" pattern="#,###"/>
                        </td>

                        <td>
                            <fmt:formatNumber value="${stock.itemSafetyStock}" pattern="#,###"/>
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
<style>
	.table tbody tr:hover .stockId {
	    color: var(--main-green);
	    text-decoration: underline;
	}

	.card {
		cursor: pointer;
    	width: 155px;
	    	   
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    gap: 10px;
	}
	
	.card.info:hover, .card.info.active {
		border: 1px solid var(--dark-gray);
		background-color : var(--dark-gray);
	}
	
	.card.success:hover, .card.success.active {
		background-color : var(--success);
	}
	
	.card.safe:hover, .card.safe.active {
		background-color : var(--safe);
	}
	
	.card.warning:hover, .card.warning.active {
		background-color : var(--warning);
	}
	
	.card.danger:hover, .card.danger.active {
		background-color : var(--danger);
	}
	
	.card:hover div, .card.active div {
		color : white !important;
	}
	
	
	
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.table tr th:nth-child(3), .table tr td:nth-child(3) {
		width: 200px;
	}
}

@media screen and (max-width: 768px) {
	
	.table tr th:nth-child(2), .table tr td:nth-child(2) {
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
	
	.search-item input {
		max-width: 300px;
	}
	
}


@media screen and (max-width: 480px) {
	.card-wrap {
		flex-wrap: wrap;
	}
}
</style>

<script>
window.addEventListener("load", function () {

    const cards = document.querySelectorAll(".stockCard .card");
    const form = document.querySelector(".search-box");
    
    document.querySelector("form").addEventListener("submit", function(e) {

        const targets = this.querySelectorAll("input[type=text], textarea");

        for (let i = 0; i < targets.length; i++) {

            if (targets[i].value.trim() === "") {

                alert("공백만 입력할 수 없습니다.");

                targets[i].focus();

                e.preventDefault();
                return false;
            }
        }
    });
    
    document.querySelectorAll("input, textarea").forEach(el => {
        el.addEventListener("blur", function() {
            this.value = this.value.trim();
        });
    });

    const statusMap = {
        safe: "안전",
        warning: "위험",
        danger: "부족"
    };

    cards.forEach(function (card) {
        card.addEventListener("click", function () {

            const type = card.dataset.cardType;

            const params = new URLSearchParams(window.location.search);

            if (type === "all") {
                params.delete("stockStatusList");
                params.delete("page");
                location.href = form.action + "?" + params.toString();
                return;
            }

            let selected = params.getAll("stockStatusList");
            const status = statusMap[type];

            if (selected.includes(status)) {
                selected = selected.filter(function (v) {
                    return v !== status;
                });
            } else {
                selected.push(status);
            }

            params.delete("stockStatusList");
            params.delete("page");

            selected.forEach(function (v) {
                params.append("stockStatusList", v);
            });

            location.href = form.action + "?" + params.toString();
        });
    });

});
</script>