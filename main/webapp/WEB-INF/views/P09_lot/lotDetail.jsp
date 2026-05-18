<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">LOT 상세</h2>
            <p class="page-subtitle">
                LOT 정보와 사용 이력을 확인할 수 있습니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > LOT관리 > 상세
            </p>
        </div>

    </div>

    <div class="btn-row">

        <div>
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/lot/list">
                목록
            </a>
        </div>

    </div>

    <div class="content-content">

        <!-- LOT 상세 -->
        <div class="content-content-content">

            <div style="
                display:flex;
                justify-content:space-between;
                align-items:center;
                margin-bottom:14px;
            ">

                <div class="content-content-content-title">
                    LOT 상세정보
                </div>

                <div>

                    <span class="btn btn-main"
                        style="cursor:default;">
                        QR 코드
                    </span>

                </div>

            </div>

            <div class="info-table-wrap">

                <table class="info-table">

                    <tr>
                        <th>LOT 번호</th>
                        <td>${lot.lotId}</td>

                        <th>품목</th>
                        <td>${lot.lotItem}</td>
                    </tr>

                    <tr>
                        <th>입고 번호</th>
                        <td>${lot.lotVendor}</td>

                        <th>제조일시</th>
                        <td>${lot.lotMfd}</td>
                    </tr>

                    <tr>
                        <th>입고일시</th>
                        <td>${lot.lotEtw}</td>

                        <th>입고수량</th>
                        <td>${lot.lotIqty} EA</td>
                    </tr>

                    <tr>
                        <th>출고일시</th>
                        <td>-</td>

                        <th>현재 수량</th>
                        <td>${lot.lotFqty} EA</td>
                    </tr>

                    <tr>
                        <th>유통기한</th>
                        <td>${lot.lotExp}</td>

                        <th>위치</th>
                        <td>${lot.lotAwhsec}</td>
                    </tr>

                </table>

            </div>

        </div>

        <!-- 사용이력 -->
        <div class="content-content-content">

            <div class="content-content-content-title">
                LOT 사용 기록
            </div>

            <div class="table-wrap">

                <table class="table">

                    <thead>
                        <tr>
                            <th style="width: 140px;">작업 코드</th>
                            <th style="width: 140px;">사용수량</th>
                            <th style="width: 160px;">사용일</th>
                            <th style="width: 140px;">사용유형</th>
                            <th>비고</th>
                        </tr>
                    </thead>

                    <tbody>

                        <tr>
                            <td>WO1001</td>
                            <td>100 EA</td>
                            <td>2026-05-12</td>
                            <td>테스트</td>
                            <td>비고내용</td>
                        </tr>

                        <tr>
                            <td>WO1002</td>
                            <td>300 EA</td>
                            <td>2026-05-13</td>
                            <td>생산투입</td>
                            <td>-</td>
                        </tr>

                        <tr>
                            <td>WO1003</td>
                            <td>50 EA</td>
                            <td>2026-05-14</td>
                            <td>출고</td>
                            <td>-</td>
                        </tr>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>