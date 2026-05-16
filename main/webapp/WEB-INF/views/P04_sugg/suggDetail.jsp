<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">건의사항 상세</h2>
            <p class="page-subtitle">선택한 건의사항의 상세 정보를 확인하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 > 건의사항 관리 > 상세</p>
        </div>
    </div>

    <div class="btn-row">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/sugg/list">
                목록으로
            </a>
        </div>

        <div class="right">
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/sugg/edit?sugg_no=${dto.sugg_no}">
                수정
            </a>

            <a class="btn btn-red"
               href="${pageContext.request.contextPath}/sugg/delete?sugg_no=${dto.sugg_no}">
                삭제
            </a>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content">
            <div class="content-content-content-title">
                건의사항 기본정보
            </div>

            <div class="info-table-wrap">
                <table class="info-table">
                    <tbody>
                        <tr>
                            <th>건의사항 번호</th>
                            <td>${dto.sugg_no}</td>
                            <th>작성자</th>
                            <td>${dto.sugg_writer}</td>
                        </tr>

                        <tr>
                            <th>제목</th>
                            <td colspan="3">${dto.sugg_title}</td>
                        </tr>

                        <tr>
                            <th>답변 여부</th>
                            <td>${dto.sugg_answer}</td>
                            <th>유효 여부</th>
                            <td>${dto.sugg_usage}</td>
                        </tr>

                        <tr>
                            <th>작성일</th>
                            <td>${dto.sugg_cdate}</td>
                            <th>수정일</th>
                            <td>${dto.sugg_mdate}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="content-content-content">
            <div class="content-content-content-title">
                건의 내용
            </div>

            <div class="info-table-wrap">
                <table class="info-table">
                    <tbody>
                        <tr>
                            <th>내용</th>
                            <td style="white-space: pre-line;">
                                ${dto.sugg_content}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="content-content-content">
            <div class="btn-row">
                <div class="left content-content-content-title">
                    댓글 목록
                </div>

                <div class="right">
                    <a class="btn btn-main"
                       href="${pageContext.request.contextPath}/sugg/comment/add?sugg_no=${dto.sugg_no}">
                        댓글 등록
                    </a>
                </div>
            </div>

            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th style="width: 120px">댓글 번호</th>
                            <th>댓글 내용</th>
                            <th style="width: 160px">작성자</th>
                            <th style="width: 180px">작성일</th>
                            <th style="width: 180px">수정일</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="comm" items="${commList}">
                            <tr>
                                <td>${comm.comm_no}</td>
                                <td style="text-align: left;">
                                    ${comm.comm_content}
                                </td>
                                <td>${comm.comm_writer}</td>
                                <td>${comm.comm_cdate}</td>
                                <td>${comm.comm_mdate}</td>
                            </tr>
                        </c:forEach>

                        <c:if test="${empty commList}">
                            <tr>
                                <td colspan="5" style="text-align: center;">
                                    등록된 댓글이 없습니다.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

</div>

<script>

</script>