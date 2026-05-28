<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">설비 관리</h2>
            <p class="page-subtitle">
                설비 가동 현황을 조회하고 새로운 설비를 등록할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 설비관리</p>
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/equip/add">
                설비 등록
            </a>
        </div>
    </div>
<div class="card-wrap eqCard">

    <div class="card info eq-all"
         data-card-type="all">
        <div class="card-title">전체 설비</div>
        <div class="card-value">${totalCount}</div>
        <div class="card-subtitle">전체 설비</div>
    </div>

    <div class="card success eq-card"
         data-card-type="10">
        <div class="card-title">가동 중 설비</div>
        <div class="card-value">${runCount}</div>
        <div class="card-subtitle">정상 가동 설비</div>
    </div>

    <div class="card info eq-card"
         data-card-type="20">
        <div class="card-title">정지 설비</div>
        <div class="card-value">${stopCount}</div>
        <div class="card-subtitle">설비 정지 상태</div>
    </div>

    <div class="card warning eq-card"
         data-card-type="30">
        <div class="card-title">점검 중 설비</div>
        <div class="card-value">${checkCount}</div>
        <div class="card-subtitle">점검 진행 설비</div>
    </div>

    <div class="card danger eq-card"
         data-card-type="40">
        <div class="card-title">고장 설비</div>
        <div class="card-value">${brokenCount}</div>
        <div class="card-subtitle">즉시 조치 필요</div>
    </div>

</div>

    <form class="search-box"
    action="${pageContext.request.contextPath}/equip/list"
    method="get">
    
    <div class="search-item">
        <label>작업장</label>

        <select name="eqWpid">
            <option value="">전체</option>

            <c:forEach var="wp" items="${wpList}">
                <option value="${wp.wpId}"
                    <c:if test="${search.eqWpid == wp.wpId}">selected</c:if>>
                    ${wp.wpName}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="search-item keyword">
        <label>설비명/설비코드</label>

        <input type="text"
            name="searchKeyword"
            value="${search.searchKeyword}"
            placeholder="내용을 입력하세요.">
    </div>

    <div class="search-btn-area">
        <button type="submit" class="btn btn-main">
            검색
        </button>

        <a class="btn btn-white"
            href="${pageContext.request.contextPath}/equip/list">
            초기화
        </a>
    </div>

	</form>

    <div class="table-wrap">

        <table class="table">

            <thead>
                <tr>
                    <th>설비</th>
                    <th>위치</th>
                    <th>전체시간</th>
                    <th>가동시간</th>
                    <th>가동률</th>
                    <th>상태</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="eqp" items="${eqList}">
                    <tr onclick="location.href='${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}'">

                        <td>
                        	<span class="eqId">
                       		 ${eqp.eqName} (${eqp.eqId})
                       		</span>
                        </td>
                        <td>${eqp.wpName}</td>
                        <td>${eqp.totalTime}시간</td>
                        <td>${eqp.runTime}시간</td>
                        <td>${eqp.runRate}</td>

                        <td>
					<c:choose>
					    <c:when test="${eqp.eqStatus == 10}">
					        <span class="status-back status-back-success">가동중</span>
					    </c:when>
					
					    <c:when test="${eqp.eqStatus == 20}">
					        <span class="status-back status-back-info">정지</span>
					    </c:when>
					
					    <c:when test="${eqp.eqStatus == 30}">
					        <span class="status-back status-back-warning">점검중</span>
					    </c:when>
					
					    <c:when test="${eqp.eqStatus == 40}">
					        <span class="status-back status-back-danger">고장</span>
					    </c:when>
					
					    <c:otherwise>
					        <span class="status-back status-back-info">비가동</span>
					    </c:otherwise>
					</c:choose>
                        </td>

                    </tr>
                </c:forEach>

                <c:if test="${empty eqList}">
                    <tr>
                        <td colspan="6" style="text-align:center;">
                            조회된 설비가 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>

        </table>

    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>

<style>
.table tbody tr:hover .eqId {
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

.card.info:hover,
.card.info.active {
    border: 1px solid var(--dark-gray);
    background-color: var(--dark-gray);
}

.card.success:hover,
.card.success.active {
    background-color: var(--success);
}

.card.safe:hover,
.card.safe.active {
    background-color: var(--safe);
}

.card.warning:hover,
.card.warning.active {
    background-color: var(--warning);
}

.card.danger:hover,
.card.danger.active {
    background-color: var(--danger);
}

.card:hover div,
.card.active div {
    color: white !important;
}
</style>
<script>
window.addEventListener("load", () => {
    bindCardFilter();
});

function bindCardFilter() {

    const allCard =
        document.querySelector(".eqCard .eq-all");

    const eqCards =
        document.querySelectorAll(".eqCard .eq-card");

    const form =
        document.querySelector(".search-box");

    if (!allCard || !eqCards.length || !form) {
        return;
    }

    const params =
        new URLSearchParams(window.location.search);

    const selectedStatusList =
        params.getAll("eqStatusList");

    // 검색 버튼만 눌러도 기존 카드 선택 유지되도록 form에 hidden input 복원
    syncSelectedStatusToForm(selectedStatusList);

    // URL 기준으로 active 복원
    if (selectedStatusList.length === 0) {

        allCard.classList.add("active");

    } else {

        allCard.classList.remove("active");

        eqCards.forEach(card => {

            const cardType =
                card.dataset.cardType;

            if (selectedStatusList.includes(cardType)) {
                card.classList.add("active");
            }
        });
    }

    // 전체 설비 클릭
    allCard.addEventListener("click", () => {

        eqCards.forEach(card => {
            card.classList.remove("active");
        });

        allCard.classList.add("active");

        submitCardFilter([]);
    });

    // 상태 카드 클릭
    eqCards.forEach(card => {

        card.addEventListener("click", () => {

            card.classList.toggle("active");

            allCard.classList.remove("active");

            const activeCards =
                document.querySelectorAll(".eqCard .eq-card.active");

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

    function syncSelectedStatusToForm(selectedValues) {

        form.querySelectorAll("input[name='eqStatusList']").forEach(input => {
            input.remove();
        });

        selectedValues.forEach(status => {

            const input =
                document.createElement("input");

            input.type = "hidden";
            input.name = "eqStatusList";
            input.value = status;

            form.appendChild(input);
        });
    }

    function submitCardFilter(selectedValues) {

        form.querySelectorAll("input[name='eqStatusList']").forEach(input => {
            input.remove();
        });

        selectedValues.forEach(status => {

            const input =
                document.createElement("input");

            input.type = "hidden";
            input.name = "eqStatusList";
            input.value = status;

            form.appendChild(input);
        });

        const pageInput =
            form.querySelector("input[name='page']");

        if (pageInput) {
            pageInput.value = 1;
        }

        form.submit();
    }
}
</script>