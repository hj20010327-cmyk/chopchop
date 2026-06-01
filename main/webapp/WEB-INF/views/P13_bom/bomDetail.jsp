<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">BOM 상세</h2>
            <p class="page-subtitle">BOM 기본 정보와 구성 품목을 확인할 수 있습니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; BOM 관리 &gt; 상세</p>
        </div>
    </div>

    <div class="btn-row">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/bom/list">
                목록
            </a>
        </div>

        <div class="right">
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/bom/edit?bomId=${bom.bomId}">
                수정
            </a>

            <a class="btn btn-red"
               href="${pageContext.request.contextPath}/bom/delete?bomId=${bom.bomId}"
               onclick="return confirm('BOM(${bom.bomId})을 삭제하시겠습니까?');">
                삭제
            </a>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content bom-info-section">

            <div class="bom-title-row">
                <div class="content-content-content-title">
                    BOM 기본 정보
                </div>

                <div>
                    <c:choose>
                        <c:when test="${bom.itemType == 20}">
                            <span class="status-back status-back-warning"> • 반제품 </span>
                        </c:when>
                        <c:when test="${bom.itemType == 30}">
                            <span class="status-back status-back-success"> • 완제품 </span>
                        </c:when>
                        <c:otherwise>
                            <span class="status-back status-back-info"> ${bom.itemType} </span>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="info-table-wrap">
                <table class="info-table">
                    <tr>
                        <th>BOM 코드</th>
                        <td>${bom.bomId}</td>
                        <th>BOM명</th>
                        <td>${bom.bomName}</td>
                    </tr>

                    <tr>
                        <th>생산 품목명</th>
                        <td>
                            <a class="toDetail"
                               href="${pageContext.request.contextPath}/item/detail?itemId=${bom.bomItem}">
                                ${bom.itemName} (${bom.bomItem})
                            </a>
                        </td>

                        <th>설명</th>
                        <td>${bom.bomContent}</td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="content-content-content">
            <div class="content-content-content-title">
                BOM 구성 품목
            </div>

            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
						    <th>품목명</th>
						    <th style="width: 120px;">품목유형</th>
						    <th style="width: 120px;">소요수량</th>
						    <th style="width: 150px;">규격</th>
						    <th style="width: 130px;">단가 (원)</th>
						    <th style="width: 150px;">소요금액 (원)</th>
						</tr>
                    </thead>

                    <tbody>
                        <c:forEach var="detail" items="${detailList}">
                            <tr class="bom-detail-row"
                                data-item-id="${detail.bomDtlItem}">

                                <td>
                                    <a class="toDetail"
                                       href="${pageContext.request.contextPath}/item/detail?itemId=${detail.bomDtlItem}">
                                        ${detail.itemName} (${detail.bomDtlItem})
                                    </a>
                                </td>

                                <td>
                                    <c:choose>
                                        <c:when test="${detail.itemType == 10}">
                                            <span class="status status-safe">
                                                • 원자재
                                            </span>
                                        </c:when>

                                        <c:when test="${detail.itemType == 20}">
                                            <span class="status status-warning">
                                                • 반제품
                                            </span>
                                        </c:when>

                                        <c:when test="${detail.itemType == 40}">
                                            <span class="status status-info">
                                                • 기타 자재
                                            </span>
                                        </c:when>

                                        <c:otherwise>
                                            <span class="status status-info">
                                                -
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>
                                    <fmt:formatNumber value="${detail.bomDtlQty}" pattern="#,##0" />
                                    ${detail.itemUnit}
                                </td>

                                <td>
                                    ${detail.itemSpec} / ${detail.itemUnit}
                                </td>

                                <td>
                                    <fmt:formatNumber value="${detail.itemPrice}" pattern="#,##0" />
                                </td>

                                <td>
                                    <fmt:formatNumber value="${detail.itemPrice * detail.bomDtlQty}" pattern="#,##0" />
                                </td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty detailList}">
                            <tr>
                                <td colspan="6" style="text-align:center;">
                                    등록된 BOM 구성 품목이 없습니다.
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
    .bom-title-row {
        display: flex;
        justify-content: space-between;
        align-items: center;

        margin-bottom: 18px;
    }

    .bom-title-row .content-content-content-title {
        margin-bottom: 0;
    }

    .bom-detail-row {
        cursor: pointer;
    }
    
        
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {

	.table tr th:nth-child(2), .table tr td:nth-child(2),
	.table tr th:nth-child(3), .table tr td:nth-child(3),
	.table tr th:nth-child(5), .table tr td:nth-child(5),
	.table tr th:last-child, .table tr td:last-child {
		width: 100px !important;
	}
	
	.table tr th:first-child, .table tr td:first-child {
		width: 150px;
	}
	
}

</style>

<script>
    window.addEventListener("load", () => {
        init();
    });

    function init() {
        bind();
    }

    function bind() {
        moveItemDetail();
    }

    function moveItemDetail() {
        const rows = document.querySelectorAll(".bom-detail-row");

        for (let i = 0; i < rows.length; i++) {
            rows[i].addEventListener("click", () => {
                const itemId = rows[i].dataset.itemId;

                const url = "${pageContext.request.contextPath}/item/detail?itemId=" + itemId;

                window.location.href = url;
            });
        }
    }
</script>