<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">창고 정보 수정</h2>
            <p class="page-subtitle">창고 : ${whDTO.whName} (${whDTO.whId})</p>
        </div>

        <div>
            <p class="page-route">홈 > 창고 관리 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/warehouse/update"
          method="post"
          enctype="multipart/form-data"
          class="grid-form">
        <input type="hidden" name="whId" value="${whDTO.whId}">
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/warehouse/detail?whId=${whDTO.whId}"
	               onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
	                취소
	            </a>
	
	            <button type="submit" class="btn btn-main">
	                수정
	            </button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>유형 <span class="red">*</span></label>
				<select name="whTypeNo" required>
					<option value="" disabled>창고 유형 선택</option>
	                <option value="10"
						${whDTO.whTypeNo == '10' ? 'selected' : ''}>
						원자재 냉동창고
					</option>
					<option value="20"
						${whDTO.whTypeNo == '20' ? 'selected' : ''}>
						원자재 냉장창고
					</option>
					<option value="30"
						${whDTO.whTypeNo == '30' ? 'selected' : ''}>
						원자재 상온창고
					</option>
					<option value="40"
						${whDTO.whTypeNo == '40' ? 'selected' : ''}>
						반제품 냉장창고
					</option>
					<option value="50"
						${whDTO.whTypeNo == '50' ? 'selected' : ''}>
						반제품 냉동창고
					</option>
					<option value="60"
						${whDTO.whTypeNo == '60' ? 'selected' : ''}>
						완제품 냉동창고
					</option>
					<option value="70"
						${whDTO.whTypeNo == '70' ? 'selected' : ''}>
						기타 자재 상온창고
					</option>
					<option value="80"
						${whDTO.whTypeNo == '80' ? 'selected' : ''}>
						반품/회수품 보관창고
					</option>
					<option value="90"
						${whDTO.whTypeNo == '90' ? 'selected' : ''}>
						부적합품 보관창고
					</option>
					<option value="100"
						${whDTO.whTypeNo == '100' ? 'selected' : ''}>
						폐기 대기창고
					</option>
	            </select>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>창고 이름 <span class="red">*</span></label>
				<input type="text" name="whName" placeholder="창고 이름 입력" value="${whDTO.whName}" required>
			</div>
			<div class="grid search-item">
				<label>창고 위치 <span class="red">*</span></label>
				<input type="text" name="whLoc" placeholder="창고 위치 입력" value="${whDTO.whLoc}" required>
			</div>
		</div>
		
		<div class="search-item">
			<input type="hidden" name="whImg" value="${whDTO.whImg}">
			<input type="hidden" name="delImg" id="delImg" value="N">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			창고 이미지 (선택)
	   		</label>
	   		<div style="display: flex; gap: 15px;">
				<input type="file" name="whImgFile" id="whImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" value="${whDTO.whImg}"
						title="${not empty whDTO.whImg and whDTO.whImg != '' ? wpDTO.wpImg : '선택된 파일 없음'}"
						placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="whImgFile"
							style="color: white; font-size: 14px;">이미지 선택</label>
					<button type="button" class="btn btn-red" id="delImgBtn" onclick="delImgFn()">삭제</button>
				</div>
	   		</div>
			
			<div id="imgPreviewBox"
			     style="${not empty whDTO.whImg and whDTO.whImg != null ? 'display:flex;' : 'display:none;'}">
			
			    <img 
			        id="previewImg"
			        src="${pageContext.request.contextPath}${whDTO.whImg}"
			        alt="이미지 미리보기"
			        style="${not empty whDTO.whImg or whDTO.whImg != null ? 'display:block;' : 'display:none;'}"
			    >
			
			</div>
			
			<div id="noImg"
			     style="font-size:12px; ${not empty whDTO.whImg or whDTO.whImg != null ? 'display:none;' : 'display:block;'}">
			    등록된 사진 없음
			</div>
		</div>

    </form>

</div>

<style>
	
	.file-status {
		color: var(--dark-gray);
	}

	/* ==============================
	   addImg
	============================== */
	
	#imgPreviewBox {
	    width: 100%;
	    
	    align-items: center;
	    justify-content: flex-start;
	    overflow: hidden;
	    margin-top: 8px;
	}
	
	#noImg {
		padding: 0 15px;
	}
	
	#imgPreviewBox img {
	    width: 80%;
	    height: 100%;
	    object-fit: cover;
	}
	
</style>

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
		const whImgFile = document.querySelector("#whImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");

		whImgFile.addEventListener("change", function () {
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
		    
		    delImg.value = "N";

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
	
	function delImgFn() {
		const whImgFile = document.querySelector("#whImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");
		
		previewImg.src = "";
		previewImg.style.display = "none";
		imgPreviewBox.style.display = "none";
		whImgFile.value = "";
		noImg.style.display = "block";
		fileName.value = "";
		fileName.title = "선택된 파일 없음";
		delImg.value = "Y";
	}

</script>
