<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">사원 등록</h2>
            <p class="page-subtitle">새로운 사원 계정을 등록할 수 있습니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 사원관리 &gt; 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/insert"
          method="post"
          class="search-box admin-add-form">

        <div class="search-btn-area form-btn-area">
            <a class="btn btn-white"
			   href="${pageContext.request.contextPath}/admin/list"
			   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
			    취소
			</a>

            <button type="submit" class="btn btn-main">
                등록
            </button>
        </div>

        <div class="grid-form">

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>사원명 <span class="red">*</span></label>
                    <input type="text"
                           name="empName"
                           required
                           placeholder="사원명을 입력하세요.">
                </div>

                <div class="search-item grid">
                    <label>전화번호</label>
                    <input type="text"
                           name="empTel"
                           placeholder="010-0000-0000">
                </div>

            </div>

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>이메일 <span class="red">*</span></label>
                    <input type="email"
                           name="empEmail"
                           placeholder="example@email.com"
                           required>
                </div>

                <div class="search-item grid">
                    <label>부서 <span class="red">*</span></label>
                    <select name="empDeptno" required>
                        <option value="">부서 선택</option>
                        <option value="10">생산관리</option>
                        <option value="20">품질검사</option>
                        <option value="30">설비관리</option>
                    </select>
                </div>

            </div>

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>권한 <span class="red">*</span></label>
                    <select name="empAuth" required>
                        <option value="">권한 선택</option>
                        <option value="10">작업자</option>
                        <option value="20">관리자</option>
                        <option value="30">최고관리자</option>
                    </select>
                </div>

                <div class="search-item grid">
                    <label>재직 상태 <span class="red">*</span></label>
                    <select name="empInOffice" required>
                        <option value="">상태 선택</option>
                        <option value="0">재직</option>
                        <option value="10">휴직</option>
                        <option value="50">퇴사</option>
                    </select>
                </div>

            </div>

            <div class="content-content-content">
                <p class="card-subtitle">
                    최초 비밀번호는 <strong>1234</strong>로 등록됩니다.
                </p>
            </div>

        </div>

    </form>

</div>

<style>
    .admin-add-form {
        width: 100%;
        display: block;
        margin: 0;
        padding: 0;
    }

    .form-btn-area {
        width: 100%;
        justify-content: flex-end;
        margin-bottom: 24px;
    }
</style>