<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">설비 점검 이력</h2>
			<p class="page-subtitle">설비의 점검 이력을 조회할 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 설비관리 &gt; 점검이력</p>
		</div>
	</div>

	<div class="btn-row">
		<div>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}">
				상세로
			</a>
		</div>

		<div>
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/equip/mt/add?eqId=${eqp.eqId}">
				점검이력 등록
			</a>
		</div>
	</div>

	<div class="content-content">

		<div class="content-content-content">

			<div class="content-content-content-title">
				점검 설비 : ${eqp.eqName} (${eqp.eqId})
			</div>

			<div class="table-wrap">
				<table class="table">

					<thead>
						<tr>
							<th>점검 시작일</th>
							<th>점검 종료일</th>
							<th>점검 사유</th>
							<th>점검 결과</th>
							<th>점검자</th>
							<th>관리</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="log" items="${eqLogList}">
							<tr>
								<td>${log.elogSdate}</td>

								<td>
									<c:choose>
										<c:when test="${empty log.elogEdate}">
											-
										</c:when>
										<c:otherwise>
											${log.elogEdate}
										</c:otherwise>
									</c:choose>
								</td>

								<td>${log.elogReason}</td>
								<td>${log.elogResult}</td>
								<td>${log.elogWorker}</td>

								<td>
									<a class="btn btn-white"
										href="${pageContext.request.contextPath}/equip/mt/edit?elogId=${log.elogId}&eqId=${eqp.eqId}">
										수정
									</a>
								</td>
							</tr>
						</c:forEach>

						<c:if test="${empty eqLogList}">
							<tr>
								<td colspan="6">
									조회된 점검이력이 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>

				</table>
			</div>

		</div>

	</div>

</div>