<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">작업 지시 수정</h2>
			<p class="page-subtitle">선택한 작업 지시(${workDTO.workId})를 작성하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 작업관리 &gt; 지시 &gt; 수정
			</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/work/order/update?workId=${workDTO.workId}"
		method="post"
		class="grid-form"
		id="workAddForm">

		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white" href="${pageContext.request.contextPath}/work/detail?workId=${workDTO.workId}">
					취소
				</a>

				<button type="submit" class="btn btn-main">
					수정
				</button>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>생산 계획 번호</label>
				<input type="text" value="${workDTO.workPlan}" readonly>
			</div>

			<div class="grid search-item">
				<label>품목</label>
				<input type="text" id="itemInfo" value="${workDTO.workItemName} (${workDTO.workItem})" placeholder="품목명 (품목코드)" readonly>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>지시 수량 <span class="red">*</span></label>
				<input type="number"
					name="workOrderQty"
					id="workOrderQty"
					placeholder="지시 수량 입력 (최대 ${workDTO.editableMaxQty} ${workDTO.workItemUnit})"
					min="1"
					max="${workDTO.editableMaxQty}"
					onkeydown="blockNumberText(event)"
					oninput="cleanQty(this)"
					value="${workDTO.workOrderQty}"
					required>
			</div>

			<div class="grid search-item">
				<label>작업일 <span class="red">*</span></label>
				<input type="date"
					name="workDate"
					id="workDate"
					style="width: 350px;"
					min="${workDTO.planSdate}"
					max="${workDTO.planEdate}"
					value="${workDTO.workDate}"
					required>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>작업 지시자</label>
				<input type="text" value="${workDTO.workDname} (${workDTO.workDirector})" placeholder="작업 지시자" readonly>
			</div>
			<div class="grid search-item">
				<label>작업자 <span class="red">*</span></label>
				<div style="display:flex; gap:10px;">
					<input type="hidden" id="workWorker" name="workWorker" value="${workDTO.workWorker}">
					<input type="text" id="workWorkerText" placeholder="작업자 조회" readonly required
						value="${workDTO.workWname} (${workDTO.workWorker})"
						style="min-width: 310px;"
					>
					<button type="button"
						class="btn btn-main"
						id="workerSearchBtn">
						조회
					</button>
				</div>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item" style="width: 95%;">
				<label>전달사항</label>
				<textarea name="workDmsg"
					id="workDmsg"
					placeholder="작업 지시 전달사항을 입력하세요. (선택)"
					style="height: 200px;"
					>${workDTO.workDmsg}</textarea>
			</div>
		</div>

	</form>

</div>


<div class="overlay" id="workerModal">
	<div class="modal" style="width:650px;">

		<div class="modal-title">작업자 조회</div>
		<p class="modal-subTitle">작업자를 검색 후 선택하세요.</p>

		<div style="display:flex; gap:10px; margin-bottom:15px;">
			<input type="text"
				id="workerKeyword"
				placeholder="사원번호/이름 검색"
				style="width: 350px; height:36px; padding:0 12px; border:1px solid var(--dark-gray); border-radius:6px; margin: 0 auto;">
		</div>

		<div class="table-wrap" style="max-height:300px; overflow:auto;">
			<table class="table">
				<thead>
					<tr>
						<th>사원번호</th>
						<th>이름</th>
						<th>선택</th>
					</tr>
				</thead>
				<tbody id="workerTbody">
					<tr>
						<td colspan="3" style="text-align:center;">
							조회된 작업자 내역이 없습니다.
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px;">
			<button type="button" class="btn btn-white" id="workerModalClose">
				닫기
			</button>
			<button type="button" class="btn btn-main" id="workerSelectBtn">
				선택
			</button>
		</div>

	</div>
</div>


<style>
	select:disabled,
	input[readonly] {
		background-color: var(--light-gray);
		color: #000;
		cursor: not-allowed;
		outline: none;
	}

	.modal .table tbody tr:hover {
		background-color: var(--white-hover);
	}
</style>


<script>
	window.addEventListener("load", function() {
		bind();
	});
	
	function bind() {
		const workOrderQty = document.querySelector("#workOrderQty");
		const form = document.querySelector("#workAddForm");
	
		const workerSearchBtn = document.querySelector("#workerSearchBtn");
		const workerModal = document.querySelector("#workerModal");
		const workerModalClose = document.querySelector("#workerModalClose");
		const workerSelectBtn = document.querySelector("#workerSelectBtn");
		const workerKeyword = document.querySelector("#workerKeyword");
	
				form.addEventListener("submit", function(e) {
			if (!validateForm()) {
				e.preventDefault();
				return;
			}
		});
	
		workerSearchBtn.addEventListener("click", function() {
			workerModal.style.display = "flex";
			workerKeyword.value = "";
			loadWorkerList(workerKeyword.value);
		});
	
		workerModalClose.addEventListener("click", function() {
			workerModal.style.display = "none";
		});
	
		workerKeyword.addEventListener("input", function() {
			loadWorkerList(workerKeyword.value);
		});
	
		workerKeyword.addEventListener("keydown", function(e) {
			if (e.key === "Enter") {
				e.preventDefault();
				loadWorkerList(workerKeyword.value);
			}
		});
	
		workerSelectBtn.addEventListener("click", function() {
			selectWorker();
		});
	
		workOrderQty.addEventListener("input", function() {
			cleanQty(this);
		});
	}
		
	function loadWorkerList(keyword) {
		const workerTbody = document.querySelector("#workerTbody");
	
		fetch("${pageContext.request.contextPath}/work/workerList?searchKeyword="
			+ encodeURIComponent(keyword))
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {
				let html = "";
	
				for (let i = 0; i < result.length; i++) {
					html += "<tr class='workers'>";
					html += "<td>" + result[i].empId + "</td>";
					html += "<td>" + result[i].empName + "</td>";
					html += "<td>";
					html += "<input type='radio' ";
					html += "name='workerRadio' ";
					html += "value='" + result[i].empId + "' ";
					html += "data-name='" + result[i].empName + "'>";
					html += "</td>";
					html += "</tr>";
				}
	
				if (result.length === 0) {
					html =
						"<tr>" +
							"<td colspan='3' style='text-align:center;'>" +
								"검색 결과가 없습니다." +
							"</td>" +
						"</tr>";
				}
	
				workerTbody.innerHTML = html;
			
				const workers = document.querySelectorAll(".workers");
				
				for (let i = 0; i<workers.length; i++) {
					workers[i].addEventListener ("click", () => {
						const radio = workers[i].querySelector("input[type='radio']");
						radio.checked = true;
					})
				}
				
			})
			.catch(function() {
				alert("작업자 목록 조회 실패");
			});
		
	}
	
	function selectWorker() {
		const checked = document.querySelector("input[name='workerRadio']:checked");
	
		if (!checked) {
			alert("작업자를 선택하세요.");
			return;
		}
	
		const workerId = checked.value;
		const workerName = checked.getAttribute("data-name");
	
		document.querySelector("#workWorker").value = workerId;
		document.querySelector("#workWorkerText").value =
			workerName + " (" + workerId + ")";
	
		document.querySelector("#workerModal").style.display = "none";
	}
	
	function validateForm() {
		const workOrderQty = document.querySelector("#workOrderQty");
		const workDate = document.querySelector("#workDate");
		const workWorker = document.querySelector("#workWorker");

		if (workOrderQty.value === "") {
			alert("지시 수량을 입력하세요.");
			workOrderQty.focus();
			return false;
		}
	
		if (Number(workOrderQty.value) < 1) {
			alert("지시 수량은 1 이상이어야 합니다.");
			workOrderQty.focus();
			return false;
		}
	
		const maxQty = Number(workOrderQty.max);

		if (!isNaN(maxQty) && maxQty > 0 && Number(workOrderQty.value) > maxQty) {
			alert("지시 수량은 최대 " + maxQty + "개까지 입력할 수 있습니다.");
			workOrderQty.value = maxQty;
			workOrderQty.focus();
			return false;
		}
		
		if (workDate.value === "") {
			alert("작업일을 입력하세요.");
			workDate.focus();
			return false;
		}
		
		const minDate = workDate.min;
		const maxDate = workDate.max;

		if (workDate.value < minDate || workDate.value > maxDate) {
			alert("작업일은 생산계획 기간 안에서만 선택할 수 있습니다.");
			workDate.focus();
			return false;
		}
	
		if (workWorker.value === "") {
			alert("작업자를 선택하세요.");
			document.querySelector("#workerSearchBtn").focus();
			return false;
		}
	
		return true;
	}
	
	function blockNumberText(e) {
		if (["-", "+", "e", "E", "."].includes(e.key)) {
			e.preventDefault();
		}
	}
	
	function cleanQty(el) {
		const maxQty = Number(el.max);

		// 숫자 말고 제거
		el.value = el.value.replace(/[^0-9]/g, "");

		// 빈 값이면 일단 그대로 둠
		if (el.value === "") {
			return;
		}

		let qty = Number(el.value);

		// 1보다 작으면 1
		if (qty < 1) {
			el.value = 1;
			return;
		}

		// max보다 크면 max로 고정
		if (!isNaN(maxQty) && maxQty > 0 && qty > maxQty) {
			el.value = maxQty;
		}
	}
	
	function setToday() {
		const workDate = document.querySelector("#workDate");
		const today = new Date();
	
		const yyyy = today.getFullYear();
		const mm = String(today.getMonth() + 1).padStart(2, "0");
		const dd = String(today.getDate()).padStart(2, "0");
	
		workDate.value = yyyy + "-" + mm + "-" + dd;
	}
</script>