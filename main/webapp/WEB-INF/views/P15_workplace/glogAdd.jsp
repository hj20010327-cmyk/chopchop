<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">작업장 점검이력 등록</h2>
            <p class="page-subtitle">${wpDTO.wpName} (${wpDTO.wpId})의 새로운 점검이력을 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 작업장 관리 > 위생점검 결과 > 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/workplace/glog/insert"
          method="post"
          enctype="multipart/form-data"
          class="grid-form">
		
		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white"
	               href="${pageContext.request.contextPath}/workplace/detail?wpId=${wpDTO.wpId}">
	                취소
	            </a>
	
	            <button type="submit" class="btn btn-main">
	                등록
	            </button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item" style="display: flex; flex-direction: row; align-items: center; gap: 25px;">
				<label>점검 결과 <span class="red">*</span></label>
				<div style="display: flex; justify-content: flex-start; gap: 20px; font-size: 14px;">
					<div style="display: flex; align-items: center; gap: 7px;">
						<input type="radio" name="glogResult" value="pass" checked> 적합
					</div>
					<div style="display: flex; align-items: center; gap: 7px;">
						<input type="radio" name="glogResult" value="fail"> 부적합
					</div>
				</div>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>검사 대상</label>
<%-- 				<input type="hidden" name="ghpWpType" id="ghpWpType" value="${wpDTO.wpType}"> --%>
				<input type="hidden" name="glogWpId" value="${wpDTO.wpId}">
				<input type="text" id="ghpWp" value="${wpDTO.wpName} (${wpDTO.wpId})" placeholder="검사 대상" required readonly>
			</div>

			<div class="grid search-item">
				<label>GHP <span class="red">*</span></label>
				<select name="ghpId" id="ghpId" required>
	                <option value="" selected disabled>GHP 선택</option>
	                <c:forEach var="ghp" items="${ghpList}">
	                	<option value="${ghp.ghpId}">${ghp.ghpName} (${ghp.ghpId})</option>
	                </c:forEach>
	            </select>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>카테고리</label>
				<input type="text" id="ghpCategory" placeholder="카테고리" required readonly
						style="min-width: 200px;">
			</div>
			
			<div class="grid search-item">
				<label>관리 기준</label>
				<input type="text" id="ghpStandard" placeholder="관리 기준" required readonly
						style="min-width: 500px;">
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>최솟값</label>
				<input type="text" id="ghpMinValue" placeholder="최솟값 기준 없음" readonly>
			</div>
			
			<div class="grid search-item">
				<label>최댓값</label>
				<input type="text" id="ghpMaxValue" placeholder="최댓값 기준 없음" readonly>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>점검 일시 <span class="red">*</span></label>
				<div style="display: flex; gap: 10px;">
					<input type="date" name="glogDay" id="glogDay" placeholder="점검 날짜" required>
					<input type="time" name="glogTime" id="glogTime" placeholder="점검 시간" required>
				</div>
			</div>			
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>점검자</label>
				<!-- 수정해야 할 부분. 로그인 필터 생기면 로그인 정보 가지고 -->
				<input type="hidden" name="glogWorker" id="glogWorker" value="EMP1007">
				<input type="text" id="glogWorkerInfo" placeholder="점검자" value="김점검 (EMP1007)" required readonly>
			</div>
			
			<div class="grid search-item">
				<label>측정값 <span class="red">*</span></label>
				<input type="number" name="glogValue" id="glogValue" placeholder="측정값 입력" required>
			</div>
		</div>
				
		<div class="grid-wrap">
			<div class="grid search-item" style="width: 90%;">
				<label>비고 </label>
				<textarea name="glogMemo" id="glogMemo" placeholder="특이사항 입력 (선택)" style="height: 200px;"></textarea>
			</div>
		</div>
		
		<div class="search-item">
			<label style="font-size: 13px; font-weight: 600; color: #555;">
	   			점검 결과 이미지 (선택)
	   		</label>
	   		<div style="display: flex; gap: 15px;">
				<input type="file" name="ghpImgFile" id="ghpImgFile" accept="image/*" style="display: none;">
				<input type="text" id="fileName" placeholder="선택된 파일 없음" readonly>
				<div style="display: flex; gap: 10px;">
					<label type="button" class="btn btn-main" for="ghpImgFile"
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
		
				
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>조치 일시 (선택)</label>
				<div style="display: flex; gap: 10px;">
					<input type="date" name="glogAday" id="ghpAday">
					<input type="time" name="glogAtime" id="ghpAtime">
				</div>
			</div>			
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item" style="width: 90%;">
				<label>조치 내용 </label>
				<textarea name="glogAction" id="glogAction" placeholder="조치 내용 입력 (선택)" style="height: 200px;"></textarea>
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
	
	input[type="radio"] {
		width: 15px;
		min-width: 15px;
		height: 15px;
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
		fillGhp();
	}

	function addImg() {
		const ghpImgFile = document.querySelector("#ghpImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		const fileName = document.querySelector("#fileName");

		ghpImgFile.addEventListener("change", function () {
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
		const ghpImgFile = document.querySelector("#ghpImgFile");
		const previewImg = document.querySelector("#previewImg");
		const imgPreviewBox = document.querySelector("#imgPreviewBox");
		const noImg = document.querySelector("#noImg");
		
		previewImg.src = "";
		previewImg.style.display = "none";
		imgPreviewBox.style.display = "none";
		ghpImgFile.value = "";
		noImg.style.display = "block";
	}
	
	function fillGhp() {
		const ghpId = document.querySelector("#ghpId");
		const ghpCategory = document.querySelector("#ghpCategory");
		const ghpStandard = document.querySelector("#ghpStandard");
		const ghpMinValue = document.querySelector("#ghpMinValue");
		const ghpMaxValue = document.querySelector("#ghpMaxValue");
		
		ghpId.addEventListener("change", () => {
// 			console.log("ghpId : " + ghpId.value);
			
			if (!ghpId.value) {
				ghpCategory.value = "";
				ghpStandard.value = "";
				return;
			}

			const contextPath = "${pageContext.request.contextPath}";
			const url = contextPath + "/workplace/glog/selectGhp?ghpId=" + encodeURIComponent(ghpId.value);
			

			fetch(url, {
				method: "GET",
				headers: {
					"Accept": "application/json"
				}
			})
			.then(response => {
				if (!response.ok) {
					throw new Error("GHP 정보 조회 실패");
				}
				return response.json();
			})
			.then(data => {
				console.log(data);

				ghpCategory.value = data.ghpCategory || "";
				ghpStandard.value = data.ghpStandard || "";
				ghpMinValue.value = data.ghpMinValue || "";
				ghpMaxValue.value = data.ghpMaxValue || "";
			})
			.catch(error => {
				console.error(error);
				alert("GHP 정보를 불러오지 못했습니다.");

				ghpCategory.value = "";
				ghpStandard.value = "";
				ghpMinValue.value = "";
				ghpMaxValue.value = "";
			});
		})
			
	}

</script>
