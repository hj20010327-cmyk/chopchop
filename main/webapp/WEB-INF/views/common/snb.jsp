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
                <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M12.5 0.5H1.5C0.947715 0.5 0.5 0.947715 0.5 1.5V12.5C0.5 13.0523 0.947715 13.5 1.5 13.5H12.5C13.0523 13.5 13.5 13.0523 13.5 12.5V1.5C13.5 0.947715 13.0523 0.5 12.5 0.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M0.5 3.5H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M4.5 3.5V13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M13.5 8.5H4.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
            </span>
            <span>대시보드</span>
        </a>

        <!-- 게시판 -->
        <div class="snb-group ${uri.contains('/notice/') || uri.contains('/suggest/') ? 'open' : ''}">
            <a href="${ctx}/notice/list"
               class="snb-menu snb-toggle ${uri.contains('/notice/') || uri.contains('/suggest/') ? 'active' : ''}">
                <span class="snb-icon">
                    <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M5.5 12.4966C5.77635 12.2419 5.99691 11.9327 6.14777 11.5885C6.29864 11.2442 6.37652 10.8725 6.37652 10.4966C6.37652 10.1208 6.29864 9.74905 6.14777 9.40482C5.99691 9.06059 5.77635 8.75136 5.5 8.49664C5.24528 8.22029 4.93605 7.99973 4.59182 7.84887C4.24759 7.69801 3.87584 7.62012 3.5 7.62012C3.12416 7.62012 2.75241 7.69801 2.40818 7.84887C2.06395 7.99973 1.75472 8.22029 1.5 8.49664C0.5 9.49664 0.5 13.4966 0.5 13.4966C0.5 13.4966 4.5 13.4966 5.5 12.4966Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M12.92 1.07676C12.5736 0.734757 12.1143 0.530837 11.6283 0.503223C11.1423 0.475608 10.6629 0.626197 10.28 0.92676L4.49998 4.99676L3.78998 7.63676C4.44159 7.71931 5.04518 8.02287 5.49998 8.49676C5.97387 8.95156 6.27743 9.55514 6.35998 10.2068L8.99998 9.49676L13.07 3.71676C13.3705 3.33384 13.5211 2.85444 13.4935 2.36843C13.4659 1.88243 13.262 1.42317 12.92 1.07676V1.07676Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M0.5 13.4968L3.75 10.2468" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
                </span>
                <span>게시판</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${ctx}/notice/list"
                   class="snb-submenu-link ${uri.contains('/notice/') ? 'active' : ''}">공지사항</a>
                <a href="${ctx}/sugg/list"
                   class="snb-submenu-link ${uri.contains('/sugg/') ? 'active' : ''}">건의사항</a>
            </div>
        </div>

        <!-- 생산/작업 -->
        <div class="snb-group ${uri.contains('/plan/') || uri.contains('/work/') || uri.contains('/quality/') ? 'open' : ''}">
            <a href="${ctx}/plan/list"
               class="snb-menu snb-toggle ${uri.contains('/plan/') || uri.contains('/work/') || uri.contains('/quality/') ? 'active' : ''}">
                <span class="snb-icon">
                    <svg class="snb-svg" width="13" height="14" viewBox="0 0 13 14" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M4.69794 2.25L5.12794 1.14C5.20046 0.952064 5.32804 0.790411 5.49399 0.676212C5.65993 0.562014 5.8565 0.500595 6.05794 0.5H6.87794C7.07938 0.500595 7.27594 0.562014 7.44189 0.676212C7.60783 0.790411 7.73542 0.952064 7.80794 1.14L8.23794 2.25L9.69794 3.09L10.8779 2.91C11.0744 2.88333 11.2744 2.91567 11.4525 3.00292C11.6305 3.09017 11.7786 3.22838 11.8779 3.4L12.2779 4.1C12.3804 4.27435 12.4277 4.47568 12.4134 4.67742C12.3991 4.87916 12.324 5.07183 12.1979 5.23L11.4679 6.16V7.84L12.2179 8.77C12.344 8.92817 12.4191 9.12084 12.4334 9.32258C12.4477 9.52432 12.4004 9.72565 12.2979 9.9L11.8979 10.6C11.7986 10.7716 11.6505 10.9098 11.4725 10.9971C11.2944 11.0843 11.0944 11.1167 10.8979 11.09L9.71794 10.91L8.25794 11.75L7.82794 12.86C7.75542 13.0479 7.62783 13.2096 7.46189 13.3238C7.29594 13.438 7.09938 13.4994 6.89794 13.5H6.05794C5.8565 13.4994 5.65993 13.438 5.49399 13.3238C5.32804 13.2096 5.20046 13.0479 5.12794 12.86L4.69794 11.75L3.23794 10.91L2.05794 11.09C1.86145 11.1167 1.66148 11.0843 1.48342 10.9971C1.30536 10.9098 1.15726 10.7716 1.05794 10.6L0.657937 9.9C0.555439 9.72565 0.508215 9.52432 0.522497 9.32258C0.53678 9.12084 0.611898 8.92817 0.737937 8.77L1.46794 7.84V6.16L0.717937 5.23C0.591898 5.07183 0.51678 4.87916 0.502497 4.67742C0.488215 4.47568 0.535439 4.27435 0.637937 4.1L1.03794 3.4C1.13726 3.22838 1.28536 3.09017 1.46342 3.00292C1.64148 2.91567 1.84145 2.88333 2.03794 2.91L3.21794 3.09L4.69794 2.25Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M6.46796 10C8.12481 10 9.46796 8.65685 9.46796 7C9.46796 5.34315 8.12481 4 6.46796 4C4.8111 4 3.46796 5.34315 3.46796 7C3.46796 8.65685 4.8111 10 6.46796 10Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M6.46796 4V7H9.46796" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M6.46796 7L4.34796 9.12" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
                </span>
                <span>생산/작업</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${ctx}/plan/list" class="snb-submenu-link ${uri.contains('/plan/') ? 'active' : ''}">생산 계획 관리</a>
                <a href="${ctx}/work/list" class="snb-submenu-link ${uri.contains('/work/') ? 'active' : ''}">작업 관리</a>
                <a href="${ctx}/quality/list" class="snb-submenu-link ${uri.contains('/quality/') ? 'active' : ''}">품질검사 관리</a>
            </div>
        </div>

        <!-- 재고 -->
        <div class="snb-group ${uri.contains('/stock/') || uri.contains('/lot/') || uri.contains('/io/') ? 'open' : ''}">
            <a href="${ctx}/io/list"
               class="snb-menu snb-toggle ${uri.contains('/stock/') || uri.contains('/lot/') || uri.contains('/io/') ? 'active' : ''}">
                <span class="snb-icon">
                    <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M7 0.5V4.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M8.5 11H11" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M0.5 4.5H13.5V12.5C13.5 12.7652 13.3946 13.0196 13.2071 13.2071C13.0196 13.3946 12.7652 13.5 12.5 13.5H1.5C1.23478 13.5 0.98043 13.3946 0.792893 13.2071C0.605357 13.0196 0.5 12.7652 0.5 12.5V4.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M0.5 4.5L2 1.61C2.16171 1.28427 2.40917 1.0088 2.71576 0.813215C3.02235 0.617632 3.37646 0.509344 3.74 0.5H10.26C10.6321 0.500197 10.9967 0.604188 11.313 0.800279C11.6292 0.996371 11.8844 1.27679 12.05 1.61L13.5 4.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
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
                    <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M12 2H13C13.1326 2 13.2598 2.05268 13.3536 2.14645C13.4473 2.24021 13.5 2.36739 13.5 2.5V10.5C13.5 10.6326 13.4473 10.7598 13.3536 10.8536C13.2598 10.9473 13.1326 11 13 11H1C0.867392 11 0.740215 10.9473 0.646447 10.8536C0.552678 10.7598 0.5 10.6326 0.5 10.5V2.5C0.5 2.36739 0.552678 2.24021 0.646447 2.14645C0.740215 2.05268 0.867392 2 1 2H2" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M6 11L5 13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M8 11L9 13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M4 13.5H10" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M5 2.5C5 2.10444 5.1173 1.71776 5.33706 1.38886C5.55682 1.05996 5.86918 0.803617 6.23463 0.652242C6.60009 0.500867 7.00222 0.46126 7.39018 0.53843C7.77814 0.615601 8.13451 0.806082 8.41421 1.08579C8.69392 1.36549 8.8844 1.72186 8.96157 2.10982C9.03874 2.49778 8.99913 2.89992 8.84776 3.26537C8.69638 3.63082 8.44004 3.94318 8.11114 4.16294C7.78224 4.3827 7.39556 4.5 7 4.5V5.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M7 8.5C6.86193 8.5 6.75 8.38807 6.75 8.25C6.75 8.11193 6.86193 8 7 8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M7 8.5C7.13807 8.5 7.25 8.38807 7.25 8.25C7.25 8.11193 7.13807 8 7 8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
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
                <a href="${ctx}/equip/list" class="snb-submenu-link ${uri.contains('/equip/') ? 'active' : ''}">설비 관리</a>
                <a href="${ctx}/vendor/list" class="snb-submenu-link ${uri.contains('/vendor/') ? 'active' : ''}">거래처 관리</a>
                <a href="${ctx}/defect/list" class="snb-submenu-link ${uri.contains('/defect/') ? 'active' : ''}">불량유형 관리</a>
                <a href="${ctx}/ghp/list" class="snb-submenu-link ${uri.contains('/ghp/') ? 'active' : ''}">위생 관리</a>
            </div>
        </div>

        <!-- 리포팅 -->
        <div class="snb-group ${uri.contains('/report/') ? 'open' : ''}">
            <a href="${ctx}/report/work"
               class="snb-menu snb-toggle ${uri.contains('/report/') ? 'active' : ''}">
                <span class="snb-icon">
                    <svg class="snb-svg" width="11" height="14" viewBox="0 0 11 14" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M8 1.5H9.5C9.76522 1.5 10.0196 1.60536 10.2071 1.79289C10.3946 1.98043 10.5 2.23478 10.5 2.5V12.5C10.5 12.7652 10.3946 13.0196 10.2071 13.2071C10.0196 13.3946 9.76522 13.5 9.5 13.5H1.5C1.23478 13.5 0.98043 13.3946 0.792893 13.2071C0.605357 13.0196 0.5 12.7652 0.5 12.5V2.5C0.5 2.23478 0.605357 1.98043 0.792893 1.79289C0.98043 1.60536 1.23478 1.5 1.5 1.5H3" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M7 0.5H4C3.44772 0.5 3 0.947715 3 1.5V2C3 2.55228 3.44772 3 4 3H7C7.55228 3 8 2.55228 8 2V1.5C8 0.947715 7.55228 0.5 7 0.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M3 5.5H8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M3 8H8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M3 10.5H8" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					</svg>
                </span>
                <span>리포팅</span>
                <span class="snb-arrow">›</span>
            </a>

            <div class="snb-submenu">
                <a href="${ctx}/report/work" class="snb-submenu-link ${uri.contains('/report/work') ? 'active' : ''}">작업 실적</a>
                <a href="${ctx}/report/quality" class="snb-submenu-link ${uri.contains('/report/quality') ? 'active' : ''}">품질</a>
                <a href="${ctx}/report/inout" class="snb-submenu-link ${uri.contains('/report/inout') ? 'active' : ''}">입출고</a>
                <a href="${ctx}/report/facility" class="snb-submenu-link ${uri.contains('/report/facility') ? 'active' : ''}">설비</a>
            </div>
        </div>

        <!-- 관리자 -->
        <div class="snb-group ${uri.contains('/admin/') || uri.contains('/alarm/') ? 'open' : ''}">
            <a href="${ctx}/admin/list"
               class="snb-menu snb-toggle ${uri.contains('/admin/') || uri.contains('/alarm/') ? 'active' : ''}">
                <span class="snb-icon">
                    <svg class="snb-svg" width="14" height="13" viewBox="0 0 14 13" fill="none" xmlns="http://www.w3.org/2000/svg">
						<path d="M5 5C6.24264 5 7.25 3.99264 7.25 2.75C7.25 1.50736 6.24264 0.5 5 0.5C3.75736 0.5 2.75 1.50736 2.75 2.75C2.75 3.99264 3.75736 5 5 5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M9.5 12.5H0.5V11.5C0.5 10.3065 0.974106 9.16193 1.81802 8.31802C2.66193 7.47411 3.80653 7 5 7C6.19347 7 7.33807 7.47411 8.18198 8.31802C9.02589 9.16193 9.5 10.3065 9.5 11.5V12.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M9 0.5C9.59674 0.5 10.169 0.737053 10.591 1.15901C11.0129 1.58097 11.25 2.15326 11.25 2.75C11.25 3.34674 11.0129 3.91903 10.591 4.34099C10.169 4.76295 9.59674 5 9 5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
						<path d="M10.6 7.18994C11.4518 7.51399 12.1852 8.08905 12.703 8.83903C13.2209 9.58901 13.4988 10.4786 13.5 11.3899V12.4999H12" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
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
                <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M7 8C8.38071 8 9.5 6.88071 9.5 5.5C9.5 4.11929 8.38071 3 7 3C5.61929 3 4.5 4.11929 4.5 5.5C4.5 6.88071 5.61929 8 7 8Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M2.72998 11.9001C3.17622 11.1676 3.80339 10.5622 4.55119 10.1422C5.29899 9.72211 6.14227 9.50146 6.99998 9.50146C7.85769 9.50146 8.70097 9.72211 9.44877 10.1422C10.1966 10.5622 10.8237 11.1676 11.27 11.9001" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M7 13.5C10.5899 13.5 13.5 10.5899 13.5 7C13.5 3.41015 10.5899 0.5 7 0.5C3.41015 0.5 0.5 3.41015 0.5 7C0.5 10.5899 3.41015 13.5 7 13.5Z" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
            </span>
            <span>마이페이지</span>
        </a>

        <a href="${ctx}/logout" class="snb-menu">
            <span class="snb-icon">
                <svg class="snb-svg" width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg">
					<path d="M9.5 10.5V12.5C9.5 12.7652 9.39464 13.0196 9.20711 13.2071C9.01957 13.3946 8.76522 13.5 8.5 13.5H1.5C1.23478 13.5 0.98043 13.3946 0.792893 13.2071C0.605357 13.0196 0.5 12.7652 0.5 12.5V1.5C0.5 1.23478 0.605357 0.98043 0.792893 0.792893C0.98043 0.605357 1.23478 0.5 1.5 0.5H8.5C8.76522 0.5 9.01957 0.605357 9.20711 0.792893C9.39464 0.98043 9.5 1.23478 9.5 1.5V3.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M6.5 7H13.5" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
					<path d="M11.5 5L13.5 7L11.5 9" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round"/>
				</svg>
            </span>
            <span>로그아웃</span>
        </a>
    </div>
</aside>


<!-- 모바일 하단 메뉴 버튼 -->
<button type="button" class="mobile-snb-btn" id="mobileSnbBtn" aria-label="모바일 메뉴 열기">
    <span class="mobile-snb-btn-icon">☰</span>
    <span class="mobile-snb-btn-text">메뉴</span>
</button>

<!-- 모바일 메뉴 오버레이 -->
<div class="mobile-snb-overlay" id="mobileSnbOverlay"></div>

<!-- 모바일 바텀시트 메뉴 -->
<nav class="mobile-snb-sheet" id="mobileSnbSheet" aria-hidden="true">

    <div class="mobile-snb-header">
        <div>
            <p class="mobile-snb-title">전체 메뉴</p>
            <p class="mobile-snb-subtitle">CHOP FOOD MES</p>
        </div>

        <button type="button" class="mobile-snb-close" id="mobileSnbClose" aria-label="모바일 메뉴 닫기">
            ×
        </button>
    </div>

    <div class="mobile-snb-body">

        <a href="${ctx}/dashboard"
           class="mobile-snb-link ${uri.contains('/dashboard') ? 'active' : ''}">
            대시보드
        </a>

        <div class="mobile-snb-group ${uri.contains('/notice/') || uri.contains('/sugg/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>게시판</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/notice/list" class="${uri.contains('/notice/') ? 'active' : ''}">공지사항</a>
                <a href="${ctx}/sugg/list" class="${uri.contains('/sugg/') ? 'active' : ''}">건의사항</a>
            </div>
        </div>

        <div class="mobile-snb-group ${uri.contains('/plan/') || uri.contains('/work/') || uri.contains('/quality/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>생산/작업</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/plan/list" class="${uri.contains('/plan/') ? 'active' : ''}">생산 계획 관리</a>
                <a href="${ctx}/work/list" class="${uri.contains('/work/') ? 'active' : ''}">작업 관리</a>
                <a href="${ctx}/quality/list" class="${uri.contains('/quality/') ? 'active' : ''}">품질검사 관리</a>
            </div>
        </div>

        <div class="mobile-snb-group ${uri.contains('/stock/') || uri.contains('/lot/') || uri.contains('/io/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>재고</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/stock/list" class="${uri.contains('/stock/') ? 'active' : ''}">재고 관리</a>
                <a href="${ctx}/lot/list" class="${uri.contains('/lot/') ? 'active' : ''}">LOT 관리</a>
                <a href="${ctx}/io/list" class="${uri.contains('/io/') ? 'active' : ''}">입출고 관리</a>
            </div>
        </div>

        <div class="mobile-snb-group ${uri.contains('/item/') || uri.contains('/routing/') || uri.contains('/bom/') || uri.contains('/warehouse/') || uri.contains('/workplace/') || uri.contains('/equip/') || uri.contains('/vendor/') || uri.contains('/defect/') || uri.contains('/ghp/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>기준정보</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/item/list" class="${uri.contains('/item/') ? 'active' : ''}">품목 관리</a>
                <a href="${ctx}/routing/list" class="${uri.contains('/routing/') ? 'active' : ''}">라우팅 관리</a>
                <a href="${ctx}/bom/list" class="${uri.contains('/bom/') ? 'active' : ''}">BOM 관리</a>
                <a href="${ctx}/warehouse/list" class="${uri.contains('/warehouse/') ? 'active' : ''}">창고 관리</a>
                <a href="${ctx}/workplace/list" class="${uri.contains('/workplace/') ? 'active' : ''}">작업장 관리</a>
                <a href="${ctx}/equip/list" class="${uri.contains('/equip/') ? 'active' : ''}">설비 관리</a>
                <a href="${ctx}/vendor/list" class="${uri.contains('/vendor/') ? 'active' : ''}">거래처 관리</a>
                <a href="${ctx}/defect/list" class="${uri.contains('/defect/') ? 'active' : ''}">불량유형 관리</a>
                <a href="${ctx}/ghp/list" class="${uri.contains('/ghp/') ? 'active' : ''}">위생 관리</a>
            </div>
        </div>

        <div class="mobile-snb-group ${uri.contains('/report/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>리포팅</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/report/work" class="${uri.contains('/report/work') ? 'active' : ''}">작업 실적</a>
                <a href="${ctx}/report/quality" class="${uri.contains('/report/quality') ? 'active' : ''}">품질</a>
                <a href="${ctx}/report/inout" class="${uri.contains('/report/inout') ? 'active' : ''}">입출고</a>
                <a href="${ctx}/report/facility" class="${uri.contains('/report/facility') ? 'active' : ''}">설비</a>
            </div>
        </div>

        <div class="mobile-snb-group ${uri.contains('/admin/') || uri.contains('/alarm/') ? 'open' : ''}">
            <button type="button" class="mobile-snb-group-btn">
                <span>관리자</span>
                <span class="mobile-snb-arrow">›</span>
            </button>

            <div class="mobile-snb-submenu">
                <a href="${ctx}/admin/list" class="${uri.contains('/admin/') ? 'active' : ''}">사원 관리</a>
                <a href="${ctx}/alarm/add" class="${uri.contains('/alarm/') ? 'active' : ''}">알람 생성</a>
            </div>
        </div>

        <div class="mobile-snb-bottom">
            <a href="${ctx}/mypage"
               class="mobile-snb-link ${uri.contains('/mypage') ? 'active' : ''}">
                마이페이지
            </a>

            <a href="${ctx}/logout" class="mobile-snb-link logout">
                로그아웃
            </a>
        </div>

    </div>
</nav>