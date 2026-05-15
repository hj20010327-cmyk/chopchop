<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="pagination">

	<!-- 첫 페이지 -->
	<c:choose>
		<c:when test="${page.currentPage == 1}">
			<a class="disabled">&laquo;</a>
		</c:when>

		<c:otherwise>
			<a href="?page=1">&laquo;</a>
		</c:otherwise>
	</c:choose>


	<!-- 이전 -->
	<c:choose>
		<c:when test="${page.currentPage == 1}">
			<a class="disabled">&lt;</a>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.currentPage - 1}">&lt;</a>
		</c:otherwise>
	</c:choose>


	<!-- 페이지 번호 -->
	<c:forEach begin="${page.startPage}" end="${page.endPage}" var="i">

		<c:choose>

			<c:when test="${i == page.currentPage}">
				<a class="active">${i}</a>
			</c:when>

			<c:otherwise>
				<a href="?page=${i}"> ${i} </a>
			</c:otherwise>

		</c:choose>

	</c:forEach>


	<!-- 다음 -->
	<c:choose>
		<c:when test="${page.currentPage == page.maxPage}">
			<a class="disabled">&gt;</a>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.currentPage + 1}">&gt;</a>
		</c:otherwise>
	</c:choose>


	<!-- 마지막 -->
	<c:choose>
		<c:when test="${page.currentPage == page.maxPage}">
			<a class="disabled">&raquo;</a>
		</c:when>

		<c:otherwise>
			<a href="?page=${page.maxPage}">&raquo;</a>
		</c:otherwise>
	</c:choose>

</div>
