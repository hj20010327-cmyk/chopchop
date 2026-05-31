<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">창고 관리</h2>
			<p class="page-subtitle">창고 목록을 조회하고 등록하세요.</p>
		</div>
		
		<div>
		<p class="page-route">홈 > 창고 관리</p>
		<a class="btn btn-white"
			href="${pageContext.request.contextPath}/warehouse/add">
			창고 등록	
		</a>
		</div>
	</div>
	
	<div class="card-wrap whCard">
		<div class="card info wh-all"
	         data-card-type="all">
	        <div class="card-title">전체 창고</div>
	        <div class="card-value">${whCard.totalWhCnt}</div>
	        <div class="card-subtitle">전체 창고</div>
	    </div>
	
<!-- 	    <div class="card success wh-card" -->
<!-- 	         data-card-type="using"> -->
<!-- 	        <div class="card-title">사용 중 창고</div> -->
<%-- 	        <div class="card-value">${whCard.usingWhCnt}</div> --%>
<!-- 	        <div class="card-subtitle">적재량 1 이상 창고</div> -->
<!-- 	    </div> -->
	
	    <div class="card safe wh-card"
	         data-card-type="safe">
	        <div class="card-title">안전 창고</div>
	        <div class="card-value">${whCard.safeWhCnt}</div>
	        <div class="card-subtitle">적재율 80% 미만</div>
	    </div>
	
	    <div class="card warning wh-card"
	         data-card-type="warning">
	        <div class="card-title">위험 창고</div>
	        <div class="card-value">${whCard.dangerWhCnt}</div>
	        <div class="card-subtitle">80% 이상 100% 미만</div>
	    </div>
	
	    <div class="card danger wh-card"
	         data-card-type="danger">
	        <div class="card-title">초과 적재 창고</div>
	        <div class="card-value">${whCard.overWhCnt}</div>
	        <div class="card-subtitle">100% 이상</div>
	    </div>
	</div>
	
	<form class="search-box"
		action="${pageContext.request.contextPath}/warehouse/list"
		id="whSearchForm"
		method="get">
		<div class="search-item">
			<label>유형</label>
			
			<select name="searchType">
				<option value="">전체</option>
			
				<option value="10"
					${search.searchType == '10' ? 'selected' : ''}>
					원자재 냉동창고
				</option>
				<option value="20"
					${search.searchType == '20' ? 'selected' : ''}>
					원자재 냉장창고
				</option>
				<option value="30"
					${search.searchType == '30' ? 'selected' : ''}>
					원자재 상온창고
				</option>
				<option value="40"
					${search.searchType == '40' ? 'selected' : ''}>
					반제품 냉장창고
				</option>
				<option value="50"
					${search.searchType == '50' ? 'selected' : ''}>
					반제품 냉동창고
				</option>
				<option value="60"
					${search.searchType == '60' ? 'selected' : ''}>
					완제품 냉동창고
				</option>
				<option value="70"
					${search.searchType == '70' ? 'selected' : ''}>
					기타 자재 상온 창고
				</option>
				<option value="80"
					${search.searchType == '80' ? 'selected' : ''}>
					반품/회수품 보관창고
				</option>
				<option value="90"
					${search.searchType == '90' ? 'selected' : ''}>
					부적합품 보관창고
				</option>
				<option value="100"
					${search.searchType == '100' ? 'selected' : ''}>
					폐기 대기창고
				</option>
			</select>
		</div>
		
		<div class="search-item keyword">
			<label>창고 번호/창고명 검색</label>
			
			<input type="text"
				name="searchKeyword"
				value="${search.searchKeyword}"
				placeholder="내용을 입력하세요.">
		</div>
		
		<div class="search-btn-area">
			<button type="submit" class="btn btn-main" >
				검색
			</button>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/warehouse/list">
				초기화
			</a>
		</div>
	</form>
	
	
	
	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 100px;">창고 번호</th>
						<th style="width: 180px;">창고명</th>
						<th style="width: 130px;">유형</th>
						<th style="width: 120px;">적재량(LOT)</th>
						<th style="width: 120px;">수용량(LOT)</th>
						<th style="width: 150px;">마지막 점검일</th>
						<th>적재율(%)</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="wh" items="${whList}">
						<tr class="whList">
							<td class="whId">${wh.whId}</td>
							<td>${wh.whName}</td>
							<td>${wh.whTypeName}</td>
							<td>${wh.whPrevQty}</td>
							<td>${wh.whQty}</td>
							<td>${wh.lastGlogDate}</td>
							<td id="qtyPer"
								style="font-weight: 700; 
								<c:if test="${wh.whUsageRate <= 0}">
									color: var(--info);
								</c:if>
								<c:if test="${wh.whUsageRate > 0 && wh.whUsageRate < 80}">
									color: var(--safe);
								</c:if>
								<c:if test="${wh.whUsageRate >= 80 && wh.whUsageRate < 100}">
									color: var(--warning);
								</c:if>
								<c:if test="${wh.whUsageRate > 100}">
									color: var(--danger);
								</c:if>
							">
							    <c:choose>
								    <c:when test="${wh.whQty != 0}">
								        <fmt:formatNumber value="${wh.whUsageRate}" pattern="0.00" />
								    </c:when>
								    <c:otherwise>
								        0.00
								    </c:otherwise>
								</c:choose>
							</td>
						</tr>	
					</c:forEach>
					
					<c:if test="${empty whList}">
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
	.table tbody tr:hover .whId {
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
	}
	
// 	function bindCardFilter() {
//         const cards = document.querySelectorAll(".whCard .card");
//         const form = document.querySelector("#whSearchForm");
//         const cardTypeInput = document.querySelector("#cardType");

//         if (!cards.length || !form || !cardTypeInput) {
//             return;
//         }

//         cards.forEach(card => {
//             card.addEventListener("click", () => {
//                 const cardType = card.dataset.cardType;

//                 cardTypeInput.value = cardType;

//                 const pageInput = form.querySelector("input[name='page']");
//                 if (pageInput) {
//                     pageInput.value = 1;
//                 }

//                 form.submit();
//             });
//         });
//     }


	function bindCardFilter() {
	    const allCard = document.querySelector(".whCard .wh-all");
	    const whCards = document.querySelectorAll(".whCard .wh-card");
	    const form = document.querySelector("#whSearchForm");
	    
	    if (!allCard || !whCards.length || !form) {
	        return;
	    }
	
	    const params = new URLSearchParams(window.location.search);
	    const selectedCardTypes = params.getAll("cardTypes");
	    
	 	// 검색 버튼만 눌러도 기존 카드 선택 유지되도록 form에 hidden input 복원
	    syncSelectedCardTypesToForm(selectedCardTypes);
		
	 	// URL 기준으로 active 복원
	    if (selectedCardTypes.length === 0) {
	        allCard.classList.add("active");
	    } else {
	        allCard.classList.remove("active");
	
	        whCards.forEach(card => {
	            const cardType = card.dataset.cardType;
	
	            if (selectedCardTypes.includes(cardType)) {
	                card.classList.add("active");
	            }
	        });
	    }
	
		 // 전체 카드 클릭		
	    allCard.addEventListener("click", () => {
	        whCards.forEach(card => {
	            card.classList.remove("active");
	        });
	
	        allCard.classList.add("active");
	
	        submitCardFilter([]);
	    });
	
	 	// 개별 카드 클릭
		whCards.forEach(card => {
	        card.addEventListener("click", () => {
	            card.classList.toggle("active");
	            allCard.classList.remove("active");
	
	            const activeCards = document.querySelectorAll(".whCard .wh-card.active");
	
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
	 	
		// 현재 선택값을 form hidden input으로 맞춰주는 함수
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
		
		// 카드 클릭 시 submit
	    function submitCardFilter(selectedValues) {
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
	
	        const pageInput = form.querySelector("input[name='page']");
	        if (pageInput) {
	            pageInput.value = 1;
	        }
	
	        form.submit();
	    }
	}
	
	function moveDetail() {
		const whLists = document.querySelectorAll(".whList");
		
		for (let i=0; i<whLists.length; i++) {
			
			whLists[i].addEventListener("click", () => {
				const whId = whLists[i].querySelector(".whId").textContent.trim();
				console.log ("whId : " + whId);
				
				const url = `${pageContext.request.contextPath}/warehouse/detail?whId=` + whId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
</script>