<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">작업 결과 수정</h2>
			<p class="page-subtitle">작업지시(${workDTO.workId})의 결과를 수정하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 작업관리 &gt; 결과 &gt; 수정
			</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/work/result/update?workId=${workDTO.workId}"
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
				<label>작업 지시 번호</label>
				<input type="text" value="${workDTO.workId}" readonly>
			</div>

			<div class="grid search-item">
				<label>품목</label>
				<input type="text" id="itemInfo" value="${workDTO.workItemName} (${workDTO.workItem})" placeholder="품목명 (품목코드)" readonly>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>지시 수량</label>
				<input type="number"
					id="workOrderQty"
					placeholder="지시 수량"
					value="${workDTO.workOrderQty}"
					readonly>
			</div>
			<div class="grid search-item">
				<label>작업 완료 수량 <span class="red">*</span></label>
				<input type="number"
					name="workPrevQty"
					id="workPrevQty"
					max="${workDTO.workOrderQty}"
					placeholder="현재 작업 완료 수량"
					value="${workDTO.workPrevQty}">
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item">
				<label>진행 상태 <span class="red">*</span></label>
				<select name="workStatus">
					<option value="" disabled selected>작업 진행 상태 선택</option>
					<option value="20" ${workDTO.workStatus == 20 ? 'selected' : ''}>진행 중</option>
					<option value="30" ${workDTO.workStatus == 30 ? 'selected' : ''}>완료</option>
					<option value="0" ${workDTO.workStatus == 0 ? 'selected' : ''}>보류</option>
				</select>
			</div>
		</div>

		<div class="grid-wrap">
			<div class="grid search-item" style="width: 95%;">
				<label>작업 특이사항</label>
				<textarea name="workWmsg"
					id="workWmsg"
					placeholder="작업 진행 중 발생한 특이사항을 입력하세요. (선택)"
					style="height: 200px;"
					>${workDTO.workWmsg}</textarea>
			</div>
		</div>

	</form>

</div>

<script>
	window.addEventListener("load", function() {
		bindResultEdit();
	});
	
	function bindResultEdit() {
		const form = document.querySelector("#workAddForm");
		const workPrevQty = document.querySelector("#workPrevQty");
		const workStatus = document.querySelector("select[name='workStatus']");
	
		workPrevQty.addEventListener("keydown", function(e) {
			blockNumberText(e);
		});
	
		workPrevQty.addEventListener("input", function() {
			cleanPrevQty(this);
		});
	
		form.addEventListener("submit", function(e) {
			if (!validateResultEdit()) {
				e.preventDefault();
				return;
			}
		});
	}
	
	function blockNumberText(e) {
		if (["-", "+", "e", "E", "."].includes(e.key)) {
			e.preventDefault();
		}
	}
	
	function cleanPrevQty(el) {
		const workOrderQty = Number(document.querySelector("#workOrderQty").value);
	
		// 숫자 아닌 값 제거
		el.value = el.value.replace(/[^0-9]/g, "");
	
		if (el.value === "") {
			return;
		}
	
		let prevQty = Number(el.value);
	
		// 0 미만 방지
		if (prevQty < 0) {
			el.value = 0;
			return;
		}
	
		// 작업 완료 수량이 지시 수량보다 크면 지시 수량으로 고정
		if (!isNaN(workOrderQty) && prevQty > workOrderQty) {
			el.value = workOrderQty;
		}
	}
	
	function validateResultEdit() {
		const workOrderQty = Number(document.querySelector("#workOrderQty").value);
		const workPrevQty = document.querySelector("#workPrevQty");
		const workStatus = document.querySelector("select[name='workStatus']");
	
		if (workPrevQty.value === "") {
			alert("작업 완료 수량을 입력하세요.");
			workPrevQty.focus();
			return false;
		}
	
		const prevQty = Number(workPrevQty.value);
	
		if (prevQty < 0) {
			alert("작업 완료 수량은 0 이상이어야 합니다.");
			workPrevQty.focus();
			return false;
		}
	
		if (prevQty > workOrderQty) {
			alert("작업 완료 수량은 지시 수량을 초과할 수 없습니다.");
			workPrevQty.value = workOrderQty;
			workPrevQty.focus();
			return false;
		}
	
		if (workStatus.value === "") {
			alert("진행 상태를 선택하세요.");
			workStatus.focus();
			return false;
		}
	
		// 완료 선택 시: 완료 수량 >= 지시 수량이어야 함
		if (workStatus.value === "30") {
			if (prevQty < workOrderQty) {
				alert("완료 처리하려면 작업 완료 수량이 지시 수량 이상이어야 합니다.");
				workPrevQty.focus();
				return false;
			}
	
			const ok = confirm("작업을 완료 처리하면 이후 결과 수정이 불가능합니다.\n정말 완료 처리하시겠습니까?");
			if (!ok) {
				return false;
			}
		}
	
		return true;
	}
</script>