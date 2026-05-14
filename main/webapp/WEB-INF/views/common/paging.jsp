<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pagination">

	<!-- 첫 페이지 -->
	<c:choose>
		<c:when test="${page.currentPage == 1}">
			<button class="disabled">&laquo;</button>
		</c:when>

		<c:otherwise>
			<a href="?page=1">&laquo;</a>
		</c:otherwise>
	</c:choose>


	<!-- 이전 -->
	<c:choose>
		<c:when test="${page.currentPage == 1}">
			<button class="disabled">&lt;</button>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.currentPage - 1}">&lt;</a>
		</c:otherwise>
	</c:choose>


	<!-- 페이지 번호 -->
	<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">

		<c:choose>

			<c:when test="${i == page.currentPage}">
				<button class="active">${i}</button>
			</c:when>

			<c:otherwise>
				<a href="?page=${i}"> ${i} </a>
			</c:otherwise>

		</c:choose>

	</c:forEach>


	<!-- 다음 -->
	<c:choose>
		<c:when test="${page.currentPage == page.maxPage}">
			<button class="disabled">&gt;</button>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.currentPage + 1}">&gt;</a>
		</c:otherwise>
	</c:choose>


	<!-- 마지막 -->
	<c:choose>
		<c:when test="${page.currentPage == page.maxPage}">
			<button class="disabled">&raquo;</button>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.maxPage}">&raquo;</a>
		</c:otherwise>
	</c:choose>

</div>

<!-- <div class="pagination"> -->

<!--     <a href="#">&laquo;</a> -->
<!--     <a href="#">&lt;</a> -->

<!--     <button class="active">1</button> -->

<!--     <a href="#">2</a> -->
<!--     <a href="#">3</a> -->
<!--     <a href="#">4</a> -->
<!--     <a href="#">5</a> -->

<!--     <a href="#">&gt;</a> -->
<!--     <a href="#">&raquo;</a> -->

<!-- </div> -->