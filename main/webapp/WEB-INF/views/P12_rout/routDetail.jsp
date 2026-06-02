<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">라우팅 상세</h2>
            <p class="page-subtitle">${rout.routName}(${rout.routId})의 상세 정보를 확인하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 라우팅 관리 &gt; 상세</p>
        </div>
    </div>

    <div class="btn-row">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/routing/list">
                목록으로
            </a>
        </div>

        <div class="right">
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/routing/edit?routId=${rout.routId}">
                수정
            </a>

            <a class="btn btn-red"
               href="${pageContext.request.contextPath}/routing/delete?routId=${rout.routId}"
               onclick="return confirm('라우팅(${rout.routId})을 삭제하시겠습니까?');">
                삭제
            </a>
        </div>
    </div>

    <!-- 라우팅 상세 정보 -->
    <div class="content-content">
        <div class="content-content-content">

            <div class="rout-title-row">
                <div class="content-content-content-title">
                    라우팅 상세 정보
                </div>

                <div>
                    <c:choose>
                        <c:when test="${rout.itemType == 20}">
                            <span class="status-back status-back-warning"> • 반제품 </span>
                        </c:when>

                        <c:when test="${rout.itemType == 30}">
                            <span class="status-back status-back-success"> • 완제품 </span>
                        </c:when>

                        <c:otherwise>
                            <span class="status-back status-back-info"> - </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-table-wrap">
                <table class="info-table">
                    <tbody>
                        <tr>
                            <th>라우팅 번호</th>
                            <td>${rout.routId}</td>

                            <th>라우팅명</th>
                            <td>${rout.routName}</td>
                        </tr>

                        <tr>
                            <th>품목명</th>
                            <td>
	                            <a class="toDetail"
	                               href="${pageContext.request.contextPath}/item/detail?itemId=${rout.routItem}">
	                                ${rout.itemName}
	                            </a>
	                        </td>
                            
                            <th>품목 코드</th>
                            <td>
	                            <a class="toDetail"
	                               href="${pageContext.request.contextPath}/item/detail?itemId=${rout.routItem}">
	                                ${rout.routItem}
	                            </a>
	                        </td>
                        </tr>

                        <tr>
                            <th>라우팅 설명</th>
                            <td colspan="3">
                                <c:choose>
                                    <c:when test="${empty rout.routContent}">
                                        -
                                    </c:when>

                                    <c:otherwise>
                                        ${rout.routContent}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

    <!-- 공정 흐름 -->
    <div class="content-content">
        <div class="content-content-content">

            <div class="routing-section-title-row">
                <div>
                    <div class="content-content-content-title">
                        공정 흐름
                    </div>

                    <p class="page-subtitle">
                        라우팅에 등록된 공정 순서입니다.
                    </p>
                </div>
            </div>

            <c:choose>
                <c:when test="${empty routDetailList}">
                    <div class="empty-box">
                        등록된 공정이 없습니다.
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="flow-card-wrap">

                        <c:forEach var="detail"
                                   items="${routDetailList}"
                                   varStatus="status">

                            <div class="flow-flow-item">

                                <c:if test="${!status.first}">
                                    <div class="flow-inline-arrow">
                                        →
                                    </div>
                                </c:if>

                                <div class="flow-card proc-detail-open"
									 data-rout-id="${rout.routId}"
									 data-proc-id="${detail.procId}">
                                    <div class="step-badge">
                                        ${status.count}
                                    </div>

                                    <div class="flow-card-title">
                                        ${detail.procName}
                                    </div>

                                    <div class="flow-card-code">
                                        ${detail.procId}
                                    </div>
                                </div>

                            </div>

                        </c:forEach>

                    </div>
                </c:otherwise>
            </c:choose>

        </div>
    </div>

    <!-- 단계 정보 -->
    <div class="content-content">
        <div class="content-content-content">

            <div class="routing-section-title-row">
                <div>
                    <div class="content-content-content-title">
                        단계 정보
                    </div>

                    <p class="page-subtitle">
                        각 공정의 설명, 작업장 타입, 사용 설비를 확인합니다.
                    </p>
                </div>
            </div>

            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 70px;">단계</th>
                            <th style="width: 190px;">공정명</th>
                            <th>공정 설명</th>
                            <th style="width: 125px;">작업장 타입</th>
                            <th style="width: 180px;">사용 설비</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:choose>
                            <c:when test="${empty routDetailList}">
                                <tr>
                                    <td colspan="5" style="text-align: center;">
                                        등록된 공정이 없습니다.
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="detail"
                                           items="${routDetailList}"
                                           varStatus="status">

                                    <tr class="proc-detail-open"
										data-rout-id="${rout.routId}"
										data-proc-id="${detail.procId}">
										
                                        <td>${status.count}</td>

                                        <td class="proc-name-cell">
										    ${detail.procName}
										    <span class="muted-text">
										        (${detail.procId})
										    </span>
										</td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${empty detail.procContent}">
                                                    -
                                                </c:when>
                                                <c:otherwise>
                                                    ${detail.procContent}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${empty detail.wpTypeName}">
                                                    -
                                                </c:when>
                                                <c:otherwise>
                                                    ${detail.wpTypeName}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${detail.eqCount == 0}">
                                                    -
                                                </c:when>

                                                <c:when test="${detail.eqCount == 1}">
                                                    ${detail.firstEqName}
                                                </c:when>

                                                <c:otherwise>
                                                    ${detail.firstEqName} 외 ${detail.eqCount - 1}건
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>

                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </div>
    </div>

</div>

<div class="overlay" id="procDetailModal">
	<div class="modal proc-detail-modal">

		<div class="modal-header">
			<div>
				<h3 class="modal-title">공정 상세정보</h3>
				<p class="modal-subTitle" id="procDetailModalSubTitle">
					공정명(공정번호)의 상세 내용을 확인하세요.
				</p>
			</div>

			<button type="button"
					class="modal-close"
					id="closeProcDetailModalBtn">
				×
			</button>
		</div>

		<div class="info-table-wrap proc-detail-info-wrap">
			<table class="info-table proc-detail-info-table">
				<tbody>
					<tr>
						<th>라우팅</th>
						<td id="procDetailRouting">-</td>
					</tr>

					<tr>
						<th>공정명</th>
						<td id="procDetailProcName">-</td>
					</tr>

					<tr>
						<th>작업장 유형</th>
						<td id="procDetailWpType">-</td>
					</tr>

					<tr>
						<th>작업장</th>
						<td id="procDetailWpList">-</td>
					</tr>

					<tr>
						<th>설비명</th>
						<td id="procDetailEqList">-</td>
					</tr>

					<tr>
						<th colspan="2" style="text-align:left;">공정 설명</th>
					</tr>
					<tr>
						<td id="procDetailContent" colspan="2" style="text-align:left; vertical-align:top; padding-top:14px;">
							내용 없음
						</td>
					</tr>
					
				</tbody>
			</table>
		</div>

	</div>
</div>


<style>

	.content-content-content-title {
		margin-top: 20px;
	}
	

    .rout-title-row {
        display: flex;
        justify-content: space-between;
        align-items: center;

        margin-bottom: 16px;
    }

    .rout-title-row .content-content-content-title {
        margin-bottom: 0;
    }

    .routing-section-title-row {
        margin-bottom: 16px;

        display: flex;
        align-items: flex-end;
        justify-content: space-between;
    }

    .flow-card-wrap {
        display: flex;
        flex-wrap: wrap;

        margin-top: 18px;
    }

    .flow-flow-item {
        display: flex;
        align-items: center;

        margin-right: 18px;
        margin-bottom: 18px;
    }

    .flow-inline-arrow {
        margin-right: 18px;

        font-size: 28px;
        font-weight: 700;
        color: #111;
    }

    .flow-card {
        position: relative;

        width: 160px;
        min-height: 110px;

        padding: 45px 16px 18px;

        border: 1px solid #ccc;
        border-radius: 8px;
        background: #fff;

        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;

        text-align: center;
    }

    .step-badge {
        position: absolute;
        top: 8px;
        left: 8px;

        width: 30px;
        height: 30px;

        border-radius: 50%;

        background: var(--main-green);
        color: #fff;

        display: flex;
        align-items: center;
        justify-content: center;

        font-weight: 700;
    }

    .flow-card-title {
        font-size: 16px;
        font-weight: 700;
        margin-top: 6px;
        margin-bottom: 8px;
    }

    .flow-card-code {
        color: #777;
        font-size: 13px;
    }

    .empty-box {
        padding: 32px;

        border: 1px solid #ddd;
        border-radius: 8px;

        color: #777;
        text-align: center;
    }

    .muted-text {
        color: #777;
        font-size: 13px;
    }
    
    
    /* =========== */
    
    .proc-detail-modal {
		width: 760px;
		max-width: calc(100vw - 40px);
		max-height: calc(100vh - 80px);
		overflow-y: auto;
	}
	
	.modal-header {
		display: flex;
		justify-content: space-between;
		align-items: flex-start;
		gap: 20px;
		margin-bottom: 20px;
	}
	
	.modal-close {
		font-size: 20px;
		cursor: pointer;
		line-height: 1;
	}
	
	.proc-detail-info-wrap {
		margin-top: 0;
		padding: 0;
	}
	
	.proc-detail-info-table th {
		width: 150px;
	}
	
	.proc-detail-info-table td {
		width: auto;
		line-height: 1.6;
		padding-top: 10px;
		padding-bottom: 10px;
	}
	
	a:hover {
		color: var(--main-green);
	}
		
	.modal-btn-row {
		margin-top: 24px;
		display: flex;
		justify-content: flex-end;
		gap: 8px;
	}
	
	.proc-detail-open {
		cursor: pointer;
	}
	
	.proc-detail-open:hover .flow-card-title,
	.proc-detail-open:hover .proc-name-cell {
		color: var(--main-green);
		text-decoration: underline;
	}
	
	.proc-detail-open:hover .proc-name-cell .muted-text {
		color: var(--main-green);
	}
	
	
	
	
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	
	.content {
		padding: 16px;
		box-sizing: border-box;
	}

	.header-row {
		flex-direction: column;
		gap: 12px;
	}

	.page-title {
		font-size: 22px;
	}

	.page-subtitle {
		font-size: 13px;
		line-height: 1.5;
	}

	.page-route {
		font-size: 12px;
	}

	.btn-row {
		justify-content: space-around;
		gap: 55px;
	}

	.btn-row .left,
	.btn-row .right {
		width: 100%;
		display: flex;
		justify-content: center;
		gap: 8px;
	}
	
	.status-back {
		font-size: 10px;
	}

	.btn-row .btn {
		text-align: center;
	}

	.content-content-content {
		padding: 10px;
		box-sizing: border-box;
	}

	.rout-title-row,
	.routing-section-title-row {
		align-items: flex-start;
		gap: 8px;
	}

	.content-content-content-title {
		font-size: 18px;
		margin-top: 10px;
	}

	/* 상세 정보는 2개씩 유지 */
	.info-table {
		width: 100%;
		table-layout: fixed;
	}

	.info-table th,
	.info-table td {
		padding: 9px 6px;
		font-size: 10px;
		word-break: break-word;
	}

	.info-table th {
		width: 25%;
		white-space: nowrap;
	}

	.info-table td {
		width: 30%;
	}

	.info-table td[colspan="3"] {
		width: 75%;
	}

	/* 공정 흐름 카드 축소 */
	.flow-card-wrap {
		display: flex;
		flex-wrap: nowrap;
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
		gap: 8px;
		padding-bottom: 8px;
	}

	.flow-flow-item {
		margin-right: 0;
		margin-bottom: 0;
		flex: 0 0 auto;
	}

	.flow-inline-arrow {
		margin-right: 8px;
		font-size: 20px;
	}

	.flow-card {
		width: 115px;
		min-height: 82px;
		padding: 34px 10px 12px;
	}

	.step-badge {
		width: 24px;
		height: 24px;
		font-size: 12px;
	}

	.flow-card-title {
		font-size: 13px;
		margin-bottom: 4px;
	}

	.flow-card-code {
		font-size: 11px;
	}

	/* 단계 정보 테이블 축소 */
	.table-wrap {
		width: 100%;
		overflow-x: auto;
		-webkit-overflow-scrolling: touch;
	}

	.table {
		min-width: 620px;
	}

	.table th,
	.table td {
		padding: 6px 4px;
		font-size: 11px;
		line-height: 1.25;
		white-space: nowrap;
	}

	.table th {
		font-size: 10px;
		font-weight: 600;
	}

	.table tr {
		height: 36px;
	}

	.table tr th:nth-child(1),
	.table tr td:nth-child(1) {
		width: 45px !important;
	}

	.table tr th:nth-child(2),
	.table tr td:nth-child(2) {
		width: 130px !important;
	}

	.table tr th:nth-child(3),
	.table tr td:nth-child(3) {
		width: 180px !important;
		white-space: normal;
		word-break: break-word;
	}

	.table tr th:nth-child(4),
	.table tr td:nth-child(4) {
		width: 90px !important;
	}

	.table tr th:nth-child(5),
	.table tr td:nth-child(5) {
		width: 130px !important;
	}

	.muted-text {
		font-size: 10px;
	}

	/* 모달 */
	.proc-detail-modal {
		width: calc(100vw - 32px);
		max-width: calc(100vw - 32px);
		max-height: calc(100vh - 60px);
		padding: 16px;
		box-sizing: border-box;
	}

	.modal-header {
		gap: 10px;
	}

	.modal-title {
		font-size: 18px;
	}

	.modal-subTitle {
		font-size: 12px;
		line-height: 1.4;
	}

	.proc-detail-info-table th,
	.proc-detail-info-table td {
		display: table-cell;
		font-size: 12px;
		padding: 8px 6px;
	}

	.proc-detail-info-table th {
		width: 90px;
	}
	
	.overlay {
		padding: 16px;
		box-sizing: border-box;
		align-items: flex-start;
		overflow-y: auto;
	}
	
	.proc-detail-modal {
		width: 100% !important;
		max-width: 100% !important;
		max-height: none !important;
		margin-top: 40px;
		padding: 16px;
		box-sizing: border-box;
		border-radius: 10px;
	}
	
	.modal-header {
		flex-direction: row;
		align-items: flex-start;
		gap: 10px;
		margin-bottom: 14px;
	}
	
	.modal-title {
		font-size: 18px;
	}
	
	.modal-subTitle {
		font-size: 12px;
		line-height: 1.4;
	}
	
	.modal-close {
		font-size: 22px;
		min-width: 28px;
		height: 28px;
	}
	
	.proc-detail-info-wrap {
		width: 100%;
		overflow-x: visible;
	}
	
	.proc-detail-info-table {
		width: 100%;
		table-layout: fixed;
	}
	
	.proc-detail-info-table th,
	.proc-detail-info-table td {
		font-size: 12px;
		padding: 8px 6px;
		line-height: 1.5;
		word-break: break-word;
		white-space: normal;
	}
	
	.proc-detail-info-table th {
		width: 32%;
	}
	
	.proc-detail-info-table td {
		width: 68%;
	}
	
	.proc-detail-info-table a {
		display: inline-block;
		margin-bottom: 4px;
		word-break: break-word;
	}
	
	#procDetailContent {
		min-height: 80px;
	}
	
}
	
</style>


<script>
	document.addEventListener("DOMContentLoaded", function() {
	
		const procDetailModal = document.getElementById("procDetailModal");
	
		const closeProcDetailModalBtn = document.getElementById("closeProcDetailModalBtn");
	
		const procDetailModalSubTitle = document.getElementById("procDetailModalSubTitle");
		const procDetailRouting = document.getElementById("procDetailRouting");
		const procDetailProcName = document.getElementById("procDetailProcName");
		const procDetailWpType = document.getElementById("procDetailWpType");
		const procDetailWpList = document.getElementById("procDetailWpList");
		const procDetailEqList = document.getElementById("procDetailEqList");
		const procDetailContent = document.getElementById("procDetailContent");
	
		const contextPath = "${pageContext.request.contextPath}";
	
		const procOpenItems = document.querySelectorAll(".proc-detail-open");
	
		procOpenItems.forEach(function(item) {
			item.addEventListener("click", function() {
				const routId = item.dataset.routId;
				const procId = item.dataset.procId;
	
				loadProcDetail(routId, procId);
			});
		});
	
		closeProcDetailModalBtn.addEventListener("click", function() {
			closeProcDetailModal();
		});
	
	
		procDetailModal.addEventListener("click", function(e) {
			if (e.target === procDetailModal) {
				closeProcDetailModal();
			}
		});
	
		function loadProcDetail(routId, procId) {
			fetch(contextPath + "/routing/proc/detail?routId=" + encodeURIComponent(routId)
					+ "&procId=" + encodeURIComponent(procId))
				.then(function(response) {
					if (!response.ok) {
						throw new Error("공정 상세 조회 실패");
					}
	
					return response.json();
				})
				.then(function(data) {
					if (!data) {
						alert("공정 상세 정보를 찾을 수 없습니다.");
						return;
					}
	
					renderProcDetail(data);
					openModal(procDetailModal);
				})
				.catch(function(error) {
					console.error(error);
					alert("공정 상세 정보를 불러오는 중 오류가 발생했습니다.");
				});
		}
	
		function renderProcDetail(data) {
			const routText = safeText(data.routName) + " (" + safeText(data.routId) + ")";
			const procText = safeText(data.procName) + " (" + safeText(data.procId) + ")";
	
			procDetailModalSubTitle.textContent =
				procText + "의 상세 내용을 확인하세요.";
	
			procDetailRouting.textContent = routText;
			procDetailProcName.textContent = safeText(data.procName);
			procDetailWpType.textContent = emptyToDash(data.wpTypeName);
			procDetailContent.textContent = emptyToDash(data.procContent);
	
			renderLinkList(
				procDetailWpList,
				data.wpList,
				contextPath + "/workplace/detail?wpId="
			);
	
			renderLinkList(
				procDetailEqList,
				data.eqList,
				contextPath + "/equip/detail?eqId="
			);
		}
	
		function renderLinkList(target, list, baseUrl) {
			target.innerHTML = "";
	
			if (!list || list.length === 0) {
				target.textContent = "-";
				return;
			}
	
			list.forEach(function(item, index) {
				const link = document.createElement("a");
	
				link.href = baseUrl + encodeURIComponent(item.id);
				link.textContent = safeText(item.name) + " (" + safeText(item.id) + ")";
	
				target.appendChild(link);
	
				if (index < list.length - 1) {
					target.appendChild(document.createTextNode(", "));
				}
			});
		}
	
		function closeProcDetailModal() {
			closeModal(procDetailModal);
			clearProcDetailModal();
		}
	
		function clearProcDetailModal() {
			procDetailModalSubTitle.textContent =
				"공정명(공정번호)의 상세 내용을 확인하세요.";
	
			procDetailRouting.textContent = "-";
			procDetailProcName.textContent = "-";
			procDetailWpType.textContent = "-";
			procDetailWpList.textContent = "-";
			procDetailEqList.textContent = "-";
			procDetailContent.textContent = "내용 없음";
		}
	
		function emptyToDash(value) {
			if (value == null || String(value).trim() === "") {
				return "-";
			}
	
			return String(value);
		}
	
		function safeText(value) {
			if (value == null) {
				return "";
			}
	
			return String(value);
		}
	});
</script>