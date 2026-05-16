<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">품목 등록</h2>
			<p class="page-subtitle">새로운 품목을 등록하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 > 품목 관리 > 등록</p>

		</div>
	</div>

	<form action="${pageContext.request.contextPath}/item/insert"
		method="post" class="search-box">

		<div class="search-btn-area"
			style="width: 100%; justify-content: flex-end;">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/item/list"> 취소 </a>

			<button type="submit" class="btn btn-main">등록</button>
		</div>
		
		<label>품목명</label>
		<input type="text" name="itemName">
		
		<label>품목종류</label>
		<select name="itemType">
			<option value="10">원자재</option>
			<option value="20">반제품</option>
			<option value="30">완제품</option>
			<option>원자재</option>
		</select>
		
		<label>단위</label>
		<input type="text" name="unit">
		
		<label>규격</label>
		<input type="text" name="spec">
		
		<label>단가</label>
		<input type="number" name="unitPrice">
		
		<label>거래처</label>
		<select name="itemVendor">
			<c:forEach var="vendor" items="${vendors}">
				<option value="${vendor.vendorId}">${vendor.vendorName}</option>
			</c:forEach>
		</select>
		
		<label>유통기한</label>
		<input type="number" name="useDate">일

		<label>안전재고</label>
		<input type="number" name="safetyStock">
	</form>


</div>