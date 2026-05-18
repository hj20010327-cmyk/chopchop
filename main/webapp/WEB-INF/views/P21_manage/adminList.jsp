<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    .admin-page .header-row {
        margin-bottom: 18px;
    }

    .admin-page .header-right-box {
        display: flex;
        flex-direction: column;
        align-items: flex-end;
    }

    .admin-page .search-box {
        width: 100%;
        justify-content: space-between;
        margin: 0 0 20px 0;
        padding: 10px 0 16px;
    }

    .admin-page .search-item input {
        min-width: 360px;
    }

    .admin-page .search-item select {
        min-width: 130px;
    }

    .admin-page .search-btn-area {
        align-items: flex-end;
    }

    .admin-page .search-btn-area .btn {
        height: 36px;
        padding: 0 22px;
    }

    .admin-page .admin-row {
        cursor: pointer;
    }

    .admin-page .status {
        gap: 4px;
    }

    @media (max-width: 1200px) {
        .admin-page .search-box {
            justify-content: flex-start;
        }

        .admin-page .search-item input {
            min-width: 260px;
        }
    }
</style>

<div class="admin-page">

    <div class="header-row">

        <div>
            <h2 class="page-title">사원 관리</h2>

            <p class="page-subtitle">
                사원 목록을 조회하고 새로운 사원을 등록할 수 있습니다.
            </p>
        </div>

        <div class="header-right-box">

            <p class="page-route">
                홈 &gt; 관리 &gt; 사원관리
            </p>

            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/admin/add">
                사원 등록
            </a>

        </div>

    </div>

    <form class="search-box"
          method="get"
          action="${pageContext.request.contextPath}/admin/list">

        <div class="search-item">
            <label>부서</label>

            <select name="searchDeptno">
                <option value="">부서 선택</option>
                <option value="10" ${search.searchDeptno == 10 ? 'selected' : ''}>생산관리</option>
                <option value="20" ${search.searchDeptno == 20 ? 'selected' : ''}>품질검사</option>
                <option value="30" ${search.searchDeptno == 30 ? 'selected' : ''}>설비관리</option>
            </select>
        </div>

        <div class="search-item">
            <label>권한</label>

            <select name="searchAuth">
                <option value="">권한 선택</option>
                <option value="0" ${search.searchAuth == 0 ? 'selected' : ''}>퇴사자</option>
                <option value="10" ${search.searchAuth == 10 ? 'selected' : ''}>작업자</option>
                <option value="20" ${search.searchAuth == 20 ? 'selected' : ''}>관리자</option>
                <option value="30" ${search.searchAuth == 30 ? 'selected' : ''}>최고관리자</option>
            </select>
        </div>

        <div class="search-item">
            <label>상태</label>

            <select name="searchStatus">
                <option value="">재직 선택</option>
                <option value="0" ${search.searchStatus == 0 ? 'selected' : ''}>재직</option>
                <option value="10" ${search.searchStatus == 10 ? 'selected' : ''}>휴직</option>
                <option value="50" ${search.searchStatus == 50 ? 'selected' : ''}>퇴사</option>
            </select>
        </div>

        <div class="search-item keyword">
            <label>사원명/사원번호 검색</label>

            <input type="text"
                   name="searchKeyword"
                   value="${search.searchKeyword}"
                   placeholder="내용을 입력하세요.">
        </div>

        <div class="search-btn-area">
            <button type="submit"
                    class="btn btn-main">
                검색
            </button>
        </div>

    </form>

    <div class="table-wrap">

        <table class="table">

            <thead>
                <tr>
                    <th>사원번호</th>
                    <th>이름</th>
                    <th>부서</th>
                    <th>권한</th>
                    <th>연락처</th>
                    <th>입사일</th>
                    <th>상태</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="admin"
                           items="${adminList}">

                    <tr class="admin-row"
                        onclick="location.href='${pageContext.request.contextPath}/admin/detail?empId=${admin.empId}'">

                        <td>${admin.empId}</td>
                        <td>${admin.empName}</td>
                        <td>${admin.deptName}</td>

                        <td>
                            <c:choose>
                                <c:when test="${admin.empAuth == 0}">
                                    퇴사자
                                </c:when>

                                <c:when test="${admin.empAuth == 10}">
                                    작업자
                                </c:when>

                                <c:when test="${admin.empAuth == 20}">
                                    관리자
                                </c:when>

                                <c:when test="${admin.empAuth == 30}">
                                    최고관리자
                                </c:when>

                                <c:otherwise>
                                    권한 미지정
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${admin.empTel}</td>
                        <td>${admin.empHiredate}</td>

                        <td>
                            <c:choose>
                                <c:when test="${admin.empInOffice == 0}">
                                    <span class="status status-success">● 재직</span>
                                </c:when>

                                <c:when test="${admin.empInOffice == 10}">
                                    <span class="status status-warning">● 휴직</span>
                                </c:when>

                                <c:when test="${admin.empInOffice == 50}">
                                    <span class="status status-info">● 퇴사</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status status-info">● 미지정</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty adminList}">
                    <tr>
                        <td colspan="7"
                            style="text-align:center;">
                            조회된 사원이 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>

        </table>

    </div>

    <jsp:include page="/WEB-INF/views/common/paging.jsp" />

</div>