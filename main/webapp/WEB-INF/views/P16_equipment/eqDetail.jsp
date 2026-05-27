<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">설비 상세</h2>
			<p class="page-subtitle">설비의 상세 정보와 점검 이력을 알 수 있습니다.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 설비관리 &gt; 상세</p>
		</div>
	</div>

	<div class="btn-row">
		<div>
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/equip/list"> 목록 </a>
		</div>

		<div>
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/equip/edit?eqId=${eqp.eqId}">
				수정 </a> <a class="btn btn-red"
				href="${pageContext.request.contextPath}/equip/delete?eqId=${eqp.eqId}"
				onclick="return confirm('정말 삭제하시겠습니까?');"> 삭제 </a>
		</div>
	</div>

	<div class="content-content">

		<div class="content-content-content">

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">

				<div style="display: flex; align-items: center; gap: 14px;">
					<div class="content-content-content-title"
						style="margin-bottom: 0;">설비 상세정보</div>

					<c:choose>

						<c:when test="${eqp.eqStatus eq 10}">
							<a class="btn btn-main" href="javascript:void(0);"
								id="openStopModal"> 설비 정지 </a>
						</c:when>

						<c:when test="${eqp.eqStatus eq 20}">
							<a class="btn btn-main"
								href="${pageContext.request.contextPath}/equip/run?eqId=${eqp.eqId}">
								설비 가동 </a>
						</c:when>

						<c:when test="${eqp.eqStatus eq 30}">
							<a class="btn btn-main"
								href="${pageContext.request.contextPath}/equip/run?eqId=${eqp.eqId}">
								점검 완료 후 가동 </a>
						</c:when>

						<c:when test="${eqp.eqStatus eq 40}">
							<a class="btn btn-main"
								href="${pageContext.request.contextPath}/equip/run?eqId=${eqp.eqId}">
								수리 완료 후 가동 </a>
						</c:when>

					</c:choose>

				</div>

				<div style="display: flex; align-items: center; gap: 10px;">

					<c:if test="${eqp.eqStatus == 20}">
						<form
							action="${pageContext.request.contextPath}/equip/status/update"
							method="post"
							style="display: flex; align-items: center; gap: 8px; margin: 0;">

							<input type="hidden" name="eqId" value="${eqp.eqId}"> <select
								name="eqStatus" id="eqStatusSelect">
								<option value="20" ${eqp.eqStatus == 20 ? 'selected' : ''}>정지</option>
								<option value="30">점검중</option>
								<option value="40">고장</option>
							</select>

							<button type="submit" class="btn btn-main">변경</button>
						</form>
					</c:if>

					<c:choose>
						<c:when test="${eqp.eqStatus == 10}">
							<span id="statusBadge" class="status-back status-back-success">가동중</span>
						</c:when>
						<c:when test="${eqp.eqStatus == 20}">
							<span id="statusBadge" class="status-back status-back-info">정지</span>
						</c:when>
						<c:when test="${eqp.eqStatus == 30}">
							<span id="statusBadge" class="status-back status-back-warning">점검중</span>
						</c:when>
						<c:when test="${eqp.eqStatus == 40}">
							<span id="statusBadge" class="status-back status-back-danger">고장</span>
						</c:when>
					</c:choose>

				</div>

			</div>

			<div class="info-table-wrap">
				<table class="info-table">

					<tr>
						<th>설비코드</th>
						<td>${eqp.eqId}</td>

						<th>설비명</th>
						<td>${eqp.eqName}</td>
					</tr>

					<tr>
						<th>가동 시작일</th>
						<td><fmt:formatDate value="${eqp.eqSdate}"
								pattern="yyyy-MM-dd HH:mm" /></td>

						<th>가동률</th>
						<td>${eqp.runRate}</td>
					</tr>

					<tr>
						<th>전체시간</th>
						<td>${eqp.totalTime}시간</td>

						<th>가동시간</th>
						<td>${eqp.runTime}시간</td>
					</tr>

					<tr>
						<th>작업장</th>
						<td>
							<a class="detail-link" href="${pageContext.request.contextPath}/workplace/detail?wpId=${eqp.eqWpid}">
								${eqp.wpName}
							</a>
						</td>

						<th>작업구역</th>
						<td>${eqp.wpTypeName}</td>
					</tr>

					<tr>
						<th>설비 책임자</th>
						<td>${eqp.eqManagerName}(${eqp.eqManager})</td>

						<th>관리업체</th>
						<td>
							<a class="detail-link" href="${pageContext.request.contextPath}/vendor/detail?vendorId=${eqp.eqVendor}">
								${eqp.eqVendorName}(${eqp.eqVendor})
							</a>
						</td>
					</tr>

				</table>
			</div>

		</div>

		<div class="content-content-content">

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">

				<div class="content-content-content-title" style="margin-bottom: 0;">
					설비 점검이력</div>

				<a class="btn btn-main"
					href="${pageContext.request.contextPath}/equip/mt/add?eqId=${eqp.eqId}">
					점검이력 등록 </a>

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
						</tr>
					</thead>

					<tbody>
						<c:forEach var="log" items="${eqLogList}">
							<tr>
								<td><fmt:formatDate value="${log.elogSdate}"
										pattern="yyyy-MM-dd HH:mm" /></td>

								<td><c:choose>
										<c:when test="${empty log.elogEdate}">
                                            -
                                        </c:when>
										<c:otherwise>
											<fmt:formatDate value="${log.elogEdate}"
												pattern="yyyy-MM-dd HH:mm" />
										</c:otherwise>
									</c:choose></td>

								<td>${log.elogReason}</td>
								<td>${log.elogResult}</td>
								<td>${log.elogWorkerName}(${log.elogWorker})</td>
							</tr>
						</c:forEach>

						<c:if test="${empty eqLogList}">
							<tr>
								<td colspan="5" style="text-align: center;">조회된 점검이력이 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>

				</table>
			</div>

			<div class="pagination">
			
			    <c:choose>
			        <c:when test="${mtPage.currentPage == 1}">
			            <a class="disabled">&laquo;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=1&runPage=${runPage.currentPage}">&laquo;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:choose>
			        <c:when test="${mtPage.currentPage == 1}">
			            <a class="disabled">&lt;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage - 1}&runPage=${runPage.currentPage}">&lt;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:forEach begin="${mtPage.startPage}" end="${mtPage.endPage}" var="i">
			        <c:choose>
			            <c:when test="${i == mtPage.currentPage}">
			                <a class="active">${i}</a>
			            </c:when>
			            <c:otherwise>
			                <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${i}&runPage=${runPage.currentPage}">
			                    ${i}
			                </a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			
			    <c:choose>
			        <c:when test="${mtPage.currentPage == mtPage.maxPage}">
			            <a class="disabled">&gt;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage + 1}&runPage=${runPage.currentPage}">&gt;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:choose>
			        <c:when test="${mtPage.currentPage == mtPage.maxPage}">
			            <a class="disabled">&raquo;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.maxPage}&runPage=${runPage.currentPage}">&raquo;</a>
			        </c:otherwise>
			    </c:choose>
			
			</div>

		</div>

		<div class="content-content-content">

			<div class="content-content-content-title">설비 가동이력</div>

			<div class="table-wrap">
				<table class="table">

					<thead>
						<tr>
							<th>가동 시작일</th>
							<th>가동 종료일</th>
							<th>가동 종료 사유</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="run" items="${eqRunList}">
							<tr>
								<td><fmt:formatDate value="${run.eqRunStime}"
										pattern="yyyy-MM-dd HH:mm" /></td>

								<td><c:choose>
										<c:when test="${empty run.eqRunEtime}">
                                            -
                                        </c:when>
										<c:otherwise>
											<fmt:formatDate value="${run.eqRunEtime}"
												pattern="yyyy-MM-dd HH:mm" />
										</c:otherwise>
									</c:choose></td>

								<td><c:choose>
										<c:when test="${empty run.eqStopReason}">
                                            -
                                        </c:when>
										<c:otherwise>
                                            ${run.eqStopReason}
                                        </c:otherwise>
									</c:choose></td>
							</tr>
						</c:forEach>

						<c:if test="${empty eqRunList}">
							<tr>
								<td colspan="3" style="text-align: center;">조회된 가동이력이 없습니다.
								</td>
							</tr>
						</c:if>
					</tbody>

				</table>
			</div>

			<div class="pagination">
			
			    <c:choose>
			        <c:when test="${runPage.currentPage == 1}">
			            <a class="disabled">&laquo;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage}&runPage=1">&laquo;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:choose>
			        <c:when test="${runPage.currentPage == 1}">
			            <a class="disabled">&lt;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage}&runPage=${runPage.currentPage - 1}">&lt;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:forEach begin="${runPage.startPage}" end="${runPage.endPage}" var="i">
			        <c:choose>
			            <c:when test="${i == runPage.currentPage}">
			                <a class="active">${i}</a>
			            </c:when>
			            <c:otherwise>
			                <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage}&runPage=${i}">
			                    ${i}
			                </a>
			            </c:otherwise>
			        </c:choose>
			    </c:forEach>
			
			    <c:choose>
			        <c:when test="${runPage.currentPage == runPage.maxPage}">
			            <a class="disabled">&gt;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage}&runPage=${runPage.currentPage + 1}">&gt;</a>
			        </c:otherwise>
			    </c:choose>
			
			    <c:choose>
			        <c:when test="${runPage.currentPage == runPage.maxPage}">
			            <a class="disabled">&raquo;</a>
			        </c:when>
			        <c:otherwise>
			            <a href="${pageContext.request.contextPath}/equip/detail?eqId=${eqp.eqId}&mtPage=${mtPage.currentPage}&runPage=${runPage.maxPage}">&raquo;</a>
			        </c:otherwise>
			    </c:choose>
			
			</div>

		</div>

	</div>

</div>

<!-- 설비 정지 모달 -->
<div id="stopOverlay" class="overlay">

	<div class="modal" style="width: 620px;">

		<h2 class="modal-title">설비 정지</h2>

		<p class="modal-subTitle">설비 가동 종료사유를 입력해주세요.</p>

		<form action="${pageContext.request.contextPath}/equip/stop"
			method="post">

			<input type="hidden" name="eqId" value="${eqp.eqId}">

			<div class="grid-wrap" style="margin-bottom: 20px;">

				<div class="search-item">
					<label>가동 시작일시</label> <input type="text"
						value="<fmt:formatDate value='${eqp.eqSdate}' pattern='yyyy-MM-dd HH:mm'/>"
						readonly>
				</div>

				<div class="search-item">
					<label>가동 종료일시</label> <input type="text" id="stopNowTime" readonly>
				</div>

			</div>

			<div class="search-item">

				<label>종료사유</label>

				<textarea name="eqStopReason" rows="5" placeholder="종료사유를 입력하세요"
					required></textarea>

			</div>

			<div
				style="display: flex; justify-content: center; gap: 10px; margin-top: 25px;">

				<button type="button" class="btn btn-white" id="closeStopModal">

					취소</button>

				<button type="submit" class="btn btn-main">확인</button>

			</div>

		</form>

	</div>

</div>

<style>

.detail-link:hover {
    text-decoration: underline;
    color: var(--main-green);
}

</style>

<script>
	const openStopModal = document.querySelector("#openStopModal");

	if (openStopModal != null) {

		openStopModal.addEventListener("click", function() {

			const now = new Date();

			let year = now.getFullYear();
			let month = now.getMonth() + 1;
			let date = now.getDate();
			let hour = now.getHours();
			let minute = now.getMinutes();

			// 한자리면 앞에 0 붙이기
			if (month < 10) {
				month = "0" + month;
			}

			if (date < 10) {
				date = "0" + date;
			}

			if (hour < 10) {
				hour = "0" + hour;
			}

			if (minute < 10) {
				minute = "0" + minute;
			}

			// 날짜 문자열 만들기
			const time = year + "-" + month + "-" + date + " " + hour + ":"
					+ minute;

			// input에 넣기
			document.querySelector("#stopNowTime").value = time;

			// 모달 열기
			openModal(document.querySelector("#stopOverlay"));
		});
	}

	const closeStopModal = document.querySelector("#closeStopModal");

	if (closeStopModal != null) {

		closeStopModal.addEventListener("click", function() {

			closeModal(document.querySelector("#stopOverlay"));
		});
	}

	const eqStatusSelect = document.querySelector("#eqStatusSelect");

	if (eqStatusSelect != null) {

		eqStatusSelect.addEventListener("change", function() {

			const badge = document.querySelector("#statusBadge");

			// 기존 색 제거
			badge.className = "status-back";

			// 점검중
			if (this.value == "30") {

				badge.classList.add("status-back-warning");

				badge.innerText = "점검중";
			}

			// 고장
			else if (this.value == "40") {

				badge.classList.add("status-back-danger");

				badge.innerText = "고장";
			}

			// 정지
			else if (this.value == "20") {

				badge.classList.add("status-back-info");

				badge.innerText = "정지";
			}
		});
	}
</script>