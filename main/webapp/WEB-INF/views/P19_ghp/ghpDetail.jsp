<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">위생 관리 기준 상세</h2>
			<p class="page-subtitle">${ghp.ghpName}(${ghp.ghpId})의 상세 정보를 확인하세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 기준관리 &gt; GHP 기준 상세</p>
		</div>
	</div>

	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/ghp/list">
				목록으로
			</a>
		</div>

		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/ghp/update?ghpId=${ghp.ghpId}">
				수정
			</a>

			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/ghp/delete?ghpId=${ghp.ghpId}"
				onclick="return confirm('GHP 기준정보를 삭제하시겠습니까?');">
				삭제
			</a>
		</div>
	</div>

	<div class="content-content">
		<div class="content-content-content">

			<div class="content-content-content-title">
				GHP 기준정보
			</div>

			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>기준코드</th>
							<td>${ghp.ghpId}</td>

							<th>기준명</th>
							<td>${ghp.ghpName}</td>
						</tr>

						<tr>
							<th>구분</th>
							<td>${ghp.ghpCategory}</td>

							<th>점검주기</th>
							<td>${ghp.ghpCycle}</td>
						</tr>

						<tr>
							<th>대상</th>
							<td>
								<c:choose>
									<c:when test="${ghp.ghpWhType != 0}">
										${ghp.whTypeName}
									</c:when>
									<c:when test="${ghp.ghpWpType != 0}">
										${ghp.wpTypeName}(작업장)
									</c:when>
									<c:otherwise>
										공통
									</c:otherwise>
								</c:choose>
							</td>

							<th>기준값</th>
							<td>
								<c:choose>
									<c:when test="${not empty ghp.ghpMinValue or not empty ghp.ghpMaxValue}">
										${ghp.ghpMinValue} ~ ${ghp.ghpMaxValue} ${ghp.ghpUnit}
									</c:when>
									<c:otherwise>
										-
									</c:otherwise>
								</c:choose>
							</td>
						</tr>

					</tbody>
				</table>
			</div>

			<div class="simple-section">
				<div class="simple-title">기준내용</div>
				<div class="simple-content">${ghp.ghpStandard}</div>
			</div>

			<div class="simple-section">
				<div class="simple-title">점검방법</div>
				<div class="simple-content">${ghp.ghpCheckMethod}</div>
			</div>

		</div>
		<div class="content-content-content">
			
			<div class="content-content-content-title">
				점검 이력
			</div>
			
			<div class="table-wrap">
			
				<table class="table">
					
					<thead>
						<th>점검이력 코드</th>
						<th>점검 날짜</th>
						<th>점검자</th>
						<th>결과</th>
						<th>점검대상</th>
					</thead>
					<tbody>
						<c:choose>
					        <c:when test="${empty glogList}">
					            <tr>
					                <td colspan="5" style="text-align:center;">
					                    등록된 점검 이력이 없습니다.
					                </td>
					            </tr>
					        </c:when>
					
					        <c:otherwise>
					            <c:forEach var="glog" items="${glogList}">
					            	<c:if test="${ghp.ghpWhType != 0}">
						                <tr onclick="location.href='${pageContext.request.contextPath}/warehouse/glog/detail?glogId=${glog.glogId}'">
					            	</c:if>
					            	<c:if test="${ghp.ghpWpType != 0}">
					            		<tr onclick="location.href='${pageContext.request.contextPath}/workplace/glog/detail?glogId=${glog.glogId}'">
					            	</c:if>
					                    <td class="whwpId">${glog.glogId}</td>
					                    <td>
					                    	<fmt:formatDate value="${glog.glogDate}"
					                    		pattern="YYYY-MM-dd"/>
					                    </td>
					                    <td>${glog.glogWorkerName}(${glog.glogWorkerId})</td>
					                    <td class="
					                    ${glog.glogResult == 'pass' ? 'status-safe' : 'status-danger'}
					                    ">
					                    ${glog.glogResult}
					                    </td>
					                    <td>
					                        <c:choose>
					                            <c:when test="${not empty glog.glogWhId}">
					                                ${glog.glogWhName}(${glog.glogWhId})
					                            </c:when>
					                            <c:when test="${not empty glog.glogWpId}">
					                                ${glog.glogWpName}(${glog.glogWpId})
					                            </c:when>
					                            <c:otherwise>
					                                -
					                            </c:otherwise>
					                        </c:choose>
					                    </td>
					                </tr>
					            </c:forEach>
					        </c:otherwise>
					    </c:choose>
					</tbody>
					
				</table>
				<jsp:include page="/WEB-INF/views/common/paging.jsp" />
			</div>
			
		</div>
		
	</div>

</div>

<style>
.table tbody tr:hover .whwpId {
	    color: var(--main-green);
	    text-decoration: underline;
	}

.simple-section {
	border-bottom: 1px solid var(--dark-gray);
	padding: 18px 12px 28px;
}

.simple-title {
	font-size: 16px;
	font-weight: 700;
	margin-bottom: 18px;
}

.simple-content {
	font-size: 14px;
	padding-left: 16px;
}
</style>