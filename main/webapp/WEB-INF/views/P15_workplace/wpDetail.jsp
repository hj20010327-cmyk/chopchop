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
				href="${pageContext.request.contextPath}/workplace/delete?wpId=${wpDTO.wpId}">
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
							<th>마지막 점검일</th>
							<c:if test="${not empty wpDTO.lastGlogDate}">
								<td>${wpDTO.lastGlogDate}</td>
							</c:if>
							<c:if test="${empty wpDTO.lastGlogDate}">
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
			<c:if test="${empty wpDTO.wpImg or wpDTO.wpImg == null}">
				<div style="padding: 10px 40px;">상세 이미지 없음</div>
			</c:if>
			<c:if test="${not empty wpDTO.wpImg and wpDTO.wpImg != null }">
				<div class="info-image" style="padding: 10px 40px;">
					<img src="${wpDTO.wpImg}"
						title="${wpDTO.wpId}_img" alt="${wpDTO.wpId}_img"
						 style="min-width: 400px; max-width: 800px; min-height: 300px; margin: 0 auto;">
				</div>
			</c:if>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					작업장 위생점검 이력
				</div>
				<div class="right">
					<a class="btn btn-main"
						href="${pageContext.request.contextPath}/workplace/glog/add?wpId=${wpDTO.wpId}">
						점검 이력 추가
					</a>
				</div>
			</div>
			
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 150px">점검 이력 번호</th>
							<th style="width: 180px">점검자</th>
							<th style="width: 250px">점검 기준</th>
							<th style="width: 120px">점검 결과</th>
							<th style="width: 230px">점검 일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="glog" items="${glogList}">
							<tr class="glogList">
								<td class="glogId">${glog.glogId}</td>
								<td>${glog.glogWName} (${glog.glogWorker})</td>
								<td>${glog.ghpName} (${glog.ghpId})</td>
								<c:if test="${glog.glogResult eq 'pass'}">
									<td>적합</td>
								</c:if>
								<c:if test="${glog.glogResult eq 'fail'}">
									<td>부적합</td>
								</c:if>
								<c:if test="${glog.glogResult != 'fail' && glog.glogResult != 'pass'}">
									<td>-</td>
								</c:if>
								<td>${glog.glogDate}</td>
							</tr>	
						</c:forEach>
						
						<c:if test="${empty glogList}">
							<tr>
								<td colspan="5" style="text-align: center;">
									조회된 내역이 없습니다.
								</td>
							</tr>
						</c:if>	
					</tbody>
				</table>
			</div>
			
			<jsp:include page="/WEB-INF/views/common/paging.jsp" />
		</div>
	</div>
	
</div>

<style>
	.table tbody tr:hover .glogId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
</style>

<script>
	
	window.addEventListener ("load", () => {
		init();
	})
	
	function init() {
		bind();
	}
	
	function bind() {
		moveGlog();
	}
	
	function moveGlog() {
		const glogLists = document.querySelectorAll(".glogList");
		
		for (let i=0; i<glogLists.length; i++) {
			
			glogLists[i].addEventListener("click", () => {
				const glogId = glogLists[i].querySelector(".glogId").textContent.trim();
				console.log ("glogId : " + glogId);
				
				const url = `${pageContext.request.contextPath}/workplace/glog/detail?glogId=` + glogId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
</script>