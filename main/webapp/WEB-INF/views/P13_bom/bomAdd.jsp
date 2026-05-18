<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
    const materialOptions = `
        <option value="">투입 품목 선택</option>

        <c:forEach var="item" items="${materialItemList}">
            <option value="${item.itemId}"
                    data-spec="${item.itemSpec}"
                    data-price="${item.itemPrice}"
                    data-unit="${item.itemUnit}">
                ${item.itemName} (${item.itemId})
            </option>
        </c:forEach>
    `;
</script>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">BOM 등록</h2>
            <p class="page-subtitle">새로운 BOM을 등록하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; bom &gt; 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/bom/insert"
          method="post"
          id="bomAddForm">

        <div class="btn-row">
            <div></div>

            <div>
                <a class="btn btn-white"
                   href="${pageContext.request.contextPath}/bom/list">
                    취소
                </a>

                <button type="submit" class="btn btn-main">
                    등록
                </button>
            </div>
        </div>

        <div class="bom-form-row">

            <div class="search-item bom-form-item">
                <label>생산 품목 <span class="red">*</span></label>

                <select name="bomItem" required>
                    <option value="">품목명 (품목코드) 선택</option>

                    <c:forEach var="item" items="${finishItemList}">
                        <option value="${item.itemId}">
                            ${item.itemName} (${item.itemId})
                        </option>
                    </c:forEach>
                </select>
            </div>

            <div class="search-item bom-form-item">
                <label>BOM명 <span class="red">*</span></label>

                <input type="text"
                       name="bomName"
                       required
                       placeholder="BOM명 입력">
            </div>

        </div>

        <div class="search-item bom-content-box">
            <label>BOM 설명</label>

            <textarea name="bomContent"
                      placeholder="BOM 설명을 입력하세요."></textarea>
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
                        <th style="width: 160px;">투입 수량</th>
                        <th style="width: 180px;">규격</th>
                        <th style="width: 180px;">단가 (원)</th>
                        <th style="width: 90px;">삭제</th>
                    </tr>
                </thead>

                <tbody id="bomDetailBody">
                    <tr>
                        <td>
                            <select name="bomDtlItemList"
                                    class="bom-detail-select"
                                    required>
                                <option value="">투입 품목 선택</option>

                                <c:forEach var="item" items="${materialItemList}">
                                    <option value="${item.itemId}"
                                            data-spec="${item.itemSpec}"
                                            data-price="${item.itemPrice}"
                                            data-unit="${item.itemUnit}">
                                        ${item.itemName} (${item.itemId})
                                    </option>
                                </c:forEach>
                            </select>
                        </td>

                        <td>
                            <input type="number"
                                   name="bomDtlQtyList"
                                   min="1"
                                   required
                                   placeholder="수량">
                        </td>

                        <td class="item-spec">-</td>
                        <td class="item-price">-</td>

                        <td>
                            <button type="button"
                                    class="btn btn-white remove-row-btn">
                                삭제
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </form>

</div>

<style>
    .bom-form-row {
        display: flex;
        justify-content: center;
        gap: 60px;

        margin: 44px 0 24px;
    }

    .bom-form-item {
        flex-direction: row;
        align-items: center;
        gap: 24px;
    }

    .bom-form-item label {
        min-width: 90px;

        font-size: 18px;
        font-weight: 700;
        color: #000;
    }

    .bom-form-item input,
    .bom-form-item select {
        width: 360px;
        height: 42px;
    }

    .bom-content-box {
        margin: 0 0 42px;
    }

    .bom-content-box label {
        margin-bottom: 6px;
    }

    .bom-content-box textarea {
        min-height: 110px;
    }

    .bom-section-title-row {
        display: flex;
        justify-content: space-between;
        align-items: center;

        margin: 0 0 24px;
    }

    #bomDetailBody select,
    #bomDetailBody input {
        width: 90%;
        height: 34px;
        padding: 0 10px;

        border: 1px solid var(--dark-gray);
        border-radius: 6px;

        font-size: 14px;
        background-color: #fff;
    }

    #bomDetailBody select:focus,
    #bomDetailBody input:focus {
        outline: none;
        border-color: var(--main-green);
    }

    #bomDetailBody .btn {
        margin: 0 auto;
    }

    @media (max-width: 1100px) {
        .bom-form-row {
            flex-direction: column;
            gap: 18px;
        }

        .bom-form-item {
            justify-content: flex-start;
        }
    }
</style>

<script>
    window.addEventListener("load", function () {
        bindBomAddEvents();
    });

    function bindBomAddEvents() {
        const addItemBtn = document.querySelector("#addItemBtn");
        const bomDetailBody = document.querySelector("#bomDetailBody");

        addItemBtn.addEventListener("click", function () {
            addBomDetailRow();
        });

        bomDetailBody.addEventListener("change", function (e) {
            if (e.target.classList.contains("bom-detail-select")) {
                updateItemInfo(e.target);
            }
        });

        bomDetailBody.addEventListener("click", function (e) {
            if (e.target.classList.contains("remove-row-btn")) {
                removeBomDetailRow(e.target);
            }
        });
    }

    function addBomDetailRow() {

        const bomDetailBody =
            document.querySelector("#bomDetailBody");

        const tr = document.createElement("tr");

        tr.innerHTML =
            '<td>' +
                '<select name="bomDtlItemList" ' +
                        'class="bom-detail-select" required>' +
                    materialOptions +
                '</select>' +
            '</td>' +

            '<td>' +
                '<input type="number" ' +
                       'name="bomDtlQtyList" ' +
                       'min="1" ' +
                       'required ' +
                       'placeholder="수량">' +
            '</td>' +

            '<td class="item-spec">-</td>' +
            '<td class="item-price">-</td>' +

            '<td>' +
                '<button type="button" ' +
                        'class="btn btn-white remove-row-btn">' +
                    '삭제' +
                '</button>' +
            '</td>';

        bomDetailBody.appendChild(tr);
    }

    function updateItemInfo(selectEl) {
        const selectedOption = selectEl.options[selectEl.selectedIndex];

        const spec = selectedOption.dataset.spec || "-";
        const unit = selectedOption.dataset.unit || "";
        const price = selectedOption.dataset.price || "-";

        const row = selectEl.closest("tr");

        row.querySelector(".item-spec").textContent =
            unit ? spec + " / " + unit : spec;

        if (price === "-") {
            row.querySelector(".item-price").textContent = "-";
        } else {
            row.querySelector(".item-price").textContent =
                Number(price).toLocaleString();
        }
    }

    function removeBomDetailRow(buttonEl) {
        const bomDetailBody = document.querySelector("#bomDetailBody");
        const rows = bomDetailBody.querySelectorAll("tr");

        if (rows.length <= 1) {
            alert("투입 품목은 최소 1개 이상 필요합니다.");
            return;
        }

        buttonEl.closest("tr").remove();
    }
</script>