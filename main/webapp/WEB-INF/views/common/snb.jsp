<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<aside class="snb">
    <nav class="snb-nav">
        <a href="${pageContext.request.contextPath}/dashboard" class="snb-menu active">
            <span class="snb-icon">⌂</span>
            <span>대시보드</span>
        </a>

        <a href="${pageContext.request.contextPath}/production" class="snb-menu">
            <span class="snb-icon">
           		<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M5.5 0.5V13.5" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M5.5 7H13.5" stroke="#000001" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
            </span>
            <span>생산관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/work" class="snb-menu">
            <span class="snb-icon">▤</span>
            <span>작업관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/material" class="snb-menu">
            <span class="snb-icon">◇</span>
            <span>자재관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/facility" class="snb-menu">
            <span class="snb-icon">⚙</span>
            <span>설비관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/quality" class="snb-menu">
            <span class="snb-icon">◉</span>
            <span>품질관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/stock" class="snb-menu">
            <span class="snb-icon">□</span>
            <span>재고관리</span>
            <span class="snb-arrow">›</span>
        </a>

        <a href="${pageContext.request.contextPath}/master" class="snb-menu">
            <span class="snb-icon">▣</span>
            <span>기준정보</span>
            <span class="snb-arrow">›</span>
        </a>
    </nav>

    <div class="snb-bottom">
        <a href="${pageContext.request.contextPath}/logout" class="snb-menu">
            <span class="snb-icon">⇱</span>
            <span>로그아웃</span>
        </a>
    </div>
</aside>