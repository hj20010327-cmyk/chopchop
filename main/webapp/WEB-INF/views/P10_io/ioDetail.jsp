<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">입출고 이력 상세</h2>

            <p class="page-subtitle">
                선택한 입출고 이력의 상세 정보를 확인할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 입출고관리 > 상세
            </p>
        </div>

    </div>

    <div class="btn-row">

        <div>
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/io/list">
                목록
            </a>
        </div>

        <div>

            <a class="btn btn-main"
                href="${pageContext.request.contextPath}/io/update?ioId=${io.ioId}">
                수정
            </a>

            <a class="btn btn-red"
                href="${pageContext.request.contextPath}/io/delete?ioId=${io.ioId}">
                삭제
            </a>

        </div>

    </div>

    <div class="content-content">

        <div class="content-content-content">

            <div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:14px;
            ">

                <div class="content-content-content-title">
                    입출고 상세정보
                </div>

                <div>

                    <c:choose>

                        <c:when test="${io.ioType == '입고'}">
                            <span class="status status-safe">
                                입고
                            </span>
                        </c:when>

                        <c:when test="${io.ioType == '출고'}">
                            <span class="status status-warning">
                                출고
                            </span>
                        </c:when>

                        <c:otherwise>
                            <span class="status">
                                ${io.ioType}
                            </span>
                        </c:otherwise>

                    </c:choose>

                </div>

            </div>

            <div class="info-table-wrap">

                <table class="info-table">

                    <tr>
                        <th>입출고 번호</th>
                        <td>${io.ioId}</td>

                        <th>담당자</th>
                        <td>${io.ioWorker}</td>
                    </tr>

                    <tr>
                        <th>입출고 LOT</th>
                        <td>${io.ioLot}</td>

                        <th>입출고 품목</th>
                        <td>${io.ioVendor}</td>
                    </tr>

                    <tr>
                        <th>입출고 사유</th>
                        <td>${io.ioReason}</td>

                        <th>거래처</th>
                        <td>-</td>
                    </tr>

                    <tr>
                        <th>입출고 수량</th>
                        <td>${io.ioQty} EA</td>

                        <th>일시</th>
                        <td>${io.ioDate}</td>
                    </tr>

                    <tr>
                        <th colspan="4"
                            style="
                                text-align:left;
                                background:#fafafa;
                            ">
                            비고
                        </th>
                    </tr>

                    <tr>
                        <td colspan="4"
                            style="
                                height:80px;
                                text-align:left;
                                vertical-align:top;
                                padding-top:14px;
                            ">

                            <c:choose>

                                <c:when test="${empty io.ioMsg}">
                                    내용 없음
                                </c:when>

                                <c:otherwise>
                                    ${io.ioMsg}
                                </c:otherwise>

                            </c:choose>

                        </td>
                    </tr>

                </table>

            </div>

        </div>

    </div>

</div>