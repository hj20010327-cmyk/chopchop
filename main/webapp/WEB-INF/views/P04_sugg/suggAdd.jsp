<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">건의사항 등록</h2>
            <p class="page-subtitle">현장의 건의사항을 등록할 수 있습니다.</p>
        </div>

        <div>
            <p class="page-route">홈 > 건의사항 관리 > 등록</p>
        </div>
    </div>

    <div class="btn-row">
        <div class="left">
            <a class="btn btn-white"
               href="${pageContext.request.contextPath}/sugg/list">
                목록으로
            </a>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/sugg/add"
          method="post">

        <div class="content-content">

            <div class="content-content-content">
                <div class="content-content-content-title">
                    건의사항 정보
                </div>

                <div class="info-table-wrap">
                    <table class="info-table">
                        <tbody>
                            <tr>
                                <th>제목</th>
                                <td colspan="3">
                                    <input type="text"
                                           name="sugg_title"
                                           placeholder="제목을 입력하세요."
                                           required>
                                </td>
                            </tr>

                            <tr>
                                <th>작성자</th>
                                <td>
                                    <input type="text"
                                           name="sugg_writer"
                                           placeholder="작성자 ID"
                                           required>
                                </td>

                                <th>비밀번호</th>
                                <td>
                                    <input type="password"
                                           name="sugg_pw"
                                           placeholder="비밀번호"
                                           required>
                                </td>
                            </tr>

                            <tr>
                                <th>건의 내용</th>
                                <td colspan="3">
                                    <textarea name="sugg_content"
                                              rows="10"
                                              placeholder="건의 내용을 입력하세요."
                                              required></textarea>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="btn-row">
                <div class="left"></div>

                <div class="right">
                    <button type="submit" class="btn btn-main">
                        등록
                    </button>

                    <a class="btn btn-white"
                       href="${pageContext.request.contextPath}/sugg/list">
                        취소
                    </a>
                </div>
            </div>

        </div>

    </form>

</div>