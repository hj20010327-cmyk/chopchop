<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">라우팅 수정</h2>
            <p class="page-subtitle">라우팅 정보와 공정 흐름을 수정합니다.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 라우팅 관리 &gt; 수정</p>
        </div>
    </div>

    <form id="routForm"
          action="${pageContext.request.contextPath}/routing/update"
          method="post"
          class="grid-form">

        <input type="hidden" name="routId" value="${rout.routId}">

        <div class="btn-row">
            <div class="left">
                <button type="button"
                        class="btn btn-white"
                        id="deleteBtn">
                    삭제
                </button>
            </div>

            <div class="right">
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/routing/detail?routId=${rout.routId}">
                    취소
                </a>

                <button type="submit"
                        class="btn btn-main">
                    수정완료
                </button>
            </div>
        </div>

        <div class="grid-wrap rout-grid-wrap">

            <div class="grid search-item">
                <label>라우팅명 <span class="red">*</span></label>
                <input type="text"
                       name="routName"
                       value="${rout.routName}"
                       required
                       placeholder="라우팅명을 입력하세요.">
            </div>

            <div class="grid search-item">
                <label>생산 품목 <span class="red">*</span></label>
                <select name="routItem" required>
                    <option value="">품목 선택</option>

                    <c:forEach var="item" items="${routItemList}">
                        <option value="${item.itemId}"
                            ${rout.routItem == item.itemId ? 'selected' : ''}>
                            <c:choose>
                                <c:when test="${item.itemType == 20}">
                                    [반제품]
                                </c:when>
                                <c:when test="${item.itemType == 30}">
                                    [완제품]
                                </c:when>
                                <c:otherwise>
                                    [기타]
                                </c:otherwise>
                            </c:choose>
                            ${item.itemName} (${item.itemId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="grid search-item rout-content-item">
                <label>라우팅 설명</label>
                <textarea name="routContent"
                          class="rout-content-textarea"
                          placeholder="라우팅 설명을 입력하세요.">${rout.routContent}</textarea>
            </div>

        </div>

        <div class="routing-section-title-row">
            <div>
                <h3 class="content-content-content-title">
                    공정 흐름 구성
                </h3>
                <p class="page-subtitle">공정을 선택해 라우팅 순서를 구성합니다.</p>
            </div>
        </div>

        <div class="routing-proc-row">

            <div class="search-item">
                <label>공정 선택 <span class="red">*</span></label>

                <select id="procSelect">
                    <option value="">공정 선택</option>

                    <c:forEach var="proc" items="${processList}">
                        <option value="${proc.procId}"
                                data-proc-name="${proc.procName}"
                                data-wp-type-name="${proc.wpTypeName}"
                                data-eq-names="${proc.eqNames}">
                            [${proc.wpTypeName}] ${proc.procName} (${proc.procId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item">
                <label>작업장 타입</label>
                <input type="text"
                       id="wpTypeView"
                       readonly
                       placeholder="공정을 선택하세요.">
            </div>

            <div class="search-item">
                <label>사용 가능 설비</label>
                <input type="text"
                       id="eqView"
                       readonly
                       placeholder="공정을 선택하세요.">
            </div>

            <div class="routing-add-btn-box">
                <button type="button"
                        class="btn btn-main"
                        id="addProcBtn">
                    공정 추가
                </button>
            </div>

        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th style="width: 80px;">순서</th>
                        <th style="width: 160px;">공정 코드</th>
                        <th style="width: 180px;">공정명</th>
                        <th style="width: 180px;">작업장 타입</th>
                        <th>사용 가능 설비</th>
                        <th style="width: 90px;">삭제</th>
                    </tr>
                </thead>

                <tbody id="selectedProcBody">
                    <c:choose>
                        <c:when test="${empty routDetailList}">
                            <tr id="emptyProcRow">
                                <td colspan="6" style="text-align: center;">
                                    추가된 공정이 없습니다.
                                </td>
                            </tr>
                        </c:when>

                        <c:otherwise>
                            <c:forEach var="detail" items="${routDetailList}" varStatus="status">
                                <tr class="proc-row" draggable="true">
                                    <td class="step-cell">${status.index + 1}</td>
                                    <td>
                                        <span class="drag-handle">≡</span>
                                        ${detail.procId}
                                        <input type="hidden"
                                               name="routDtlProcList"
                                               value="${detail.procId}">
                                    </td>
                                    <td>${detail.procName}</td>
                                    <td>${detail.wpTypeName}</td>
                                    <td>${detail.eqNames}</td>
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
    }

    .routing-section-title-row .content-content-content-title {
        margin-bottom: 8px;
    }

    .routing-proc-row {
        display: grid;
        grid-template-columns: 130px 260px 260px 90px;
        column-gap: 16px;
        align-items: end;
        width: 804px;
        margin-bottom: 20px;
    }

    .routing-proc-row .search-item {
        width: 100%;
        min-width: 0;
    }

    .routing-proc-row .search-item input,
    .routing-proc-row .search-item select {
        width: 100% !important;
        min-width: 0 !important;
        max-width: 100% !important;
        box-sizing: border-box;
    }

    .routing-add-btn-box .btn {
        width: 90px;
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
    }
</style>

<script>
    window.addEventListener("load", function() {
        const procSelect = document.getElementById("procSelect");
        const wpTypeView = document.getElementById("wpTypeView");
        const eqView = document.getElementById("eqView");
        const addProcBtn = document.getElementById("addProcBtn");
        const selectedProcBody = document.getElementById("selectedProcBody");
        const routForm = document.getElementById("routForm");
        const deleteBtn = document.getElementById("deleteBtn");

        procSelect.addEventListener("change", function() {
            const option = procSelect.options[procSelect.selectedIndex];

            if (!procSelect.value) {
                wpTypeView.value = "";
                eqView.value = "";
                return;
            }

            wpTypeView.value = option.dataset.wpTypeName || "";
            eqView.value = option.dataset.eqNames || "등록된 설비 없음";
        });

        addProcBtn.addEventListener("click", function() {
            const option = procSelect.options[procSelect.selectedIndex];

            if (!procSelect.value) {
                alert("공정을 선택하세요.");
                return;
            }

            addProcessRow({
                procId: option.value,
                procName: option.dataset.procName,
                wpTypeName: option.dataset.wpTypeName,
                eqNames: option.dataset.eqNames || "등록된 설비 없음"
            });

            procSelect.value = "";
            wpTypeView.value = "";
            eqView.value = "";
        });

        deleteBtn.addEventListener("click", function() {
            if (!confirm("해당 라우팅을 삭제하시겠습니까?")) {
                return;
            }

            routForm.action = "${pageContext.request.contextPath}/routing/delete";
            routForm.submit();
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

        const existingRows = selectedProcBody.querySelectorAll(".proc-row");
        existingRows.forEach(function(row) {
            bindRowEvent(row);
        });

        function addProcessRow(proc) {
            const emptyRow = document.getElementById("emptyProcRow");

            if (emptyRow) {
                emptyRow.remove();
            }

            const tr = document.createElement("tr");
            tr.className = "proc-row";
            tr.draggable = true;

            tr.innerHTML =
                '<td class="step-cell"></td>' +
                '<td>' +
                    '<span class="drag-handle">≡</span> ' +
                    proc.procId +
                    '<input type="hidden" name="routDtlProcList" value="' + proc.procId + '">' +
                '</td>' +
                '<td>' + proc.procName + '</td>' +
                '<td>' + proc.wpTypeName + '</td>' +
                '<td>' + proc.eqNames + '</td>' +
                '<td>' +
                    '<button type="button" class="btn btn-white remove-btn">삭제</button>' +
                '</td>';

            selectedProcBody.appendChild(tr);

            bindRowEvent(tr);
            refreshStep();
        }

        function bindRowEvent(row) {
            const removeBtn = row.querySelector(".remove-btn");

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
    });
</script>