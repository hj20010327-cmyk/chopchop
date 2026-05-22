<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">창고 상세</h2>
			<p class="page-subtitle">선택한 창고의 상세 정보를 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈 > 창고 관리 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/warehouse/list">
				목록으로
			</a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/warehouse/edit?whId=${whDTO.whId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/warehouse/delete?whId=${whDTO.whId}"
				onclick="return confirm('창고(${whDTO.whId})를 삭제하시겠습니까?');">
				삭제
			</a>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div class="content-content-content-title">
				창고 상세정보
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>창고</th>
							<td>${whDTO.whName} (${whDTO.whId})</td>
							<th>유형</th>
							<td>${whDTO.whTypeName}</td>
						</tr>
						<tr>
							<th>창고 위치</th>
							<td>${whDTO.whLoc}</td>
							<th>설명</th>
							<td>${whDTO.whTypeContent}</td>
						</tr>
						<tr>
							<th>수용량</th>
							<td>${whDTO.whQty} LOT</td>
							<th>적재율</th>
							<td>${whDTO.whUsageRate} %</td>
						</tr>
						<tr>
							<th>적재량</th>
							<td>${whDTO.whPrevQty} LOT</td>
							<th>마지막 점검일</th>
							<c:if test="${not empty whDTO.lastGlogDate}">
								<td>${whDTO.lastGlogDate}</td>
							</c:if>
							<c:if test="${empty whDTO.lastGlogDate}">
								<td>-</td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 내 섹션 정보
				</div>
				<div class="right">
					<a class="btn btn-main"
						href="${pageContext.request.contextPath}/warehouse/section/add?whId=${whDTO.whId}">
						섹션 추가
					</a>
				</div>
			</div>
			
			<div style="display: flex; align-items: flex-start; gap: 15px;">
				<div class="card" style="width: 80%; padding: 20px;">
					<div class="content-content-content-title">창고 영역도</div>
					<c:if test="${empty whDTO.whImg or whDTO.whImg == ''}">
						<div style="font-size: 14px; color: var(--dark-gray);">창고 영역도가 없습니다</div>
					</c:if>
					<c:if test="${not empty whDTO.whImg and whDTO.whImg != ''}">
			        	<div class="info-image">
							<img src="${pageContext.request.contextPath}${whDTO.whImg}"
								title="${whDTO.whId}_img" alt="${whDTO.whId}_img"
								 style="width: 100%;">
						</div>
					</c:if>
				</div>
				
				<div class="table-wrap">
					<table class="table">
						<thead>
							<tr>
								<th>섹션번호</th>
								<th>수용량(LOT)</th>
								<th>적재량(LOT)</th>
								<th>적재율(%)</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="sec" items="${secList}">
								<tr class="secList">
									<td class="secId">${sec.secId}</td>
									<td>${sec.secQty}</td>
									<td>${sec.secPrevQty}</td>
									<td id="qtyPer"
										style="font-weight: 700; 
										<c:if test="${sec.secUsageRate <= 0}">
											color: var(--info);
										</c:if>
										<c:if test="${sec.secUsageRate > 0 && sec.secUsageRate < 80}">
											color: var(--safe);
										</c:if>
										<c:if test="${sec.secUsageRate >= 80 && sec.secUsageRate < 100}">
											color: var(--warning);
										</c:if>
										<c:if test="${sec.secUsageRate > 100}">
											color: var(--danger);
										</c:if>
									">
									    <c:choose>
										    <c:when test="${wh.whQty != 0}">
										        <fmt:formatNumber value="${sec.secUsageRate}" pattern="0.00" />
										    </c:when>
										    <c:otherwise>
										        0.00
										    </c:otherwise>
										</c:choose>
									</td>
								</tr>	
							</c:forEach>
							
							<c:if test="${empty secList}">
								<tr>
									<td colspan="4" style="text-align: center;">
										조회된 내역이 없습니다.
									</td>
								</tr>
							</c:if>	
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="btn-row">
				<div class="left content-content-content-title">
					창고 위생점검 이력
				</div>
				<div class="right">
					<a class="btn btn-main"
						href="${pageContext.request.contextPath}/warehouse/glog/add?whId=${whDTO.whId}">
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
	.table tbody tr:hover .secId,  .table tbody tr:hover .glogId {
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
		moveSec();
	}
	
	function moveSec() {
		const secLists = document.querySelectorAll(".secList");
		
		for (let i=0; i<secLists.length; i++) {
			
			secLists[i].addEventListener("click", () => {
				const secId = secLists[i].querySelector(".secId").textContent.trim();
				console.log ("secId : " + secId);
				
				const url = `${pageContext.request.contextPath}/warehouse/section/detail?secId=` + secId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
	function moveGlog() {
		const glogLists = document.querySelectorAll(".glogList");
		
		for (let i=0; i<glogLists.length; i++) {
			
			glogLists[i].addEventListener("click", () => {
				const glogId = glogLists[i].querySelector(".glogId").textContent.trim();
				console.log ("glogId : " + glogId);
				
				const url = `${pageContext.request.contextPath}/warehouse/glog/detail?glogId=` + glogId;
				console.log ("url : " + url);
				
				window.location.href = url;
			})
		}
	}
	
</script>