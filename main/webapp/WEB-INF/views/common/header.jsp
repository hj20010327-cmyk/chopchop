<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header class="header">
    <div class="header-left">
        <a href="${pageContext.request.contextPath}/dashboard" class="header-logo">
            <img
		        src="${pageContext.request.contextPath}/resources/img/CHOP_FOOD__.png"
		        alt="CHOP FOOD"
		        class="header-logo-img"
    		>
        </a>

    </div>

	<div class="alarm-wrap">
	    <div class="header-right">
	        <button type="button" class="header-icon" id="alarmBtn">
	
			    <c:choose>
			        <c:when test="${hasAlarm}">
			            <svg class="header-bell-icon" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
			                <path d="M6 13H8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			                <path d="M11 5.5C11 4.43913 10.5786 3.42172 9.82843 2.67157C9.07828 1.92143 8.06087 1.5 7 1.5C5.93913 1.5 4.92172 1.92143 4.17157 2.67157C3.42143 3.42172 3 4.43913 3 5.5V9C3 9.39782 2.84196 9.77936 2.56066 10.0607C2.27936 10.342 1.89782 10.5 1.5 10.5H12.5C12.1022 10.5 11.7206 10.342 11.4393 10.0607C11.158 9.77936 11 9.39782 11 9V5.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			                <path d="M0.5 5.37C0.500539 4.41814 0.727534 3.48007 1.16224 2.63327C1.59694 1.78647 2.22687 1.05525 3 0.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			                <path d="M13.5 5.37C13.4995 4.41814 13.2725 3.48007 12.8378 2.63327C12.4031 1.78647 11.7731 1.05525 11 0.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			            </svg>
			        </c:when>
			
			        <c:otherwise>
			            <svg class="header-bell-icon" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
			                <path d="M7 0.5C8.13778 0.5 9.22896 0.951981 10.0335 1.75651C10.838 2.56104 11.29 3.65222 11.29 4.79C11.29 9.56 13.03 10.5 13.5 10.5H0.5C0.98 10.5 2.71 9.55 2.71 4.79C2.71 3.65222 3.16198 2.56104 3.96651 1.75651C4.77104 0.951981 5.86222 0.5 7 0.5V0.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			                <path d="M5.5 12.3301C5.58644 12.6621 5.7806 12.9561 6.05205 13.1659C6.32351 13.3757 6.6569 13.4896 7 13.4896C7.3431 13.4896 7.67649 13.3757 7.94795 13.1659C8.2194 12.9561 8.41356 12.6621 8.5 12.3301" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
			            </svg>
			        </c:otherwise>
			    </c:choose>
			
			</button>
			
			<div class="alarm-panel" id="alarmPanel">
		        <h3 class="alarm-title">알림 내역</h3>
		
		        <div class="alarm-list">
		            <div class="alarm-item">
		                <p>[작업지시] 새로운 작업 내용이 업로드 되었습니다.</p>
		                <button type="button" class="alarm-close">×</button>
		            </div>
		
		            <div class="alarm-item">
		                <p>[재고] 부족한 재고가 발생하였습니다.</p>
		                <button type="button" class="alarm-close">×</button>
		            </div>
		        </div>
		    </div>
		</div>

        <div class="header-profile">
            <span class="profile-img"></span>
            <span class="profile-name">
            	<a href="${pageContext.request.contextPath}/mypage?empId=">
	            	홍길동 (EMP1001)
            	</a>
           	</span>
        </div>
    </div>
</header>