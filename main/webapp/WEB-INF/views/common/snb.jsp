<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<aside class="snb">
    <nav class="snb-nav">

        <!-- 대시보드 -->
        <a href="${pageContext.request.contextPath}/dashboard"
           class="snb-menu"
           data-snb-path="/dashboard">
            <span class="snb-icon">
                <!-- dashboard svg -->
                <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
            <span>대시보드</span>
        </a>

        <!-- 게시판 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/notice/list" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- board svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>게시판</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/notice/list" class="snb-submenu-link">공지사항</a>
                <a href="${pageContext.request.contextPath}/suggest/list" class="snb-submenu-link">건의사항</a>
            </div>
        </div>

        <!-- 생산/작업 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/production/list" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- production svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>생산/작업</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/production/list" class="snb-submenu-link">생산 계획 관리</a>
                <a href="${pageContext.request.contextPath}/work/list" class="snb-submenu-link">작업 관리</a>
                <a href="${pageContext.request.contextPath}/quality/list" class="snb-submenu-link">품질검사 관리</a>
            </div>
        </div>

        <!-- 재고 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/io/list" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- stock svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>재고</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/stock/list" class="snb-submenu-link">재고 관리</a>
                <a href="${pageContext.request.contextPath}/lot/list" class="snb-submenu-link">LOT 관리</a>
                <a href="${pageContext.request.contextPath}/io/list" class="snb-submenu-link">입출고 관리</a>
            </div>
        </div>

        <!-- 기준정보 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/item/list" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- master svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>기준정보</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/item/list" class="snb-submenu-link">품목 관리</a>
                <a href="${pageContext.request.contextPath}/routing/list" class="snb-submenu-link">라우팅 관리</a>
                <a href="${pageContext.request.contextPath}/bom/list" class="snb-submenu-link">BOM 관리</a>
                <a href="${pageContext.request.contextPath}/warehouse/list" class="snb-submenu-link">창고 관리</a>
                <a href="${pageContext.request.contextPath}/workplace/list" class="snb-submenu-link">작업장 관리</a>
                <a href="${pageContext.request.contextPath}/facility/list" class="snb-submenu-link">설비 관리</a>
                <a href="${pageContext.request.contextPath}/vendor/list" class="snb-submenu-link">거래처 관리</a>
                <a href="${pageContext.request.contextPath}/defect/list" class="snb-submenu-link">불량유형 관리</a>
            </div>
        </div>

        <!-- 리포팅 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/report/work" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- report svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>리포팅</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/report/work" class="snb-submenu-link">작업 실적</a>
                <a href="${pageContext.request.contextPath}/report/quality" class="snb-submenu-link">품질 검사</a>
                <a href="${pageContext.request.contextPath}/report/inout" class="snb-submenu-link">입출고</a>
                <a href="${pageContext.request.contextPath}/report/facility" class="snb-submenu-link">설비 가동</a>
            </div>
        </div>

        <!-- 관리자 -->
        <div class="snb-group">
            <a href="${pageContext.request.contextPath}/admin/list" class="snb-menu snb-toggle">
                <span class="snb-icon">
                    <!-- admin svg -->
                    <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                        <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    </svg>
                </span>
                <span>관리자</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${pageContext.request.contextPath}/admin/list" class="snb-submenu-link">회원 관리</a>
                <a href="${pageContext.request.contextPath}/alarm/add" class="snb-submenu-link">알람 생성</a>
            </div>
        </div>

    </nav>

    <div class="snb-bottom">
        <a href="${pageContext.request.contextPath}/mypage" class="snb-menu" data-snb-path="/mypage">
            <span class="snb-icon">
                <!-- mypage svg -->
                <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
            <span>마이페이지</span>
        </a>

        <a href="${pageContext.request.contextPath}/logout" class="snb-menu">
            <span class="snb-icon">
                <!-- logout svg -->
                <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
            <span>로그아웃</span>
        </a>
    </div>
</aside>