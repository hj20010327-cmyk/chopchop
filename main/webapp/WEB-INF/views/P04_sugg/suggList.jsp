<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">건의사항</h2>
		</div>

		<div>
			<p class="page-route">홈 > 건의사항</p>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/sugg/add"> 건의사항 등록 </a>
		</div>
	</div>
	

	<form class="search-box"
      	  action="${pageContext.request.contextPath}/sugg/list"
      	  method="get"
      	  id="searchForm">

    <div class="search-item date-item">
        <label>기간</label>

        <div class="date-row">
            <input type="date"
            	   id="startDate"
                   name="startDate"
                   value="${suggDTO.startDate}">

            <span>~</span>

            <input type="date"
                   id="endDate"
                   name="endDate"
                   value="${suggDTO.endDate}">
        </div>
    </div>

    <div class="search-item status-item">
        <label>상태</label>

        <select name="sugg_answer">
            <option value="">전체</option>
            <option value="N" ${suggDTO.sugg_answer == 'N' ? 'selected' : ''}>
                답변대기
            </option>
            <option value="Y" ${suggDTO.sugg_answer == 'Y' ? 'selected' : ''}>
                답변완료
            </option>
        </select>
    </div>

    <div class="search-item keyword">
        <label>제목/작성자 검색</label>

        <input type="text"
               name="keyword"
               value="${suggDTO.keyword}"
               placeholder="내용을 입력하세요.">
    </div>

    <div class="search-btn-area">
        <button type="submit" class="btn btn-main">검색</button>
         <a class="btn btn-white reset-btn"
       href="${pageContext.request.contextPath}/sugg/list">
        초기화
    	</a>
    </div>

</form>

	<div>
		<div class="table-wrap">
			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>댓글</th>
						<th>조회수</th>
						<th>상태</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="dto" items="${list}">
						<tr class="suggList">
							<td class="suggNo">${dto.sugg_no}</td>
							<td class="suggTitle">${dto.sugg_title}</td>
							<td>${dto.sugg_cdate}</td>
							<td>${dto.sugg_writer}</td>
							<td>${dto.comment_count}</td>
							<td>${dto.sugg_view}</td>
							<td><c:choose>
									<c:when test="${dto.sugg_answer eq 'N'}">
										<span style="color:var(--dark-gray);"> • 답변대기 </span>
									</c:when>
									<c:otherwise>
										<span style="color:var(--success);"> • 답변완료 </span>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>

					<c:if test="${empty list}">
						<tr>
							<td colspan="7" style="text-align: center;">조회된 건의사항이 없습니다.
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>

		<jsp:include page="/WEB-INF/views/common/paging.jsp" />

	</div>

</div>

<script>

    window.addEventListener("load", () => {
        init();
    });

    function init() {
        bind();
    }

    function bind() {
        moveDetail();
        dateCheck();
    }

    function moveDetail() {
        const suggLists = document.querySelectorAll(".suggList");

        for (let i = 0; i < suggLists.length; i++) {

            suggLists[i].addEventListener("click", () => {
                const suggNo = suggLists[i].querySelector(".suggNo").textContent.trim();
                console.log("sugg_no : " + suggNo);

                const url = `${pageContext.request.contextPath}/sugg/detail?sugg_no=` + suggNo;
                console.log("url : " + url);

                window.location.href = url;
            });
        }
    }
    
    document.querySelector("#searchForm")
    .addEventListener("submit", function(e){

        const startDate =
            document.querySelector("input[name='startDate']").value;

        const endDate =
            document.querySelector("input[name='endDate']").value;

        // 둘 다 선택했을 때만 검사
        if(startDate && endDate){

            if(startDate > endDate){
                alert("시작일은 종료일보다 늦을 수 없습니다.");
                e.preventDefault();
                return;
            }

        }

    });
    
    function dateCheck() {
        const startDate = document.querySelector("#startDate");
        const endDate = document.querySelector("#endDate");

        // 페이지 처음 열렸을 때 startDate 값이 있으면 endDate 최소값 설정
        if (startDate.value) {
            endDate.min = startDate.value;
        }

        startDate.addEventListener("change", function () {
            endDate.min = startDate.value;

            // 이미 선택된 종료일이 시작일보다 이전이면 초기화
            if (endDate.value && endDate.value < startDate.value) {
                endDate.value = "";
            }
        });
    }
    

</script>

<style>
.search-box {
    display: flex;
    align-items: flex-end;
    gap: 10px;
    flex-wrap: nowrap;
}

.date-item {
    width: auto;
}

.date-row {
    display: flex;
    align-items: center;
    gap: 8px;
}

.date-row input {
    width: 230px;
    min-width: 230px;
}

.status-item select {
    width: 110px;
    min-width: 110px;
}

.keyword input {
    width: 240px;
    min-width: 240px;
}

.search-btn-area {
    display: flex;
    align-items: center;
    gap: 8px;
    flex-wrap: nowrap;
    min-width: 145px;
}

.reset-btn {
    width: 66px;
    white-space: nowrap;
}

.suggTitle {
    cursor: pointer;
    transition: 0.2s;
}

.suggTitle:hover {
    color: #2d7a46;
    text-decoration: underline;
}


/* PC 화면에서만 한 줄 유지 */
@media (min-width: 1200px) {
    .search-box {
        flex-wrap: nowrap;
    }
}

/* 작은 화면에서는 자연스럽게 줄바꿈 */
@media (max-width: 768px) {
    .date-row {
        flex-wrap: wrap;
    }

    .date-row input,
    .status-item select,
    .keyword input {
        width: 100%;
    }

    .search-item,
    .search-btn-area {
        width: 100%;
    }
}
</style>

