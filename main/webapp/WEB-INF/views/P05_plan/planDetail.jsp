<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">생산 계획 상세</h2>
			<p class="page-subtitle">생산 계획의 상세 정보와 작업 지시 목록을 조회할 수 있습니다.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 생산계획 &gt; 상세
			</p>
		</div>
	</div>

	<div class="btn-row">
		<div>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/plan/list">
				목록
			</a>
		</div>
		<div>
			<a class="btn btn-main" href="${pageContext.request.contextPath}/plan/edit?planId=${planDTO.planId}">
				수정
			</a>
			<a class="btn btn-red" href="${pageContext.request.contextPath}/plan/delete?planId=${planDTO.planId}"
				onclick="return confirm('생산 계획을 삭제하시겠습니까?');">
				삭제
			</a>
		</div>
	</div>

	<div class="content-content" style="display: flex; flex-direction: column; gap: 20px;">

		<div class="content-content-content">
			<div class="detail-title-row">
				<div class="content-content-content-title">생산 계획 상세정보</div>
				<div>
					<c:choose>
						<c:when test="${planDTO.planStatus == 10}">
							<span class="status-back status-back-warning">• 대기중</span>
						</c:when>
						<c:when test="${planDTO.planStatus == 20}">
							<span class="status-back status-back-success">• 작업중</span>
						</c:when>
						<c:when test="${planDTO.planStatus == 30}">
							<span class="status-back status-back-safe">• 완료</span>
						</c:when>
						<c:when test="${planDTO.planStatus == 40}">
							<span class="status-back status-back-danger">• 지연</span>
						</c:when>
						<c:when test="${planDTO.planStatus == 0}">
							<span class="status-back status-back-info">• 보류</span>
						</c:when>
						<c:otherwise>
							<span class="status-back status-back-info">• 기타</span>
						</c:otherwise>
					</c:choose>
				</div>
			</div>

			<div class="info-table-wrap">
				<table class="info-table">
					<tr>
						<th>계획번호</th>
						<td>${planDTO.planId}</td>
						<th>담당자</th>
						<td>
							<c:choose>
								<c:when test="${empty planDTO.planDname}">
									${planDTO.planDirector}
								</c:when>
								<c:otherwise>
									${planDTO.planDname}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>품목</th>
						<td>
							<a class="toDetail" href="${pageContext.request.contextPath}/item/detail?itemId=${planDTO.planItem}">
								${planDTO.planItemName} (${planDTO.planItem})
							</a>
						</td>
						<th>등록일시</th>
						<td>
							<fmt:formatDate value="${planDTO.planCdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
					<tr>
						<th>계획수량</th>
						<td>
							<fmt:formatNumber value="${planDTO.planFinQty}" pattern="#,###"/> ${planDTO.planItemUnit}
						</td>
						<th>기간</th>
						<td>
							${fn:substring(planDTO.planSdate, 0, 10)} ~ ${fn:substring(planDTO.planEdate, 0, 10)}
						</td>
					</tr>
					<tr>
						<th>현재완료수량</th>
						<td>
							<fmt:formatNumber value="${planDTO.planWpQty}" pattern="#,###"/> ${planDTO.planItemUnit}
						</td>
						<th>작업예정수량</th>
						<td>
							<fmt:formatNumber value="${planDTO.planWorkingQty}" pattern="#,###"/> ${planDTO.planItemUnit}
						</td>
					</tr>
					<tr>
						<th colspan="4" style="text-align:left; background:#fafafa;">
							지시 전달사항
						</th>
					</tr>
					<tr>
						<td colspan="4" style="height:80px; text-align:left; vertical-align:top; padding-top:14px;">
							<c:choose>
								<c:when test="${empty planDTO.planDmsg or planDTO.planDmsg == ''}">
									내용없음
								</c:when>
								<c:otherwise>
									${planDTO.planDmsg}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>
			
			<div style="padding: 20px;">
				<div class="progress-title-row">
					<h3 style="font-weight: 700; font-size: 16px; margin: 0">작업 완료률</h3>
					<div class="progress-text">
						<span>${planDTO.progressRate}%</span>
						(<fmt:formatNumber value="${planDTO.planWpQty}" pattern="#,###"/>
						 / <fmt:formatNumber value="${planDTO.planFinQty}" pattern="#,###"/>)
					</div>
				</div>
	
				<div class="progress-wrap">
					<div class="progress-bar" style="width:${planDTO.progressRate}%;"></div>
				</div>
			</div>
		</div>


		<div class="content-content-content">
			<div class="content-content-content-title">작업 지시 목록</div>

			<div class="table-wrap">
				<table class="table work-table">
					<thead>
						<tr>
							<th style="width: 140px;">작업 지시 번호</th>
							<th style="width: 150px;">작업 예정 수량(${planDTO.planItemUnit})</th>
							<th style="width: 150px;">현재 완료 수량(${planDTO.planItemUnit})</th>
							<th style="width: 150px;">작업자</th>
							<th style="width: 120px;">작업 상태</th>
							<th>작업일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="wo" items="${woList}">
							<tr onclick="window.location.href='${pageContext.request.contextPath}/work/detail?workId=${wo.workId}'">
								<td class="toDetail workId">${wo.workId}</td>
								<td><fmt:formatNumber value="${wo.workOrderQty}" pattern="#,###"/></td>
								<td>
									<c:choose>
										<c:when test="${empty wo.workPrevQty}">
											0
										</c:when>
										<c:otherwise>
											<fmt:formatNumber value="${wo.workPrevQty}" pattern="#,###"/>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									${wo.workWname} (${wo.workWorker})
								</td>
								<td>
									<c:choose>
										<c:when test="${wo.workStatus == 10}">
											<span class="status status-warning">• 작업전</span>
										</c:when>
										<c:when test="${wo.workStatus == 20}">
											<span class="status status-success">• 진행중</span>
										</c:when>
										<c:when test="${wo.workStatus == 30}">
											<span class="status status-safe">• 작업완료</span>
										</c:when>
										<c:when test="${wo.workStatus == 40}">
											<span class="status status-danger">• 지연</span>
										</c:when>
										<c:when test="${wo.workStatus == 50}">
											<span class="status status-info">• 보류</span>
										</c:when>
										<c:otherwise>
											<span class="status status-info">• 기타</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${empty wo.workDate or wo.workDate == ''}">
											-
										</c:when>
										<c:otherwise>
											${fn:substring(wo.workDate, 0, 10)}
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty woList}">
							<tr>
								<td colspan="6" style="text-align:center;">
									조회된 작업 지시가 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

	</div>

</div>

<style>
	.detail-title-row,
	.progress-title-row {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 14px;
	}

	.progress-title-row {
		padding: 0 20px;
	}

	.progress-text {
		font-size: 16px;
		font-weight: 600;
	}

	.progress-text span {
		color: var(--main-green);
		font-weight: 800;
	}

	.progress-wrap {
		width: calc(100% - 40px);
		height: 10px;
		margin: 22px 20px 10px;
		border-radius: 10px;
		background-color: var(--sub-green);
		overflow: hidden;
	}

	.progress-bar {
		height: 100%;
		border-radius: 10px;
		background-color: var(--main-green);
	}
	
	.table tbody tr:hover .workId {
	    color: var(--main-green);
	    text-decoration: underline;
	}
</style>