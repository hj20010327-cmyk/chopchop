<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">작업장 등록</h2>
            <p class="page-subtitle">새로운 작업장을 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 작업장 관리 > 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/workplace/insert"
          method="post"
          enctype="multipart/form-data"
          class="grid-form">
		
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/workplace/list">
	                취소
	            </a>
	
	            <button type="submit" class="btn btn-main">
	                등록
	            </button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>작업장 이름 <span class="red">*</span></label>
				<input type="text" name="wpName" placeholder="작업장 이름 입력" required>
			</div>
			
			<div class="grid search-item">
				<label>유형 <span class="red">*</span></label>
				<select name="wpType" required>
	                <option value="" selected disabled>작업장 유형 선택</option>
	                <option value="10">전처리</option>
	                <option value="20">배합</option>
	                <option value="30">반죽</option>
	                <option value="40">제피</option>
					<option value="50">성형</option>
					<option value="60">증숙</option>
					<option value="70">냉각</option>
					<option value="80">급속냉동</option>
					<option value="90">포장</option>
					<option value="100">검사</option>
	            </select>
			</div>
		</div>
		
		<div class="search-item">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			작업장 이미지 (선택)
	   		</label>
	   		<div style="display: flex; gap: 15px;">
				<input type="file" name="wpImgFile" id="wpImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="wpImgFile"
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
	/* ==============================
	   addImg
	============================== */
	
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

		    const reader = new FileReader();

		    reader.onload = function (e) {
		        previewImg.src = e.target.result;
		        imgPreviewBox.style.display = "flex";
		        previewImg.style.display = "block";
		        noImg.style.display = "none";
		        fileName.value = e.target.result;
		    };

		    reader.readAsDataURL(file);
		});
	}
	
	function delImg() {
		const wpImgFile = document.querySelector("#wpImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		
		previewImg.src = "";
		previewImg.style.display = "none";
		imgPreviewBox.style.display = "none";
		wpImgFile.value = "";
		noImg.style.display = "block";
	}

</script>
