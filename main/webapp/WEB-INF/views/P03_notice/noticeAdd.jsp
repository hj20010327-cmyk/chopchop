<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">공지사항 등록</h2>
        </div>

        <div>
            <p class="page-route">홈 > 공지사항 > 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/notice/add"
          method="post"
          enctype="multipart/form-data">

        <div class="btn-row" style="margin-top:20px;">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/notice/list"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    등록
                </button>
            </div>
        </div>

        <div class="content-content">

            <div class="content-content-content">

                <div class="info-table-wrap"
                     style="
                        border:1px solid #bbb;
                        border-radius:4px;
                        background:#fff;
                        padding:24px;
                        margin-top:20px;">

                    <div style="margin-bottom:24px;">

                        <label style="
                                display:block;
                                font-weight:bold;
                                margin-bottom:12px;">
                            제목 <span style="color:red;">*</span>
                        </label>

                        <input type="text"
                               name="not_title"
                               placeholder="제목을 입력하세요"
                               required
                               style="
                                    width:100%;
                                    height:36px;
                                    border:1px solid #aaa;
                                    border-radius:3px;
                                    padding:0 12px;
                                    box-sizing:border-box;">

                    </div>

                    <div style="margin-bottom:34px;">

                        <label style="
                                display:block;
                                font-weight:bold;
                                margin-bottom:12px;">
                            내용 <span style="color:red;">*</span>
                        </label>

                        <textarea name="not_content"
                                  placeholder="내용을 입력하세요"
                                  required
                                  style="
                                    width:100%;
                                    height:260px;
                                    border:1px solid #aaa;
                                    border-radius:3px;
                                    padding:16px;
                                    box-sizing:border-box;
                                    resize:none;"></textarea>

                    </div>

                    <div style="
                            display:flex;
                            align-items:center;
                            gap:20px;">

                        <label style="
                                font-weight:bold;
                                min-width:70px;">
                            첨부파일
                        </label>

                        <label for="uploadFiles"
                               class="btn btn-white"
                               style="cursor:pointer;">
                            첨부파일 추가
                        </label>

                        <input type="file"
                               id="uploadFiles"
                               name="uploadFiles"
                               multiple
                               style="display:none;">

                        <span id="fileText"
                              style="font-size:13px; color:#555;">
                            선택된 파일 없음
                        </span>

                    </div>

                </div>

            </div>

        </div>
    </form>
</div>

<script>
document.querySelector("#uploadFiles").addEventListener("change", function () {

    const fileText =
        document.querySelector("#fileText");

    if (this.files.length === 0) {
        fileText.innerText = "선택된 파일 없음";
        return;
    }

    if (this.files.length === 1) {
        fileText.innerText = this.files[0].name;
        return;
    }

    fileText.innerText = this.files.length + "개 파일 선택됨";
});
</script>