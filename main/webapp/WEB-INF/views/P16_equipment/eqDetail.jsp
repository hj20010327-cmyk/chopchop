<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">설비 상세</h2>
			<p class="page-subtitle"> ${eqp.eqName}(${eqp.eqId})의 상세 정보와 점검이력, 가동이력을 확인하세요.</p>
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
			<c:if test="${isAdmin}">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/equip/edit?eqId=${eqp.eqId}">
				수정 </a> <a class="btn btn-red"
				href="${pageContext.request.contextPath}/equip/delete?eqId=${eqp.eqId}"
				onclick="return confirm('정말 삭제하시겠습니까?');"> 삭제 </a>
			</c:if>
		</div>
	</div>

	<div class="content-content">

		<div class="content-content-content">

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">

				<div style="display: flex; align-items: center; gap: 14px;">
					<div class="content-content-content-title"
						style="margin-bottom: 0;">설비 상세정보</div>
					<c:if test="${isAdmin}">
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
					</c:if>

				</div>

				<div style="display: flex; align-items: center; gap: 10px;">


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

					<c:if test="${isAdmin && eqp.eqStatus == 20}">
						<form
							action="${pageContext.request.contextPath}/equip/status/update"
							method="post"
							style="display: flex; align-items: center; gap: 8px; margin: 0;">

							<input type="hidden" name="eqId" value="${eqp.eqId}"> <select
								name="eqStatus" class="search-item" id="eqStatusSelect">
								<option value="20" ${eqp.eqStatus == 20 ? 'selected' : ''}>정지</option>
								<option value="30">점검중</option>
								<option value="40">고장</option>
							</select>

							<button type="submit" class="btn btn-main">변경</button>
						</form>
					</c:if>
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
							<a class="toDetail" href="${pageContext.request.contextPath}/workplace/detail?wpId=${eqp.eqWpid}">
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
							<a class="toDetail" href="${pageContext.request.contextPath}/vendor/detail?vendorId=${eqp.eqVendor}">
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

				<c:if test="${isAdmin}">
				<a class="btn btn-main"
					href="${pageContext.request.contextPath}/equip/mt/add?eqId=${eqp.eqId}">
					점검이력 등록 </a>
				</c:if>

			</div>

			<div class="table-wrap">
				<table class="table">

					<thead>
						<tr>
							<th>설비 점검 코드</th>
							<th>점검 시작일</th>
							<th>점검 종료일</th>
							<th>점검 사유</th>
							<th>점검 결과</th>
							<th>점검자</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="log" items="${eqLogList}">
							<tr onclick="openEqLogModal(this)"
						    data-elog-id="${log.elogId}"
						    data-eq-id="${log.elogEqid}"
						    data-worker="${log.elogWorkerName}(${log.elogWorker})"
							data-sdate="<fmt:formatDate value='${log.elogSdate}' pattern='yyyy-MM-dd HH:mm' />"
							data-edate="<fmt:formatDate value='${log.elogEdate}' pattern='yyyy-MM-dd HH:mm' />"
						    data-reason="${log.elogReason}"
						    data-result="${log.elogResult}"
						    data-content="${log.elogContent}">
						    
						    <td>
						        <a class="detail-link"
						           href="javascript:void(0);">
						            ${log.elogId}
						        </a>
						    </td>
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
				<table class="table noneTr">

					<thead>
						<tr>
							<th>가동 번호</th>
							<th>가동 시작일</th>
							<th>가동 종료일</th>
							<th>가동 종료 사유</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="run" items="${eqRunList}">
							<tr
							onclick="openEqRunModal(this)"
						    data-run-no="${run.eqRunNo}"
						    data-eq-id="${run.eqRunEqid}"
						    data-stime="<fmt:formatDate value='${run.eqRunStime}' pattern='yyyy-MM-dd HH:mm' />"
						    data-etime="<fmt:formatDate value='${run.eqRunEtime}' pattern='yyyy-MM-dd HH:mm' />"
						    data-reason="${run.eqStopReason}"
							>
								<td>
									<a class="detail-link"
									   href="javascript:void(0);">
										${run.eqRunNo}   
									</a>
								</td>
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
								<td colspan="4" style="text-align: center;">조회된 가동이력이 없습니다.
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
						value="<fmt:formatDate value='${currentRun.eqRunStime}'  pattern='yyyy-MM-dd HH:mm'/>"
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

<!-- 점검이력 모달 -->
<div id="eqLogOverlay" class="overlay">

    <div class="modal" style="width: 620px;">
      <div class="eqlog-header">
        <h2 class="modal-title">점검이력 상세</h2>
        
        <c:if test="${isAdmin}">
		<button type="button"
        class="btn btn-red"
        id="deleteEqLogBtn">
   		 삭제
		</button>
		</c:if>
	  </div>

        <p class="modal-subTitle">
             ${eqp.eqName}(${eqp.eqId})의 점검이력 상세 정보를 확인하고 수정하세요.
        </p>

        <form action="${pageContext.request.contextPath}/equip/mt/update"
              method="post"
              id="eqLogForm">

            <input type="hidden" name="elogId" id="modalElogId">
            <input type="hidden" name="elogEqid" id="modalElogEqid">

            <div class="grid-form">

                <div class="grid-wrap">
                    <div class="search-item">
                        <label>점검 시작일</label>
                        <input type="text" id="modalSdateText" readonly>
                    </div>
                    <div class="search-item">
                        <label>점검 종료일</label>
                        <input type="text"
                               id="modalEdateText"
                               readonly>
                       	<input type="datetime-local"
						       name="elogEdate"
						       id="modalEdate"
						       style="display:none;">
                    </div>

                </div>

                <div class="grid-wrap">
                    <div class="search-item">
                        <label>점검자</label>
                        <input type="text" id="modalWorker" readonly>
                    </div>
                    <div class="search-item">
                        <label>점검 결과</label>
                        <input type="text"
                               name="elogResult"
                               id="modalResult"
                               readonly>
                    </div>
                </div>

                <div class="grid-wrap">
                    <div class="search-item">
                        <label>점검 사유</label>
                        <input type="text"
                               name="elogReason"
                               id="modalReason"
                               readonly>
                    </div>
                </div>

                <div class="grid-wrap">
                    <div class="search-item" style="width:100%;">
                        <label>점검 내용</label>
                        <textarea name="elogContent"
                                  id="modalContent"
                                  readonly
                                  style="height:160px;"></textarea>
                    </div>
                </div>

            </div>

            <div style="display:flex; justify-content:center; gap:10px; margin-top:25px;">

                <button type="button"
                        class="btn btn-white"
                        id="closeEqLogModal">
                    취소
                </button>

				<c:if test="${isAdmin}">
                <button type="button"
                        class="btn btn-main"
                        id="editEqLogBtn">
                    수정
                </button>

                <button type="submit"
                        class="btn btn-main"
                        id="saveEqLogBtn"
                        style="display:none;">
                    저장
                </button>
                </c:if>

            </div>

        </form>

    </div>
    
    <form id="deleteEqLogForm"
      action="${pageContext.request.contextPath}/equip/mt/delete"
      method="post">

    <input type="hidden"
           name="elogId"
           id="deleteElogId">

    <input type="hidden"
           name="eqId"
           id="deleteEqId">

</form>

</div>

<!-- 가동이력 모달 -->
<div id="eqRunOverlay" class="overlay">

    <div class="modal" style="width: 620px;">

        <h2 class="modal-title">가동이력 상세</h2>

        <p class="modal-subTitle">
            ${eqp.eqName}(${eqp.eqId})의 가동이력 상세 정보를 확인하고 종료사유를 수정하세요.
        </p>

        <form action="${pageContext.request.contextPath}/equip/run/update"
              method="post"
              id="eqRunForm">

            <input type="hidden" name="eqRunNo" id="modalRunNo">
            <input type="hidden" name="eqRunEqid" id="modalRunEqid">

            <div class="grid-form">

                <div class="grid-wrap">
                    <div class="search-item">
                        <label>가동 시작일</label>
                        <input type="text" id="modalRunStime" readonly>
                    </div>

                    <div class="search-item">
                        <label>가동 종료일</label>
                        <input type="text" id="modalRunEtime" readonly>
                    </div>
                </div>

                <div class="grid-wrap">
                    <div class="search-item" style="width:100%;">
                        <label>가동 종료 사유</label>
                        <textarea name="eqStopReason"
                                  id="modalRunReason"
                                  readonly
                                  style="height:160px;"></textarea>
                    </div>
                </div>

            </div>

            <div style="display:flex; justify-content:center; gap:10px; margin-top:25px;">

                <button type="button"
                        class="btn btn-white"
                        id="closeEqRunModal">
                    취소
                </button>

				<c:if test="${isAdmin}">
                <button type="button"
                        class="btn btn-main"
                        id="editEqRunBtn">
                    수정
                </button>

                <button type="submit"
                        class="btn btn-main"
                        id="saveEqRunBtn"
                        style="display:none;">
                    저장
                </button>
                </c:if>

            </div>

        </form>

    </div>

</div>

<style>

.table tbody tr:hover .detail-link {
    color: var(--main-green);
    text-decoration: underline;
}

.search-item input {
    min-width: 235px;
}

.eqlog-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.eqlog-header .modal-title {
    margin-bottom: 0;
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
	function openEqLogModal(row) {

	    document.querySelector("#modalSdateText").type = "text";
	    document.querySelector("#modalEdateText").type = "text";
		
	    document.querySelector("#modalElogId").value =
	        row.dataset.elogId;

	    document.querySelector("#modalElogEqid").value =
	        row.dataset.eqId;
	    
	    document.querySelector("#deleteElogId").value =
	        row.dataset.elogId;

	    document.querySelector("#deleteEqId").value =
	        row.dataset.eqId;

	    document.querySelector("#modalWorker").value =
	        row.dataset.worker;

	    document.querySelector("#modalSdateText").value =
	        row.dataset.sdate;

	    document.querySelector("#modalEdateText").value =
	        row.dataset.edate;
	    
	    document.querySelector("#modalEdate").value =
	        toDateTimeLocal(row.dataset.edate);

	    document.querySelector("#modalReason").value =
	        row.dataset.reason;

	    document.querySelector("#modalResult").value =
	        row.dataset.result;

	    document.querySelector("#modalContent").value =
	        row.dataset.content;

	    setEqLogReadonly(true);

	    document.querySelector("#eqLogOverlay").style.display = "flex";
	}

	function setEqLogReadonly(readonly) {

	    document.querySelector("#modalReason").readOnly =
	        readonly;

	    document.querySelector("#modalResult").readOnly =
	        readonly;

	    document.querySelector("#modalContent").readOnly =
	        readonly;

	    const editBtn =
	        document.querySelector("#editEqLogBtn");

	    const saveBtn =
	        document.querySelector("#saveEqLogBtn");

	    if (readonly) {

	        // 종료일 text 보여주기
	        document.querySelector("#modalEdateText")
	            .style.display = "block";

	        // 종료일 datetime 숨기기
	        document.querySelector("#modalEdate")
	            .style.display = "none";

	        if (editBtn != null) {
	            editBtn.style.display = "inline-block";
	        }

	        if (saveBtn != null) {
	            saveBtn.style.display = "none";
	        }

	    } else {

	        // 수정모드면 datetime 보여주기
	        document.querySelector("#modalEdateText")
	            .style.display = "none";

	        document.querySelector("#modalEdate")
	            .style.display = "block";

	        if (editBtn != null) {
	            editBtn.style.display = "none";
	        }

	        if (saveBtn != null) {
	            saveBtn.style.display = "inline-block";
	        }

	        document.querySelector("#modalSdateText")
	            .type = "datetime-local";
	    }
	}

	const editEqLogBtn =
	    document.querySelector("#editEqLogBtn");

	if (editEqLogBtn != null) {

	    editEqLogBtn.addEventListener("click", function () {
	        setEqLogReadonly(false);
	    });
	}

	document.querySelector("#closeEqLogModal")
	    .addEventListener("click", function () {
	        document.querySelector("#eqLogOverlay").style.display = "none";
	    });

	function toDateTimeLocal(value) {

	    if (value == null || value == "" || value == "null") {
	        return "";
	    }

	    return value.substring(0, 16).replace(" ", "T");
	}

	document.querySelector("#eqLogForm")
	    .addEventListener("submit", function (e) {

	        const sdateText =
	            document.querySelector("#modalSdateText").value;

	        const edate =
	            document.querySelector("#modalEdate").value;

	        const sdate =
	            toDateTimeLocal(sdateText);

	        if (edate != "" && sdate != "" && edate < sdate) {
	            alert("점검 종료일은 점검 시작일보다 빠를 수 없습니다.");
	            e.preventDefault();
	            return;
	        }
	    });
	
	const deleteEqLogBtn =
	    document.querySelector("#deleteEqLogBtn");

	if (deleteEqLogBtn != null) {

	    deleteEqLogBtn.addEventListener("click", function () {

	        if (!confirm("점검이력을 삭제하시겠습니까?")) {
	            return;
	        }

	        document.querySelector("#deleteEqLogForm").submit();
	    });
	}
	
	function openEqRunModal(row) {

	    document.querySelector("#modalRunNo").value =
	        row.dataset.runNo;

	    document.querySelector("#modalRunEqid").value =
	        row.dataset.eqId;

	    document.querySelector("#modalRunStime").value =
	        row.dataset.stime;

	    document.querySelector("#modalRunEtime").value =
	        row.dataset.etime;

	    document.querySelector("#modalRunReason").value =
	        row.dataset.reason;

	    setEqRunReadonly(true);

	    openModal(document.querySelector("#eqRunOverlay"));
	}

	function setEqRunReadonly(readonly) {

	    document.querySelector("#modalRunReason").readOnly =
	        readonly;

	    const editBtn =
	        document.querySelector("#editEqRunBtn");

	    const saveBtn =
	        document.querySelector("#saveEqRunBtn");

	    if (readonly) {

	        if (editBtn != null) {
	            editBtn.style.display = "inline-block";
	        }

	        if (saveBtn != null) {
	            saveBtn.style.display = "none";
	        }

	    } else {

	        if (editBtn != null) {
	            editBtn.style.display = "none";
	        }

	        if (saveBtn != null) {
	            saveBtn.style.display = "inline-block";
	        }
	    }
	}

	const editEqRunBtn =
	    document.querySelector("#editEqRunBtn");

	if (editEqRunBtn != null) {

	    editEqRunBtn.addEventListener("click", function () {
	        setEqRunReadonly(false);
	    });
	}

	document.querySelector("#closeEqRunModal")
	    .addEventListener("click", function () {
	        closeModal(document.querySelector("#eqRunOverlay"));
	    });
</script>