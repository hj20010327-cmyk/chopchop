<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><tiles:insertAttribute name="title" ignore="true" /></title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/header.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/snb.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common/layout.css">
</head>
<body>

	<div class="app">
		<tiles:insertAttribute name="header" />

		<div class="app-body">
			<tiles:insertAttribute name="snb" />

			<main class="content">
				<tiles:insertAttribute name="content" />
			</main>
		</div>
		
		<button type="button" id="topBtn" class="btn-top" aria-label="맨 위로 이동">
		    ↑
		</button>
	</div>

	<script src="${pageContext.request.contextPath}/resources/js/common.js"></script>

</body>
</html>