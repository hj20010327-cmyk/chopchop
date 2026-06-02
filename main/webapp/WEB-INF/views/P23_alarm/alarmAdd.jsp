<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">알림 생성</h2>
			<p class="page-subtitle">사용자에게 전달할 알림을 생성합니다.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 알림관리 &gt; 생성</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/alarm/insertDo"
		method="post"
		style="width:100%; max-width:1050px;">

		<input type="hidden" name="targetType" id="targetType" value="ALL">
		<input type="hidden" name="alarmEmp" id="alarmEmp">
		<input type="hidden" name="alarmDept" id="alarmDept">
		<input type="hidden" name="alarmAuth" id="alarmAuth">

		<div style="display:flex; justify-content:flex-end; gap:12px; margin-bottom:36px;">
			<a class="btn btn-white"
				href="#">
				초기화
			</a>

			<button type="submit" class="btn btn-main">
				생성
			</button>
		</div>

		<div class="form-row">
			<div class="search-item">
				<label>알림 제목 <span class="red">*</span></label>
				<input type="text" name="alarmTitle" placeholder="알림 제목 입력">
			</div>

			<div class="search-item">
				<label>알림 유형 <span class="red">*</span></label>
				<select name="alarmTypeNo">
					<option value="">알림 유형 선택</option>
				
					<c:forEach var="type" items="${alarmTypeList}">
						<option value="${type.alarmTypeNo}">
							${type.alarmTypeName}
						</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="form-row">
			<div class="search-item">
				<label>수신 대상 구분 <span class="red">*</span></label>
				<select id="targetSelect">
					<option value="ALL">전체</option>
					<option value="EMP">사원</option>
					<option value="DEPT">부서</option>
					<option value="AUTH">권한</option>
				</select>
			</div>

			<div class="search-item target-item">
				<label>수신 대상</label>
				<div style="display:flex; gap:14px;">
					<input type="text" id="targetName" placeholder="전체" readonly>
					<button type="button" class="btn btn-main" id="targetSearchBtn">조회</button>
				</div>
			</div>
		</div>

		<div class="form-row single">
			<div class="search-item">
				<label>알림 내용 <span class="red">*</span></label>
				<textarea name="alarmContent"
					placeholder="알림 내용을 입력하세요."
					style="height:220px;"></textarea>
			</div>
		</div>

	</form>
</div>

<div class="overlay" id="targetModal">

	<div class="modal" style="width:650px;">

		<div class="modal-title">수신 대상 조회</div>

		<p class="modal-subTitle">
			수신 대상을 검색 후 선택하세요.
		</p>

		<div style="display:flex; gap:10px; margin-bottom:15px;">

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
							조회된 수신 대상이 없습니다.
						</td>
					</tr>
				</tbody>
			</table>

		</div>

		<div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px;">
			<button type="button" class="btn btn-white" id="targetModalClose">
				닫기
			</button>
		</div>

	</div>

</div>

<style>

/* 모바일 대응 */
@media (max-width: 768px) {

	form {
		max-width: 100% !important;
	}

	.form-row {
		flex-direction: column;
		gap: 16px;
		margin-bottom: 18px;
	}

	.form-row .search-item {
		width: 100%;
	}

	.form-row.single .search-item {
		width: 100%;
	}

	/* 상단 초기화/생성 버튼 */
	form > div[style*="justify-content:flex-end"] {
		gap: 8px !important;
		margin-bottom: 24px !important;
		flex-wrap: wrap;
	}

	/* 수신 대상 input + 조회 버튼 */
	.target-item > div {
		flex-direction: column;
		gap: 8px !important;
	}

	.target-item input,
	.target-item button {
		width: 100%;
	}

	textarea {
		height: 180px !important;
	}

	/* 모달 */
	.overlay {
		padding: 16px;
		box-sizing: border-box;
	}

	.modal {
		width: 100% !important;
		max-width: 100%;
		max-height: 90vh;
		overflow-y: auto;
		box-sizing: border-box;
	}

	/* 모달 검색창 */
	.modal > div[style*="display:flex"] {
		flex-direction: column;
		gap: 8px !important;
	}

	#targetKeyword {
		width: 100% !important;
	}

	#targetSearchSubmit {
		width: 100%;
	}

	.table-wrap {
		overflow-x: auto !important;
	}

	.table {
		min-width: 520px;
	}
	
	{

 

}
}

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
</style>

<script>
window.addEventListener("load", function() {

	const form = document.querySelector("form");

	const targetSelect = document.querySelector("#targetSelect");
	const targetType = document.querySelector("#targetType");
	const targetName = document.querySelector("#targetName");
	const targetSearchBtn = document.querySelector("#targetSearchBtn");

	const alarmEmp = document.querySelector("#alarmEmp");
	const alarmDept = document.querySelector("#alarmDept");
	const alarmAuth = document.querySelector("#alarmAuth");

	const targetModal = document.querySelector("#targetModal");
	const targetModalClose = document.querySelector("#targetModalClose");
	const targetKeyword = document.querySelector("#targetKeyword");
	const targetSearchSubmit = document.querySelector("#targetSearchSubmit");
	const targetTbody = document.querySelector("#targetTbody");

	applyTargetType();

	targetSelect.addEventListener("change", function() {
		applyTargetType();
	});

	targetSearchBtn.addEventListener("click", function() {
		if (targetSelect.value === "ALL") {
			alert("전체 알림은 대상 조회가 필요 없습니다.");
			return;
		}

		targetModal.style.display = "flex";
		document.body.style.overflow = "hidden";
		targetKeyword.value = "";
		loadTargetList("");
	});

	targetModalClose.addEventListener("click", function() {
		closeTargetModal();
	});

	targetModal.addEventListener("click", function(e) {
		if (e.target === targetModal) {
			closeTargetModal();
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

	form.addEventListener("submit", function(e) {
		if (!validateForm()) {
			e.preventDefault();
			return;
		}
	});

	function applyTargetType() {
		targetType.value = targetSelect.value;

		alarmEmp.value = "";
		alarmDept.value = "";
		alarmAuth.value = "";

		if (targetSelect.value === "ALL") {
			targetName.value = "전체";
			targetSearchBtn.disabled = true;
		} else {
			targetName.value = "";
			targetSearchBtn.disabled = false;
		}
	}

	function closeTargetModal() {
		targetModal.style.display = "none";
		document.body.style.overflow = "";
	}

	function loadTargetList(keyword) {

		fetch("${pageContext.request.contextPath}/alarm/targetList?targetType="
			+ encodeURIComponent(targetSelect.value)
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
					if (targetSelect.value === "EMP") {
						html += "사원";
					} else if (targetSelect.value === "DEPT") {
						html += "부서";
					} else {
						html += "권한";
					}
					html += "</td>";

					html += "<td>" + result[i].code + "</td>";
					html += "<td>" + result[i].name + "</td>";

					html += "<td>";
					html += "<input type='radio' ";
					html += "name='targetRadio' ";
					html += "value='" + result[i].code + "' ";
					html += "data-name='" + result[i].name + "'>";
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
				alert("수신 대상 조회 실패");
			});
	}

	function selectTarget() {
		const checked = document.querySelector("input[name='targetRadio']:checked");

		if (!checked) {
			alert("수신 대상을 선택하세요.");
			return;
		}

		const code = checked.value;
		const name = checked.getAttribute("data-name");

		targetName.value = name + " (" + code + ")";

		alarmEmp.value = "";
		alarmDept.value = "";
		alarmAuth.value = "";

		if (targetSelect.value === "EMP") {
			alarmEmp.value = code;
		} else if (targetSelect.value === "DEPT") {
			alarmDept.value = code;
		} else if (targetSelect.value === "AUTH") {
			alarmAuth.value = code;
		}

		closeTargetModal();
	}

	function validateForm() {
		const alarmTitle = document.querySelector("input[name='alarmTitle']");
		const alarmTypeNo = document.querySelector("select[name='alarmTypeNo']");
		const alarmContent = document.querySelector("textarea[name='alarmContent']");

		if (alarmTitle.value.trim() === "") {
			alert("알림 제목을 입력하세요.");
			alarmTitle.focus();
			return false;
		}

		if (alarmTypeNo.value === "") {
			alert("알림 유형을 선택하세요.");
			alarmTypeNo.focus();
			return false;
		}

		if (targetSelect.value !== "ALL" && targetName.value.trim() === "") {
			alert("수신 대상을 선택하세요.");
			targetSearchBtn.focus();
			return false;
		}

		if (alarmContent.value.trim() === "") {
			alert("알림 내용을 입력하세요.");
			alarmContent.focus();
			return false;
		}

		return true;
	}
	
	const urlParams = new URLSearchParams(location.search);

	const result = urlParams.get("result");

	if (result === "success") {
		alert("알림 생성이 완료되었습니다.");
	}

	else if (result === "fail") {
		alert("알림 생성에 실패했습니다.");
	}

});
</script>