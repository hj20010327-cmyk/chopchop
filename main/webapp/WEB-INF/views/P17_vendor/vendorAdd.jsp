<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">거래처 등록</h2>
            <p class="page-subtitle">새로운 거래처를 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 거래처 관리 &gt; 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/vendor/insert"
          method="post"
          class="grid-form">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/vendor/list"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    등록
                </button>
            </div>
        </div>

        <div class="grid-wrap vendor-row">
            <div class="grid search-item vendor-type">
                <label>유형 <span class="red">*</span></label>

                <select name="vendorType" required>
                    <option value="" selected disabled>거래처 유형 선택</option>
                    <option value="S">공급업체</option>
                    <option value="C">납품처</option>
                    <option value="E">기타</option>
                </select>
            </div>

            <div class="grid search-item vendor-name">
                <label>거래처 이름 <span class="red">*</span></label>

                <input type="text"
                       name="vendorName"
                       placeholder="거래처 이름 입력"
                       required>
            </div>
        </div>

        <div class="grid-wrap vendor-row">
            <div class="grid search-item vendor-contact">
                <label>연락처 <span class="red">*</span></label>

                <input type="text"
                       name="vendorTel"
                       placeholder="연락처 입력 (ex. 010-1234-5678)"
                       required>
            </div>

            <div class="grid search-item vendor-email">
                <label>이메일</label>

                <input type="text"
                       name="vendorEmail"
                       placeholder="이메일 입력 (선택)">
            </div>
        </div>

        <div class="vendor-address-wrap">

            <div class="search-item">
                <label>주소 <span class="red">*</span></label>

                <div class="vendor-address-row">
                    <input type="text"
                           name="vendorZipcode"
                           placeholder="우편번호"
                           readonly
                           class="vendor-zipcode">

                    <input type="text"
                           name="vendorAddr"
                           placeholder="기본주소"
                           required
                           readonly
                           class="vendor-base-addr">

                    <button type="button"
                            class="btn btn-main"
                            onclick="execPostcode()">
                        조회
                    </button>
                </div>
            </div>

            <div class="search-item">
                <input type="text"
                       name="vendorAddrDetail"
                       placeholder="상세주소 입력 (선택)"
                       class="vendor-detail-addr">
            </div>

        </div>

    </form>

</div>

<style>
    .vendor-row {
        display: flex;
        align-items: flex-end;
        gap: 24px;
    }

    .vendor-type {
        width: 220px;
    }

    .vendor-type select {
        width: 100%;
        min-width: 100% !important;
    }

    .vendor-name,
    .vendor-contact,
    .vendor-email {
        flex: 1;
    }

    .vendor-name input,
    .vendor-contact input,
    .vendor-email input {
        width: 100%;
        min-width: 100% !important;
    }

    .vendor-address-wrap {
        display: flex;
        flex-direction: column;
        gap: 10px;
    }

    .vendor-address-row {
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .vendor-zipcode {
        width: 160px;
        min-width: 160px !important;
    }

    .vendor-base-addr {
        flex: 1;
        min-width: 0 !important;
    }

    .vendor-detail-addr {
        width: 100%;
        min-width: 0 !important;
    }
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function execPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            document.querySelector('input[name="vendorZipcode"]').value = data.zonecode;
            document.querySelector('input[name="vendorAddr"]').value =
                data.roadAddress || data.jibunAddress;

            document.querySelector('input[name="vendorAddrDetail"]').focus();
        }
    }).open();
}
</script>