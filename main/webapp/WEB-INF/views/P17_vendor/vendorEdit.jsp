<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">거래처 수정</h2>
            <p class="page-subtitle">
                ${vendor.vendorName}(${vendor.vendorId})의 정보를 수정할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 거래처 관리 &gt; 수정
            </p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/vendor/update"
          method="post"
          class="grid-form">

        <input type="hidden"
               name="vendorId"
               value="${vendor.vendorId}">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/vendor/detail?vendorId=${vendor.vendorId}">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    수정
                </button>
            </div>
        </div>

        <div class="grid-wrap vendor-row">
            <div class="grid search-item vendor-type">
                <label>유형 <span class="red">*</span></label>

                <select name="vendorType" required>
                    <option value="S"
                        ${vendor.vendorType == 'S' ? 'selected' : ''}>
                        공급업체
                    </option>

                    <option value="C"
                        ${vendor.vendorType == 'C' ? 'selected' : ''}>
                        납품처
                    </option>

                    <option value="E"
                        ${vendor.vendorType == 'E' ? 'selected' : ''}>
                        기타
                    </option>
                </select>
            </div>

            <div class="grid search-item vendor-name">
                <label>거래처 이름 <span class="red">*</span></label>

                <input type="text"
                       name="vendorName"
                       value="${vendor.vendorName}"
                       required>
            </div>
        </div>

        <div class="grid-wrap vendor-row">
            <div class="grid search-item vendor-contact">
                <label>연락처 <span class="red">*</span></label>

                <input type="text"
                       name="vendorTel"
                       value="${vendor.vendorTel}"
                       required>
            </div>

            <div class="grid search-item vendor-email">
                <label>이메일</label>

                <input type="text"
                       name="vendorEmail"
                       value="${vendor.vendorEmail}">
            </div>
        </div>

        <div class="vendor-address-wrap">

            <div class="search-item">
                <label>주소 <span class="red">*</span></label>

                <div class="vendor-address-row">
                    <input type="text"
                           name="vendorZipcode"
                           value="${vendor.vendorZipcode}"
                           placeholder="우편번호"
                           readonly
                           class="vendor-zipcode">

                    <input type="text"
                           name="vendorAddr"
                           value="${vendor.vendorAddr}"
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
                       value="${vendor.vendorAddrDetail}"
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