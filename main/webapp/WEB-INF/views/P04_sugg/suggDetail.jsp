<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">건의사항 상세</h2>
        </div>

        <div>
            <p class="page-route">홈 > 건의사항 > 상세</p>
        </div>
    </div>

    <div class="btn-row" style="margin-top:20px;">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/sugg/list">
                목록
            </a>
        </div>

        <div class="right">
            <a class="btn btn-main"
               href="${pageContext.request.contextPath}/sugg/edit?sugg_no=${dto.sugg_no}">
                수정
            </a>

            <form action="${pageContext.request.contextPath}/sugg/delete"
                  method="post"
                  style="display:inline;">

                <input type="hidden"
                       name="sugg_no"
                       value="${dto.sugg_no}">

                <button type="submit"
                        class="btn btn-red"
                        onclick="return confirm('삭제하시겠습니까?');">
                    삭제
                </button>

            </form>
        </div>
    </div>

    <div class="content-content">

        <!-- 상세 -->
        <div class="content-content-content">

            <div class="info-table-wrap"
                 style="
                    border:1px solid #d9d9d9;
                    border-radius:4px;
                    background:#fff;
                    overflow:hidden;
                    margin-top:10px;">

                <!-- 제목 -->
                <div style="padding:24px 24px 14px;">

                    <div style="
                            display:flex;
                            justify-content:space-between;
                            align-items:flex-start;">

                        <div style="
                                font-size:22px;
                                font-weight:700;
                                color:#222;">
                            ${dto.sugg_title}
                        </div>

                        <div style="
                                font-size:13px;
                                margin-top:6px;">
						<c:if test="${sessionScope.loginUser.empAuth < 20}">
 
                            <c:choose>
                                <c:when test="${dto.sugg_answer eq 'Y'}">
                                  <span style="color:var(--success);">• 답변완료</span>  
                                </c:when>
                                <c:otherwise>
                                   <span style="color:var(--dark-gray);">• 답변대기</span>
                                </c:otherwise>
                            </c:choose>
                         </c:if>
                            
							<c:if test="${sessionScope.loginUser.empAuth >= 20}">
							    <form action="${pageContext.request.contextPath}/sugg/answer"
							          method="post"
							          class="answer-form">
							
							        <input type="hidden"
							               name="sugg_no"
							               value="${dto.sugg_no}">
							
							        <label>
							            <input type="radio"
							                   name="sugg_answer"
							                   value="N"
							                   ${dto.sugg_answer eq 'N' ? 'checked' : ''}>
							            답변 대기
							        </label>
							
							        <label>
							            <input type="radio"
							                   name="sugg_answer"
							                   value="Y"
							                   ${dto.sugg_answer eq 'Y' ? 'checked' : ''}>
							            완료
							        </label>
							
							        <button type="submit"
							                class="btn btn-main">
							            확인
							        </button>
							    </form>
							</c:if>

                        </div>

                    </div>

                </div>

                <!-- 작성 정보 -->
                <div style="
                        border-top:1px solid #ddd;
                        border-bottom:1px solid #ddd;
                        padding:10px 24px;
                        font-size:12px;
                        color:#555;">

                    <span style="margin-right:28px;">
                        작성자 ${dto.empName} (${dto.sugg_writer})
                    </span>

                    <span style="margin-right:28px;">
                        등록일 ${dto.sugg_cdate}
                    </span>

                    <span style="margin-right:28px;">
                        조회수 ${dto.sugg_view}
                    </span>

                    <span id="copyurl" style="float:right; cursor:pointer;">
                        URL 복사
                    </span>

                </div>

                <!-- 내용 -->
                <div style="
                        min-height:260px;
                        padding:26px 24px;
                        font-size:17px;
                        line-height:1.8;
                        white-space:pre-line;
                        color:#333;">

                    ${dto.sugg_content}

                </div>
                
				<!-- 첨부파일 -->
				<c:if test="${not empty dto.sugg_file_origin_name}">
				    <div style="
				            border-top:1px solid #ddd;
				            padding:12px 24px;
				            font-size:13px;
				            color:#555;">
				
				        첨부파일 :
				        <a href="${pageContext.request.contextPath}/resources/upload/sugg/${dto.sugg_file_save_name}"
				           download="${dto.sugg_file_origin_name}">
				            ${dto.sugg_file_origin_name}
				        </a>
				
				    </div>
				</c:if>
                
                

            </div>

        </div>


        <!-- 댓글 -->
        <div class="content-content-content"
             style="margin-top:24px;">

            <div class="content-content-content-title"
                 style="margin-bottom:14px;">
                댓글 (${commList.size()})
            </div>


            <!-- 일반 댓글 입력 -->
            <form action="${pageContext.request.contextPath}/sugg/comment/add"
                  method="post"
                  style="
                        display:flex;
                        gap:8px;
                        margin-bottom:25px;">

                <input type="hidden" name="comm_sugg_no" value="${dto.sugg_no}">
                <input type="hidden" name="comm_parent" value="">
                <input type="hidden" name="comm_level" value="0">

                <input type="text"
                       name="comm_content"
                       placeholder="댓글을 입력하세요."
                       required
                       style="
                            flex:1;
                            height:40px;
                            border:1px solid #ddd;
                            padding:0 14px;
                            border-radius:2px;">

                <button type="submit"
                        class="btn btn-main">
                    등록
                </button>

            </form>


            <!-- 댓글 목록 -->
            <div class="table-wrap">

                <table class="table"
                       style="border:none;">

                    <tbody>

                        <c:forEach var="comm" items="${commList}">

                            <tr>
                                <td style="
                                		 position:relative;
                                        border-left:none;
                                        border-right:none;
                                        padding:18px 12px;
                                        text-align:left;
                                        padding-left:${comm.comm_level * 35 + 12}px;">

							<div style="
							        display:flex;
							        justify-content:space-between;
							        align-items:center;
							        margin-bottom:8px;">
							
							    <strong>
							         ${comm.empName} (${comm.comm_writer})
							    </strong>
							
							    <div style="
							            display:flex;
							            align-items:center;
							            gap:8px;">
							
							        <span style="
							                font-size:13px;
							                color:#777;">
							            ${comm.comm_cdate}
							        </span>
							
							        <c:if test="${sessionScope.loginUser.empId eq comm.comm_writer}">
							
							            <form action="${pageContext.request.contextPath}/sugg/comment/delete"
							                  method="post"
							                  style="display:inline;">
							
							                <input type="hidden"
							                       name="comm_no"
							                       value="${comm.comm_no}">
							
							                <input type="hidden"
							                       name="comm_sugg_no"
							                       value="${dto.sugg_no}">
							
							                <button type="submit"
							                        class="comment-delete-x"
							                        onclick="return confirm('댓글을 삭제하시겠습니까?');">
							                    ×
							                </button>
							
							            </form>
							
							        </c:if>
							
							    </div>
							
							</div>
									
									<div onclick="showReplyForm(${comm.comm_no})"
									     style="
									        padding-left:8px;
									        line-height:1.7;
									        cursor:pointer;">
									    ${comm.comm_content}
									</div>
									
<%-- 									<c:if test="${comm.comm_level < 2}"> --%>
<!-- 									    <button type="button" -->
<!-- 									            class="btn-none" -->
<%-- 									            onclick="showReplyForm(${comm.comm_no})"> --%>
<!-- 									        답글 -->
<!-- 									    </button> -->
<%-- 									</c:if> --%>


                                    <!-- 대댓글 / 대대댓글 입력 -->
                                    <c:if test="${comm.comm_level < 2}">

                                        <form id="replyForm_${comm.comm_no}"
                                        	  action="${pageContext.request.contextPath}/sugg/comment/add"
                                              method="post"
                                              style="
                                                    display:none;
                                                    gap:8px;
                                                    margin-top:10px;">

                                            <input type="hidden" name="comm_sugg_no" value="${dto.sugg_no}">
                                            <input type="hidden" name="comm_parent" value="${comm.comm_no}">
                                            <input type="hidden" name="comm_level" value="${comm.comm_level + 1}">

                                            <input type="text"
                                                   name="comm_content"
                                                   placeholder="답글을 입력하세요."
                                                   required
                                                   style="
                                                        flex:1;
                                                        height:34px;
                                                        border:1px solid #ddd;
                                                        padding:0 10px;">

                                            <button type="submit"
                                                    class="btn btn-main">
                                                작성
                                            </button>

                                        </form>

                                    </c:if>
                                </td>
                            </tr>

                        </c:forEach>


                        <c:if test="${empty commList}">
                            <tr>
                                <td style="
                                        text-align:center;
                                        padding:35px;
                                        color:#999;">
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

<style>

.answer-form {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-top: 10px;
}

.comment-delete-x {
    font-size: 20px;
    font-weight: 700;
    color: var(--dark-gray);
    background: transparent;
    border: none;
    cursor: pointer;
}

.comment-delete-x:hover {
    color: var(--main-red);
    text-decoration: none;
}
</style>

<script>
document.querySelector("#copyurl").addEventListener("click", function () {
    navigator.clipboard.writeText(window.location.href);
    alert("URL이 복사되었습니다.");
});

function showReplyForm(commNo) {

    const form =
        document.querySelector("#replyForm_" + commNo);

    if (form == null) {
        return;
    }

    if (form.style.display === "none" ||
        form.style.display === "") {

        form.style.display = "flex";
    } else {
        form.style.display = "none";
    }
}

</script>