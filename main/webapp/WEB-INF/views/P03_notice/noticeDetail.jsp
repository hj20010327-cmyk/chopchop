<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">공지사항 상세</h2>
        </div>

        <div>
            <p class="page-route">홈 > 공지사항 > 상세</p>
        </div>
    </div>

    <div class="btn-row" style="margin-top:20px;">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/notice/list">
                목록
            </a>
        </div>

        <div class="right">
            <c:if test="${isAdmin}">
                <a class="btn btn-main"
                   href="${pageContext.request.contextPath}/notice/edit?not_no=${dto.not_no}">
                    수정
                </a>

                <form action="${pageContext.request.contextPath}/notice/delete"
                      method="post"
                      style="display:inline;">

                    <input type="hidden"
                           name="not_no"
                           value="${dto.not_no}">

                    <button type="submit"
                            class="btn btn-red"
                            onclick="return confirm('삭제하시겠습니까?');">
                        삭제
                    </button>
                </form>
            </c:if>
        </div>
    </div>

    <div class="content-content">

        <div class="content-content-content">

            <div class="info-table-wrap"
                 style="
                    border:1px solid #d9d9d9;
                    border-radius:4px;
                    background:#fff;
                    overflow:hidden;
                    margin-top:10px;">

                <div style="padding:24px 24px 14px;">

                    <div style="
                            font-size:22px;
                            font-weight:700;
                            color:#222;">
                        ${dto.not_title}
                    </div>

                </div>

                <div style="
                        border-top:1px solid #ddd;
                        border-bottom:1px solid #ddd;
                        padding:10px 24px;
                        font-size:12px;
                        color:#555;">

                    <span style="margin-right:28px;">
                        작성자 ${dto.empName} (${dto.not_writer})
                    </span>

                    <span style="margin-right:28px;">
                        등록일 ${dto.not_cdate}
                    </span>

                    <span style="margin-right:28px;">
                        조회수 ${dto.not_view}
                    </span>

                    <span id="copyurl"
                          style="float:right; cursor:pointer;">
                        URL 복사
                    </span>

                </div>

                <div style="
                        min-height:260px;
                        padding:26px 24px;
                        font-size:17px;
                        line-height:1.8;
                        white-space:pre-line;
                        color:#333;">

                    ${dto.not_content}

                </div>

                <c:if test="${not empty fileList}">
                    <div style="
                            border-top:1px solid #ddd;
                            padding:12px 24px;
                            font-size:13px;
                            color:#555;">

                        <div style="font-weight:bold; margin-bottom:8px;">
                            첨부파일
                        </div>

                        <c:forEach var="file" items="${fileList}">
                            <div style="margin-bottom:6px;">
                                <a href="${pageContext.request.contextPath}/resources/upload/notice/${file.file_save_name}"
                                   download="${file.file_origin_name}">
                                    ${file.file_origin_name}
                                </a>
                            </div>
                        </c:forEach>

                    </div>
                </c:if>

            </div>

        </div>

    </div>
</div>

<script>
document.querySelector("#copyurl").addEventListener("click", function () {
    navigator.clipboard.writeText(window.location.href);
    alert("URL이 복사되었습니다.");
});
</script>