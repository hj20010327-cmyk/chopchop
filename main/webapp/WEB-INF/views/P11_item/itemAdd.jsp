<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">

		<div>
			<h2 class="page-title">품목 등록</h2>

			<p class="page-subtitle">
				새로운 품목을 등록하세요.
			</p>
		</div>

		<div>
			<p class="page-route">
				홈 &gt; 품목관리 &gt; 등록
			</p>
		</div>

	</div>

	<form action="${pageContext.request.contextPath}/item/insert"
		method="post"
		style="
			width:100%;
			max-width:1050px;
		">

		<!-- 버튼 -->
		<div style="
			display:flex;
			justify-content:flex-end;
			gap:12px;
		" class="btn-media">

			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/item/list">
				취소
			</a>

			<button type="submit"
				class="btn btn-main">
				등록
			</button>

		</div>

		<!-- 1줄 -->
		<div style="
			display:flex;
			gap:40px;
			margin-bottom:26px;
		">

			<!-- 품목명 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					품목명 <span class="red">*</span>
				</label>

				<input type="text"
					name="itemName"
					placeholder="품목명 입력"
					style="width: 48%;">
			</div>


		</div>
		
		<div style="
			display:flex;
			gap:40px;
			margin-bottom:26px;
		">
		
			<!-- 품목유형 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					품목유형 <span class="red">*</span>
				</label>

				<select name="itemType" id="itemType">

					<option value="">
						품목 유형 선택
					</option>

					<option value="10">
						원자재
					</option>

					<option value="20">
						반제품
					</option>

					<option value="30">
						완제품
					</option>
					
					<option value="40">
						기타 자재
					</option>

				</select>

			</div>
			
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">
			<label>창고 유형</label>
			<select name="itemWhType" id="itemWhType">
				<option>창고 유형 선택</option>
			</select>
			</div>
			
		</div>

		<!-- 2줄 -->
		<div style="
			display:flex;
			gap:40px;
			margin-bottom:26px;
		">

			<!-- 안전재고 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					안전재고 <span class="red">*</span>
				</label>

				<input type="text"
					name="safetyStock"
					placeholder="안전재고 입력">
			</div>

			<!-- 사용가능기간 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					사용가능기간(일) <span class="red">*</span>
				</label>

				<input type="number"
					name="useDate"
					placeholder="사용가능 기간 입력">
			</div>

		</div>

		<!-- 3줄 -->
		<div style="
			display:flex;
			gap:36px;
			margin-bottom:26px;
		">

			<!-- 단위 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					단위 <span class="red">*</span>
				</label>

				<div class="unit-wrap"
				style="position:relative; width:100%;">
			
				<input type="text"
					name="unit"
					id="unit"
					autocomplete="off"
					placeholder="단위 입력"
					style="width:100%;">
			
				<div id="unitAutoBox"
					style="
						display:none;
						position:absolute;
						top:44px;
						left:0;
						right:0;
						width:100%;
						background:white;
						border:1px solid #ddd;
						border-radius:6px;
						z-index:1000;
						max-height:160px;
						overflow-y:auto;
						box-sizing:border-box;
					">
				</div>
			
			</div>
			</div>

			<!-- 규격 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					규격 <span class="red">*</span>
				</label>


					<div class="spec-wrap"
						style="position:relative; width:100%;">
					
						<input type="text"
							name="spec"
							id="spec"
							autocomplete="off"
							placeholder="규격 입력"
							style="width:100%;">
					
						<div id="specAutoBox"
							style="
								display:none;
								position:absolute;
								top:44px;
								left:0;
								right:0;
								width:100%;
								background:white;
								border:1px solid #ddd;
								border-radius:6px;
								z-index:1000;
								max-height:160px;
								overflow-y:auto;
								box-sizing:border-box;
							">
						</div>
					
					</div>
			</div>

			<!-- 단가 -->
			<div style="
				display:flex;
				flex-direction:column;
				flex:1;
			" class="search-item">

				<label>
					단가(원) <span class="red">*</span>
				</label>

				<input type="text"
					name="unitPrice"
					placeholder="단가 입력">
			</div>

		</div>

		

	</form>

</div>
<script>
window.addEventListener("load", function() {

	/* =========================
		단위 자동완성
	========================= */

	const unitInput = document.querySelector("#unit");
	const unitAutoBox = document.querySelector("#unitAutoBox");

	let unitArray = [];

	fetch("${pageContext.request.contextPath}/item/unitList")
		.then(function(response) {
			return response.json();
		})
		.then(function(result) {

			unitArray = result.map(function(row) {

				if (typeof row === "string") {
					return row;
				}

				return row.unit;
			});

			console.log("단위 목록:", unitArray);
		})
		.catch(function(error) {
			console.log("단위 목록 조회 실패", error);
		});

	function showUnitList() {

		const keyword = unitInput.value.trim().toUpperCase();

		unitAutoBox.innerHTML = "";

		let filtered = unitArray.filter(function(unit) {

			if (!unit) {
				return false;
			}

			if (keyword === "") {
				return true;
			}

			return unit.toUpperCase().indexOf(keyword) !== -1;
		});

		if (filtered.length === 0) {
			unitAutoBox.style.display = "none";
			return;
		}

		let html = "";

		for (let i = 0; i < filtered.length; i++) {

			html += '<div class="unit-option" ';
			html += 'style="padding:10px 12px; cursor:pointer; font-size:13px;">';
			html += filtered[i];
			html += '</div>';
		}

		unitAutoBox.innerHTML = html;
		unitAutoBox.style.display = "block";
	}

	unitInput.addEventListener("focus", showUnitList);
	unitInput.addEventListener("input", showUnitList);

	unitAutoBox.addEventListener("click", function(e) {

		const option = e.target.closest(".unit-option");

		if (!option) {
			return;
		}

		unitInput.value = option.innerText;
		unitAutoBox.style.display = "none";
	});


	/* =========================
		규격 자동완성
	========================= */

	const specInput = document.querySelector("#spec");
	const specAutoBox = document.querySelector("#specAutoBox");

	let specArray = [];

	fetch("${pageContext.request.contextPath}/item/specList")
		.then(function(response) {
			return response.json();
		})
		.then(function(result) {

			// result 예시:
			// [{spec:"50EA, 5kg", itemName:"새우만두"}, ...]
			specArray = result;

		})
		.catch(function(error) {
			console.log("규격 목록 조회 실패", error);
		});

	function showSpecList() {

		const keyword = specInput.value.trim().toUpperCase();

		specAutoBox.innerHTML = "";

		let filtered = specArray.filter(function(specObj) {

			const spec =
				specObj.spec || specObj.SPEC;

			if (!spec) {
				return false;
			}

			if (keyword === "") {
				return true;
			}

			return spec.toUpperCase().indexOf(keyword) !== -1;
		});

		if (filtered.length === 0) {
			specAutoBox.style.display = "none";
			return;
		}

		let html = "";

		for (let i = 0; i < filtered.length; i++) {

			const spec =
				filtered[i].spec || filtered[i].SPEC;

			const itemName =
				filtered[i].itemName || filtered[i].ITEMNAME;

			html += '<div class="spec-option" ';
			html += 'data-spec="' + spec + '" ';
			html += 'style="padding:10px 12px; cursor:pointer; font-size:13px;">';

			html += '<span style="font-weight:600;">';
			html += spec;
			html += '</span>';

			html += '<span style="color:#888; margin-left:8px;">';
			html += itemName;
			html += '</span>';

			html += '</div>';
		}

		specAutoBox.innerHTML = html;
		specAutoBox.style.display = "block";
	}

	specInput.addEventListener("focus", showSpecList);
	specInput.addEventListener("input", showSpecList);

	specAutoBox.addEventListener("click", function(e) {

		const option = e.target.closest(".spec-option");

		if (!option) {
			return;
		}

		// 화면에는 대표 품목을 보여주지만 input에는 규격만 넣음
		specInput.value = option.dataset.spec;
		specAutoBox.style.display = "none";
	});


	/* =========================
		바깥 클릭 시 자동완성 닫기
	========================= */

	document.addEventListener("click", function(e) {

		if (!unitInput.contains(e.target)
			&& !unitAutoBox.contains(e.target)) {

			unitAutoBox.style.display = "none";
		}

		if (!specInput.contains(e.target)
			&& !specAutoBox.contains(e.target)) {

			specAutoBox.style.display = "none";
		}
	});


	/* =========================
		단가 콤마
	========================= */

	const unitPriceInput =
		document.querySelector("input[name='unitPrice']");

	unitPriceInput.addEventListener("input", function() {

		let value = this.value;

		value = value.replace(/[^0-9]/g, "");

		value = Number(value).toLocaleString("ko-KR");

		if (value === "0") {
			this.value = "";
		} else {
			this.value = value;
		}
	});


	/* =========================
		안전재고 콤마
	========================= */

	const safetyStockInput =
		document.querySelector("input[name='safetyStock']");

	safetyStockInput.addEventListener("input", function() {

		let value = this.value;

		value = value.replace(/[^0-9]/g, "");

		value = Number(value).toLocaleString("ko-KR");

		if (value === "0") {
			this.value = "";
		} else {
			this.value = value;
		}
	});


	/* =========================
		음수 입력 방지
	========================= */

	const useDateInput =
		document.querySelector("input[name='useDate']");

	function preventNegative(inputTag) {

		inputTag.addEventListener("input", function() {

			if (this.value < 0) {
				this.value = 0;
			}
		});

		inputTag.addEventListener("keydown", function(e) {

			if (e.key === "-") {
				e.preventDefault();
			}
		});
	}

	preventNegative(safetyStockInput);
	preventNegative(useDateInput);


	/* =========================
		폼 전송 전 콤마 제거
	========================= */

	const form = document.querySelector("form");

	form.addEventListener("submit", function() {

		    const targets = this.querySelectorAll("input[type=text], textarea");

		    for (let i = 0; i < targets.length; i++) {

		        if (targets[i].value.trim() === "") {

		            alert("공백만 입력할 수 없습니다.");

		            targets[i].focus();

		            e.preventDefault();
		            return false;
		        }
		    }
		});
		
		document.querySelectorAll("input, textarea").forEach(el => {
		    el.addEventListener("blur", function() {
		        this.value = this.value.trim();
		    });
		});

		unitPriceInput.value =
			unitPriceInput.value.replace(/,/g, "");

		safetyStockInput.value =
			safetyStockInput.value.replace(/,/g, "");
	});


	/* =========================
		품목 유형별 창고 유형
	========================= */

	const itemTypeSelect =
		document.querySelector("#itemType");

	const whTypeSelect =
		document.querySelector("#itemWhType");

	itemTypeSelect.addEventListener("change", function() {

		const itemType = this.value;

		let html =
			'<option value="">창고 유형 선택</option>';

		if (itemType === "10") {

			html += '<option value="10">원자재냉동창고</option>';
			html += '<option value="20">원자재냉장창고</option>';
			html += '<option value="30">원자재상온창고</option>';

		} else if (itemType === "20") {

			html += '<option value="40">반제품냉장창고</option>';
			html += '<option value="50">반제품냉동창고</option>';

		} else if (itemType === "30") {

			html += '<option value="60">완제품창고</option>';

		} else if (itemType === "40") {

			html += '<option value="70">기타 자재 창고</option>';
		}

		whTypeSelect.innerHTML = html;
	});

});
</script>

<style>
@media screen and (max-width: 768px) {

	.content {
		padding: 16px;
		box-sizing: border-box;
	}

	.header-row {
		flex-direction: column;
		gap: 12px;
	}

	.page-title {
		font-size: 22px;
	}

	.page-subtitle {
		font-size: 13px;
	}

	.page-route {
		font-size: 12px;
	}

	form {
		width: 100% !important;
		max-width: 100% !important;
	}

	/* 버튼 영역 */
	.btn-media {
		display: flex !important;
		justify-content: flex-end !important;
		flex-direction: row !important;
		gap: 8px !important;
	}

	form > div:first-child .btn {
		text-align: center;
	}

	/* 모든 행 세로 배치 */
	form > div[style*="display:flex"]:not(.btn-media) {
		flex-direction: column !important;
		gap: 14px !important;
		margin-bottom: 14px !important;
	}

	.search-item {
		width: 100%;
	}

	.search-item input,
	.search-item select {
		width: 100% !important;
		box-sizing: border-box;
	}

	/* 품목명 48% 제거 */
	input[name="itemName"] {
		width: 100% !important;
	}

	/* 자동완성 */
	#unitAutoBox,
	#specAutoBox {
		max-height: 140px;
		font-size: 12px;
	}

	label {
		font-size: 13px;
	}

	input,
	select {
		font-size: 14px;
		min-height: 30px;
	}

	.unit-option,
	.spec-option {
		padding: 8px 10px !important;
		font-size: 12px !important;
	}
}
</style>