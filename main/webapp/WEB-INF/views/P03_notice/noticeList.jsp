<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">공지사항</h2>
        </div>

        <div>
            <p class="page-route">홈 > 공지사항 목록</p>

            <c:if test="${sessionScope.loginUser.empAuth >= 20}">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/notice/add">
                    공지사항 등록
                </a>
            </c:if>
        </div>
    </div>

    <form class="search-box"
          action="${pageContext.request.contextPath}/notice/list"
          method="get"
          id="searchForm">

        <div class="search-item date-item">

            <label>기간</label>

            <div class="date-row">

                <input type="date"
                       id="startDate"
                       name="startDate"
                       value="${noticeDTO.startDate}">

                <span>~</span>

                <input type="date"
                       id="endDate"
                       name="endDate"
                       value="${noticeDTO.endDate}">

            </div>

        </div>

        <div class="search-item keyword">

            <label>제목/작성자 검색</label>

            <input type="text"
                   class="short"
                   name="keyword"
                   value="${noticeDTO.keyword}"
                   placeholder="내용을 입력하세요.">

        </div>

        <div class="search-btn-area">

            <button type="submit"
                    class="btn btn-main">
                검색
            </button>

            <a class="btn btn-white reset-btn"
               href="${pageContext.request.contextPath}/notice/list">
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
                        <th>조회수</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="dto" items="${list}">

                        <tr onclick="location.href='${pageContext.request.contextPath}/notice/detail?not_no=${dto.not_no}'"
                            style="cursor:pointer;">

                            <td>${dto.not_no}</td>

                            <td class="noticeTitle">
                                ${dto.not_title}
                            </td>

                            <td>${dto.not_cdate}</td>

                            <td>${dto.empName} (${dto.not_writer})</td>

                            <td>${dto.not_view}</td>

                        </tr>

                    </c:forEach>

                    <c:if test="${empty list}">

                        <tr>
                            <td colspan="5"
                                style="text-align:center;">
                                조회된 공지사항이 없습니다.
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
window.addEventListener("load", function () {
    dateCheck();
});

function dateCheck() {

    const startDate =
        document.querySelector("#startDate");

    const endDate =
        document.querySelector("#endDate");

    if (startDate.value) {
        endDate.min = startDate.value;
    }

    startDate.addEventListener("change", function () {

        endDate.min = startDate.value;

        if (endDate.value &&
            endDate.value < startDate.value) {

            endDate.value = "";
        }
    });
}
</script>

<style>
.noticeTitle {
    text-align: left;
    cursor: pointer;
    transition: 0.2s;
}

.noticeTitle:hover {
    color: var(--main-green);
    text-decoration: underline;
}
</style>