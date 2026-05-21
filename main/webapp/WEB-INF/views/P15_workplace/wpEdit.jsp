<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">작업장 정보 수정</h2>
            <p class="page-subtitle">작업장 : ${wpDTO.wpName} (${wpDTO.wpId})</p>
        </div>

        <div>
            <p class="page-route">홈 > 작업장 관리 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/workplace/update"
          method="post"
          enctype="multipart/form-data"
          class="grid-form">
        <input type="hidden" name="wpId" value="${wpDTO.wpId}">
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/workplace/detail?wpId=${wpDTO.wpId}"
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
				<label>작업장 이름 <span class="red">*</span></label>
				<input type="text" name="wpName" placeholder="작업장 이름 입력" value="${wpDTO.wpName}" required>
			</div>
			
			<div class="grid search-item">
				<label>유형 <span class="red">*</span></label>
				<select name="wpTypeNo" required>
					<option value="" disabled>작업장 유형 선택</option>
	                <option value="10"
						${wpDTO.wpTypeNo == '10' ? 'selected' : ''}>
						전처리
					</option>
					<option value="20"
						${wpDTO.wpTypeNo == '20' ? 'selected' : ''}>
						배합
					</option>
					<option value="30"
						${wpDTO.wpTypeNo == '30' ? 'selected' : ''}>
						반죽
					</option>
					<option value="40"
						${wpDTO.wpTypeNo == '40' ? 'selected' : ''}>
						제피
					</option>
					<option value="50"
						${wpDTO.wpTypeNo == '50' ? 'selected' : ''}>
						성형
					</option>
					<option value="60"
						${wpDTO.wpTypeNo == '60' ? 'selected' : ''}>
						증숙
					</option>
					<option value="70"
						${wpDTO.wpTypeNo == '70' ? 'selected' : ''}>
						냉각
					</option>
					<option value="80"
						${wpDTO.wpTypeNo == '80' ? 'selected' : ''}>
						급속냉동
					</option>
					<option value="90"
						${wpDTO.wpTypeNo == '90' ? 'selected' : ''}>
						포장
					</option>
					<option value="100"
						${wpDTO.wpTypeNo == '100' ? 'selected' : ''}>
						검사
					</option>
	            </select>
			</div>
		</div>
		
		<div class="search-item">
			<input type="hidden" name="wpImg" value="${wpDTO.wpImg}">
			<input type="hidden" name="delImg" id="delImg" value="N">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			작업장 이미지 (선택)
	   		</label>
	   		<div style="display: flex; gap: 15px;">
				<input type="file" name="wpImgFile" id="wpImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" value="${wpDTO.wpImg}"
					title="${not empty wpDTO.wpImg and wpDTO.wpImg != '' ? wpDTO.wpImg : '선택된 파일 없음'}"
					placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="wpImgFile"
							style="color: white; font-size: 14px;">이미지 선택</label>
					<button type="button" class="btn btn-red" id="delImgBtn" onclick="delImgFn()">삭제</button>
				</div>
	   		</div>
			
			<div id="imgPreviewBox"
			     style="${not empty wpDTO.wpImg and wpDTO.wpImg != null ? 'display:flex;' : 'display:none;'}">
			
			    <img 
			        id="previewImg"
			        src="${pageContext.request.contextPath}${wpDTO.wpImg}"
			        alt="이미지 미리보기"
			        style="${not empty wpDTO.wpImg or wpDTO.wpImg != null ? 'display:block;' : 'display:none;'}"
			    >
			
			</div>
			
			<div id="noImg"
			     style="font-size:12px; ${not empty wpDTO.wpImg or wpDTO.wpImg != null ? 'display:none;' : 'display:block;'}">
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
		const wpImgFile = document.querySelector("#wpImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");

		wpImgFile.addEventListener("change", function () {
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
		const wpImgFile = document.querySelector("#wpImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");
		
		previewImg.src = "";
		previewImg.style.display = "none";
		imgPreviewBox.style.display = "none";
		wpImgFile.value = "";
		noImg.style.display = "block";
		fileName.value = "";
		fileName.title = "선택된 파일 없음";
		delImg.value = "Y";
	}

</script>
