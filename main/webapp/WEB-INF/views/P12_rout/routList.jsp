<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">라우팅 관리</h2>
            <p class="page-subtitle">생산 품목별 공정 흐름을 조회하고 관리합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 라우팅 관리</p>

            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/routing/add">
                라우팅 등록
            </a>
        </div>
    </div>

    <form class="search-box"
	      action="${pageContext.request.contextPath}/routing/list"
	      method="get">
	
	    <div class="search-item">
	        <label>검색조건</label>
	
	        <select name="searchType">
	            <option value=""
	                ${empty search.searchType ? 'selected' : ''}>
	                전체
	            </option>
	
	            <option value="routId"
	                ${search.searchType == 'routId' ? 'selected' : ''}>
	                라우팅 코드
	            </option>
	
	            <option value="routName"
	                ${search.searchType == 'routName' ? 'selected' : ''}>
	                라우팅명
	            </option>
	
	            <option value="itemId"
	                ${search.searchType == 'itemId' ? 'selected' : ''}>
	                품목 코드
	            </option>
	
	            <option value="itemName"
	                ${search.searchType == 'itemName' ? 'selected' : ''}>
	                품목명
	            </option>
	        </select>
	    </div>
	
	    <div class="search-item keyword">
	        <label>검색어</label>
	
	        <input type="text"
	               name="searchKeyword"
	               value="${search.searchKeyword}"
	               placeholder="검색어를 입력하세요.">
	    </div>
	
	    <div class="search-btn-area">
	        <button type="submit" class="btn btn-main">
	            검색
	        </button>
	        
	        <a class="btn btn-white"
			   href="${pageContext.request.contextPath}/routing/list">
			    초기화
			</a>
	    </div>
	
	</form>

    <div class="table-wrap">
        <table class="table">
            <thead>
                <tr>
                    <th style="width: 120px;">라우팅 코드</th>
                    <th style="width: 155px;">라우팅명</th>
                    <th style="width: 150px;">생산 품목코드</th>
                    <th style="width: 180px;">생산 품목명</th>
                    <th>설명</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="rout" items="${routList}">
                    <tr class="rout-row">
                        <td class="rout-id">${rout.routId}</td>
                        <td>${rout.routName}</td>
                        <td>${rout.routItem}</td>
                        <td>${rout.itemName}</td>
                        <td>${rout.routContent}</td>
                    </tr>
                </c:forEach>

                <c:if test="${empty routList}">
                    <tr>
                        <td colspan="5"
                            style="text-align: center;">
                            조회된 라우팅 정보가 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>

<style>
	
    .rout-row {
        cursor: pointer;
    }

    .rout-row:hover .rout-id {
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
    window.addEventListener("load", function() {
        const rows = document.querySelectorAll(".rout-row");

        rows.forEach(function(row) {
            row.addEventListener("click", function() {
                const routId = row.querySelector(".rout-id").textContent.trim();

                location.href =
                    "${pageContext.request.contextPath}/routing/detail?routId="
                    + encodeURIComponent(routId);
            });
        });
    });
</script>