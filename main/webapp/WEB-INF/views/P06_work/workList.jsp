<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">작업 관리</h2>
			<p class="page-subtitle">작업 내역을 조회할 수 있습니다.</p>
		</div>
		
		<div>
		<p class="page-route">홈 > 작업 관리</p>
		<a class="btn btn-white"
			href="${pageContext.request.contextPath}/work/order/add">
			작업지시 등록	
		</a>
		</div>
	</div>
	
	<div class="card-wrap workCard">
		<div class="card info work-all"
	         data-card-type="all">
	        <div class="card-title">전체 작업</div>
	        <div class="card-value">${workCard.totalCnt}</div>
	        <div class="card-subtitle">금일 기준</div>
	    </div>
	
	    <div class="card success work-card"
	         data-card-type="ing">
	        <div class="card-title">진행 중인 작업</div>
	        <div class="card-value">${workCard.ingCnt}</div>
	        <div class="card-subtitle">금일 기준</div>
	    </div>
	
	    <div class="card warning work-card"
	         data-card-type="wait">
	        <div class="card-title">대기 중인 작업</div>
	        <div class="card-value">${workCard.waitCnt}</div>
			<div class="card-subtitle">금일 기준</div>
	    </div>
	
	    <div class="card danger work-card"
	         data-card-type="delay">
	        <div class="card-title">지연된 작업</div>
	        <div class="card-value">${workCard.delayCnt}</div>
			<div class="card-subtitle">금일 기준</div>
	    </div>
	
	    <div class="card safe work-card"
	         data-card-type="fin">
	        <div class="card-title">완료된 작업</div>
	        <div class="card-value">${workCard.finCnt}</div>
	        <div class="card-subtitle">금일 기준</div>
	    </div>
	
	    <div class="card info work-card"
	         data-card-type="etc">
	        <div class="card-title">보류된 작업</div>
	        <div class="card-value">${workCard.etcCnt}</div>
	        <div class="card-subtitle">금일 기준</div>
	    </div>
	</div>
	
	<form class="search-box"
		action="${pageContext.request.contextPath}/work/list"
		id="workSearchForm"
		method="get">
<%-- 		<input type="hidden" name="cardType" id="cardType" value="${search.cardType}"> --%>
		
		<div class="search-item">
			<label>기간</label>
			<div>
				<input type="date" id="workSearchSdate" name="workSearchSdate" value="${search.workSearchSdate}"
					onchange="limitDate()"> ~ <input type="date" id="workSearchEdate" name="workSearchEdate" value="${search.workSearchEdate}">
			</div>
		</div>
		
		<div class="search-item">
			<label>상태</label>
			
			<select name="searchType">
				<option value="">전체</option>
			
				<option value="20"
					${search.searchType == '20' ? 'selected' : ''}>
					진행 중
				</option>
				<option value="30"
					${search.searchType == '30' ? 'selected' : ''}>
					완료
				</option>
				<option value="10"
					${search.searchType == '10' ? 'selected' : ''}>
					대기
				</option>
				<option value="40"
					${search.searchType == '40' ? 'selected' : ''}>
					지연
				</option>
				<option value="0"
					${search.searchType == '0' ? 'selected' : ''}>
					보류
				</option>
			</select>
		</div>
		
		<div class="search-item keyword">
			<label>품목명/품목코드/생산계획 코드 검색</label>
			
			<input type="text"
				class="short"
				name="searchKeyword"
				value="${search.searchKeyword}"
				placeholder="내용을 입력하세요.">
		</div>
		
		<div class="search-btn-area">
			<button type="submit" class="btn btn-main" >
				검색
			</button>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/work/list">
				초기화
			</a>
		</div>
	</form>
	
	
	
	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th>작업지시</th>
						<th>생산계획</th>
						<th>품목</th>
						<th>지시수량</th>
						<th>완료수량</th>
						<th>작업자</th>
						<th>상태</th>
						<th>작업일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="work" items="${workList}">
						<tr class="workList">
							<td class="workId">${work.workId}</td>
							<td>${work.workPlan}</td>
							<td>${work.workItemName} (${work.workItem})</td>
							<td><fmt:formatNumber value="${work.workOrderQty}" pattern="#,###" /> ${work.workItemUnit}</td>
							<td>
								<c:choose>
									<c:when test="${not empty work.workPrevQty and work.workPrevQty != null}">
										<fmt:formatNumber value="${work.workPrevQty}" pattern="#,###" /> ${work.workItemUnit}
									</c:when>
									<c:otherwise>
										0 ${work.workItemUnit}
									</c:otherwise>
								</c:choose>
							</td>
							<td>${work.workWname} (${work.workWorker})</td>
							<td>
								<c:choose>
									<c:when test="${work.workStatus == 10}">
										<span class="status status-warning">• 대기중</span>
									</c:when>
									<c:when test="${work.workStatus == 20}">
										<span class="status status-success">• 작업중</span>
									</c:when>
									<c:when test="${work.workStatus == 30}">
										<span class="status status-safe">• 완료</span>
									</c:when>
									<c:when test="${work.workStatus == 40}">
										<span class="status status-danger">• 지연</span>
									</c:when>
									<c:when test="${work.workStatus == 0}">
										<span class="status status-info">• 보류</span>
									</c:when>
									<c:otherwise>
										<span class="status status-info">• 기타</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td>
								<fmt:formatDate value="${work.workDate}" pattern="yyyy-MM-dd"/>
							</td>
						</tr>	
					</c:forEach>
					
					<c:if test="${empty workList}">
						<tr>
							<td colspan="8" style="text-align: center;">
								조회된 내역이 없습니다.
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
	.table tbody tr:hover .workId {
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
	
</style>

<script>
	
	window.addEventListener ("load", () => {
		init();
	})
	
	function init() {
		bind();
	}
	
	function bind() {
		bindCardFilter();
		moveDetail();
		limitDate();
	}
	
	function bindCardFilter() {
	    const allCard = document.querySelector(".workCard .work-all");
	    const workCards = document.querySelectorAll(".workCard .work-card");
	    const form = document.querySelector("#workSearchForm");

	    if (!allCard || !workCards.length || !form) {
	        return;
	    }

	    const params = new URLSearchParams(window.location.search);
	    const selectedCardTypes = params.getAll("cardTypes");

	    syncSelectedCardTypesToForm(selectedCardTypes);

	    if (selectedCardTypes.length === 0) {
	        allCard.classList.add("active");
	    } else {
	        allCard.classList.remove("active");

	        workCards.forEach(card => {
	            const cardType = card.dataset.cardType;

	            if (selectedCardTypes.includes(cardType)) {
	                card.classList.add("active");
	            }
	        });
	    }

	    allCard.addEventListener("click", () => {
	        workCards.forEach(card => {
	            card.classList.remove("active");
	        });

	        allCard.classList.add("active");

	        submitCardFilter([]);
	    });

	    workCards.forEach(card => {
	        card.addEventListener("click", () => {
	            card.classList.toggle("active");
	            allCard.classList.remove("active");

	            const activeCards = document.querySelectorAll(".workCard .work-card.active");
	            const selectedValues = [];

	            activeCards.forEach(activeCard => {
	                selectedValues.push(activeCard.dataset.cardType);
	            });

	            if (selectedValues.length === 0) {
	                allCard.classList.add("active");
	                submitCardFilter([]);
	                return;
	            }

	            submitCardFilter(selectedValues);
	        });
	    });

	    function syncSelectedCardTypesToForm(selectedValues) {
	        form.querySelectorAll("input[name='cardTypes']").forEach(input => {
	            input.remove();
	        });

	        selectedValues.forEach(cardType => {
	            const input = document.createElement("input");

	            input.type = "hidden";
	            input.name = "cardTypes";
	            input.value = cardType;

	            form.appendChild(input);
	        });
	    }

	    function submitCardFilter(selectedValues) {
	        syncSelectedCardTypesToForm(selectedValues);

	        const pageInput = form.querySelector("input[name='page']");
	        if (pageInput) {
	            pageInput.value = 1;
	        }

	        form.submit();
	    }
	}
	
	function moveDetail() {
	    const workLists = document.querySelectorAll(".workList");

	    for (let i = 0; i < workLists.length; i++) {
	        workLists[i].addEventListener("click", () => {
	            const workId = workLists[i].querySelector(".workId").textContent.trim();

	            const url = `${pageContext.request.contextPath}/work/detail?workId=` + workId;

	            window.location.href = url;
	        });
	    }
	}
	
	function limitDate() {
		const sdate = document.querySelector("#workSearchSdate");
		const edate = document.querySelector("#workSearchEdate");
		
		const startValue = sdate.value;
		
		if (!startValue) {
			edate.removeAttribute("min");
			return;
		}
		
		edate.min = startValue;
		
		if (edate.value && edate.value < startValue) {
	        edate.value = "";
	    }
		
		if (sdate.value) {
	        edate.min = sdate.value;
	    }
	}
	
</script>