<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">생산 계획 수정</h2>
			<p class="page-subtitle">생산계획(${planDTO.planId})의 내용을 수정하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 생산계획 관리 &gt; 수정
			</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/plan/update?planId=${planDTO.planId}"
		method="post"
		class="grid-form">
		<input type="hidden" name="planDirector" value="${planDTO.planDirector}">
		<div class="btn-row">
			<div></div>
			<div class="right">
				<a class="btn btn-white" href="${pageContext.request.contextPath}/plan/detail?planId=${planDTO.planId}">
					취소
				</a>
	
				<button type="submit" class="btn btn-main">
					수정
				</button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item" style="display: flex; flex-direction: row; align-items: center; gap: 25px;">
				<label>생산 계획 중단</label>
				<div style="display: flex; justify-content: flex-start; gap: 20px; font-size: 14px;">
					<div style="display: flex; align-items: center; gap: 7px;">
						<input type="radio"<c:if test="${planDTO.planStatus == 0}">checked</c:if> onchange="checkStatus(this)"
								name="planStatus" value="-1"> 보류
					</div>
				</div>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>
					품목
				</label>
				<input type="text" value="${planDTO.planItem}" readonly>
			</div>
			<div class="grid search-item">
				<label>계획 수량 <span class="red">*</span></label>
				<input type="number" name="planFinQty" id="planQty" placeholder="계획 수량 입력" value="${planDTO.planFinQty}"
					min="1" onkeydown="blockMinus(event)" oninput="removeMinus(this)" required>
			</div>
		</div>
		
		<div class="grid-wrap date">
			<div class="grid search-item" style="min-width: 400px;">
				<label>계획 시작일 <span class="red">*</span></label>
				<input type="date" name="planSdate" id="planSdate" placeholder="계획 시작 일자" value="${planDTO.planSdate}" onchange="limitDate()" required>
			</div>
			<div class="grid search-item" style="min-width: 400px;">
				<label>계획 종료일 <span class="red">*</span></label>
				<input type="date" name="planEdate" id="planEdate" placeholder="계획 종료 일자" value="${planDTO.planEdate}" required>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item" style="width: 95%;">
				<label>전달사항</label>
				<textarea name="planDmsg" id="planDmsg" placeholder="특이사항 입력 (선택)" style="height: 200px;">${planDTO.planDmsg}</textarea>
			</div>
		</div>
	
	</form>

</div>





<style>
	input[type="radio"] {
		width: 15px;
		min-width: 15px;
		height: 15px;
	}


/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.date .search-item, .date input {
		min-width: 300px !important;
		width: 300px;
	}
}
</style>




<script>

function bind () {
	limitDate();
}


function itemList () {
	const itemTypeSelect = document.querySelector("#itemType");
	const itemSelect = document.querySelector("#itemId");
	const itemType = itemTypeSelect.value;
	
	const planQty = document.querySelector("#planQty")

	itemSelect.innerHTML =
		'<option value="" disabled selected>품목 선택</option>';

	planQty.value = "";

	fetch("${pageContext.request.contextPath}/plan/itemList?itemType=" + encodeURIComponent(itemType))
		.then(function(response) {
			return response.json();
		})
		.then(function(result) {
			let html = '<option value="" disabled selected>품목 선택</option>';
			for (let i = 0; i < result.length; i++) {
				html += '<option value="' + result[i].itemId + '">';
				html += result[i].itemName + ' (' + result[i].itemId + ')';
				html += '</option>';
			}
			itemSelect.innerHTML = html;
		})
		.catch(function() {
			alert("품목 목록 조회 실패");
		});

}

function blockMinus(e) {
	if (['-', '+', 'e', 'E', '.'].includes(e.key)) {
        e.preventDefault();
    }
}

function removeMinus(el) {
    el.value = el.value.replace(/[-+eE.]/g, '');

    if (el.value !== "" && Number(el.value) < 1) {
        el.value = 1;
    }
}

function limitDate() {
	const sdate = document.querySelector("#planSdate");
	const edate = document.querySelector("#planEdate");
	
	const startValue = sdate.value;
	
	if (!startValue) {
		edate.removeAttribute("min");
		return;
	}
	
	edate.min = startValue;
	
	if (edate.value && edate.value < startValue) {
        edate.value = "";
    }
	
	if (sdate.value) {
        edate.min = sdate.value;
    }
}

function checkStatus(checkbox) {
	let result = true;
	
	if (checkbox.checked) {
		result = confirm("계획을 보류 상태로 변경하면 다시 되돌릴 수 없습니다.\n정말로 변경하시겠습니까?");
		
		if (!result) {
			checkbox.checked = false;
		}
	}
}

</script>