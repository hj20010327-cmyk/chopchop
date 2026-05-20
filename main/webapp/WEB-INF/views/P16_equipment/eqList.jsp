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

    <div style="display:flex; gap:16px; margin:50px 0 35px;">

        <div style="width:171px; height:130px; border:1px solid var(--dark-gray); border-radius:8px; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:15px;">
            <div style="font-size:18px; font-weight:700;">가용 설비</div>
            <div style="font-size:42px; font-weight:800;">${totalCount}</div>
        </div>

        <div style="width:171px; height:130px; border-radius:8px; background-color:var(--success); color:#fff; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:15px;">
            <div style="font-size:18px; font-weight:700;">가동 중 설비</div>
            <div style="font-size:42px; font-weight:800;">${runCount}</div>
        </div>

        <div style="width:171px; height:130px; border-radius:8px; background-color:#777; color:#fff; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:15px;">
            <div style="font-size:18px; font-weight:700;">정지 설비</div>
            <div style="font-size:42px; font-weight:800;">${stopCount}</div>
        </div>

        <div style="width:171px; height:130px; border-radius:8px; background-color:var(--warning); color:#fff; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:15px;">
            <div style="font-size:18px; font-weight:700;">점검 중 설비</div>
            <div style="font-size:42px; font-weight:800;">${checkCount}</div>
        </div>

        <div style="width:171px; height:130px; border-radius:8px; background-color:var(--danger); color:#fff; display:flex; flex-direction:column; justify-content:center; align-items:center; gap:15px;">
            <div style="font-size:18px; font-weight:700;">고장 설비</div>
            <div style="font-size:42px; font-weight:800;">${brokenCount}</div>
        </div>

    </div>

    <form class="search-box"
        action="${pageContext.request.contextPath}/equip/list"
        method="get"
        style="width:100%; justify-content:space-between;">

        <div style="display:flex; gap:20px;">

            <div class="search-item">
                <label>작업장</label>

                <select name="eqWpid">
                    <option value="">전체</option>

                    <option value="WP1001-01"
                        <c:if test="${search.eqWpid == 'WP1001-01'}">selected</c:if>>
                        WP1001-01
                    </option>
                </select>
            </div>

            <div class="search-item">
                <label>상태</label>

                <select name="eqStatus">
                    <option value="0">전체</option>

                    <option value="10"
                        <c:if test="${search.eqStatus == 10}">selected</c:if>>
                        가동중
                    </option>

                    <option value="20"
                        <c:if test="${search.eqStatus == 20}">selected</c:if>>
                        정지
                    </option>

                    <option value="30"
                        <c:if test="${search.eqStatus == 30}">selected</c:if>>
                        점검중
                    </option>

                    <option value="40"
                        <c:if test="${search.eqStatus == 40}">selected</c:if>>
                        고장
                    </option>
                </select>
            </div>

        </div>

        <div style="display:flex; align-items:flex-end; gap:8px;">

            <div class="search-item">
                <label>설비명/설비코드</label>

                <input type="text"
                    name="searchKeyword"
                    value="${search.searchKeyword}"
                    placeholder="내용을 입력하세요."
                    style="width:360px;">
            </div>

            <button type="submit"
                class="btn btn-main"
                style="height:36px;">
                검색
            </button>

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

                        <td>${eqp.eqName} (${eqp.eqId})</td>
                        <td>${eqp.wpName}</td>
                        <td>${eqp.totalTime}시간</td>
                        <td>${eqp.runTime}시간</td>
                        <td>${eqp.runRate}</td>

                        <td>
                            <c:choose>
                                <c:when test="${eqp.eqStatus == 10}">
                                    <span class="status status-success">가동중</span>
                                </c:when>

                                <c:when test="${eqp.eqStatus == 20}">
                                    <span class="status status-info">정지</span>
                                </c:when>

                                <c:when test="${eqp.eqStatus == 30}">
                                    <span class="status status-warning">점검중</span>
                                </c:when>

                                <c:when test="${eqp.eqStatus == 40}">
                                    <span class="status status-danger">고장</span>
                                </c:when>

                                <c:otherwise>
                                    <span class="status">비가동</span>
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