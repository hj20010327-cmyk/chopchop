<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">LOT 관리</h2>
			<p class="page-subtitle">LOT 목록을 조회할 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 > LOT관리</p>
		</div>
	</div>
	
	<div class="card-wrap lotCard">
		<div class="card info lot-all ${empty lotDTO.itemTypeList and empty lotDTO.expStatus ? 'active' : ''}"
	         data-card-type="all">
	        <div class="card-title">전체 품목</div>
	        <div class="card-value">
	        	<fmt:formatNumber value="${totalCount}" pattern="#,###"/>
	        </div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	
	    <div class="card safe lot-card ${fn:contains(lotDTO.itemTypeList, '10') ? 'active' : ''}"
	         data-card-type="raw">
	        <div class="card-title">원자재</div>
	        <div class="card-value">
	        	<fmt:formatNumber value="${rawCount}" pattern="#,###"/>
	        </div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	
	    <div class="card warning lot-card ${fn:contains(lotDTO.itemTypeList, '20') ? 'active' : ''}"
	         data-card-type="semi">
	        <div class="card-title">반제품</div>
	        <div class="card-value">
	        	<fmt:formatNumber value="${semiCount}" pattern="#,###"/>
	        </div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	
	    <div class="card success lot-card ${fn:contains(lotDTO.itemTypeList, '30') ? 'active' : ''}"
	         data-card-type="fin">
	        <div class="card-title">완제품</div>
	        <div class="card-value">
	        	<fmt:formatNumber value="${finCount}" pattern="#,###"/>
	        </div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	    
	    <div class="card info lot-card ${fn:contains(lotDTO.itemTypeList, '40') ? 'active' : ''}"
	         data-card-type="etc">
	        <div class="card-title">기타 자재</div>
	        <div class="card-value">
	        	<fmt:formatNumber value="${etcCount}" pattern="#,###"/>
	        </div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	    
	    <div class="card danger lot-card ${lotDTO.expStatus == '임박' ? 'active' : ''}"
	         data-card-type="exp">
	        <div class="card-title">유통기한 임박</div>
	        <div class="card-value">${expCount}</div>
	        <div class="card-subtitle">사용가능/사용중 기준</div>
	    </div>
	</div>

	<form class="search-box"
		action="${pageContext.request.contextPath}/lot/list" method="get">

		<div class="search-item">
			<label>유통기한</label>

			<div style="display: flex; align-items: center; gap: 8px;">
				<input type="date" id="startDate" name="startDate" value="${lotDTO.startDate}">

				<span>~</span> <input type="date" id="endDate" name="endDate"
					value="${lotDTO.endDate}">
			</div>
		</div>

		<div class="search-item">
			<label>상태</label> <select name="lotStatus">
				<option value="">전체</option>

				<option value="10" ${lotDTO.lotStatus == '10' ? 'selected' : ''}>
					사용 가능</option>

				<option value="20" ${lotDTO.lotStatus == '20' ? 'selected' : ''}>
					사용중</option>

				<option value="30" ${lotDTO.lotStatus == '30' ? 'selected' : ''}>
					사용완료</option>

				<option value="40" ${lotDTO.lotStatus == '40' ? 'selected' : ''}>
					보류</option>

				<option value="0" ${lotDTO.lotStatus == '0' ? 'selected' : ''}>
					폐기</option>
			</select>
		</div>

		<div class="search-item keyword">
			<label>품목명/LOT 번호 검색</label> <input type="text" name="searchKeyword"
				value="${lotDTO.searchKeyword}" placeholder="내용을 입력하세요." class="short">
		</div>

		<div class="search-btn-area">
			<button type="submit" class="btn btn-main">검색</button>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/lot/list">
				초기화
			</a>
		</div>
	</form>

	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 130px;">LOT 번호</th>
						<th style="width: 200px;">품목명(코드)</th>
						<th style="width: 130px;">위치</th>
						<th style="width: 100px;">수량</th>
						<th style="width: 180px;">유통기한</th>
						<th style="width: 100px;">상태</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="lot" items="${lotList}">
						<tr onclick="location.href='${pageContext.request.contextPath}/lot/detail?lotId=${lot.lotId}'">
							<td class="lotId">${lot.lotId}</td>
							<td>${lot.lotItemName}(${lot.lotItem})</td>
							<td>
								<c:choose>
									<c:when test="${lot.lotQc == 'Y'}">
										${lot.lotAwhsec}
									</c:when>
									<c:when test="${lot.lotQc == 'N'}">
										${lot.lotBwhsec}
									</c:when>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${lot.lotQc == 'Y'}">
										<fmt:formatNumber value="${lot.lotFqty}" pattern="#,###"/>
										EA
									</c:when>
									<c:when test="${lot.lotQc == 'N'}">
										<fmt:formatNumber value="${lot.lotQty}" pattern="#,###"/>
										EA
									</c:when>
								</c:choose>
							</td>
							<td>
								<fmt:formatDate value="${lot.lotExp}"
								pattern="yyyy-MM-dd HH:mm"/>
							</td>
							<td>
								<c:choose>

									<c:when test="${lot.lotStatus == '10'}">
										<span class="status status-success"> • 사용가능 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '20'}">
										<span class="status status-safe"> • 사용중 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '30'}">
										<span class="status status-info"> • 사용완료 </span>
									</c:when>
									
									<c:when test="${lot.lotStatus == '40'}">
										<span class="status status-warning"> • 보류 </span>
									</c:when>

									<c:when test="${lot.lotStatus == '0'}">
										<span class="status status-danger"> • 폐기 </span>
									</c:when>

									<c:otherwise>
										<span class="status"> ${lot.lotStatus} </span>
									</c:otherwise>

								</c:choose>
							</td>
						</tr>
					</c:forEach>

					<c:if test="${empty lotList}">
						<tr>
							<td colspan="6" style="text-align: center;">조회된 LOT가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<jsp:include page="/WEB-INF/views/common/paging.jsp" />

	</div>
</div>
<style>
	.table tbody tr:hover .lotId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
	
	.card {
		cursor: pointer;
    	width: 145px;
    	height: 135px;
	    	   
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
	.table tr th:nth-child(4), .table tr td:nth-child(4) {
		width: 120px;
	}
}
	
	
	
</style>

<script>
window.addEventListener("load", function () {

    const cards = document.querySelectorAll(".lotCard .card");
    const form = document.querySelector(".search-box");

    const itemTypeMap = {
        raw: "10",
        semi: "20",
        fin: "30",
        etc: "40"
    };

    cards.forEach(function (card) {
        card.addEventListener("click", function () {

            const type = card.dataset.cardType;
            const params = new URLSearchParams(window.location.search);

            params.delete("page");

            if (type === "all") {
                params.delete("itemTypeList");
                params.delete("expStatus");
                location.href = form.action + "?" + params.toString();
                return;
            }

            if (type === "exp") {

             	// 상태 검색 제거
                params.delete("lotStatus");

                const expStatus = params.get("expStatus");

                if (expStatus === "임박") {
                    params.delete("expStatus");
                } else {
                    params.set("expStatus", "임박");
                }

                location.href = form.action + "?" + params.toString();
                return;
            }

            let selected = params.getAll("itemTypeList");
            const itemType = itemTypeMap[type];

            if (selected.includes(itemType)) {
                selected = selected.filter(function (v) {
                    return v !== itemType;
                });
            } else {
                selected.push(itemType);
            }

            params.delete("itemTypeList");

            selected.forEach(function (v) {
                params.append("itemTypeList", v);
            });

            location.href = form.action + "?" + params.toString();
        });
    });
    
    const startDate = document.querySelector("#startDate");
    const endDate = document.querySelector("#endDate");

    function syncDateLimit() {
        if (startDate.value !== "") {
            endDate.min = startDate.value;
        } else {
            endDate.removeAttribute("min");
        }

        if (endDate.value !== "") {
            startDate.max = endDate.value;
        } else {
            startDate.removeAttribute("max");
        }
    }

    startDate.addEventListener("change", function () {
        if (endDate.value !== "" && startDate.value > endDate.value) {
            endDate.value = startDate.value;
        }

        syncDateLimit();
    });

    endDate.addEventListener("change", function () {
        if (startDate.value !== "" && endDate.value < startDate.value) {
            startDate.value = endDate.value;
        }

        syncDateLimit();
    });

    syncDateLimit();

});
</script>