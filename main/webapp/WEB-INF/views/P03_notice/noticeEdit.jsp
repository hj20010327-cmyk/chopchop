<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">공지사항 수정</h2>
        </div>

        <div>
            <p class="page-route">홈 > 공지사항 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/notice/edit"
          method="post"
          enctype="multipart/form-data">

        <input type="hidden"
               name="not_no"
               value="${dto.not_no}">

        <div class="btn-row"
             style="margin-top:18px; margin-bottom:12px;">

            <div class="left"></div>

            <div class="right">

                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/notice/detail?not_no=${dto.not_no}"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    수정
                </button>

            </div>

        </div>

        <div class="content-content">

            <div class="content-content-content">

                <div class="info-table-wrap"
                     style="
                        border:1px solid #bbb;
                        border-radius:5px;
                        padding:24px;
                        background:#fff;">

                    <!-- 제목 -->
                    <div style="margin-bottom:24px;">

                        <label style="
                                display:block;
                                font-weight:bold;
                                margin-bottom:8px;">

                            제목
                            <span style="color:#d33;">
                                *
                            </span>

                        </label>

                        <input type="text"
                               name="not_title"
                               value="${dto.not_title}"
                               placeholder="제목을 입력하세요"
                               required
                               style="
                                    width:100%;
                                    height:36px;
                                    border:1px solid #aaa;
                                    padding:0 12px;
                                    box-sizing:border-box;">

                    </div>

                    <!-- 내용 -->
                    <div style="margin-bottom:24px;">

                        <label style="
                                display:block;
                                font-weight:bold;
                                margin-bottom:8px;">

                            내용
                            <span style="color:#d33;">
                                *
                            </span>

                        </label>

                        <textarea name="not_content"
                                  placeholder="내용을 입력하세요"
                                  required
                                  style="
                                    width:100%;
                                    height:260px;
                                    border:1px solid #aaa;
                                    padding:14px;
                                    box-sizing:border-box;
                                    resize:none;">${dto.not_content}</textarea>

                    </div>

                    <!-- 첨부파일 -->
                    <div style="
                            display:flex;
                            align-items:center;
                            gap:18px;">

                        <label style="font-weight:bold;">
                            첨부파일
                        </label>

                        <input type="file"
                               name="uploadFiles"
                               id="uploadFiles"
                               multiple
                               style="display:none;">

                        <label for="uploadFiles"
                               class="btn btn-white">
                            첨부파일 추가
                        </label>

                        <div id="fileBox"
                             style="
                                display:flex;
                                align-items:center;
                                gap:8px;
                                flex-wrap:wrap;">

                            <span id="fileName"
                                  style="
                                    font-size:14px;
                                    color:#555;">

                                <c:choose>

                                    <c:when test="${not empty fileList}">
                                        기존 첨부파일 ${fileList.size()}개
                                    </c:when>

                                    <c:otherwise>
                                        선택된 파일 없음
                                    </c:otherwise>

                                </c:choose>

                            </span>

                        </div>

                    </div>

                    <!-- 기존 첨부파일 목록 -->
                    <c:if test="${not empty fileList}">

                        <div style="
                                margin-top:14px;
                                padding-left:88px;
                                font-size:13px;
                                color:#555;">

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

    </form>

</div>

<script>

document.querySelector("#uploadFiles")
.addEventListener("change", function() {

    const fileName =
        document.querySelector("#fileName");

    if (this.files.length === 0) {

        fileName.innerText = "선택된 파일 없음";
        return;
    }

    if (this.files.length === 1) {

        fileName.innerText =
            this.files[0].name;
        return;
    }

    fileName.innerText =
        this.files.length + "개 파일 선택됨";

});

</script>