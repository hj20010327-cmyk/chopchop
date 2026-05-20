<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">설비 상세</h2>
            <p class="page-subtitle">
                설비의 상세 정보와 점검 이력을 알 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 설비관리 &gt; 상세</p>
        </div>
    </div>

    <div class="btn-row">
        <div>
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/eq/list">
                목록
            </a>
        </div>

        <div>
            <a class="btn btn-main"
                href="${pageContext.request.contextPath}/eq/edit?eqId=${eqp.eqId}">
                수정
            </a>

            <a class="btn btn-red"
                href="${pageContext.request.contextPath}/eq/delete?eqId=${eqp.eqId}">
                삭제
            </a>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content">

            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">

                <div style="display:flex; align-items:center; gap:14px;">
                    <div class="content-content-content-title" style="margin-bottom:0;">
                        설비 상세정보
                    </div>

                    <a class="btn btn-sub"
                        href="${pageContext.request.contextPath}/eq/stop?eqId=${eqp.eqId}">
                        설비 정지
                    </a>

                    <a class="btn btn-main"
                        href="${pageContext.request.contextPath}/eq/run?eqId=${eqp.eqId}">
                        설비 가동
                    </a>
                </div>

                <div style="display:flex; align-items:center; gap:14px;">

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

                    <select name="eqStatus"
                        style="width:150px; min-width:150px; height:36px;">
                        <option value="">설비 상태 선택</option>
                        <option value="10">가동중</option>
                        <option value="20">정지</option>
                        <option value="30">점검중</option>
                        <option value="40">고장</option>
                    </select>
                </div>

            </div>

            <div class="info-table-wrap">
                <table class="info-table">

                    <tr>
                        <th>설비코드</th>
                        <td>${eqp.eqId}</td>

                        <th>설비명</th>
                        <td>${eqp.eqName}</td>
                    </tr>

                    <tr>
                        <th>가동 시작일</th>
                        <td>${eqp.eqSdate}</td>

                        <th>가동률</th>
                        <td>${eqp.runRate}</td>
                    </tr>

                    <tr>
                        <th>전체시간</th>
                        <td>${eqp.totalTime}시간</td>

                        <th>가동시간</th>
                        <td>${eqp.runTime}시간</td>
                    </tr>

                    <tr>
                        <th>작업장</th>
                        <td>${eqp.eqWpid}</td>

                        <th>작업구역</th>
                        <td>${eqp.eqWpid}</td>
                    </tr>

                    <tr>
                        <th>설비 책임자</th>
                        <td>김설비 (EMP1006)</td>

                        <th>관리업체</th>
                        <td>거래처명 (거래처코드)</td>
                    </tr>

                </table>
            </div>

        </div>

        <div class="content-content-content">

            <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:14px;">

                <div class="content-content-content-title" style="margin-bottom:0;">
                    설비 점검이력
                </div>

                <a class="btn btn-main"
                    href="${pageContext.request.contextPath}/eq/log/add?eqId=${eqp.eqId}">
                    점검이력 등록
                </a>

            </div>

            <div class="table-wrap">
                <table class="table">

                    <thead>
                        <tr>
                            <th>점검 시작일</th>
                            <th>점검 종료일</th>
                            <th>점검 사유</th>
                            <th>점검 결과</th>
                            <th>점검자</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="log" items="${eqLogList}">
                            <tr>
                                <td>${log.elogSdate}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty log.elogEdate}">
                                            -
                                        </c:when>
                                        <c:otherwise>
                                            ${log.elogEdate}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${log.elogReason}</td>
                                <td>${log.elogResult}</td>
                                <td>${log.elogWorker}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty eqLogList}">
                            <tr>
                                <td colspan="5" style="text-align:center;">
                                    조회된 점검이력이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>

                </table>
            </div>

            <jsp:include page="/WEB-INF/views/common/paging.jsp" />

        </div>

        <div class="content-content-content">

            <div class="content-content-content-title">
                설비 가동이력
            </div>

            <div class="table-wrap">
                <table class="table">

                    <thead>
                        <tr>
                            <th>가동 시작일</th>
                            <th>가동 종료일</th>
                            <th>가동 종료 사유</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="run" items="${eqRunList}">
                            <tr>
                                <td>${run.eqRunStime}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty run.eqRunEtime}">
                                            -
                                        </c:when>
                                        <c:otherwise>
                                            ${run.eqRunEtime}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${empty run.eqStopReason}">
                                            -
                                        </c:when>
                                        <c:otherwise>
                                            ${run.eqStopReason}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty eqRunList}">
                            <tr>
                                <td colspan="3" style="text-align:center;">
                                    조회된 가동이력이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>

                </table>
            </div>

            <jsp:include page="/WEB-INF/views/common/paging.jsp" />

        </div>

    </div>

</div>