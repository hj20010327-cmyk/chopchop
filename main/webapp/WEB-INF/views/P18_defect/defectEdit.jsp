<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">불량 유형 수정</h2>
            <p class="page-subtitle">
                ${def.defTypeName}(${${def.defTypeId}})의 정보를 수정하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 불량 유형 관리 &gt; 수정
            </p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/defect/update"
          method="post"
          class="defect-form">

        <input type="hidden"
               name="defTypeId"
               value="${def.defTypeId}">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/defect/detail?defTypeId=${def.defTypeId}"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    수정완료
                </button>
            </div>
        </div>

        <div class="defect-form-wrap">

            <div class="search-item defect-code-item">
                <label>불량 유형 코드</label>

                <input type="text"
                       value="${def.defTypeId}"
                       readonly>
            </div>

            <div class="search-item defect-name-item">
                <label>
                    불량 유형명
                    <span class="red">*</span>
                </label>

                <input type="text"
                       name="defTypeName"
                       value="${def.defTypeName}"
                       required>
            </div>

            <div class="search-item defect-action-item">
                <label>기준 조치</label>

                <textarea name="defStandardAction"
                          class="defect-action-textarea"
                          placeholder="기준 조치를 입력하세요.">${def.defStandardAction}</textarea>
            </div>

        </div>

    </form>

</div>

<style>
    .defect-form {
        width: 100%;
    }

    .defect-form-wrap {
        display: flex;
        flex-wrap: wrap;
        align-items: flex-start;

        gap: 18px 24px;

        width: 684px;
    }

    .defect-code-item {
        width: 260px;
    }

    .defect-name-item {
        width: 400px;
    }

    .defect-action-item {
        width: 684px;
    }

    .defect-code-item input {
        min-width: 0;
        width: 260px;
        box-sizing: border-box;
    }

    .defect-name-item input {
        min-width: 0;
        width: 400px;
        box-sizing: border-box;
    }

    .defect-action-item textarea {
        width: 684px;
        min-height: 120px;
        box-sizing: border-box;
    }
</style>