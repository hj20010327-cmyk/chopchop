<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">BOM 관리</h2>
            <p class="page-subtitle">생산 품목 기준의 BOM 구성을 조회합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; BOM 관리</p>

            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/bom/add">
                BOM 등록
            </a>
        </div>
    </div>

    <form class="search-box"
          action="${pageContext.request.contextPath}/bom/list"
          method="get">

        <div class="search-item">
            <label>품목유형</label>

            <select name="searchType">
                <option value="">전체</option>

                <option value="FIN"
                    ${search.searchType == 'FIN' ? 'selected' : ''}>
                    완제품
                </option>

                <option value="SEMI"
				    ${search.searchType == 'SEMI' ? 'selected' : ''}>
				    반제품
				</option>
            </select>
        </div>

        <div class="search-item keyword">
            <label>품목코드/품목명/BOM명 검색</label>

            <input type="text"
                   name="searchKeyword"
                   value="${search.searchKeyword}"
                   placeholder="내용을 입력하세요.">
        </div>

        <div class="search-btn-area">
            <button type="submit"
                    class="btn btn-main">
                검색
            </button>
            
            <a class="btn btn-white"
			   href="${pageContext.request.contextPath}/bom/list">
			    초기화
			</a>
        </div>

    </form>

    <div>
        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 130px;">BOM코드</th>
                        <th style="width: 160px;">BOM명</th>
                        <th style="width: 220px;">생산 품목명</th>
                        <th style="width: 120px;">생산 품목 유형</th>
                        <th>설명</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="bom" items="${bomList}">
                        <tr class="bomList">
                            <td class="bomId">${bom.bomId}</td>
                            <td>${bom.bomName}</td>
                            <td>${bom.itemName} (${bom.bomItem})</td>

                            <td>
                                <c:choose>

								    <c:when test="${bom.itemType == 20}">
								        <span class="status status-warning">
								            • 반제품
								        </span>
								    </c:when>
								
								    <c:when test="${bom.itemType == 30}">
								        <span class="status status-success">
								            • 완제품
								        </span>
								    </c:when>
								
								    <c:otherwise>
								        <span class="status status-info">
								            -
								        </span>
								    </c:otherwise>
								
								</c:choose>
                            </td>

                            <td>${bom.bomContent}</td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty bomList}">
                        <tr>
                            <td colspan="5"
                                style="text-align: center;">
                                조회된 BOM 정보가 없습니다.
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
    .table tbody tr:hover .bomId {
        color: var(--main-green);
        text-decoration: underline;
    }
    
        
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.table tr th, .table tr td {
		width: 100px;
	}
	
	.table tr th:nth-child(3), .table tr td:nth-child(3),
	.table tr th:nth-child(4), .table tr td:nth-child(4) {
		display: none;
	}
	
	.table tr th:last-child, .table tr td:last-child {
		width: 300px;
	}
	
}
    
</style>

<script>
    window.addEventListener("load", () => {
        init();
    });

    function init() {
        bind();
    }

    function bind() {
        moveDetail();
    }

    function moveDetail() {
        const bomLists = document.querySelectorAll(".bomList");

        for (let i = 0; i < bomLists.length; i++) {
            bomLists[i].addEventListener("click", () => {
                const bomId = bomLists[i].querySelector(".bomId").textContent.trim();

                const url = "${pageContext.request.contextPath}/bom/detail?bomId=" + bomId;

                window.location.href = url;
            });
        }
    }
</script>