<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">생산 계획 등록</h2>
			<p class="page-subtitle">새로운 생산 계획을 등록하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 생산계획 관리 &gt; 등록
			</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/plan/insert"
		method="post"
		class="grid-form">
		<input type="hidden" name="planDirector" value="${sessionScope.loginUser.empId}">
		<div class="btn-row">
			<div></div>
			<div class="right">
				<a class="btn btn-white" href="${pageContext.request.contextPath}/plan/list">
					취소
				</a>
	
				<button type="submit" class="btn btn-main">
					등록
				</button>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item">
				<label>품목 유형 <span class="red">*</span></label>
				<select id="itemType" onchange="itemList()">
					<option value="" disabled selected>품목유형 선택</option>
<!-- 					<option value="10">원자재</option> -->
					<option value="20">반제품</option>
					<option value="30">완제품</option>
				</select>
			</div>
			<div class="grid search-item">
				<label>
					품목 <span class="red">*</span>
				</label>
				<select id="itemId" name="planItem" style="width: 215px;">
					<option value="" disabled selected>품목 선택</option>
				</select>

			</div>
			<div class="grid search-item">
				<label>계획 수량 <span class="red">*</span></label>
				<input type="number" name="planFinQty" id="planQty" placeholder="계획 수량 입력"
					min="1" onkeydown="blockMinus(event)" oninput="removeMinus(this)" required>
			</div>
		</div>
		
		<div class="grid-wrap date">
			<div class="grid search-item" style="min-width: 400px;">
				<label>계획 시작일 <span class="red">*</span></label>
				<input type="date" name="planSdate" id="planSdate" placeholder="계획 시작 일자" onchange="limitDate()" required>
			</div>
			<div class="grid search-item" style="min-width: 400px;">
				<label>계획 종료일 <span class="red">*</span></label>
				<input type="date" name="planEdate" id="planEdate" placeholder="계획 종료 일자" required>
			</div>
		</div>
		
		<div class="grid-wrap">
			<div class="grid search-item" style="width: 95%;">
				<label>전달사항</label>
				<textarea name="planDmsg" id="planDmsg" placeholder="특이사항 입력 (선택)" style="height: 200px;"></textarea>
			</div>
		</div>
	
	</form>

</div>

<style>


/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.date .search-item, .date input {
		min-width: 300px !important;
		width: 300px;
	}
}


@media screen and (max-width: 480px) {
	.grid-wrap {
		display: flex !important;
		flex-direction: column !important;
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

</script>