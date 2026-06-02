<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">불량 유형 등록</h2>
            <p class="page-subtitle">새로운 불량 유형을 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 불량 유형 관리 &gt; 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/defect/insert"
          method="post"
          class="grid-form">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/defect/list"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit" class="btn btn-main">
                    등록
                </button>
            </div>
        </div>

        <div class="grid-wrap defect-grid-wrap-add">

            <div class="grid search-item defect-name-item-add">
                <label>불량 유형명 <span class="red">*</span></label>

                <input type="text"
                       name="defTypeName"
                       required
                       placeholder="불량 유형명을 입력하세요.">
            </div>

            <div class="grid search-item defect-action-item-add">
                <label>기준 조치</label>

                <textarea name="defStandardAction"
                          class="defect-action-textarea-add"
                          placeholder="기준 조치를 입력하세요."></textarea>
            </div>

        </div>

    </form>

</div>

<style>
    .defect-grid-wrap-add {
        display: grid;
        grid-template-columns: 400px;
        justify-content: flex-start;

        row-gap: 18px;
    }

    .defect-name-item-add input {
        width: 400px;
        box-sizing: border-box;
    }

    .defect-action-item-add {
        width: 644px;
    }

    .defect-action-textarea-add {
        width: 100%;
        min-height: 120px;
        box-sizing: border-box;
    }
    

@media screen and (max-width: 480px) {
	input {
		width: 80% !important;
	}
	
	.defect-action-textarea-add {
		width: 80vw;
	}
}
</style>