<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">내 정보 수정</h2>
            <p class="page-subtitle">내 정보 ${user.empName}(${user.empId})를 수정하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 내 정보 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/mypage/update?empId=${user.empId}"
          method="post"
          enctype="multipart/form-data"
          class="grid-form">
		
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/mypage?empId=${user.empId}"
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
				<label>이름 <span class="red">*</span></label>
				<input type="text" name="empName" value="${user.empName}" placeholder="이름 입력" required>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>연락처</label>
				<input type="text" name="empTel" value="${user.empTel}" placeholder="010-0000-0000">
			</div>
			<div class="grid search-item">
				<label>이메일 <span class="red">*</span></label>
				<input type="text" name="empEmail" value="${user.empEmail}" placeholder="example@email.com" required>
			</div>
		</div>
		
		<div class="search-item">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			프로필 이미지 (선택)
	   		</label>
	   		<div style="display: flex; gap: 15px;">
	   			<input type="hidden" name="delImg" id="delImg" value="N">
				<input type="file" name="empImgFile" id="empImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" value="${user.empImg}"
						title="${not empty user.empImg and user.empImg != '' ? user.empImg : '선택된 파일 없음'}"
						placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="empImgFile"
							style="color: white; font-size: 14px;">이미지 선택</label>
					<button type="button" class="btn btn-red" id="delImgBtn" onclick="delImgFn()">삭제</button>
				</div>
	   		</div>
			
			<div id="imgPreviewBox"
				style="${not empty user.empImg or user.empImg != null ? 'display:block;' : 'display:none;'}">
		        <img id="previewImg" src="${pageContext.request.contextPath}${user.empImg}" alt="이미지 미리보기"
		        	style="${not empty user.empImg or user.empImg != null ? 'display:block;' : 'display:none;'}">
			</div>
			
			<div id="noImg"
			     style="font-size:12px; ${not empty user.empImg or user.empImg != null ? 'display:none;' : 'display:block;'}">
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
		const empImgFile = document.querySelector("#empImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");

		empImgFile.addEventListener("change", function () {
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
		const empImgFile = document.querySelector("#empImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");
		const delImg = document.querySelector("#delImg");
		
		previewImg.src = "";
		previewImg.style.display = "none";
		imgPreviewBox.style.display = "none";
		empImgFile.value = "";
		noImg.style.display = "block";
		fileName.value = "";
		fileName.title = "선택된 파일 없음";
		delImg.value = "Y";
	}
	
</script>
