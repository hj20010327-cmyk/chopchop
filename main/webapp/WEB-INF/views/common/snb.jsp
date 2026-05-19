<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="uri" value="${pageContext.request.requestURI}" />

<aside class="snb">
    <nav class="snb-nav">

        <!-- 대시보드 -->
        <a href="${ctx}/dashboard"
           class="snb-menu ${uri.contains('/dashboard') ? 'active' : ''}"
           data-snb-path="/dashboard">
            <span class="snb-icon">
                <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
            <span>대시보드</span>
        </a>

        <!-- 게시판 -->
        <div class="snb-group ${uri.contains('/notice/') || uri.contains('/suggest/') ? 'open' : ''}">
            <a href="${ctx}/notice/list"
               class="snb-menu snb-toggle ${uri.contains('/notice/') || uri.contains('/suggest/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/notice/list"
                   class="snb-submenu-link ${uri.contains('/notice/') ? 'active' : ''}">공지사항</a>
                <a href="${ctx}/suggest/list"
                   class="snb-submenu-link ${uri.contains('/suggest/') ? 'active' : ''}">건의사항</a>
            </div>
        </div>

        <!-- 생산/작업 -->
        <div class="snb-group ${uri.contains('/production/') || uri.contains('/work/') || uri.contains('/quality/') ? 'open' : ''}">
            <a href="${ctx}/production/list"
               class="snb-menu snb-toggle ${uri.contains('/production/') || uri.contains('/work/') || uri.contains('/quality/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/production/list" class="snb-submenu-link ${uri.contains('/production/') ? 'active' : ''}">생산 계획 관리</a>
                <a href="${ctx}/work/list" class="snb-submenu-link ${uri.contains('/work/') ? 'active' : ''}">작업 관리</a>
                <a href="${ctx}/quality/list" class="snb-submenu-link ${uri.contains('/quality/') ? 'active' : ''}">품질검사 관리</a>
            </div>
        </div>

        <!-- 재고 -->
        <div class="snb-group ${uri.contains('/stock/') || uri.contains('/lot/') || uri.contains('/io/') ? 'open' : ''}">
            <a href="${ctx}/io/list"
               class="snb-menu snb-toggle ${uri.contains('/stock/') || uri.contains('/lot/') || uri.contains('/io/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/stock/list" class="snb-submenu-link ${uri.contains('/stock/') ? 'active' : ''}">재고 관리</a>
                <a href="${ctx}/lot/list" class="snb-submenu-link ${uri.contains('/lot/') ? 'active' : ''}">LOT 관리</a>
                <a href="${ctx}/io/list" class="snb-submenu-link ${uri.contains('/io/') ? 'active' : ''}">입출고 관리</a>
            </div>
        </div>

        <!-- 기준정보 -->
        <div class="snb-group ${uri.contains('/item/') || uri.contains('/routing/') || uri.contains('/bom/') || uri.contains('/warehouse/') || uri.contains('/workplace/') || uri.contains('/facility/') || uri.contains('/vendor/') || uri.contains('/defect/') ? 'open' : ''}">
            <a href="${ctx}/item/list"
               class="snb-menu snb-toggle ${uri.contains('/item/') || uri.contains('/routing/') || uri.contains('/bom/') || uri.contains('/warehouse/') || uri.contains('/workplace/') || uri.contains('/facility/') || uri.contains('/vendor/') || uri.contains('/defect/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/item/list" class="snb-submenu-link ${uri.contains('/item/') ? 'active' : ''}">품목 관리</a>
                <a href="${ctx}/routing/list" class="snb-submenu-link ${uri.contains('/routing/') ? 'active' : ''}">라우팅 관리</a>
                <a href="${ctx}/bom/list" class="snb-submenu-link ${uri.contains('/bom/') ? 'active' : ''}">BOM 관리</a>
                <a href="${ctx}/warehouse/list" class="snb-submenu-link ${uri.contains('/warehouse/') ? 'active' : ''}">창고 관리</a>
                <a href="${ctx}/workplace/list" class="snb-submenu-link ${uri.contains('/workplace/') ? 'active' : ''}">작업장 관리</a>
                <a href="${ctx}/facility/list" class="snb-submenu-link ${uri.contains('/facility/') ? 'active' : ''}">설비 관리</a>
                <a href="${ctx}/vendor/list" class="snb-submenu-link ${uri.contains('/vendor/') ? 'active' : ''}">거래처 관리</a>
                <a href="${ctx}/defect/list" class="snb-submenu-link ${uri.contains('/defect/') ? 'active' : ''}">불량유형 관리</a>
            </div>
        </div>

        <!-- 리포팅 -->
        <div class="snb-group ${uri.contains('/report/') ? 'open' : ''}">
            <a href="${ctx}/report/work"
               class="snb-menu snb-toggle ${uri.contains('/report/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/report/work" class="snb-submenu-link ${uri.contains('/report/work') ? 'active' : ''}">작업 실적</a>
                <a href="${ctx}/report/quality" class="snb-submenu-link ${uri.contains('/report/quality') ? 'active' : ''}">품질 검사</a>
                <a href="${ctx}/report/inout" class="snb-submenu-link ${uri.contains('/report/inout') ? 'active' : ''}">입출고</a>
                <a href="${ctx}/report/facility" class="snb-submenu-link ${uri.contains('/report/facility') ? 'active' : ''}">설비 가동</a>
            </div>
        </div>

        <!-- 관리자 -->
        <div class="snb-group ${uri.contains('/admin/') || uri.contains('/alarm/') ? 'open' : ''}">
            <a href="${ctx}/admin/list"
               class="snb-menu snb-toggle ${uri.contains('/admin/') || uri.contains('/alarm/') ? 'active' : ''}">
                <span class="snb-icon">
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
                <a href="${ctx}/admin/list" class="snb-submenu-link ${uri.contains('/admin/') ? 'active' : ''}">사원 관리</a>
                <a href="${ctx}/alarm/add" class="snb-submenu-link ${uri.contains('/alarm/') ? 'active' : ''}">알람 생성</a>
            </div>
        </div>

    </nav>

    <div class="snb-bottom">
        <a href="${ctx}/mypage"
           class="snb-menu ${uri.contains('/mypage') ? 'active' : ''}"
           data-snb-path="/mypage">
            <span class="snb-icon">
                <svg class="snb-svg" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M1.5 13.5L12.5 13.5C13.0523 13.5 13.5 13.0523 13.5 12.5L13.5 1.5C13.5 0.947715 13.0523 0.5 12.5 0.5L1.5 0.5C0.947715 0.5 0.5 0.947715 0.5 1.5L0.5 12.5C0.5 13.0523 0.947715 13.5 1.5 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 0.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M5.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </span>
            <span>마이페이지</span>
        </a>

        <a href="${ctx}/logout" class="snb-menu">
            <span class="snb-icon">
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