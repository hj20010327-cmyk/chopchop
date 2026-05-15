<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">거래처 등록</h2>

            <p class="page-subtitle">
                새로운 거래처를 등록하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 거래처 > 등록
            </p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/vendor/insert"
          method="post"
          class="search-box">

        <div class="search-btn-area" style="width: 100%; justify-content: flex-end;">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/vendor/list">
                취소
            </a>

            <button type="submit" class="btn btn-main">
                등록
            </button>
        </div>

        <div class="search-item keyword">
            <label>거래처 이름 *</label>
            <input type="text"
                   name="vendorName"
                   placeholder="거래처 이름 입력"
                   required>
        </div>

        <div class="search-item keyword">
            <label>유형 *</label>
            <select name="vendorType" required>
                <option value="">거래처 유형 선택</option>
                <option value="S">공급업체</option>
                <option value="C">납품처</option>
                <option value="E">기타</option>
            </select>
        </div>

        <div class="search-item keyword">
            <label>연락처 *</label>
            <input type="text"
                   name="vendorTel"
                   placeholder="연락처 입력"
                   required>
        </div>

        <div class="search-item keyword">
            <label>이메일 *</label>
            <input type="email"
                   name="vendorEmail"
                   placeholder="이메일 입력"
                   required>
        </div>

        <div class="search-item keyword" style="flex-basis: 100%;">
            <label>주소 *</label>

            <div style="display: flex; gap: 8px;">
                <input type="text"
                       name="vendorAddress"
                       placeholder="주소 조회"
                       readonly
                       required>

                <button type="button" class="btn btn-main">
                    조회
                </button>
            </div>
        </div>

        <div class="search-item keyword" style="flex-basis: 100%;">
            <label>상세주소</label>
            <input type="text"
                   name="vendorAddressDetail"
                   placeholder="상세주소 입력 (선택)">
        </div>

        <div class="search-item">
            <label>우편번호</label>
            <input type="text"
                   name="vendorZipcode"
                   placeholder="우편 번호"
                   readonly>
        </div>

    </form>

</div>