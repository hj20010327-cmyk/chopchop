<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">사원 수정</h2>
            <p class="page-subtitle">사원 정보를 수정할 수 있습니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 사원관리 &gt; 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/admin/update"
          method="post"
          class="search-box admin-add-form">

        <input type="hidden"
               name="empId"
               value="${admin.empId}">

        <div class="search-btn-area form-btn-area">
            <a class="btn btn-white"
			   href="${pageContext.request.contextPath}/admin/detail?empId=${admin.empId}"
			   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
			    취소
			</a>

            <button type="submit" class="btn btn-main">
                수정완료
            </button>
        </div>

        <div class="grid-form">

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>사원번호</label>
                    <input type="text"
                           value="${admin.empId}"
                           readonly>
                </div>

                <div class="search-item grid">
                    <label>사원명 <span class="red">*</span></label>
                    <input type="text"
                           name="empName"
                           value="${admin.empName}"
                           required>
                </div>

            </div>

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>전화번호</label>
                    <input type="text"
                           name="empTel"
                           value="${admin.empTel}">
                </div>

                <div class="search-item grid">
                    <label>이메일 <span class="red">*</span></label>
                    <input type="email"
                           name="empEmail"
                           value="${admin.empEmail}"
                           required>
                </div>

            </div>

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>부서 <span class="red">*</span></label>
                    <select name="empDeptno" required>
                        <option value="10" ${admin.empDeptno == 10 ? 'selected' : ''}>생산관리</option>
                        <option value="20" ${admin.empDeptno == 20 ? 'selected' : ''}>품질검사</option>
                        <option value="30" ${admin.empDeptno == 30 ? 'selected' : ''}>설비관리</option>
                    </select>
                </div>

                <div class="search-item grid">
                    <label>권한 <span class="red">*</span></label>
                    <select name="empAuth" required>
                        <option value="0" ${admin.empAuth == 0 ? 'selected' : ''}>퇴사자</option>
                        <option value="10" ${admin.empAuth == 10 ? 'selected' : ''}>작업자</option>
                        <option value="20" ${admin.empAuth == 20 ? 'selected' : ''}>관리자</option>
                        <option value="30" ${admin.empAuth == 30 ? 'selected' : ''}>최고관리자</option>
                    </select>
                </div>

            </div>

            <div class="grid-wrap">

                <div class="search-item grid">
                    <label>재직 상태 <span class="red">*</span></label>
                    <select name="empInOffice" required>
                        <option value="0" ${admin.empInOffice == 0 ? 'selected' : ''}>재직</option>
                        <option value="10" ${admin.empInOffice == 10 ? 'selected' : ''}>휴직</option>
                        <option value="50" ${admin.empInOffice == 50 ? 'selected' : ''}>퇴사</option>
                    </select>
                </div>

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