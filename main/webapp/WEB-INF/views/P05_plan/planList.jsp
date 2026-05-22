<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">생산 계획 관리</h2>
			<p class="page-subtitle">생산 계획을 조회할 수 있습니다.</p>
		</div>
		
		<div>
		<p class="page-route">홈 > 생산 계획 관리</p>
		<a class="btn btn-white"
			href="${pageContext.request.contextPath}/plan/add">
			생산계획 등록	
		</a>
		</div>
	</div>
	
	<div class="card-wrap planCard">
		<div class="card info plan-all"
	         data-card-type="all">
	        <div class="card-title">전체 계획</div>
	        <div class="card-value">${planCard.totalCnt}</div>
	    </div>
	
	    <div class="card success plan-card"
	         data-card-type="ing">
	        <div class="card-title">진행 중인 계획</div>
	        <div class="card-value">${planCard.ingCnt}</div>
	    </div>
	
	    <div class="card warning plan-card"
	         data-card-type="wait">
	        <div class="card-title">대기 중인 계획</div>
	        <div class="card-value">${planCard.waitCnt}</div>
	    </div>
	
	    <div class="card danger plan-card"
	         data-card-type="stop">
	        <div class="card-title">중단된 계획</div>
	        <div class="card-value">${planCard.stopCnt}</div>
	    </div>
	
	    <div class="card safe plan-card"
	         data-card-type="etc">
	        <div class="card-title">보류된 계획</div>
	        <div class="card-value">${planCard.etcCnt}</div>
	    </div>
	</div>
	
	<form class="search-box"
		action="${pageContext.request.contextPath}/plan/list"
		id="planSearchForm"
		method="get">
<%-- 		<input type="hidden" name="cardType" id="cardType" value="${search.cardType}"> --%>
		
		<div class="search-item">
			<label>기간</label>
			<div>
				<input type="date" id="planSearchSdate" name="planSearchSdate" value="${search.planSearchSdate}"
					onchange="limitDate()"> ~ <input type="date" id="planSearchEdate" name="planSearchEdate" value="${search.planSearchEdate}">
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
					중단
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
			<a class="btn btn-white" href="${pageContext.request.contextPath}/plan/list">
				초기화
			</a>
		</div>
	</form>
	
	
	
	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th>생산계획</th>
						<th>품목</th>
						<th>계획수량</th>
						<th>기간</th>
						<th>상태</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="plan" items="${planList}">
						<tr class="planList">
							<td class="planId">${plan.planId}</td>
							<td>${plan.planItemName} (${plan.planItem})</td>
							<td><fmt:formatNumber value="${plan.planFinQty}" pattern="#,###" /></td>
							<td>
<%-- 								<fmt:formatDate value="${plan.planSdate}" pattern="yyyy-MM-dd" /> --%>
<!-- 								~ -->
<%-- 								<fmt:formatDate value="${plan.planEdate}" pattern="yyyy-MM-dd" /> --%>
								${fn:substring(plan.planSdate, 0, 10)}
								    ~
							    ${fn:substring(plan.planEdate, 0, 10)}
							</td>
							<td class="span">상태</td>
							<td>${plan.planCdate}</td>
							<td class="whId">${wh.whId}</td>
						</tr>	
					</c:forEach>
					
					<c:if test="${empty planList}">
						<tr>
							<td colspan="7" style="text-align: center;">
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
	.table tbody tr:hover .planId {
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
	    const allCard = document.querySelector(".planCard .plan-all");
	    const planCards = document.querySelectorAll(".planCard .plan-card");
	    const form = document.querySelector("#planSearchForm");

	    if (!allCard || !planCards.length || !form) {
	        return;
	    }

	    const params = new URLSearchParams(window.location.search);
	    const selectedCardTypes = params.getAll("cardTypes");

	    syncSelectedCardTypesToForm(selectedCardTypes);

	    if (selectedCardTypes.length === 0) {
	        allCard.classList.add("active");
	    } else {
	        allCard.classList.remove("active");

	        planCards.forEach(card => {
	            const cardType = card.dataset.cardType;

	            if (selectedCardTypes.includes(cardType)) {
	                card.classList.add("active");
	            }
	        });
	    }

	    allCard.addEventListener("click", () => {
	        planCards.forEach(card => {
	            card.classList.remove("active");
	        });

	        allCard.classList.add("active");

	        submitCardFilter([]);
	    });

	    planCards.forEach(card => {
	        card.addEventListener("click", () => {
	            card.classList.toggle("active");
	            allCard.classList.remove("active");

	            const activeCards = document.querySelectorAll(".planCard .plan-card.active");
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
	    const planLists = document.querySelectorAll(".planList");

	    for (let i = 0; i < planLists.length; i++) {
	        planLists[i].addEventListener("click", () => {
	            const planId = planLists[i].querySelector(".planId").textContent.trim();

	            const url = `${pageContext.request.contextPath}/plan/detail?planId=` + planId;

	            window.location.href = url;
	        });
	    }
	}
	
	function limitDate() {
		const sdate = document.querySelector("#planSearchSdate");
		const edate = document.querySelector("#planSearchEdate");
		
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