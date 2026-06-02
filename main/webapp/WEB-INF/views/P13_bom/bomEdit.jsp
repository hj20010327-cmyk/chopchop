<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">BOM 수정</h2>
            <p class="page-subtitle">BOM(${bom.bomId})의 정보를 수정하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; BOM 관리 &gt; 수정</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/bom/update"
          method="post"
          class="grid-form"
          id="bomEditForm">

        <input type="hidden" name="bomId" value="${bom.bomId}">

        <div class="btn-row">
		    <div class="left"></div>
		
		    <div class="right">
		        <a class="btn btn-white"
		           href="${pageContext.request.contextPath}/bom/detail?bomId=${bom.bomId}"
		           onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');">
		            취소
		        </a>
		
		        <button type="submit" class="btn btn-main">
		            수정
		        </button>
		    </div>
		</div>

        <div class="grid-wrap bom-grid-wrap">

            <div class="search-item bom-code-item">
                <label>BOM 코드</label>
                <input type="text" value="${bom.bomId}" readonly>
            </div>

            <div class="search-item bom-type-item">
                <label>품목 유형 <span class="red">*</span></label>

                <select id="bomItemTypeSelect">
                    <option value="30"
                        <c:if test="${bom.itemType == 30}">selected</c:if>>
                        완제품
                    </option>

                    <option value="20"
                        <c:if test="${bom.itemType == 20}">selected</c:if>>
                        반제품
                    </option>
                </select>
            </div>

            <div class="search-item bom-product-item">
                <label>생산 품목 <span class="red">*</span></label>

                <select name="bomItem"
                        id="bomItemSelect"
                        required>
                    <option value="" disabled>
                        품목명 (품목코드) 선택
                    </option>

                    <c:forEach var="item" items="${finishItemList}">
                        <option value="${item.itemId}"
                                data-item-type="${item.itemType}"
                            <c:if test="${item.itemId == bom.bomItem}">selected</c:if>>
                            ${item.itemName} (${item.itemId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item bom-name-item">
                <label>BOM명 <span class="red">*</span></label>

                <input type="text"
                       name="bomName"
                       value="${bom.bomName}"
                       required
                       placeholder="BOM명 입력">
            </div>

            <div class="search-item bom-content-item">
                <label>BOM 설명</label>

                <textarea name="bomContent"
                          class="bom-content-textarea"
                          placeholder="BOM 설명을 입력하세요.">${bom.bomContent}</textarea>
            </div>

        </div>

        <div class="bom-section-title-row">
            <div class="content-content-content-title">
                투입 품목
            </div>

            <button type="button"
                    class="btn btn-main"
                    id="addItemBtn">
                품목 추가
            </button>
        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th>투입 품목</th>
                        <th>투입 수량</th>
                        <th>규격</th>
                        <th>단가 (원)</th>
                        <th>소요금액 (원)</th>
                        <th>삭제</th>
                    </tr>
                </thead>

                <tbody id="bomDetailBody">
                    <c:forEach var="detail" items="${detailList}">
                        <tr class="bom-detail-row"
                            data-item-id="${detail.bomDtlItem}"
                            data-qty="${detail.bomDtlQty}">

                            <td class="bom-item-name">
                                ${detail.itemName} (${detail.bomDtlItem})
                                <input type="hidden"
                                       name="bomDtlItemList"
                                       value="${detail.bomDtlItem}">
                            </td>

                            <td>
                                <fmt:formatNumber value="${detail.bomDtlQty}" pattern="#,##0" /> ${detail.itemUnit}
                                <input type="hidden"
                                       name="bomDtlQtyList"
                                       value="${detail.bomDtlQty}">
                            </td>

                            <td>${detail.itemSpec} / ${detail.itemUnit}</td>

                            <td>
                                <fmt:formatNumber value="${detail.itemPrice}" pattern="#,##0" />
                            </td>

                            <td>
                                <fmt:formatNumber value="${detail.itemPrice * detail.bomDtlQty}" pattern="#,##0" />
                            </td>

                            <td>
                                <button type="button"
                                        class="remove-row-btn">
                                    ✕
                                </button>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty detailList}">
                        <tr class="empty-add-row">
                            <td colspan="6">
                                - 투입 품목을 추가하려면 이 영역을 클릭하거나 품목 추가 버튼을 눌러주세요.
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

    </form>

</div>

<div class="modal-overlay" id="bomItemModal">
    <div class="modal-box bom-item-modal-box">

        <div class="modal-header">
            <h3 class="modal-title">투입 품목 선택</h3>

            <button type="button"
                    class="modal-close-btn"
                    id="closeBomItemModalBtn">
                ×
            </button>
        </div>

        <div class="modal-body">

            <div class="search-item modal-search-item">
                <label>품목 유형 <span class="red">*</span></label>

                <select id="modalBomItemTypeSelect">
                    <option value="10">원자재</option>
                    <option value="20">반제품</option>
                    <option value="40">기타 자재</option>
                </select>
            </div>

            <div class="search-item modal-search-item">
                <label>투입 품목 <span class="red">*</span></label>

                <select id="modalBomItemSelect">
                    <option value="">투입 품목 선택</option>

                    <c:forEach var="item" items="${materialItemList}">
                        <option value="${item.itemId}"
                                data-item-type="${item.itemType}"
                                data-spec="${item.itemSpec}"
                                data-price="${item.itemPrice}"
                                data-unit="${item.itemUnit}">
                            ${item.itemName} (${item.itemId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item modal-search-item">
                <label>투입 수량 <span class="red">*</span></label>

                <input type="number"
                       id="modalBomQtyInput"
                       min="1"
                       placeholder="수량">
            </div>

            <div class="modal-info-box">
                <div>
                    <span>규격</span>
                    <strong id="modalItemSpec">-</strong>
                </div>

                <div>
                    <span>단가</span>
                    <strong id="modalItemPrice">-</strong>
                </div>

                <div>
                    <span>소요금액</span>
                    <strong id="modalTotalPrice">-</strong>
                </div>
            </div>

        </div>

        <div class="modal-footer">
            <button type="button"
                    class="btn btn-white"
                    id="cancelBomItemModalBtn">
                취소
            </button>

            <button type="button"
                    class="btn btn-main"
                    id="saveBomItemBtn">
                적용
            </button>
        </div>

    </div>
</div>

<style>
    .bom-grid-wrap {
        display: grid;
        grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
        width: 624px;
        column-gap: 24px;
        row-gap: 18px;
    }

    .bom-code-item,
    .bom-type-item,
    .bom-product-item,
    .bom-name-item,
    .bom-content-item {
        min-width: 0;
    }

    .bom-code-item {
        grid-column: 1 / 2;
    }

    .bom-type-item {
        grid-column: 1 / 2;
    }

    .bom-product-item {
        grid-column: 2 / 3;
    }

    .bom-name-item {
        grid-column: 1 / 3;
    }

    .bom-content-item {
        grid-column: 1 / 3;
    }

    .bom-grid-wrap input,
    .bom-grid-wrap select,
    .bom-grid-wrap textarea {
        width: 100%;
        box-sizing: border-box;
    }

    .bom-content-textarea {
        min-height: 100px;
    }

    .bom-section-title-row {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin: 32px 0 16px;
    }

    .empty-add-row {
        cursor: pointer;
    }

    .empty-add-row td {
        height: 52px;
        color: #777;
        text-align: center;
    }

    .empty-add-row:hover td {
        color: var(--main-green);
        text-decoration: underline;
        background-color: #f8faf9;
    }

    .bom-detail-row {
        cursor: pointer;
    }

    .bom-detail-row:hover .bom-item-name {
        color: var(--main-green);
        text-decoration: underline;
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

    .modal-overlay {
        display: none;

        position: fixed;
        inset: 0;
        z-index: 1000;

        background-color: rgba(0, 0, 0, 0.35);

        justify-content: center;
        align-items: center;
    }

    .modal-overlay.active {
        display: flex;
    }

    .modal-box {
        width: 560px;
        padding: 24px;

        border-radius: 10px;
        background-color: #fff;

        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.18);
    }

    .modal-header {
        display: flex;
        justify-content: space-between;
        align-items: center;

        margin-bottom: 20px;
    }

    .modal-title {
        margin: 0;

        font-size: 20px;
        font-weight: 800;
    }

    .modal-close-btn {
        border: none;
        background: none;

        font-size: 26px;
        font-weight: 700;

        cursor: pointer;
    }

    .modal-body {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .modal-search-item select,
    .modal-search-item input {
        width: 100%;
        height: 38px;

        padding: 0 10px;

        border: 1px solid var(--dark-gray);
        border-radius: 6px;

        font-size: 14px;
        background-color: #fff;
    }

    .modal-search-item select:focus,
    .modal-search-item input:focus {
        outline: none;
        border-color: var(--main-green);
    }

    .modal-info-box {
        display: grid;
        grid-template-columns: 1fr 1fr 1fr;
        gap: 12px;

        margin-top: 4px;
    }

    .modal-info-box div {
        padding: 14px 16px;

        border: 1px solid var(--gray);
        border-radius: 8px;
        background-color: #f8f9fa;
    }

    .modal-info-box span {
        display: block;

        margin-bottom: 8px;

        font-size: 13px;
        color: #777;
    }

    .modal-info-box strong {
        font-size: 15px;
        color: #222;
    }

    .modal-footer {
        display: flex;
        justify-content: flex-end;
        gap: 8px;

        margin-top: 24px;
    }
    
@media screen and (max-width: 480px) {
	.grid-wrap {
		display: flex !important;
		flex-direction: column !important;
		align-items: flex-start;
	}
	
	.grid-wrap input[type="text"] {
		width: 80vw;
	}
	
	.modal-box {
		width: 90%;
	}
	
	.bom-content-item {
		width: 53% !important;
	}
}
</style>

<script>
    let editingRow = null;

    window.addEventListener("load", function () {
        bindBomEditEvents();
    });

    function bindBomEditEvents() {
        const bomItemTypeSelect = document.querySelector("#bomItemTypeSelect");
        const bomItemSelect = document.querySelector("#bomItemSelect");

        const addItemBtn = document.querySelector("#addItemBtn");
        const bomDetailBody = document.querySelector("#bomDetailBody");
        const bomEditForm = document.querySelector("#bomEditForm");

        const modal = document.querySelector("#bomItemModal");
        const closeBtn = document.querySelector("#closeBomItemModalBtn");
        const cancelBtn = document.querySelector("#cancelBomItemModalBtn");
        const saveBtn = document.querySelector("#saveBomItemBtn");
        const itemSelect = document.querySelector("#modalBomItemSelect");
        const itemTypeSelect = document.querySelector("#modalBomItemTypeSelect");
        const qtyInput = document.querySelector("#modalBomQtyInput");

        bomItemTypeSelect.addEventListener("change", function () {
            filterBomItems(true);
        });

        itemTypeSelect.addEventListener("change", function () {
            filterModalBomItems(true);
        });

        filterBomItems(false);
        filterModalBomItems(false);

        addItemBtn.addEventListener("click", function () {
            openBomItemModal(null);
        });

        bomDetailBody.addEventListener("click", function (e) {
            if (e.target.classList.contains("remove-row-btn")) {
                e.stopPropagation();
                removeBomDetailRow(e.target);
                return;
            }

            const emptyRow = e.target.closest(".empty-add-row");
            if (emptyRow) {
                openBomItemModal(null);
                return;
            }

            const detailRow = e.target.closest(".bom-detail-row");
            if (detailRow) {
                openBomItemModal(detailRow);
            }
        });

        itemSelect.addEventListener("change", function () {
            updateModalItemInfo();
        });

        qtyInput.addEventListener("input", function () {
            updateModalItemInfo();
        });

        closeBtn.addEventListener("click", function () {
            closeBomItemModal();
        });

        cancelBtn.addEventListener("click", function () {
            closeBomItemModal();
        });

        modal.addEventListener("click", function (e) {
            if (e.target === modal) {
                closeBomItemModal();
            }
        });

        saveBtn.addEventListener("click", function () {
            saveBomDetailRow();
        });

        bomEditForm.addEventListener("submit", function (e) {
            const detailRows = document.querySelectorAll("#bomDetailBody .bom-detail-row");

            if (detailRows.length === 0) {
                alert("투입 품목을 1개 이상 추가해주세요.");
                e.preventDefault();
            }
        });
    }

    function filterBomItems(resetValue) {
        const typeSelect = document.querySelector("#bomItemTypeSelect");
        const itemSelect = document.querySelector("#bomItemSelect");

        const selectedType = typeSelect.value;
        const options = itemSelect.querySelectorAll("option");

        options.forEach(option => {
            if (!option.dataset.itemType) {
                option.hidden = false;
                return;
            }

            option.hidden = option.dataset.itemType !== selectedType;
        });

        if (resetValue) {
            itemSelect.value = "";
        }
    }

    function filterModalBomItems(resetValue) {
        const typeSelect = document.querySelector("#modalBomItemTypeSelect");
        const itemSelect = document.querySelector("#modalBomItemSelect");

        const selectedType = typeSelect.value;
        const options = itemSelect.querySelectorAll("option");

        options.forEach(option => {
            if (!option.dataset.itemType) {
                option.hidden = false;
                return;
            }

            option.hidden = option.dataset.itemType !== selectedType;
        });

        if (resetValue) {
            itemSelect.value = "";
        }

        updateModalItemInfo();
    }

    function openBomItemModal(row) {
        editingRow = row;

        const modal = document.querySelector("#bomItemModal");
        const itemSelect = document.querySelector("#modalBomItemSelect");
        const itemTypeSelect = document.querySelector("#modalBomItemTypeSelect");
        const qtyInput = document.querySelector("#modalBomQtyInput");

        itemTypeSelect.value = "10";
        itemSelect.value = "";
        qtyInput.value = "";

        document.querySelector("#modalItemSpec").textContent = "-";
        document.querySelector("#modalItemPrice").textContent = "-";
        document.querySelector("#modalTotalPrice").textContent = "-";

        if (row) {
            itemSelect.value = row.dataset.itemId;

            const selectedOption = itemSelect.options[itemSelect.selectedIndex];

            if (selectedOption && selectedOption.dataset.itemType) {
                itemTypeSelect.value = selectedOption.dataset.itemType;
            }

            filterModalBomItems(false);

            itemSelect.value = row.dataset.itemId;
            qtyInput.value = row.dataset.qty;

            updateModalItemInfo();
        } else {
            filterModalBomItems(false);
        }

        modal.classList.add("active");
    }

    function closeBomItemModal() {
        document.querySelector("#bomItemModal").classList.remove("active");
        editingRow = null;
    }

    function updateModalItemInfo() {
        const itemSelect = document.querySelector("#modalBomItemSelect");
        const qtyInput = document.querySelector("#modalBomQtyInput");
        const selectedOption = itemSelect.options[itemSelect.selectedIndex];

        if (!selectedOption || !selectedOption.value) {
            document.querySelector("#modalItemSpec").textContent = "-";
            document.querySelector("#modalItemPrice").textContent = "-";
            document.querySelector("#modalTotalPrice").textContent = "-";
            return;
        }

        const spec = selectedOption.dataset.spec || "-";
        const unit = selectedOption.dataset.unit || "";
        const price = selectedOption.dataset.price || "-";
        const qty = Number(qtyInput.value || 0);

        document.querySelector("#modalItemSpec").textContent =
            unit ? spec + " / " + unit : spec;

        document.querySelector("#modalItemPrice").textContent =
            price === "-"
                ? "-"
                : Number(price).toLocaleString() + "원";

        document.querySelector("#modalTotalPrice").textContent =
            price === "-" || qty <= 0
                ? "-"
                : (Number(price) * qty).toLocaleString() + "원";
    }

    function saveBomDetailRow() {
        const itemSelect = document.querySelector("#modalBomItemSelect");
        const qtyInput = document.querySelector("#modalBomQtyInput");
        const selectedOption = itemSelect.options[itemSelect.selectedIndex];

        if (!selectedOption || !selectedOption.value) {
            alert("투입 품목을 선택해주세요.");
            itemSelect.focus();
            return;
        }

        if (!qtyInput.value || Number(qtyInput.value) <= 0) {
            alert("투입 수량을 입력해주세요.");
            qtyInput.focus();
            return;
        }

        const itemId = selectedOption.value;
        const itemText = selectedOption.textContent.trim();
        const spec = selectedOption.dataset.spec || "-";
        const unit = selectedOption.dataset.unit || "";
        const price = selectedOption.dataset.price || "-";
        const qty = qtyInput.value;

        if (editingRow) {
            updateBomDetailRow(editingRow, itemId, itemText, qty, spec, unit, price);
        } else {
            addBomDetailRow(itemId, itemText, qty, spec, unit, price);
        }

        closeBomItemModal();
    }

    function addBomDetailRow(itemId, itemText, qty, spec, unit, price) {
        removeEmptyRow();

        const bomDetailBody = document.querySelector("#bomDetailBody");
        const tr = document.createElement("tr");

        tr.className = "bom-detail-row";
        tr.dataset.itemId = itemId;
        tr.dataset.qty = qty;

        tr.innerHTML = makeBomDetailRowHtml(itemId, itemText, qty, spec, unit, price);

        bomDetailBody.appendChild(tr);
    }

    function updateBomDetailRow(row, itemId, itemText, qty, spec, unit, price) {
        row.dataset.itemId = itemId;
        row.dataset.qty = qty;
        row.innerHTML = makeBomDetailRowHtml(itemId, itemText, qty, spec, unit, price);
    }

    function makeBomDetailRowHtml(itemId, itemText, qty, spec, unit, price) {
        const specText = unit ? spec + " / " + unit : spec;
        const qtyText = Number(qty).toLocaleString();
        const priceText = price === "-" ? "-" : Number(price).toLocaleString();
        const totalPriceText =
            price === "-"
                ? "-"
                : (Number(price) * Number(qty)).toLocaleString();

        return ''
            + '<td class="bom-item-name">'
            + itemText
            + '<input type="hidden" name="bomDtlItemList" value="' + itemId + '">'
            + '</td>'
            + '<td>'
            + qtyText + (unit ? ' ' + unit : '')
            + '<input type="hidden" name="bomDtlQtyList" value="' + qty + '">'
            + '</td>'
            + '<td>' + specText + '</td>'
            + '<td>' + priceText + '</td>'
            + '<td>' + totalPriceText + '</td>'
            + '<td>'
            + '<button type="button" class="remove-row-btn">✕</button>'
            + '</td>';
    }

    function removeBomDetailRow(buttonEl) {
        buttonEl.closest("tr").remove();

        const rows = document.querySelectorAll("#bomDetailBody .bom-detail-row");

        if (rows.length === 0) {
            appendEmptyRow();
        }
    }

    function removeEmptyRow() {
        const emptyRow = document.querySelector("#bomDetailBody .empty-add-row");

        if (emptyRow) {
            emptyRow.remove();
        }
    }

    function appendEmptyRow() {
        const bomDetailBody = document.querySelector("#bomDetailBody");
        const tr = document.createElement("tr");

        tr.className = "empty-add-row";
        tr.innerHTML =
            '<td colspan="6">'
            + '- 투입 품목을 추가하려면 이 영역을 클릭하거나 품목 추가 버튼을 눌러주세요.'
            + '</td>';

        bomDetailBody.appendChild(tr);
    }
</script>