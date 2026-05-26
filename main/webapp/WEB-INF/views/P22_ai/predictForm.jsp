<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">AI 품질 예측</h2>
            <p class="page-subtitle">
                생산 조건을 입력하여 품질 위험도를 예측합니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; AI 분석 &gt; AI 품질 예측
            </p>
        </div>
    </div>

    <form id="predictForm"
    	  class="search-box"
	      action="${pageContext.request.contextPath}/ai/predict"
	      method="post">
	
	    <div class="search-item">
	        <label>생산량</label>
	
	        <input type="number"
	               id="prodQty"
	               name="prodQty"
	               value="1800"
	               required>
	    </div>
	
	    <div class="search-item">
	        <label>온도(℃)</label>
	
	        <input type="number"
	               step="0.1"
	               id="temperature"
	               name="temperature"
	               value="35.5"
	               required>
	    </div>
	
	    <div class="search-item">
	        <label>습도(%)</label>
	
	        <input type="number"
	               step="0.1"
	               id="humidity"
	               name="humidity"
	               value="88.0"
	               required>
	    </div>
	
	    <div class="search-item">
	        <label>설비 가동시간</label>
	
	        <input type="number"
	               id="equipmentRuntime"
	               name="equipmentRuntime"
	               value="25"
	               required>
	    </div>
	
	    <div class="search-item">
	        <label>근무 구분</label>
	
	        <select id="workShiftNum"
	                name="workShiftNum">
	
	            <option value="0">주간</option>
	            <option value="1" selected>야간</option>
	
	        </select>
	    </div>
	
	    <div class="search-btn-area"
		     style="width:100%; justify-content:flex-end; gap:10px;">
		
		    <button type="button"
		            class="btn btn-white"
		            onclick="loadWeatherData()">
		        현재 날씨 가져오기
		    </button>
		
		    <button type="button"
		            class="btn btn-white"
		            onclick="fillNormalData()">
		        일반 조건
		    </button>
		
		    <button type="button"
		            class="btn btn-white"
		            onclick="fillDangerData()">
		        위험 조건
		    </button>
		
		    <button type="submit"
		            class="btn btn-main">
		        AI 예측 실행
		    </button>
		
		</div>
	
	</form>
	
	<div id="aiLoadingOverlay" class="ai-loading-overlay">
	    <div class="ai-loading-box">
	        <div class="ai-spinner"></div>
	
	        <strong>AI 분석 중...</strong>
	
	        <p>
	            머신러닝 모델이 입력된 생산 조건을 분석하고 있습니다.
	        </p>
	    </div>
	</div>

</div>

<style>
.ai-loading-overlay {
    display: none;

    position: fixed;
    top: 0;
    left: 0;
    z-index: 9999;

    width: 100%;
    height: 100%;

    background-color: rgba(255, 255, 255, 0.72);

    align-items: center;
    justify-content: center;
}

.ai-loading-overlay.active {
    display: flex;
}

.ai-loading-box {
    width: 360px;
    padding: 34px 28px;

    text-align: center;

    border-radius: 18px;
    background-color: #fff;
    border: 1px solid #e5e7eb;

    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}

.ai-spinner {
    width: 48px;
    height: 48px;

    margin: 0 auto 18px auto;

    border: 5px solid #e5e7eb;
    border-top-color: var(--main-green);

    border-radius: 50%;

    animation: aiSpin 0.9s linear infinite;
}

.ai-loading-box strong {
    display: block;

    margin-bottom: 10px;

    font-size: 20px;
    color: #222;
}

.ai-loading-box p {
    margin: 0;

    font-size: 14px;
    color: #666;
    line-height: 1.6;
}

@keyframes aiSpin {
    from {
        transform: rotate(0deg);
    }
    to {
        transform: rotate(360deg);
    }
}
</style>

<script>

    async function loadWeatherData() {

        try {

            const response =
                await fetch(
                    "${pageContext.request.contextPath}/ai/weather"
                );

            const data = await response.json();

            if (data.success) {

                document.getElementById("temperature").value =
                	Number(data.temp).toFixed(1);

                document.getElementById("humidity").value =
                	Number(data.humidity).toFixed(0);

                alert("현재 날씨 정보를 불러왔습니다.");

            } else {

                alert("날씨 정보를 불러오지 못했습니다.");
            }

        } catch (e) {

            alert("날씨 API 호출 중 오류가 발생했습니다.");
        }
    }

    function fillNormalData() {

        document.getElementById("prodQty").value =
            1000;

        document.getElementById("temperature").value =
            24.0;

        document.getElementById("humidity").value =
            55.0;

        document.getElementById("equipmentRuntime").value =
            8;

        document.getElementById("workShiftNum").value =
            0;
    }

    function fillDangerData() {

        document.getElementById("prodQty").value =
            1800;

        document.getElementById("temperature").value =
            35.5;

        document.getElementById("humidity").value =
            88.0;

        document.getElementById("equipmentRuntime").value =
            25;

        document.getElementById("workShiftNum").value =
            1;
    }

</script>

<script>
    document.addEventListener("DOMContentLoaded", function() {

        const predictForm =
            document.getElementById("predictForm");

        const loadingOverlay =
            document.getElementById("aiLoadingOverlay");

        predictForm.addEventListener("submit", function() {

            loadingOverlay.classList.add("active");

            const submitButton =
                predictForm.querySelector("button[type='submit']");

            submitButton.disabled = true;
            submitButton.innerText = "분석 중...";
        });
    });
</script>