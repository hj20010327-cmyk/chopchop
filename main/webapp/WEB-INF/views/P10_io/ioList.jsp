<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">입출고 관리</h2>
            <p class="page-subtitle">입출고 이력을 조회할 수 있습니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 입출고관리</p>

            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/io/insert">
                입출고 등록
            </a>
        </div>
    </div>

    <form class="search-box"
        action="${pageContext.request.contextPath}/io/list"
        method="get">

        <div class="search-item">
            <label>기간</label>

            <div style="display: flex; align-items: center; gap: 8px;">
                <input type="date"
                    name="startDate"
                    value="${search.startDate}">

                <span>~</span>

                <input type="date"
                    name="endDate"
                    value="${search.endDate}">
            </div>
        </div>

        <div class="search-item">
            <label>유형</label>

            <select name="ioType">
                <option value="">전체</option>

                <option value="IN"
                    ${search.ioType == 'IN' ? 'selected' : ''}>
                    입고
                </option>

                <option value="OUT"
                    ${search.ioType == 'OUT' ? 'selected' : ''}>
                    출고
                </option>
            </select>
        </div>

        <div class="search-item">
            <label>품목명/LOT 번호/입출고 번호 검색</label>

            <input type="text"
                name="searchKeyword"
                value="${search.searchKeyword}"
                placeholder="내용을 입력하세요." class="short">
        </div>

        <div class="search-btn-area">
            <button type="submit" class="btn btn-main">
                검색
            </button>
            <a class="btn btn-white" href="${pageContext.request.contextPath}/io/list">
				초기화
			</a>
        </div>

    </form>

    <div class="table-wrap">

        <table class="table">

            <thead>
                <tr>
                    <th style="width: 140px;">입출고 번호</th>
                    <th style="width: 100px;">유형</th>
                    <th>품목</th>
                    <th style="width: 130px;">수량</th>
                    <th style="width: 140px;">LOT 번호</th>
                    <th style="width: 180px;">처리일시</th>
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

                        <td>${io.itemName} (${io.itemId})</td>

                        <td>${io.ioQty} EA</td>

                        <td>${io.ioLot}</td>

                        <td>
                        	<fmt:formatDate value="${io.ioDate}"
								pattern="yyyy-MM-dd HH:mm"/>
						</td>

                    </tr>
                </c:forEach>

                <c:if test="${empty ioList}">
                    <tr>
                        <td colspan="6" style="text-align: center;">
                            조회된 입출고 이력이 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>

        </table>

    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>
<style>
	.table tbody tr:hover .ioId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
</style>