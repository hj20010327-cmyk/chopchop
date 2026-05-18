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

    <div class="search-item date-item" style="width: 600px;">
        <label>기간</label>

        <div class="date-row">
            <input type="date"
                   name="startDate"
                   value="${suggDTO.startDate}">

            <span>~</span>

            <input type="date"
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
							<td>${dto.sugg_title}</td>
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
    

</script>

<style>
.search-box {
    display: flex;
    align-items: flex-end;
    gap: 10px;
}

.search-item {
    display: flex;
    flex-direction: column;
    gap: 6px;
}

.date-row {
    display: flex;
    align-items: center;
    gap: 8px;
}

.date-row input {
    width: 120px;
}

.status-item select {
    width: 90px;
}

.keyword input {
    width: 260px;
}

.search-btn-area {
    display: flex;
    align-items: flex-end;
}
</style>

