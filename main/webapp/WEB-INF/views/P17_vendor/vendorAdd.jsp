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
          enctype="multipart/form-data"
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

            <div class="grid search-item vendor-name">
                <label>사업자 번호 <span class="red">*</span></label>

                <input type="text"
                       name="vendorBRN"
                       placeholder="사업자 번호 입력 (ex.000-00-00000)"
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
        
        <div class="search-item">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			사업자 등록증 <span class="red">*</span>
	   		</label>
	   		<div style="display: flex; gap: 15px;">
				<input type="file" name="venImgFile" id="venImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" title="선택된 파일 없음" placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="venImgFile"
							style="color: white; font-size: 14px;">이미지 선택</label>
					<button type="button" class="btn btn-red" id="delImgBtn" onclick="delImg()">삭제</button>
				</div>
	   		</div>
			
			<div id="imgPreviewBox" style="display: none;">
		        <img id="previewImg" src="" alt="이미지 미리보기"
		        >
			</div>
			
			<div id="noImg"
			     style="font-size:12px; display: block; margin-top: 8px;">
			    등록된 사진 없음
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
    
    #imgPreviewBox {
	    width: 100%;
	    display: none;
	    
	    align-items: center;
	    justify-content: flex-start;
	    overflow: hidden;
	    margin-top: 8px;
	}
	
	#noImg {
		padding: 0 15px;
	}
	
	#imgPreviewBox img {
	    display: none;
	    width: 80%;
	    height: 100%;
	    object-fit: cover;
	}
	
		
@media screen and (max-width: 480px) {
	.grid-wrap {
		display: flex !important;
		flex-direction: column !important;
		align-items: flex-start;
	}
	
	.grid-wrap input {
		width: 80vw !important;
	}
}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>

window.addEventListener("load", () => {
	init();
})

function init() {
	bind();
}

function bind() {
	addImg();
}

function addImg() {
	const venImgFile = document.querySelector("#venImgFile");
	const previewImg = document.querySelector("#previewImg");
	const imgPreviewBox = document.querySelector("#imgPreviewBox");
	const noImg = document.querySelector("#noImg");
	const fileName = document.querySelector("#fileName");

	venImgFile.addEventListener("change", function () {
	    const file = this.files[0];

	    if (!file) {
	        previewImg.src = "";
	        previewImg.style.display = "none";
	        imgPreviewBox.style.display = "none";
	        noImg.style.display = "block";
	        return;
	    }

	    if (!file.type.startsWith("image/")) {
	        alert("이미지 파일만 등록할 수 있습니다.");
	        this.value = "";
	        previewImg.src = "";
	        previewImg.style.display = "none";
	        imgPreviewBox.style.display = "none";
	        noImg.style.display = "block";
	        return;
	    }

	    const reader = new FileReader();

	    reader.onload = function (e) {
	        previewImg.src = e.target.result;
	        imgPreviewBox.style.display = "flex";
	        previewImg.style.display = "block";
	        noImg.style.display = "none";
	        fileName.value = e.target.result;
	        fileName.title = e.target.result;
	    };

	    reader.readAsDataURL(file);
	});
}

function delImg() {
	const venImgFile = document.querySelector("#venImgFile");
	const previewImg = document.querySelector("#previewImg");
	const imgPreviewBox = document.querySelector("#imgPreviewBox");
	const noImg = document.querySelector("#noImg");
	const fileName = document.querySelector("#fileName");
	
	previewImg.src = "";
	previewImg.style.display = "none";
	imgPreviewBox.style.display = "none";
	venImgFile.value = "";
	noImg.style.display = "block";
	fileName.value = "";
	fileName.title = "선택된 파일 없음";
}

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