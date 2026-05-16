<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">작업장 상세</h2>
			<p class="page-subtitle">선택한 작업장의 상세 정보를 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈 > 작업장 관리 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/workplace/list">
				목록으로
			</a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/workplace/edit?wpId=${wpDTO.wpId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/workplace/delete">
				삭제
			</a>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				작업장 상세정보
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>작업장명</th>
							<td>${wpDTO.wpName}</td>
							<th>작업장 코드</th>
							<td>${wpDTO.wpId}</td>
						</tr>
						<tr>
							<th>작업장 유형</th>
							<td>${wpDTO.wpType}</td>
							<th>관리 기준</th>
							<c:if test="${not empty wpDTO.ghpId}">
								<td>${wpDTO.ghpName} (${wpDTO.ghpId})</td>
							</c:if>
							<c:if test="${empty wpDTO.ghpId}">
								<td>-</td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				작업장 상세 이미지
			</div>
			<div class="info-image">
				
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					작업장 위생점검 이력
				</div>
				<div class="right">
					<a class="btn btn-main"
						href="${pageContext.request.contextPath}/workplace/glog/add?wpId=${wpId}">
						점검 이력 추가
					</a>
				</div>
			</div>
			
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 150px">점검 이력 번호</th>
							<th style="width: 210px">점검자</th>
							<th style="width: 100px">측정값</th>
							<th style="width: 150px">점검 결과</th>
							<th style="width: 230px">점검 일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="wp" items="${wpList}">
							<tr class="wpList">
								<td class="wpId">${wp.wpId}</td>
								<td>${wp.wpName}</td>
								<td>${wp.wpType}</td>
								<td>${wp.ghpId}</td>
								<td>${wp.wpTypeContent}</td>
							</tr>	
						</c:forEach>
						
						<c:if test="${empty wpList}">
							<tr>
								<td colspan="5" style="text-align: center;">
									조회된 내역이 없습니다.
								</td>
							</tr>
						</c:if>	
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
</div>

<script>
	
	
</script>