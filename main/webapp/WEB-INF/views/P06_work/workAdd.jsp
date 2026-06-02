<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">작업 지시 등록</h2>
			<p class="page-subtitle">새로운 작업 지시를 등록하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 작업관리 &gt; 지시 &gt; 등록
			</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/work/order/insert"
		method="post"
		class="grid-form"
		id="workAddForm">

		<div class="btn-row">
			<div class="left"></div>
			<div class="right">
				<a class="btn btn-white" href="${pageContext.request.contextPath}/work/list">
					취소
				</a>

				<button type="submit" class="btn btn-main">
					등록
				</button>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>생산 계획 번호 <span class="red">*</span></label>
				<select id="workPlan" name="workPlan" required>
					<option value="" disabled selected>생산 계획 코드 선택</option>
				</select>
			</div>

			<div class="grid search-item">
				<label>품목</label>
				<input type="text" id="itemInfo" placeholder="품목명 (품목코드)" readonly>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>지시 수량 <span class="red">*</span></label>
				<input type="number"
					name="workOrderQty"
					id="workOrderQty"
					placeholder="지시 수량 입력"
					min="1"
					onkeydown="blockNumberText(event)"
					oninput="cleanQty(this)"
					required>
			</div>

			<div class="grid search-item">
				<label>작업일 <span class="red">*</span></label>
				<input type="date"
					name="workDate"
					id="workDate"
					style="width: 350px;"
					required>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>작업 지시자</label>
				<input type="hidden" name="workDirector" value="${sessionScope.loginUser.empId}" placeholder="작업 지시자">
				<input type="text" value="${sessionScope.loginUser.empName} (${sessionScope.loginUser.empId})" placeholder="작업 지시자" readonly>
			</div>
			<div class="grid search-item">
				<label>작업자 <span class="red">*</span></label>
				<div style="display:flex; gap:10px;">
					<input type="hidden" id="workWorker" name="workWorker">
					<input type="text" id="workWorkerText" placeholder="작업자 조회" readonly required
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
					style="height: 200px;"></textarea>
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
	
@media screen and (max-width: 480px) {
	.grid-wrap {
		display: flex !important;
		flex-direction: column !important;
	}
}
	
</style>


<script>
	window.addEventListener("load", function() {
		bind();
		loadPlanList();
		setToday();
	});
	
	let selectedPlan = null;
	
	function bind() {
		const workPlan = document.querySelector("#workPlan");
		const workOrderQty = document.querySelector("#workOrderQty");
		const form = document.querySelector("#workAddForm");
	
		const workerSearchBtn = document.querySelector("#workerSearchBtn");
		const workerModal = document.querySelector("#workerModal");
		const workerModalClose = document.querySelector("#workerModalClose");
// 		const workerSearchSubmit = document.querySelector("#workerSearchSubmit");
		const workerSelectBtn = document.querySelector("#workerSelectBtn");
		const workerKeyword = document.querySelector("#workerKeyword");
	
		workPlan.addEventListener("change", function() {
			applyPlanInfo();
		});
	
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
	
	
	function loadPlanList() {
		const workPlan = document.querySelector("#workPlan");
	
		workPlan.innerHTML =
			'<option value="" disabled selected>생산 계획 코드 선택</option>';
	
		fetch("${pageContext.request.contextPath}/work/planList")
			.then(function(response) {
				return response.json();
			})
			.then(function(result) {
				let html =
					'<option value="" disabled selected>생산 계획 코드 선택</option>';
	
				for (let i = 0; i < result.length; i++) {
					const plan = result[i];
	
					const remainQty =
						Number(plan.planFinQty) - Number(plan.planWorkingQty);
	
					html += '<option value="' + plan.planId + '" ';
					html += 'data-item-id="' + plan.planItem + '" ';
					html += 'data-item-name="' + plan.planItemName + '" ';
					html += 'data-item-unit="' + plan.planItemUnit + '" ';
					html += 'data-fin-qty="' + plan.planFinQty + '" ';
					html += 'data-working-qty="' + plan.planWorkingQty + '" ';
					html += 'data-remain-qty="' + remainQty + '" ';
					html += 'data-plan-sdate="' + plan.planSdateStr + '" ';
					html += 'data-plan-edate="' + plan.planEdateStr + '">';
					html += plan.planId + ' (';
					html += plan.planWorkingQty + '/' + plan.planFinQty;
					html += ')';
					html += '</option>';
				}
	
				workPlan.innerHTML = html;
			})
			.catch(function() {
				alert("생산 계획 목록 조회 실패");
			});
	}
	
	function applyPlanInfo() {
		const workPlan = document.querySelector("#workPlan");
		const itemInfo = document.querySelector("#itemInfo");
		const workOrderQty = document.querySelector("#workOrderQty");
		const workDate = document.querySelector("#workDate");

		const option = workPlan.options[workPlan.selectedIndex];

		selectedPlan = {
			planId: option.value,
			itemId: option.getAttribute("data-item-id"),
			itemName: option.getAttribute("data-item-name"),
			itemUnit: option.getAttribute("data-item-unit"),
			finQty: Number(option.getAttribute("data-fin-qty")),
			workingQty: Number(option.getAttribute("data-working-qty")),
			remainQty: Number(option.getAttribute("data-remain-qty")),
			planSdate: option.getAttribute("data-plan-sdate"),
			planEdate: option.getAttribute("data-plan-edate")
		};

		itemInfo.value =
			selectedPlan.itemName + " (" + selectedPlan.itemId + ")";

		workOrderQty.value = "";
		workOrderQty.max = selectedPlan.remainQty;
		workOrderQty.placeholder =
			"지시 수량 입력 (최대 " + selectedPlan.remainQty + " " + selectedPlan.itemUnit + ")";

		workDate.min = selectedPlan.planSdate;
		workDate.max = selectedPlan.planEdate;

		if (!workDate.value || workDate.value < selectedPlan.planSdate || workDate.value > selectedPlan.planEdate) {
			workDate.value = selectedPlan.planSdate;
		}
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
		const workPlan = document.querySelector("#workPlan");
		const workOrderQty = document.querySelector("#workOrderQty");
		const workDate = document.querySelector("#workDate");
		const workWorker = document.querySelector("#workWorker");
	
		if (workPlan.value === "") {
			alert("생산 계획 번호를 선택하세요.");
			workPlan.focus();
			return false;
		}
	
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
	
		if (selectedPlan && Number(workOrderQty.value) > selectedPlan.remainQty) {
			alert("지시 수량은 남은 수량을 초과할 수 없습니다.");
			workOrderQty.focus();
			return false;
		}
	
		if (workDate.value === "") {
			alert("작업일을 입력하세요.");
			workDate.focus();
			return false;
		}
		
		if (selectedPlan) {
			if (workDate.value < selectedPlan.planSdate || workDate.value > selectedPlan.planEdate) {
				alert("작업일은 생산계획 기간 안에서만 선택할 수 있습니다.");
				workDate.focus();
				return false;
			}
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
		el.value = el.value.replace(/[-+eE.]/g, "");
	
		if (el.value !== "" && Number(el.value) < 1) {
			el.value = 1;
		}
	
		if (selectedPlan && el.value !== "" && Number(el.value) > selectedPlan.remainQty) {
			el.value = selectedPlan.remainQty;
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