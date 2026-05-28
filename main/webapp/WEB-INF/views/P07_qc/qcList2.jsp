<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">품질 관리</h2>
            <p class="page-subtitle">품질 검사 결과를 조회하고 관리합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 품질관리</p>
            <a class="btn btn-white"
			href="${pageContext.request.contextPath}/quality/add">
			품질 검사 등록	
		</a>
        </div>
    </div>

   <div class="card-wrap qcCard">

    <div class="card info qc-all"
    	data-card-type="all">
        <div class="card-title">금일 검사 수량</div>
        <div class="card-value">${summary.todayQty}</div>
        <div class="card-subtitle">전체 검사 수량</div>
    </div>

    <div class="card safe qc-card"
    	data-card-type="safe">
        <div class="card-title">합격 수량</div>
        <div class="card-value">${summary.passQty}</div>
        <div class="card-subtitle">정상 처리 수량</div>
    </div>

    <div class="card danger qc-card"
    	data-card-type="danger">
        <div class="card-title">불량 수량</div>
        <div class="card-value">${summary.failQty}</div>
        <div class="card-subtitle">불량 발생 수량</div>
    </div>

    <div class="card warning qc-card"
    	data-card-type="warning">
        <div class="card-title">불량률</div>
        <div class="card-value">${summary.failRate} <span style="color: #555; font-size: 20px;">%</span></div>
        <div class="card-subtitle">전체 대비 불량률</div>
    </div>

</div>

    <form action="${pageContext.request.contextPath}/quality/list" method="get"
        class="search-box">

        <div class="search-item">
            <label>기간</label>
		<div style="display: flex; align-items: center; gap: 8px;">
            <input type="date" name="startDate" value="${search.startDate}">
            <span>~</span>
            <input type="date" name="endDate" value="${search.endDate}">
        </div>
        </div>

        <div class="search-item">
            <label>상태</label>
            <select name="qcStatus">
                <option value="0" ${search.qcStatus == 0 ? 'selected' : ''}>전체</option>
                <option value="10" ${search.qcStatus == 10 ? 'selected' : ''}>대기</option>
                <option value="20" ${search.qcStatus == 20 ? 'selected' : ''}>진행중</option>
                <option value="30" ${search.qcStatus == 30 ? 'selected' : ''}>완료</option>
                <option value="40" ${search.qcStatus == 40 ? 'selected' : ''}>중단</option>
            </select>
        </div>

        <div class="search-item keyword">
            <label>검색어</label>
            <input type="text" name="searchKeyword"
                value="${search.searchKeyword}"
                placeholder="검사코드 / LOT">
        </div>

        <button type="submit" class="btn btn-main">검색</button>
    </form>

    <table class="table">
        <thead>
            <tr>
                <th>검사코드</th>
                <th>LOT</th>
                <th>검사유형</th>
                <th>검사수량</th>
                <th>합격수량</th>
                <th>상태</th>
                <th>검사자</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
                <c:when test="${empty qcList}">
                    <tr>
                        <td colspan="8" class="empty">
                            조회된 품질검사 내역이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="qc" items="${qcList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/quality/detail?qcId=${qc.qcId}'">
                            <td>${qc.qcId}</td>
                            <td>${qc.qcLot}</td>
                            <td>
                            	<c:choose>
                                    <c:when test="${qc.qcType == 10}">
                                        <span class="status status-warning">수입검사</span>
                                    </c:when>
                                    <c:when test="${qc.qcType == 20}">
                                        <span class="status status-safe">공정검사</span>
                                    </c:when>
                                    <c:when test="${qc.qcType == 30}">
                                        <span class="status status-success">출하검사</span>
                                    </c:when>
                                    <c:when test="${qc.qcType == 0}">
                                        <span class="status status-danger">기타</span>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td>
                            	<fmt:formatNumber value="${qc.qcQty}" pattern="#,###" /> EA
                            </td>
                            <td>
                            	<fmt:formatNumber value="${qc.qcPassQty}" pattern="#,###" /> EA
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${qc.qcStatus == 10}">
                                        <span class="status status-warning">대기</span>
                                    </c:when>
                                    <c:when test="${qc.qcStatus == 20}">
                                        <span class="status status-safe">진행중</span>
                                    </c:when>
                                    <c:when test="${qc.qcStatus == 30}">
                                        <span class="status status-success">완료</span>
                                    </c:when>
                                    <c:when test="${qc.qcStatus == 40}">
                                        <span class="status status-danger">중단</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status status-info">보류</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                            	${qc.workerName}(${qc.qcWorker})
                            </td>

                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    	<jsp:include page="/WEB-INF/views/common/paging.jsp" />
</div>
<style>
	.card {
    	width: 155px;
	    	   
	    display: flex;
	    flex-direction: column;
	    justify-content: center;
	    align-items: center;
	    gap: 10px;
	}
	
</style>