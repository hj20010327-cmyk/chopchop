<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<header class="header">
    <div class="header-left">
        <a href="${pageContext.request.contextPath}/dashboard" class="header-logo">
            <img
		        src="${pageContext.request.contextPath}/resources/img/CHOP_FOOD__WHITE_.png"
		        alt="CHOP FOOD"
		        class="header-logo-img"
    		>
        </a>

    </div>

    <div class="header-right">
        <button type="button" class="header-icon">🔔</button>
        <button type="button" class="header-icon">⚙</button>

        <div class="header-profile">
            <span class="profile-img"></span>
            <span class="profile-name">홍길동</span>
            <span class="profile-arrow">⌄</span>
        </div>
    </div>
</header>