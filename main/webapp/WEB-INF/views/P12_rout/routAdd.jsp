<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">라우팅 등록</h2>
            <p class="page-subtitle">생산 품목별 공정 흐름을 등록합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 라우팅 관리 &gt; 등록</p>
        </div>
    </div>

    <form id="routForm"
          action="${pageContext.request.contextPath}/routing/insert"
          method="post"
          class="grid-form">

        <div class="btn-row">
            <div class="left"></div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/routing/list"
                   onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    등록
                </button>
            </div>
        </div>

        <div class="rout-form-wrap">

            <div class="rout-form-row">
                <div class="search-item rout-type-item">
                    <label>품목 유형 <span class="red">*</span></label>

                    <select id="itemTypeFilter">
                        <option value="">전체</option>
                        <option value="20">반제품</option>
                        <option value="30">완제품</option>
                    </select>
                </div>

                <div class="search-item rout-item-select">
                    <label>생산 품목 <span class="red">*</span></label>

                    <select name="routItem"
                            id="routItemSelect"
                            required>
                        <option value="">품목 선택</option>

                        <c:forEach var="item" items="${routItemList}">
                            <option value="${item.itemId}"
                                    data-item-type="${item.itemType}">
                                ${item.itemName} (${item.itemId})
                            </option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="rout-form-row">
                <div class="search-item rout-name-item">
                    <label>라우팅명 <span class="red">*</span></label>

                    <input type="text"
                           name="routName"
                           required
                           placeholder="라우팅명을 입력하세요.">
                </div>
            </div>

            <div class="rout-form-row">
                <div class="search-item rout-content-item">
                    <label>라우팅 설명</label>

                    <input type="text"
                           name="routContent"
                           placeholder="라우팅 설명을 입력하세요.">
                </div>
            </div>

        </div>

        <div class="routing-section-title-row">
            <div>
                <h3 class="content-content-content-title">공정 흐름 구성</h3>
                <p class="page-subtitle">
                    공정을 즉석 등록하고 드래그하여 라우팅 순서를 구성합니다.
                </p>
            </div>

            <button type="button"
                    class="btn btn-main"
                    id="openProcModalBtn">
                공정 추가
            </button>
        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 70px;">이동</th>
                        <th style="width: 80px;">순서</th>
                        <th style="width: 180px;">공정명</th>
                        <th style="width: 180px;">작업장 타입</th>
                        <th>공정 설명</th>
                        <th style="width: 90px;">삭제</th>
                    </tr>
                </thead>

                <tbody id="selectedProcBody">
                    <tr id="emptyProcRow">
                        <td colspan="6" style="text-align: center;">
                            추가된 공정이 없습니다.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </form>

</div>

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

                    <c:forEach var="wp" items="${wpTypeList}">
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

<style>
    .rout-form-wrap {
        display: flex;
        flex-direction: column;
        gap: 12px;
        width: 760px;
    }

    .rout-form-row {
        display: flex;
        gap: 0;
    }

    .rout-form-row .search-item {
        margin-right: 24px;
    }

    .rout-form-row .search-item:last-child {
        margin-right: 0;
    }

    .rout-type-item {
        width: 200px;
    }

    .rout-item-select {
        width: 536px;
    }

    .rout-name-item,
    .rout-content-item {
        width: 760px;
    }

    .rout-form-wrap input,
    .rout-form-wrap select {
        width: 100% !important;
        min-width: 0 !important;
        max-width: 100% !important;
        box-sizing: border-box;
    }

    .routing-section-title-row {
        margin: 48px 0 16px;
        display: flex;
        align-items: flex-end;
        justify-content: space-between;
    }

    .routing-section-title-row .content-content-content-title {
        margin-bottom: 8px;
    }

    .proc-row {
        cursor: grab;
    }

    .proc-row.dragging {
        opacity: 0.5;
    }

    .drag-cell {
        text-align: center;
    }

    .drag-handle {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 28px;
        height: 28px;
        color: #888;
        font-weight: 700;
        cursor: grab;
    }

    #emptyProcRow {
        cursor: pointer;
    }

    #emptyProcRow:hover td {
        color: var(--main-green);
        text-decoration: underline;
        background-color: #f8faf9;
    }

    .remove-row-btn {
        width: 32px;
        height: 32px;
        border: none;
        border-radius: 50%;
        background-color: #f1f3f5;
        color: #666;
        font-size: 18px;
        font-weight: 700;
        cursor: pointer;
        transition: 0.2s;
    }

    .remove-row-btn:hover {
        background-color: #dee2e6;
        color: #333;
        transform: scale(1.05);
    }

    .modal-bg {
        display: none;
        position: fixed;
        inset: 0;
        z-index: 9999;
        background: rgba(0, 0, 0, 0.35);
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
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
    }

    .modal-header {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-bottom: 20px;
    }

    .modal-header h3 {
        margin: 0;
        font-size: 20px;
    }

    .modal-close {
        border: 0;
        background: transparent;
        font-size: 28px;
        line-height: 1;
        cursor: pointer;
    }

    .modal-body {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .modal-body .search-item {
        width: 100%;
    }

    .modal-body input,
    .modal-body select,
    .modal-body textarea {
        width: 100% !important;
        min-width: 0 !important;
        max-width: 100% !important;
        box-sizing: border-box;
    }

    .proc-content-textarea {
        min-height: 100px;
        resize: none;
    }

    .modal-btn-row {
        margin-top: 24px;
        display: flex;
        justify-content: flex-end;
        gap: 8px;
    }
    
    
    
/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	.rout-form-row {
		width: 100% !important;
	}
	
	.rout-item-select {
		width: 300px !important;
	}
	
	.rout-name-item, .rout-content-item {
		width: 620px !important;
	}
	
	.table tr th:nth-child(1), .table tr td:nth-child(1),
	.table tr th:nth-child(2), .table tr td:nth-child(2),
	.table tr th:last-child, .table tr td:last-child {
		width: 65px !important;
	}
	
	.table tr th:nth-child(3), .table tr td:nth-child(3) {
		width: 145px !important;
	}
	
	.table tr th:nth-child(3), .table tr td:nth-child(3) {
		width: 145px !important;
	}
	
	.table tr th:nth-child(4), .table tr td:nth-child(4) {
		width: 100px !important;
	}
}
    
</style>

<script>
    window.addEventListener("load", function() {

        const routForm = document.getElementById("routForm");
        const selectedProcBody = document.getElementById("selectedProcBody");

        const itemTypeFilter = document.getElementById("itemTypeFilter");
        const routItemSelect = document.getElementById("routItemSelect");

        const procModalBg = document.getElementById("procModalBg");
        const openProcModalBtn = document.getElementById("openProcModalBtn");
        const closeProcModalBtn = document.getElementById("closeProcModalBtn");
        const cancelProcModalBtn = document.getElementById("cancelProcModalBtn");
        const addProcBtn = document.getElementById("addProcBtn");

        const modalProcName = document.getElementById("modalProcName");
        const modalProcWpType = document.getElementById("modalProcWpType");
        const modalProcContent = document.getElementById("modalProcContent");

        bindEmptyRowEvent();

        itemTypeFilter.addEventListener("change", function() {
            const selectedType = itemTypeFilter.value;
            const options = routItemSelect.querySelectorAll("option");

            routItemSelect.value = "";

            options.forEach(function(option) {
                if (option.value === "") {
                    option.hidden = false;
                    return;
                }

                const itemType = option.dataset.itemType;

                option.hidden =
                    selectedType !== "" && itemType !== selectedType;
            });
        });

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
            const wpOption = modalProcWpType.options[modalProcWpType.selectedIndex];
            const wpTypeName = wpOption.dataset.wpTypeName || "";
            const procContent = modalProcContent.value.trim();

            if (procName === "") {
                alert("공정명을 입력하세요.");
                modalProcName.focus();
                return;
            }

            if (procWpType === "") {
                alert("작업장 타입을 선택하세요.");
                modalProcWpType.focus();
                return;
            }

            addProcessRow({
                procId: "",
                procName: procName,
                procWpType: procWpType,
                wpTypeName: wpTypeName,
                procContent: procContent
            });

            closeProcModal();
        });

        routForm.addEventListener("submit", function(e) {

            const rows = selectedProcBody.querySelectorAll(".proc-row");

            if (rows.length === 0) {
                e.preventDefault();
                alert("공정을 1개 이상 추가하세요.");
                return;
            }

            refreshStep();
        });

        function openProcModal() {
            clearProcModal();
            procModalBg.classList.add("active");
            modalProcName.focus();
        }

        function closeProcModal() {
            procModalBg.classList.remove("active");
            clearProcModal();
        }

        function clearProcModal() {
            modalProcName.value = "";
            modalProcWpType.value = "";
            modalProcContent.value = "";
        }

        function bindEmptyRowEvent() {
            const emptyRow = document.getElementById("emptyProcRow");

            if (emptyRow) {
                emptyRow.onclick = function() {
                    openProcModal();
                };
            }
        }

        function addProcessRow(proc) {

            const emptyRow = document.getElementById("emptyProcRow");

            if (emptyRow) {
                emptyRow.remove();
            }

            const tr = document.createElement("tr");
            tr.className = "proc-row";
            tr.draggable = true;

            tr.innerHTML =
                '<td class="drag-cell">' +
                    '<span class="drag-handle">≡</span>' +
                '</td>' +

                '<td class="step-cell"></td>' +

                '<td>' +
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
                    '<button type="button" class="remove-row-btn remove-btn">✕</button>' +
                '</td>';

            selectedProcBody.appendChild(tr);

            bindRowEvent(tr);
            refreshStep();
        }

        function bindRowEvent(row) {

            const removeBtn = row.querySelector(".remove-btn");
            const dragHandle = row.querySelector(".drag-handle");

            if (removeBtn) {
                removeBtn.addEventListener("click", function(e) {
                    e.stopPropagation();

                    row.remove();
                    refreshStep();
                    showEmptyRowIfNeeded();
                });
            }

            if (dragHandle) {
                dragHandle.addEventListener("click", function(e) {
                    e.stopPropagation();
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

            const rows = selectedProcBody.querySelectorAll(".proc-row");

            rows.forEach(function(row, index) {
                row.querySelector(".step-cell").textContent = index + 1;
            });
        }

        function showEmptyRowIfNeeded() {

            const rows = selectedProcBody.querySelectorAll(".proc-row");

            if (rows.length === 0) {
                selectedProcBody.innerHTML =
                    '<tr id="emptyProcRow">' +
                        '<td colspan="6" style="text-align: center;">' +
                            '추가된 공정이 없습니다.' +
                        '</td>' +
                    '</tr>';

                bindEmptyRowEvent();
            }
        }

        selectedProcBody.addEventListener("dragover", function(e) {

            e.preventDefault();

            const dragging = selectedProcBody.querySelector(".dragging");

            if (!dragging) {
                return;
            }

            const afterElement = getDragAfterElement(selectedProcBody, e.clientY);

            if (afterElement == null) {
                selectedProcBody.appendChild(dragging);
            } else {
                selectedProcBody.insertBefore(dragging, afterElement);
            }
        });

        function getDragAfterElement(container, y) {

            const draggableElements = [
                ...container.querySelectorAll(".proc-row:not(.dragging)")
            ];

            return draggableElements.reduce(function(closest, child) {

                const box = child.getBoundingClientRect();
                const offset = y - box.top - box.height / 2;

                if (offset < 0 && offset > closest.offset) {
                    return {
                        offset: offset,
                        element: child
                    };
                } else {
                    return closest;
                }

            }, {
                offset: Number.NEGATIVE_INFINITY
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