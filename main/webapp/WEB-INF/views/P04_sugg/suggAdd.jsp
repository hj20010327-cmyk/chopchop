<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">건의사항 등록</h2>
        </div>

        <div>
            <p class="page-route">홈 > 건의사항 > 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/sugg/add"
          method="post"
          enctype="multipart/form-data"
          id="suggAddForm">

        <div class="btn-row"
             style="margin-top:55px; margin-bottom:25px;">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/sugg/list">
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
                        border:1px solid #999;
                        border-radius:8px;
                        padding:35px 45px;
                        background:#fff;">

                    <div style="
                            display:grid;
                            grid-template-columns: 1fr 280px;
                            gap:14px;
                            margin-bottom:45px;">

                        <div>
                            <label style="
                                    display:block;
                                    font-weight:700;
                                    font-size:18px;
                                    margin-bottom:12px;">
                                제목 <span style="color:#d32f2f;">*</span>
                            </label>

                            <input type="text"
                                   name="sugg_title"
                                   placeholder="제목을 입력하세요"
                                   required
                                   style="
                                        width:100%;
                                        height:46px;
                                        border:1px solid #999;
                                        border-radius:4px;
                                        padding:0 18px;
                                        font-size:15px;">
                        </div>

                        <div>
                            <label style="
                                    display:block;
                                    font-weight:700;
                                    font-size:18px;
                                    margin-bottom:12px;">
                                비밀번호 <span style="color:#d32f2f;">*</span>
                            </label>

                            <input type="password"
                                   name="sugg_pw"
                                   placeholder="숫자 4자리"
                                   maxlength="4"
                                   required
                                   style="
                                        width:100%;
                                        height:46px;
                                        border:1px solid #999;
                                        border-radius:4px;
                                        padding:0 18px;
                                        font-size:15px;">
                        </div>

                    </div>

                    <div style="margin-bottom:40px;">

                        <label style="
                                display:block;
                                font-weight:700;
                                font-size:18px;
                                margin-bottom:12px;">
                            내용 <span style="color:#d32f2f;">*</span>
                        </label>

                        <textarea name="sugg_content"
                                  placeholder="내용을 입력하세요"
                                  required
                                  style="
                                    width:100%;
                                    height:330px;
                                    border:1px solid #999;
                                    border-radius:4px;
                                    padding:18px;
                                    font-size:15px;
                                    resize:none;"></textarea>

                    </div>

                    <div style="
                            display:flex;
                            align-items:center;
                            gap:24px;">
                     <strong style="font-size:18px;">
				        첨부파일
				    </strong>
				    
				     <input type="file"
					        name="uploadFile"
					        id="uploadFile"
					        style="display:none;">

                    <label for="uploadFile"
          				   class="btn btn-white">
					 	첨부파일 추가
					</label>

				    <span id="fileName" style="font-size:14px; color:#555;">
				        선택된 파일 없음
				    </span>

                    </div>

                </div>

            </div>

        </div>

    </form>

</div>

<script>
document.querySelector("#suggAddForm").addEventListener("submit", function(e) {
    const pw = document.querySelector("input[name='sugg_pw']").value;

    if (!/^[0-9]{4}$/.test(pw)) {
        alert("비밀번호는 숫자 4자리로 입력하세요.");
        e.preventDefault();
        return;
    }
});

document.querySelector("#uploadFile").addEventListener("change", function() {
    const fileName = this.files.length > 0 ? this.files[0].name : "선택된 파일 없음";
    document.querySelector("#fileName").innerText = fileName;
});
</script>