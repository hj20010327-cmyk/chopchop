<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">라우팅 수정</h2>
            <p class="page-subtitle">라우팅 공정 흐름을 수정합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 라우팅 관리 &gt; 수정</p>
        </div>
    </div>

    <form id="routForm"
          action="${pageContext.request.contextPath}/routing/update"
          method="post"
          class="grid-form">

        <input type="hidden"
               name="routId"
               value="${rout.routId}">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">

                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/routing/detail?routId=${rout.routId}">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    수정
                </button>
            </div>
        </div>

        <div class="grid-wrap rout-grid-wrap">

            <div class="grid search-item">
                <label>라우팅명 <span class="red">*</span></label>
                <input type="text"
                       name="routName"
                       value="${rout.routName}"
                       required>
            </div>

            <div class="grid search-item">
                <label>생산 품목 <span class="red">*</span></label>

                <select name="routItem"
                        required>

                    <option value="">품목 선택</option>

                    <c:forEach var="item" items="${routItemList}">

                        <option value="${item.itemId}"
                            <c:if test="${item.itemId eq rout.routItem}">
                                selected
                            </c:if>>
                            ${item.itemName} (${item.itemId})
                        </option>

                    </c:forEach>

                </select>
            </div>

            <div class="grid search-item rout-content-item">
                <label>라우팅 설명</label>

                <textarea name="routContent"
                          class="rout-content-textarea">${rout.routContent}</textarea>
            </div>

        </div>


        <!-- 공정 구성 -->
        <div class="routing-section-title-row">

            <div>
                <h3 class="content-content-content-title">공정 흐름 구성</h3>

                <p class="page-subtitle">
                    공정 순서를 드래그로 조정할 수 있습니다.
                </p>
            </div>

            <button type="button"
                    class="btn btn-main"
                    id="openProcModalBtn">
                공정 추가
            </button>

        </div>


        <!-- 공정 테이블 -->
        <div class="table-wrap">

            <table class="table">

                <thead>
                    <tr>
                        <th style="width: 80px;">순서</th>
                        <th style="width: 180px;">공정명</th>
                        <th style="width: 180px;">작업장 타입</th>
                        <th>공정 설명</th>
                        <th style="width: 90px;">삭제</th>
                    </tr>
                </thead>

                <tbody id="selectedProcBody">

                    <c:choose>

                        <c:when test="${empty routDetailList}">

                            <tr id="emptyProcRow">
                                <td colspan="5" style="text-align: center;">
                                    추가된 공정이 없습니다.
                                </td>
                            </tr>

                        </c:when>

                        <c:otherwise>

                            <c:forEach var="detail"
                                       items="${routDetailList}"
                                       varStatus="status">

                                <tr class="proc-row"
                                    draggable="true">

                                    <td class="step-cell">
                                        ${status.count}
                                    </td>

                                    <td>

                                        <span class="drag-handle">≡</span>

                                        ${detail.procName}

                                        <input type="hidden"
                                               name="procIdList"
                                               value="${detail.procId}">

                                        <input type="hidden"
                                               name="procNameList"
                                               value="${detail.procName}">
                                    </td>

                                    <td>

                                        ${detail.wpTypeName}

                                        <input type="hidden"
                                               name="procWpTypeList"
                                               value="${detail.procWpType}">
                                    </td>

                                    <td>

                                        ${detail.procContent}

                                        <input type="hidden"
                                               name="procContentList"
                                               value="${detail.procContent}">
                                    </td>

                                    <td>
                                        <button type="button"
                                                class="btn btn-white remove-btn">
                                            삭제
                                        </button>
                                    </td>

                                </tr>

                            </c:forEach>

                        </c:otherwise>

                    </c:choose>

                </tbody>

            </table>

        </div>

    </form>

</div>


<!-- 공정 추가 모달 -->
<div class="modal-bg" id="procModalBg">

    <div class="modal-box proc-modal-box">

        <div class="modal-header">

            <h3>공정 추가</h3>

            <button type="button"
                    class="modal-close"
                    id="closeProcModalBtn">
                ×
            </button>

        </div>

        <div class="modal-body">

            <div class="search-item">

                <label>공정명 <span class="red">*</span></label>

                <input type="text"
                       id="modalProcName"
                       placeholder="공정명을 입력하세요.">

            </div>

            <div class="search-item">

                <label>작업장 타입 <span class="red">*</span></label>

                <select id="modalProcWpType">

                    <option value="">작업장 타입 선택</option>

                    <c:forEach var="wp"
                               items="${wpTypeList}">

                        <option value="${wp.wpTypeNo}"
                                data-wp-type-name="${wp.wpTypeName}">
                            ${wp.wpTypeName}
                        </option>

                    </c:forEach>

                </select>

            </div>

            <div class="search-item">

                <label>공정 설명</label>

                <textarea id="modalProcContent"
                          class="proc-content-textarea"
                          placeholder="공정 설명을 입력하세요."></textarea>

            </div>

        </div>

        <div class="modal-btn-row">

            <button type="button"
                    class="btn btn-white"
                    id="cancelProcModalBtn">
                취소
            </button>

            <button type="button"
                    class="btn btn-main"
                    id="addProcBtn">
                추가
            </button>

        </div>

    </div>

</div>


<!-- 스타일은 add.jsp와 동일 -->
<style>

.rout-grid-wrap {
    display: grid;
    grid-template-columns: 200px 400px;
    column-gap: 24px;
    row-gap: 18px;
    width: 624px;
}

.rout-grid-wrap .grid {
    width: 100%;
    min-width: 0;
}

.rout-grid-wrap .grid input,
.rout-grid-wrap .grid select,
.rout-grid-wrap .grid textarea {
    width: 100% !important;
    min-width: 0 !important;
    max-width: 100% !important;
    box-sizing: border-box;
}

.rout-content-item {
    grid-column: 1 / 3;
}

.rout-content-textarea {
    min-height: 100px;
    resize: none;
}

.routing-section-title-row {
    margin: 48px 0 16px;

    display: flex;
    align-items: flex-end;
    justify-content: space-between;
}

.proc-row {
    cursor: grab;
}

.proc-row.dragging {
    opacity: 0.5;
}

.drag-handle {
    color: #888;
    font-weight: 700;
    cursor: grab;
    margin-right: 8px;
}

.modal-bg {
    display: none;

    position: fixed;
    top: 0;
    left: 0;
    z-index: 9999;

    width: 100%;
    height: 100%;

    background: rgba(0,0,0,0.35);

    align-items: center;
    justify-content: center;
}

.modal-bg.active {
    display: flex;
}

.modal-box {
    width: 520px;
    padding: 24px;

    background: #fff;
    border-radius: 10px;
}

.modal-header {
    display: flex;
    justify-content: space-between;
    align-items: center;

    margin-bottom: 20px;
}

.modal-close {
    border: 0;
    background: transparent;

    font-size: 28px;
    cursor: pointer;
}

.modal-body {
    display: flex;
    flex-direction: column;
    gap: 16px;
}

.modal-btn-row {
    margin-top: 24px;

    display: flex;
    justify-content: flex-end;
    gap: 8px;
}

.proc-content-textarea {
    min-height: 100px;
    resize: none;
}

</style>


<!-- 스크립트 -->
<script>

window.addEventListener("load", function() {

    const selectedProcBody = document.getElementById("selectedProcBody");

    const procModalBg = document.getElementById("procModalBg");

    const openProcModalBtn = document.getElementById("openProcModalBtn");
    const closeProcModalBtn = document.getElementById("closeProcModalBtn");
    const cancelProcModalBtn = document.getElementById("cancelProcModalBtn");
    const addProcBtn = document.getElementById("addProcBtn");

    const modalProcName = document.getElementById("modalProcName");
    const modalProcWpType = document.getElementById("modalProcWpType");
    const modalProcContent = document.getElementById("modalProcContent");


    bindAllRows();


    openProcModalBtn.addEventListener("click", function() {
        openProcModal();
    });

    closeProcModalBtn.addEventListener("click", function() {
        closeProcModal();
    });

    cancelProcModalBtn.addEventListener("click", function() {
        closeProcModal();
    });

    procModalBg.addEventListener("click", function(e) {

        if (e.target === procModalBg) {
            closeProcModal();
        }

    });


    addProcBtn.addEventListener("click", function() {

        const procName = modalProcName.value.trim();
        const procWpType = modalProcWpType.value;

        const wpOption =
            modalProcWpType.options[modalProcWpType.selectedIndex];

        const wpTypeName =
            wpOption.dataset.wpTypeName || "";

        const procContent =
            modalProcContent.value.trim();

        if (procName === "") {
            alert("공정명을 입력하세요.");
            return;
        }

        if (procWpType === "") {
            alert("작업장 타입을 선택하세요.");
            return;
        }

        addProcessRow({
            procId : "",
            procName : procName,
            procWpType : procWpType,
            wpTypeName : wpTypeName,
            procContent : procContent
        });

        closeProcModal();

    });


    function openProcModal() {

        modalProcName.value = "";
        modalProcWpType.value = "";
        modalProcContent.value = "";

        procModalBg.classList.add("active");

    }


    function closeProcModal() {
        procModalBg.classList.remove("active");
    }


    function addProcessRow(proc) {

        const emptyRow =
            document.getElementById("emptyProcRow");

        if (emptyRow) {
            emptyRow.remove();
        }

        const tr = document.createElement("tr");

        tr.className = "proc-row";
        tr.draggable = true;

        tr.innerHTML =
            '<td class="step-cell"></td>' +

            '<td>' +
                '<span class="drag-handle">≡</span>' +
                escapeHtml(proc.procName) +

                '<input type="hidden" name="procIdList" value="' + escapeAttr(proc.procId) + '">' +
                '<input type="hidden" name="procNameList" value="' + escapeAttr(proc.procName) + '">' +
            '</td>' +

            '<td>' +
                escapeHtml(proc.wpTypeName) +

                '<input type="hidden" name="procWpTypeList" value="' + escapeAttr(proc.procWpType) + '">' +
            '</td>' +

            '<td>' +
                escapeHtml(proc.procContent) +

                '<input type="hidden" name="procContentList" value="' + escapeAttr(proc.procContent) + '">' +
            '</td>' +

            '<td>' +
                '<button type="button" class="btn btn-white remove-btn">삭제</button>' +
            '</td>';

        selectedProcBody.appendChild(tr);

        bindRowEvent(tr);
        refreshStep();

    }


    function bindAllRows() {

        const rows =
            selectedProcBody.querySelectorAll(".proc-row");

        rows.forEach(function(row) {
            bindRowEvent(row);
        });

    }


    function bindRowEvent(row) {

        const removeBtn =
            row.querySelector(".remove-btn");

        if (removeBtn) {

            removeBtn.addEventListener("click", function() {

                row.remove();

                refreshStep();
                showEmptyRowIfNeeded();

            });

        }

        row.addEventListener("dragstart", function() {
            row.classList.add("dragging");
        });

        row.addEventListener("dragend", function() {

            row.classList.remove("dragging");

            refreshStep();

        });

    }


    function refreshStep() {

        const rows =
            selectedProcBody.querySelectorAll(".proc-row");

        rows.forEach(function(row, index) {

            row.querySelector(".step-cell").textContent =
                index + 1;

        });

    }


    function showEmptyRowIfNeeded() {

        const rows =
            selectedProcBody.querySelectorAll(".proc-row");

        if (rows.length === 0) {

            selectedProcBody.innerHTML =
                '<tr id="emptyProcRow">' +
                    '<td colspan="5" style="text-align:center;">' +
                        '추가된 공정이 없습니다.' +
                    '</td>' +
                '</tr>';

        }

    }


    selectedProcBody.addEventListener("dragover", function(e) {

        e.preventDefault();

        const dragging =
            selectedProcBody.querySelector(".dragging");

        if (!dragging) {
            return;
        }

        const afterElement =
            getDragAfterElement(selectedProcBody, e.clientY);

        if (afterElement == null) {
            selectedProcBody.appendChild(dragging);
        } else {
            selectedProcBody.insertBefore(dragging, afterElement);
        }

    });


    function getDragAfterElement(container, y) {

        const draggableElements =
            [...container.querySelectorAll(".proc-row:not(.dragging)")];

        return draggableElements.reduce(function(closest, child) {

            const box = child.getBoundingClientRect();

            const offset =
                y - box.top - box.height / 2;

            if (offset < 0 && offset > closest.offset) {

                return {
                    offset : offset,
                    element : child
                };

            } else {

                return closest;

            }

        }, {
            offset : Number.NEGATIVE_INFINITY
        }).element;

    }


    function escapeHtml(value) {

        if (value == null) {
            return "";
        }

        return String(value)
            .replaceAll("&", "&amp;")
            .replaceAll("<", "&lt;")
            .replaceAll(">", "&gt;")
            .replaceAll('"', "&quot;")
            .replaceAll("'", "&#039;");

    }


    function escapeAttr(value) {
        return escapeHtml(value);
    }

});

</script>