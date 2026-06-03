<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">내 알림</h2>
            <p class="page-subtitle">나에게 전달된 알림을 확인합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 마이페이지 &gt; 내 알림</p>
        </div>
    </div>

    <table class="table">
        <thead>
            <tr>
                <th style="width: 80px;">유형</th>
                <th style="width: 220px;">제목</th>
                <th>내용</th>
                <th style="width: 150px;">등록일</th>
            </tr>
        </thead>

        <tbody>
            <c:choose>
                <c:when test="${empty alarmList}">
                    <tr>
                        <td colspan="4" class="empty">
                            확인할 알림이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>
                    <c:forEach var="alarm" items="${alarmList}">
                        <tr onclick="location.href='${pageContext.request.contextPath}/alarm/detail?alarmId=${alarm.alarmId}'">
                            <td>
                                <c:choose>
                                    <c:when test="${alarm.alarmTypeNo == 10}">작업</c:when>
                                    <c:when test="${alarm.alarmTypeNo == 20}">이상</c:when>
                                    <c:when test="${alarm.alarmTypeNo == 30}">점검</c:when>
                                    <c:when test="${alarm.alarmTypeNo == 40}">일반</c:when>
                                    <c:otherwise>알림</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${alarm.alarmTitle}</td>
                            <td class="alarm-content">
							    ${alarm.alarmContent}
							</td>

                            <td>
                                <fmt:formatDate value="${alarm.alarmDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

</div>

<style>
.alarm-content {
    max-width: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>