<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">작업 상세</h2>
			<p class="page-subtitle">작업지시(${workDTO.workId})의 내용을 확인하고, 결과를 수정하세요.</p>
		</div>
		<div>
			<p class="page-route">
				홈 &gt; 작업관리 &gt; 상세
			</p>
		</div>
	</div>

	<div class="btn-row">
		<div>
			<a class="btn btn-white" href="${pageContext.request.contextPath}/work/list">
				목록
			</a>
		</div>
		<div>
			<c:if test="${workDTO.workStatus == 10}">
				<a class="btn btn-main" href="${pageContext.request.contextPath}/work/order/edit?workId=${workDTO.workId}">
					수정
				</a>
				<a class="btn btn-red"
					href="${pageContext.request.contextPath}/work/delete?workId=${workDTO.workId}"
					onclick="return confirm('작업 지시를 삭제하시겠습니까?');">
					삭제
				</a>
			</c:if>
		</div>
	</div>

	<div class="content-content" style="display: flex; flex-direction: column; gap: 20px;">

		<div class="content-content-content">
			<div class="detail-title-row">
				<div class="content-content-content-title">작업 지시 상세정보</div>
				<div style="display: flex; gap: 15px; align-items: flex-end;">
					<c:choose>
						<c:when test="${workDTO.workStatus == 10}">
							<span class="status-back status-back-warning">• 대기중</span>
						</c:when>
						<c:when test="${workDTO.workStatus == 20}">
							<span class="status-back status-back-success">• 작업중</span>
						</c:when>
						<c:when test="${workDTO.workStatus == 30}">
							<span class="status-back status-back-safe">• 완료</span>
						</c:when>
						<c:when test="${workDTO.workStatus == 40}">
							<span class="status-back status-back-danger">• 지연</span>
						</c:when>
						<c:when test="${workDTO.workStatus == 0}">
							<span class="status-back status-back-info">• 보류</span>
						</c:when>
						<c:otherwise>
							<span class="status-back status-back-info">• 기타</span>
						</c:otherwise>
					</c:choose>
					
					<c:if test="${(workDTO.workStatus == 20 or workDTO.workStatus == 40)}">
						<a class="btn btn-orange" href="${pageContext.request.contextPath}/work/result/edit?workId=${workDTO.workId}">
							결과 수정
						</a>
					</c:if>
				</div>
			</div>

			<div class="info-table-wrap">
				<table class="info-table">
					<tr>
						<th>작업코드</th>
						<td>${workDTO.workId}</td>
						
						<th>생산계획</th>
						<td>
							<a class="toDetail" href="${pageContext.request.contextPath}/plan/detail?planId=${workDTO.workPlan}">
								${workDTO.workPlan}
							</a>
						</td>
						
					</tr>

					<tr>
						<th>품목</th>
						<td>
							<a class="toDetail" href="${pageContext.request.contextPath}/item/detail?itemId=${workDTO.workItem}">
								${workDTO.workItemName} (${workDTO.workItem})
							</a>
						</td>
						<th>생산된 LOT</th>
						<td>
							<c:choose>
								<c:when test="${empty workDTO.lotId}">
									-
								</c:when>
								<c:otherwise>
									<a class="toDetail" href="${pageContext.request.contextPath}/lot/detail?lotId=${workDTO.lotId}">
										${workDTO.lotId}
									</a>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th>지시수량</th>
						<td>
							<fmt:formatNumber value="${workDTO.workOrderQty}" pattern="#,###"/>
							${workDTO.workItemUnit}
						</td>
						<th>현재완료수량</th>
						<td>
							<fmt:formatNumber value="${workDTO.workPrevQty}" pattern="#,###"/>
							${workDTO.workItemUnit}
						</td>
						
					</tr>
					
					<tr>
						<th>작업일</th>
						<td>
							<fmt:formatDate value="${workDTO.workDate}" pattern="yyyy-MM-dd"/>
						</td>
						<th>작업 완료일</th>
						<td>
							<fmt:formatDate value="${workDTO.workFdate}" pattern="yyyy-MM-dd"/>
						</td>
					</tr>

					<tr>
						<th>작업자</th>
						<td>
							<c:choose>
								<c:when test="${empty workDTO.workWname}">
									-
								</c:when>
								<c:otherwise>
									${workDTO.workWname} (${workDTO.workWorker})
								</c:otherwise>
							</c:choose>
						</td>
						<th>담당자</th>
						<td>
							<c:choose>
								<c:when test="${empty workDTO.workDname}">
									${workDTO.workDirector}
								</c:when>
								<c:otherwise>
									${workDTO.workDname} (${workDTO.workDirector})
								</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th>등록일시</th>
						<td>
							<fmt:formatDate value="${workDTO.workCdate}" pattern="yyyy-MM-dd HH:mm"/>
						</td>
						<th>최종수정일시</th>
						<td>
							<fmt:formatDate value="${workDTO.workMdate}" pattern="yyyy-MM-dd HH:mm"/>
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
								<c:when test="${empty workDTO.workDmsg}">
									내용없음
								</c:when>
								<c:otherwise>
									${workDTO.workDmsg}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>

					<tr>
						<th colspan="4" style="text-align:left; background:#fafafa;">
							작업 특이사항
						</th>
					</tr>

					<tr>
						<td colspan="4" style="height:80px; text-align:left; vertical-align:top; padding-top:14px;">
							<c:choose>
								<c:when test="${empty workDTO.workWmsg}">
									내용없음
								</c:when>
								<c:otherwise>
									${workDTO.workWmsg}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>

			<div style="padding: 20px;">
				<div class="progress-title-row">
					<h3 style="font-weight: 700; font-size: 16px; margin: 0">진행률</h3>
					<div class="progress-text">
						<span>${workDTO.progressRate}%</span>
						(
						<fmt:formatNumber value="${workDTO.workPrevQty}" pattern="#,###"/>
						/
						<fmt:formatNumber value="${workDTO.workOrderQty}" pattern="#,###"/>
						)
					</div>
				</div>

				<div class="progress-wrap">
					<div class="progress-bar" style="width:${workDTO.progressRate}%;"></div>
				</div>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">BOM 목록</div>
			
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th>품목</th>
							<th>유형</th>
							<th>소요수량</th>
							<th>규격</th>
							<th>단가(원)</th>
							<th>소요금액(원)</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="bom" items="${workDTO.bomList}">
							<tr>
								<td>
									<a class="toDetail" href="${pageContext.request.contextPath}/item/detail?itemId=${bom.itemId}">
										${bom.itemName} (${bom.itemId})
									</a>
								</td>
								<td>
									<c:choose>
										<c:when test="${bom.itemType == 10}">
											<span class="status-back stauts-back-success">• 원자재</span>
										</c:when>
										<c:when test="${bom.itemType == 20}">
											<span class="status-back stauts-back-success">• 반제품</span>
										</c:when>
										<c:when test="${bom.itemType == 30}">
											<span class="status-back stauts-back-success">• 완제품</span>
										</c:when>
										<c:otherwise>
											<span class="status-back stauts-back-info">• 기타자재</span>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
									<fmt:formatNumber value="${bom.bomQty}" pattern="#,###"/>
									 ${bom.itemUnit}
							 	</td>
								<td>${bom.itemSpec}</td>
								<td>
									<fmt:formatNumber value="${bom.itemUnitPrice}" pattern="#,###"/>
								</td>
								<td>
									<fmt:formatNumber value="${bom.itemUnitPrice * bom.bomQty * bom.reqQty}" pattern="#,###"/>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty workDTO.bomList}">
							<tr>
								<td colspan="6">BOM 정보 없음</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<div class="content-content-content">
			<div class="content-content-content-title">공정 정보</div>

			<div class="info-table-wrap">
				<table class="info-table">
					<tr>
						<th>라우팅</th>
						<td>
							<c:choose>
								<c:when test="${empty workDTO.routId}">
									-
								</c:when>
								<c:otherwise>
									<a class="toDetail" href="${pageContext.request.contextPath}/routing/detail?routId=${workDTO.routId}">
										${workDTO.routName} (${workDTO.routId})
									</a>
								</c:otherwise>
							</c:choose>
						</td>
						<th>품목</th>
						<td>
							${workDTO.workItemName} (${workDTO.workItem})
						</td>
					</tr>

					<tr>
						<th>라우팅 설명</th>
						<td colspan="3" style="height:70px; text-align:left; vertical-align:top; padding-top:14px;">
							<c:choose>
								<c:when test="${empty workDTO.routContent}">
									내용없음
								</c:when>
								<c:otherwise>
									${workDTO.routContent}
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
			</div>

			<div style="padding: 20px;">
				<div class="content-content-content-title">공정 순서</div>

				<div class="proc-wrap">
					<div class="proc-list">

						<c:forEach var="proc" items="${workProcList}">
							<div class="proc-row">
								<div class="proc-step">${proc.routDtlStep}</div>

								<div class="proc-main">
									<div class="proc-name">
										<c:choose>
											<c:when test="${empty proc.procName}">
												공정명 없음
											</c:when>
											<c:otherwise>
												${proc.procName} (${proc.procId})
											</c:otherwise>
										</c:choose>
									</div>

									<div class="proc-sub">
										<c:choose>
											<c:when test="${empty proc.procContent}">
												공정 설명 없음
											</c:when>
											<c:otherwise>
												${proc.procContent}
											</c:otherwise>
										</c:choose>
									</div>
								</div>

								<div class="proc-place">
									<div>
										<c:choose>
											<c:when test="${empty proc.wpList}">
												작업장 미지정
											</c:when>
											<c:otherwise>
												<c:forEach var="wp" items="${proc.wpList}" varStatus="status">
													<a class="proc-link" href="${pageContext.request.contextPath}/worplace/detail?wpId=${wp.wpId}">
														${wp.wpName} (${wp.wpId})
													</a><c:if test="${!status.last}">, </c:if>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</c:forEach>

						<c:if test="${empty workProcList}">
							<div class="empty-proc">
								조회된 공정 순서가 없습니다.
							</div>
						</c:if>
					</div>

<!-- 					<div class="qr-box"> -->
<!-- 						<div class="qr-title">QR 코드</div> -->
<!-- 						<div class="qr-sub"> -->
<!-- 							공정 사진이나<br> -->
<!-- 							설비 정보 -->
<!-- 						</div> -->
<!-- 					</div> -->

				</div>
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

	.proc-wrap {
		display: flex;
		gap: 60px;
		align-items: flex-start;
	}

	.proc-list {
		flex: 1;
		border-top: 1px solid var(--dark-gray);
	}

	.proc-row {
		display: flex;
		border-bottom: 1px solid var(--dark-gray);
	}

	.proc-step {
		display: flex;
		align-items: center;
		justify-content: center;
		background-color: var(--main-green);
		color: #fff;
		font-weight: 700;
		width: 70px;
	}

	.proc-main {
		display: flex;
		flex-direction: column;
		justify-content: center;
		padding: 10px 18px;
		width: 455px;
	}

	.proc-name {
		font-size: 14px;
		font-weight: 700;
	}

	.proc-sub {
		margin-top: 4px;
		font-size: 13px;
		color: #555;
		line-height: 1.4;
	}

	.proc-place {
		display: flex;
		flex-direction: column;
		justify-content: center;
		gap: 4px;
		padding: 10px 18px;
		font-size: 13px;
		border-left: 1px solid var(--gray);
	}

	.empty-proc {
		padding: 20px;
		text-align: center;
		border-bottom: 1px solid var(--dark-gray);
	}

	.qr-box {
		width: 180px;
		height: 180px;
		border: 1px solid var(--dark-gray);
		border-radius: 8px;

		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;

		text-align: center;
	}

	.qr-title {
		font-size: 18px;
		font-weight: 800;
		margin-bottom: 24px;
	}

	.qr-sub {
		font-size: 14px;
		font-weight: 700;
		line-height: 1.5;
	}
	
	.proc-link:hover {
		color: var(--main-green);
	}

	@media (max-width: 900px) {
		.proc-wrap {
			flex-direction: column;
		}

		.qr-box {
			width: 100%;
		}

		.proc-row {
			grid-template-columns: 52px 1fr;
		}

		.proc-place {
			grid-column: 2 / 3;
			border-left: none;
			border-top: 1px solid var(--gray);
		}
		
		
	    .table-wrap {
			width: 100%;
			overflow-x: auto;
			overflow-y: hidden;
			-webkit-overflow-scrolling: touch;
		}
	
		.table {
			min-width: 760px;
			white-space: nowrap;
		}
	}
	
@media screen and (max-width: 900px) {

	.proc-row {
		display: flex !important;
		flex-wrap: wrap !important;
		width: 100% !important;
	}

	.proc-step {
		width: 52px !important;
		min-width: 52px !important;
	}

	.proc-main {
		width: calc(100% - 52px) !important;
		min-width: 0 !important;
		box-sizing: border-box;
	}

	.proc-place {
		width: calc(100% - 52px) !important;
/* 		margin-left: 52px !important; */
		box-sizing: border-box;
		border-left: none !important;
		border-top: 1px solid var(--gray);
	}

}
@media screen and (max-width: 480px) {

	.proc-wrap {
		width: 100% !important;
		display: block !important;
	}

	.proc-list {
		width: 100% !important;
		min-width: 0 !important;
	}

	.proc-row {
		display: grid !important;
		grid-template-columns: 45px 1fr !important;
		width: 100% !important;
	}

	.proc-step {
		width: 45px !important;
		min-width: 45px !important;
		grid-row: 1 / 3;
	}

	.proc-main {
		width: auto !important;
		min-width: 0 !important;
		padding: 10px 12px !important;
		box-sizing: border-box;
	}

	.proc-place {
		width: auto !important;
		min-width: 0 !important;
		padding: 10px 12px !important;
		border-left: none !important;
		border-top: 1px solid var(--gray);
		box-sizing: border-box;
	}

	.proc-name,
	.proc-sub,
	.proc-place {
		white-space: normal !important;
		word-break: keep-all;
		overflow-wrap: anywhere;
	}

}
</style>