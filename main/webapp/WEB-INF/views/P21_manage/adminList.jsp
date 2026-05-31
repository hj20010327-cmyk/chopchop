<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">사원 관리</h2>
			<p class="page-subtitle">사원 목록을 조회하고 등록하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 사원관리</p>

			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/admin/add"> 사원 등록 </a>
		</div>
	</div>

	<div class="card-wrap adminCard">

		<div class="card info dept-all"
			data-deptno="all">

			<div class="card-title">전체</div>
			<div class="card-value">${totalAdminCount}&nbsp;<span style="font-size:20px">명</span></div>
		</div>

		<c:forEach var="dept" items="${deptSummary}">

			<c:set var="cardClass" value="dept-default" />

			<c:choose>
				<c:when test="${dept.empDeptno == 10}">
					<c:set var="cardClass" value="success" />
				</c:when>

				<c:when test="${dept.empDeptno == 20}">
					<c:set var="cardClass" value="warning" />
				</c:when>

				<c:when test="${dept.empDeptno == 30}">
					<c:set var="cardClass" value="safe" />
				</c:when>
			</c:choose>

			<div class="card dept-card ${cardClass}"
				data-deptno="${dept.empDeptno}">

				<div class="card-title">${dept.deptName}</div>
				<div class="card-value">${dept.deptCount}&nbsp;<span style="font-size:20px">명</span></div>
			</div>

		</c:forEach>
	</div>

	<form class="search-box" id="adminSearchForm" method="get"
		action="${pageContext.request.contextPath}/admin/list">

		<div class="search-item">
			<label>권한</label> <select name="searchAuth">
				<option value="">권한 선택</option>
				<option value="0" ${search.searchAuth eq '0' ? 'selected' : ''}>퇴사자</option>
				<option value="10" ${search.searchAuth eq '10' ? 'selected' : ''}>작업자</option>
				<option value="20" ${search.searchAuth eq '20' ? 'selected' : ''}>관리자</option>
				<option value="30" ${search.searchAuth eq '30' ? 'selected' : ''}>최고관리자</option>
			</select>
		</div>

		<div class="search-item">
			<label>상태</label> <select name="searchStatus">
				<option value="">재직 선택</option>
				<option value="0" ${search.searchStatus eq '0' ? 'selected' : ''}>재직</option>
				<option value="10" ${search.searchStatus eq '10' ? 'selected' : ''}>휴직</option>
				<option value="50" ${search.searchStatus eq '50' ? 'selected' : ''}>퇴사</option>
			</select>
		</div>

		<div class="search-item keyword">
			<label>사원명/사원번호 검색</label> <input type="text" name="searchKeyword"
				value="${search.searchKeyword}" placeholder="내용을 입력하세요.">
		</div>

		<div class="search-btn-area">
			<button type="submit" class="btn btn-main">
				검색
			</button>
			
			<a class="btn btn-white"
			   href="${pageContext.request.contextPath}/admin/list">
			    초기화
			</a>
		</div>
	</form>

	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 130px;">사원번호</th>
						<th style="width: 120px;">이름</th>
						<th style="width: 120px;">부서</th>
						<th style="width: 120px;">권한</th>
						<th style="width: 160px;">연락처</th>
						<th style="width: 130px;">입사일</th>
						<th style="width: 120px;">상태</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="admin" items="${adminList}">
						<tr class="adminList">
							<td class="empId">${admin.empId}</td>
							<td>${admin.empName}</td>
							<td>${admin.deptName}</td>

							<td><c:choose>
									<c:when test="${admin.empAuth == 0}">퇴사자</c:when>
									<c:when test="${admin.empAuth == 10}">작업자</c:when>
									<c:when test="${admin.empAuth == 20}">관리자</c:when>
									<c:when test="${admin.empAuth == 30}">최고관리자</c:when>
									<c:otherwise>권한 미지정</c:otherwise>
								</c:choose></td>

							<td>${admin.empTel}</td>
							<td>${admin.empHiredate}</td>

							<td><c:choose>
									<c:when test="${admin.empInOffice == 0}">
										<span class="status status-success">• 재직</span>
									</c:when>
									<c:when test="${admin.empInOffice == 10}">
										<span class="status status-warning">• 휴직</span>
									</c:when>
									<c:when test="${admin.empInOffice == 50}">
										<span class="status status-info">• 퇴사</span>
									</c:when>
									<c:otherwise>
										<span class="status status-info">• 미지정</span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>

					<c:if test="${empty adminList}">
						<tr>
							<td colspan="7" style="text-align: center;">조회된 사원이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<jsp:include page="/WEB-INF/views/common/paging.jsp" />
	</div>
</div>

<style>
.adminCard .card {
    width: 155px;
    cursor: pointer;

    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 10px;
}

.adminCard .card.info {
    border: 1px solid var(--dark-gray);
}

.adminCard .card.info .card-value {
    color: var(--dark-gray);
}

.adminCard .card.info:hover,
.adminCard .card.info.active {
    background-color: var(--dark-gray);
}

.adminCard .card.success:hover,
.adminCard .card.success.active {
    background-color: var(--success);
}

.adminCard .card.safe:hover,
.adminCard .card.safe.active {
    background-color: var(--safe);
}

.adminCard .card.warning:hover,
.adminCard .card.warning.active {
    background-color: var(--warning);
}

.adminCard .card:hover div,
.adminCard .card.active div {
    color: white !important;
}

.table tbody tr:hover .empId {
    color: var(--main-green);
    text-decoration: underline;
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
		bindDeptCardFilter();
		moveDetail();
	}

	function bindDeptCardFilter() {
		const allCard = document.querySelector(".adminCard .dept-all");
		const deptCards = document.querySelectorAll(".adminCard .dept-card");
		const form = document.querySelector("#adminSearchForm");

		if (!allCard || !deptCards.length || !form) {
			return;
		}

		const params = new URLSearchParams(window.location.search);
		const selectedDeptnos = params.getAll("searchDeptnos");

		if (selectedDeptnos.length === 0) {
			allCard.classList.add("active");
		} else {
			allCard.classList.remove("active");

			deptCards.forEach(card => {
				const deptno = card.dataset.deptno;

				if (selectedDeptnos.includes(deptno)) {
					card.classList.add("active");
				}
			});
		}

		allCard.addEventListener("click", () => {
			deptCards.forEach(card => {
				card.classList.remove("active");
			});

			allCard.classList.add("active");

			submitDeptFilter([]);
		});

		deptCards.forEach(card => {
			card.addEventListener("click", () => {
				card.classList.toggle("active");
				allCard.classList.remove("active");

				const activeCards = document.querySelectorAll(".adminCard .dept-card.active");

				const selectedValues = [];

				activeCards.forEach(activeCard => {
					selectedValues.push(activeCard.dataset.deptno);
				});

				if (selectedValues.length === 0) {
					allCard.classList.add("active");
					submitDeptFilter([]);
					return;
				}

				submitDeptFilter(selectedValues);
			});
		});

		function submitDeptFilter(selectedValues) {
			form.querySelectorAll("input[name='searchDeptnos']").forEach(input => {
				input.remove();
			});

			selectedValues.forEach(deptno => {
				const input = document.createElement("input");

				input.type = "hidden";
				input.name = "searchDeptnos";
				input.value = deptno;

				form.appendChild(input);
			});

			form.submit();
		}
	}

	function moveDetail() {
		const adminLists = document.querySelectorAll(".adminList");

		for (let i = 0; i < adminLists.length; i++) {
			adminLists[i].addEventListener("click", () => {
				const empId = adminLists[i].querySelector(".empId").textContent.trim();

				const url = "${pageContext.request.contextPath}/admin/detail?empId=" + empId;

				window.location.href = url;
			});
		}
	}
</script>