<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">위생 관리 기준 등록</h2>
			<p class="page-subtitle">새로운 위생 관리 기준을 등록하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 위생관리기준 &gt; 등록</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/ghp/insertDo"
		method="post"
		style="width:100%; max-width:1050px;">

		<input type="hidden" name="targetType" id="targetType">
		<input type="hidden" name="ghpWpType" id="ghpWpType" value="0">
		<input type="hidden" name="ghpWhType" id="ghpWhType" value="0">

		<div style="display:flex; justify-content:flex-end; gap:12px; margin-bottom:36px;">
			<a class="btn btn-white" href="${pageContext.request.contextPath}/ghp/list">취소</a>
			<button type="submit" class="btn btn-main">등록</button>
		</div>

		<div class="form-row">
			<div class="search-item">
				<label>관리 기준명 <span class="red">*</span></label>
				<input type="text" name="ghpName" placeholder="기준명 입력">
			</div>

			<div class="search-item">
				<label>분류 <span class="red">*</span></label>
				<input type="text" name="ghpCategory" placeholder="관리 기준 분류 입력">
			</div>
		</div>

		<div class="form-row">
			<div class="search-item target-item">
				<label>관리대상 <span class="red">*</span></label>
				<div style="display:flex; gap:14px;">
					<input type="text" id="targetName" placeholder="관리대상 조회" readonly>
					<button type="button" class="btn btn-main" id="targetSearchBtn">조회</button>
				</div>
			</div>
		</div>

		<div class="form-row">
			<div class="search-item">
				<label>최소 허용값</label>
				<input type="number" name="ghpMinValue" placeholder="최소 허용값 입력">
			</div>

			<div class="search-item">
				<label>최대 허용값</label>
				<input type="number" name="ghpMaxValue" placeholder="최대 허용값 입력">
			</div>
		</div>

		<div class="form-row">
			<div class="search-item">
				<label>점검 주기 <span class="red">*</span></label>
				<input type="text" name="ghpCycle" placeholder="점검 주기 입력">
			</div>

			<div class="search-item">
				<label>단위</label>
				<input type="text" name="ghpUnit" placeholder="예: ℃, %, mm">
			</div>
		</div>

		<div class="form-row single">
			<div class="search-item">
				<label>관리 기준</label>
				<textarea name="ghpStandard"
					placeholder="관리 기준을 입력하세요. (선택)"
					style="height:190px;"></textarea>
			</div>
		</div>

		<div class="form-row single">
			<div class="search-item">
				<label>점검 방법</label>
				<textarea name="ghpCheckMethod"
					placeholder="점검 방법을 입력하세요. (선택)"
					style="height:190px;"></textarea>
			</div>
		</div>

	</form>

	<div class="overlay" id="targetModal">

	<div class="modal" style="width:650px;">

		<div class="modal-title">관리대상 조회</div>

		<p class="modal-subTitle">
			관리대상을 검색 후 선택하세요.
		</p>

		<div class="search-item"
		style="display:flex; gap:10px; margin-bottom:15px; 
		justify-content: space-around;
		flex-direction: row;">

			<select id="modalTargetType"
				style="width:120px;">

				<option value="WP">작업장</option>
				<option value="WH">창고</option>

			</select>

			<input type="text"
				id="targetKeyword"
				placeholder="코드/이름 검색"
				style="width:350px;">

			<button type="button"
				class="btn btn-main"
				id="targetSearchSubmit">
				검색
			</button>

		</div>

		<div class="table-wrap"
			style="max-height:300px; overflow:auto;">

			<table class="table">

				<thead>
					<tr>
						<th>구분</th>
						<th>코드</th>
						<th>이름</th>
						<th>선택</th>
					</tr>
				</thead>

				<tbody id="targetTbody">

					<tr>
						<td colspan="4" style="text-align:center;">
							조회된 관리대상이 없습니다.
						</td>
					</tr>

				</tbody>

			</table>

		</div>

		<div style="display:flex;
			justify-content:flex-end;
			gap:10px;
			margin-top:20px;">

			<button type="button"
				class="btn btn-white"
				id="targetModalClose">
				닫기
			</button>

		</div>

	</div>

</div>
</div>

<style>
.form-row {
	width: 100%;
	display: flex;
	gap: 40px;
	margin-bottom: 26px;
}

.form-row .search-item {
	flex: 1;
	display: flex;
	flex-direction: column;
}

.form-row.single .search-item {
	width: 100%;
}

.target-item input[readonly] {
	background-color: var(--light-gray);
	cursor: not-allowed;
}

.modal .table tbody tr:hover {
	background-color: var(--white-hover);
	cursor: pointer;
}

@media screen and (max-width: 480px) {
	.form-row {
		display: flex !important;
		flex-direction: column !important;
	}
}
</style>

<script>
window.addEventListener("load", function() {

	const form = document.querySelector("form");

	const targetSearchBtn = document.querySelector("#targetSearchBtn");
	const targetModal = document.querySelector("#targetModal");
	const targetModalClose = document.querySelector("#targetModalClose");

	const modalTargetType = document.querySelector("#modalTargetType");
	const targetKeyword = document.querySelector("#targetKeyword");
	const targetSearchSubmit = document.querySelector("#targetSearchSubmit");
	const targetTbody = document.querySelector("#targetTbody");

	const targetType = document.querySelector("#targetType");
	const targetName = document.querySelector("#targetName");
	const ghpWpType = document.querySelector("#ghpWpType");
	const ghpWhType = document.querySelector("#ghpWhType");

	targetSearchBtn.addEventListener("click", function() {
		targetModal.style.display = "flex";
		document.body.style.overflow = "hidden";
		targetKeyword.value = "";
		loadTargetList("");
	});

	targetModalClose.addEventListener("click", function() {
		targetModal.style.display = "none";
		document.body.style.overflow = "";
	});
	
	targetModal.addEventListener("click", function(e) {

		if (e.target === targetModal) {
			targetModal.style.display = "none";
			document.body.style.overflow = "";
		}

	});

	targetSearchSubmit.addEventListener("click", function() {
		loadTargetList(targetKeyword.value);
	});

	targetKeyword.addEventListener("input", function() {
		loadTargetList(targetKeyword.value);
	});

	targetKeyword.addEventListener("keydown", function(e) {
		if (e.key === "Enter") {
			e.preventDefault();
			loadTargetList(targetKeyword.value);
		}
	});

	modalTargetType.addEventListener("change", function() {
		targetKeyword.value = "";
		loadTargetList("");
	});

	form.addEventListener("submit", function(e) {
		
		const targets = this.querySelectorAll("input[type=text], textarea");

	    for (let i = 0; i < targets.length; i++) {

	        if (targets[i].value.trim() === "") {

	            alert("공백만 입력할 수 없습니다.");

	            targets[i].focus();

	            e.preventDefault();
	            return false;
	        }
	    }
	    
	    document.querySelectorAll("input, textarea").forEach(el => {
	        el.addEventListener("blur", function() {
	            this.value = this.value.trim();
	        });
	    });
		
		if (!validateForm()) {
			e.preventDefault();
			return;
		}
	});

	function loadTargetList(keyword) {

		fetch("${pageContext.request.contextPath}/ghp/targetList?targetType="
			+ encodeURIComponent(modalTargetType.value)
			+ "&keyword="
			+ encodeURIComponent(keyword))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {

				let html = "";

				for (let i = 0; i < result.length; i++) {

					html += "<tr class='target-row'>";

					html += "<td>";
					html += modalTargetType.value === "WP" ? "작업장" : "창고";
					html += "</td>";

					html += "<td>";
					html += result[i].code;
					html += "</td>";

					html += "<td>";
					html += result[i].name;
					html += "</td>";

					html += "<td>";
					html += "<input type='radio' ";
					html += "name='targetRadio' ";
					html += "value='" + result[i].code + "' ";
					html += "data-name='" + result[i].name + "' ";
					html += "data-type='" + modalTargetType.value + "'>";
					html += "</td>";

					html += "</tr>";
				}

				if (result.length === 0) {
					html =
						"<tr>" +
							"<td colspan='4' style='text-align:center;'>" +
								"검색 결과가 없습니다." +
							"</td>" +
						"</tr>";
				}

				targetTbody.innerHTML = html;

				const rows = document.querySelectorAll(".target-row");

				for (let i = 0; i < rows.length; i++) {
					rows[i].addEventListener("click", function() {
						const radio = rows[i].querySelector("input[type='radio']");
						radio.checked = true;

						selectTarget();
					});
				}
			})
			.catch(function() {
				alert("관리대상 조회 실패");
			});
	}

	function selectTarget() {

		const checked = document.querySelector("input[name='targetRadio']:checked");

		if (!checked) {
			alert("관리대상을 선택하세요.");
			return;
		}

		const code = checked.value;
		const name = checked.getAttribute("data-name");
		const type = checked.getAttribute("data-type");

		targetType.value = type;
		targetName.value = name + " (" + code + ")";

		if (type === "WP") {
			ghpWpType.value = code;
			ghpWhType.value = "0";
		} else {
			ghpWhType.value = code;
			ghpWpType.value = "0";
		}

		targetModal.style.display = "none";
	}

	function validateForm() {

		const ghpName = document.querySelector("input[name='ghpName']");
		const ghpCategory = document.querySelector("input[name='ghpCategory']");
		const ghpCycle = document.querySelector("input[name='ghpCycle']");

		if (ghpName.value.trim() === "") {
			alert("관리 기준명을 입력하세요.");
			ghpName.focus();
			return false;
		}

		if (ghpCategory.value.trim() === "") {
			alert("분류를 입력하세요.");
			ghpCategory.focus();
			return false;
		}

		if (targetType.value === "") {
			alert("관리대상을 선택하세요.");
			targetSearchBtn.focus();
			return false;
		}

		if (ghpCycle.value.trim() === "") {
			alert("점검 주기를 입력하세요.");
			ghpCycle.focus();
			return false;
		}

		return true;
	}

});
</script>