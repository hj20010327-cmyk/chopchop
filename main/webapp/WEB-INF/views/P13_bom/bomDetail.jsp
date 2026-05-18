<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
        <div>
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/bom/list">
                목록
            </a>
        </div>

        <div>
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/bom/edit?bomId=${bom.bomId}">
                수정
            </a>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content">
            <div class="content-content-content-title">
                BOM 기본 정보
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
                        <th>완제품 코드</th>
                        <td>${bom.bomItem}</td>
                        <th>완제품명</th>
                        <td>${bom.itemName}</td>
                    </tr>

                    <tr>
                        <th>품목 유형</th>
                        <td>
                            <c:choose>
							    <c:when test="${bom.itemType == 10}">
							        원자재
							    </c:when>
							    <c:when test="${bom.itemType == 20}">
							        반제품
							    </c:when>
							    <c:when test="${bom.itemType == 30}">
							        완제품
							    </c:when>
							    <c:otherwise>
							        ${bom.itemType}
							    </c:otherwise>
							</c:choose>
                        </td>

                        <th>사용 여부</th>
                        <td>
                            <c:choose>
                                <c:when test="${bom.bomUsage == 'Y'}">
                                    <span class="status status-success">사용</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status status-info">미사용</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>

                    <tr>
                        <th>설명</th>
                        <td colspan="3">${bom.bomContent}</td>
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
                            <th style="width: 130px;">상세코드</th>
                            <th style="width: 160px;">품목코드</th>
                            <th>품목명</th>
                            <th style="width: 120px;">품목유형</th>
                            <th style="width: 120px;">소요수량</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="detail" items="${detailList}">
                            <tr>
                                <td>${detail.bomDtlId}</td>
                                <td>${detail.bomDtlItem}</td>
                                <td>${detail.itemName}</td>

                                <td>
                                    <c:choose>
                                        <c:when test="${detail.itemType == 'FIN'}">
                                            완제품
                                        </c:when>
                                        <c:when test="${detail.itemType == 'MAT'}">
                                            원자재
                                        </c:when>
                                        <c:otherwise>
                                            ${detail.itemType}
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td>${detail.bomDtlQty}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty detailList}">
                            <tr>
                                <td colspan="5"
                                    style="text-align:center;">
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