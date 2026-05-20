<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">건의사항 수정</h2>
        </div>

        <div>
            <p class="page-route">홈 > 건의사항 > 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/sugg/edit"
          method="post"
          enctype="multipart/form-data">

        <input type="hidden"
               name="sugg_no"
               value="${dto.sugg_no}">

        <input type="hidden"
               name="deleteFile"
               id="deleteFile"
               value="N">

        <div class="btn-row"
             style="margin-top:18px; margin-bottom:12px;">

            <div class="left"></div>

            <div class="right">

                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/sugg/detail?sugg_no=${dto.sugg_no}">
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

                    <!-- 제목 / 비밀번호 -->
                    <div style="
                            display:grid;
                            grid-template-columns: 1fr 160px;
                            gap:10px;
                            margin-bottom:24px;">

                        <div>

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
                                   name="sugg_title"
                                   value="${dto.sugg_title}"
                                   placeholder="제목을 입력하세요"
                                   required
                                   style="
                                        width:100%;
                                        height:36px;
                                        border:1px solid #aaa;
                                        padding:0 12px;
                                        box-sizing:border-box;">

                        </div>

                        <div>

                            <label style="
                                    display:block;
                                    font-weight:bold;
                                    margin-bottom:8px;">

                                비밀번호

                            </label>

                            <input type="password"
                                   name="sugg_pw"
                                   value="${dto.sugg_pw}"
                                   placeholder="숫자 4자리"
                                   required
                                   style="
                                        width:100%;
                                        height:36px;
                                        border:1px solid #aaa;
                                        padding:0 12px;
                                        box-sizing:border-box;">

                        </div>

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

                        <textarea name="sugg_content"
                                  placeholder="내용을 입력하세요"
                                  required
                                  style="
                                    width:100%;
                                    height:260px;
                                    border:1px solid #aaa;
                                    padding:14px;
                                    box-sizing:border-box;
                                    resize:none;">${dto.sugg_content}</textarea>

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
                               name="uploadFile"
                               id="uploadFile"
                               style="display:none;">

                        <label for="uploadFile"
                               class="btn btn-white">
                            첨부파일 추가
                        </label>

                        <div id="oldFileBox"
                             style="
                                display:flex;
                                align-items:center;
                                gap:8px;">

                            <span id="fileName"
                                  style="
                                    font-size:14px;
                                    color:#555;">

                                <c:choose>

                                    <c:when test="${not empty dto.sugg_file_origin_name}">
                                        ${dto.sugg_file_origin_name}
                                    </c:when>

                                    <c:otherwise>
                                        선택된 파일 없음
                                    </c:otherwise>

                                </c:choose>

                            </span>

                            <c:if test="${not empty dto.sugg_file_origin_name}">

                                <button type="button"
                                        id="deleteFileBtn"
                                        class="btn btn-white">
                                    삭제
                                </button>

                            </c:if>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </form>

</div>

<script>

document.querySelector("#uploadFile")
.addEventListener("change", function() {

    const fileName =
        this.files.length > 0
        ? this.files[0].name
        : "선택된 파일 없음";

    document.querySelector("#fileName")
        .innerText = fileName;

    document.querySelector("#deleteFile")
        .value = "N";

    const oldFileBox =
        document.querySelector("#oldFileBox");

    if(oldFileBox){
        oldFileBox.style.display = "flex";
    }

});


const deleteFileBtn =
    document.querySelector("#deleteFileBtn");

if(deleteFileBtn){

    deleteFileBtn
    .addEventListener("click", function(){

        document.querySelector("#deleteFile")
            .value = "Y";

        document.querySelector("#oldFileBox")
            .style.display = "none";

        alert(
            "첨부파일 삭제 처리되었습니다.\n수정 버튼을 눌러야 적용됩니다."
        );

    });

}

</script>