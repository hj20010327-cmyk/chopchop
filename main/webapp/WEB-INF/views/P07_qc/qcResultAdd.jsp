<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div>

    <div class="header-row">
        <div>
            <h2 class="page-title">품질검사 결과 등록</h2>
            <p class="page-subtitle">품질검사 지시(${qc.qcId})의 결과를 수정하세요.</p>
        </div>

        <div>
            <p class="page-route">홈 &gt; 품질관리 &gt; 결과 &gt; 등록</p>
        </div>
    </div>

    <form action="${pageContext.request.contextPath}/quality/result/insertDo"
        method="post"
        style="width:100%; max-width:1100px;">

		<input type="hidden" name="qcId" value="${qc.qcId}">
		<input type="hidden" name="qcLot" value="${qc.qcLot}">
		<input type="hidden" name="qcQty" id="qcQty" value="${qc.qcQty}">
		<input type="hidden" name="qcType" id="qcType" value="${qc.qcType}">
		<input type="hidden" name="lotQty" id="lotQty" value="${qc.lotQty}">
		
		<input type="hidden" id="savedWhId" value="${qc.whId}">
		<input type="hidden" id="savedSecId" value="${qc.bwhsec}">
		

        <div style="display:flex; justify-content:flex-end; gap:12px;">
            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/quality/detail?qcId=${qc.qcId}">
                취소
            </a>

            <button type="submit" class="btn btn-main">
                등록
            </button>
        </div>

<!--         <div style="margin-top:45px; margin-bottom:35px; font-size:20px; font-weight:700;"> -->
<%--             검사자 : ${qc.workerName} (${qc.qcWorker}) --%>
<!--         </div> -->

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>검사 코드</label>
                <input type="text" value="${qc.qcId}" readonly>
            </div>

            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>검사대상</label>
                <input type="text" value="${qc.qcLot}" readonly>
            </div>
        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>품목</label>
                <input type="text" value="${qc.itemName} (${qc.itemId})" readonly>
                <input type="hidden" value="${qc.itemId}" id="itemId">
            </div>

            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>검사 수량</label>
                <input type="text" id="qcQtyText" value="${qc.qcQty}" readonly>
            </div>
        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class='status'>
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>검사 상태 <span class="red">*</span></label>

                <div style="display:flex; gap:22px; height:42px; align-items:center;">
                    <input style="min-width:0;" type="radio" name="qcStatus" value="10" ${qc.qcStatus == 10 ? 'checked' : ''}> 대기
                    <input style="min-width:0;" type="radio" name="qcStatus" value="20" ${qc.qcStatus == 20 ? 'checked' : ''}> 진행중
                    <input style="min-width:0;" type="radio" name="qcStatus" value="30" ${qc.qcStatus == 30 ? 'checked' : ''}> 완료
                    <input style="min-width:0;" type="radio" name="qcStatus" value="40" ${qc.qcStatus == 40 ? 'checked' : ''}> 중단
                    <input style="min-width:0;" type="radio" name="qcStatus" value="0" ${qc.qcStatus == 0 ? 'checked' : ''}> 보류
                </div>
            </div>
        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>합격 수량</label>
                <input type="text" id="qcPassQtyText" value="${qc.qcPassQty}" readonly>
                <input type="hidden" name="qcPassQty" id="qcPassQty" value="${qc.qcPassQty}">
            </div>

            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>불량 수량</label>
                <input type="text" id="failQty" value="0" placeholder="불량 수량" readonly>
            </div>
        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>입고 창고 <span class="red">*</span></label>
                <select id="whId">
                    <option value="">창고 선택</option>
                </select>
            </div>

            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>입고 구역 <span class="red">*</span></label>
                <select name="awhsec" id="awhsec">
                    <option value="">구역 선택</option>
                </select>
            </div>
        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">
            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>입고 수량</label>
                <input type="text" id="inQty" placeholder="입고 수량" readonly>
            </div>

            <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                <label>폐기 수량</label>
                <input type="text" id="disposeQty" value="0" placeholder="폐기 수량" readonly>
            </div>
        </div>

        <div class="search-item" style="margin-bottom:26px;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <label>불량 상세 내역</label>
                <button type="button" class="btn btn-main" id="addDefectBtn">
                    불량 상세내역 추가
                </button>
            </div>

            <div class="table-wrap" style="margin-top:15px;">
                <table class="table">
                    <thead>
                        <tr>
                            <th>불량 유형</th>
                            <th>불량 수량</th>
                            <th>조치 내용</th>
                            <th>폐기</th>
                            <th>삭제</th>
                        </tr>
                    </thead>

                    <tbody id="defectTbody">
                        <c:choose>
                            <c:when test="${empty defLogList}">
                                <tr>
                                    <td colspan="5" style="text-align:center;">
                                        등록된 불량 내역이 없습니다.
                                    </td>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="def" items="${defLogList}">
                                    <tr class="defect-row">
                                        <td>
                                            ${def.defTypeName} (${def.defType})
                                            <input type="hidden" name="defectType" value="${def.defType}">
                                        </td>

                                        <td>
                                            ${def.defQty}
                                            <input type="hidden"
                                                class="defectQtyValue"
                                                name="defectQty"
                                                value="${def.defQty}">
                                        </td>

                                        <td>
                                            ${def.defAction}
                                            <input type="hidden"
                                                name="defectAction"
                                                value="${def.defAction}">
                                        </td>

                                        <td>
                                            ${def.defDiscard}
                                            <input type="hidden"
                                                class="defectDiscardValue"
                                                name="defectDiscard"
                                                value="${def.defDiscard}">
                                        </td>

                                        <td>
                                            <button type="button" class="remove-row-btn">✕</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="search-item" style="display:flex; flex-direction:column;">
            <label>특이사항</label>
            <textarea name="qcWmsg"
                placeholder="작업 특이사항을 입력하세요. (선택)"
                style="height:180px;">${qc.qcWmsg}</textarea>
        </div>

    </form>

    <div class="overlay" id="defectModal">
        <div class="modal" style="width:850px;">

            <div style="display:flex; justify-content:space-between; align-items:center;">
                <div>
                    <div class="modal-title">불량 상세 내역 추가</div>
                    <p class="modal-subTitle">불량 상세 내역을 입력해주세요.</p>
                </div>

                <button type="button" class="btn btn-red" id="defectDeleteBtn">
                    삭제
                </button>
            </div>

            <div style="display:flex; gap:30px; margin-top:30px;">
                <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                    <label>불량 유형 <span class="red">*</span></label>
                    <select id="defectType">
                        <option value="">불량 유형 선택하기</option>
                    </select>
                </div>

                <div class="search-item" style="display:flex; flex-direction:column; flex:1;">
                    <label>수량 <span class="red">*</span></label>
                    <input type="number" id="defectQty" placeholder="수량 입력" min="1">
                </div>
            </div>

            <div style="display:flex; justify-content:space-between; align-items:center; margin-top:28px;">
                <label style="font-weight:700;">조치 내용</label>

                <label>
                    <input type="checkbox" id="defectDiscard" style="min-width:0;">
                    폐기 여부
                </label>
            </div>

            <textarea id="defectAction"
                placeholder="조치 내용을 입력하세요. (선택)"
                style="width:100%; height:170px; margin-top:12px;"></textarea>

            <div style="display:flex; justify-content:center; gap:14px; margin-top:28px;">
                <button type="button" class="btn btn-white" id="defectModalClose">
                    취소
                </button>

                <button type="button" class="btn btn-main" id="defectSaveBtn">
                    등록
                </button>
            </div>

        </div>
    </div>

</div>

<style>
input[readonly] {
    background-color: var(--light-gray);
    color: #000;
    cursor: not-allowed;
}

.remove-row-btn {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 50%;
    background-color: #f1f3f5;
    color: #666;
    font-size: 12px;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}

.remove-row-btn:hover {
    background-color: #dee2e6;
    color: #333;
    transform: scale(1.05);
}

.table tbody tr:hover {
	background-color: white;
	cursor: default;
}



@media screen and (max-width: 480px) {
	.column {
		flex-direction: column;
	}
	
	.textarea {
		min-width: 0px !important;
	}
	
	.status label {
		margin-top: 15px;
	}
	
	.status div {
		flex-wrap: wrap;
	}
}

</style>

<script>
window.addEventListener("load", function() {
    formatQty();
    loadDefectTypeList();
    loadWarehouseList();
    bind();
    bindDefectRemoveButtons();
    recalcByDefectRows();
});

function bind() {
    const form = document.querySelector("form");

    document.querySelector("#addDefectBtn").addEventListener("click", function() {
        openDefectModal();
    });

    document.querySelector("#defectModalClose").addEventListener("click", function() {
        document.querySelector("#defectModal").style.display = "none";
    });

    document.querySelector("#defectSaveBtn").addEventListener("click", function() {
        addDefectRow();
    });

    document.querySelector("#defectDeleteBtn").addEventListener("click", function() {
        clearDefectForm();
    });

    document.querySelector("#defectType").addEventListener("change", function() {
        const option = this.options[this.selectedIndex];

        document.querySelector("#defectAction").value =
            option.dataset.action || "";
    });

    document.querySelector("#whId").addEventListener("change", function() {
        loadSectionList(this.value);
    });

    document.querySelectorAll("input, textarea").forEach(el => {
        el.addEventListener("blur", function() {
            this.value = this.value.trim();
        });
    });

    form.addEventListener("submit", function(e) {
        const targets = this.querySelectorAll("input[type=text]:not([readonly])");

        for (let i = 0; i < targets.length; i++) {
            if (targets[i].value.trim() === "") {
                alert("공백만 입력할 수 없습니다.");
                targets[i].focus();
                e.preventDefault();
                return false;
            }
        }

        if (!validateForm()) {
            e.preventDefault();
            return false;
        }
    });
}

function loadWarehouseList() {
    const itemId = document.querySelector("#itemId").value;
    const savedWhId = document.querySelector("#savedWhId")?.value || "";

    fetch("${pageContext.request.contextPath}/quality/result/warehouseList?itemId="
        + encodeURIComponent(itemId))
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html = '<option value="">창고 선택</option>';

            for (let i = 0; i < result.length; i++) {
                html += '<option value="' + result[i].whId + '">';
                html += result[i].whName + ' (' + result[i].whId + ')';
                html += '</option>';
            }

            document.querySelector("#whId").innerHTML = html;

            if (savedWhId) {
                document.querySelector("#whId").value = savedWhId;
                loadSectionList(savedWhId, true);
            } else {
                document.querySelector("#awhsec").innerHTML =
                    '<option value="">구역 선택</option>';
            }
        })
        .catch(function() {
            alert("창고 목록 조회 실패");
        });
}

function loadSectionList(whId, isInit) {
    if (!whId) {
        document.querySelector("#awhsec").innerHTML =
            '<option value="">구역 선택</option>';
        return;
    }

    const savedSecId = document.querySelector("#savedSecId")?.value || "";

    fetch("${pageContext.request.contextPath}/quality/result/sectionList?whId="
        + encodeURIComponent(whId))
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html = '<option value="">구역 선택</option>';

            for (let i = 0; i < result.length; i++) {
                html += '<option value="' + result[i].secId + '">';
                html += result[i].secId;
                html += ' (';
                html += result[i].secPrevQty;
                html += '/';
                html += result[i].secQty;
                html += ')';
                html += '</option>';
            }

            document.querySelector("#awhsec").innerHTML = html;

            if (isInit && savedSecId) {
                document.querySelector("#awhsec").value = savedSecId;
            }
        })
        .catch(function() {
            alert("구역 목록 조회 실패");
        });
}

function loadDefectTypeList() {
    fetch("${pageContext.request.contextPath}/quality/result/defectTypeList")
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html = '<option value="">불량 유형 선택하기</option>';

            for (let i = 0; i < result.length; i++) {
                html += '<option ';
                html += 'value="' + result[i].defTypeId + '" ';
                html += 'data-name="' + result[i].defTypeName + '" ';
                html += 'data-action="' + result[i].defStandardAction + '">';
                html += result[i].defTypeName + ' (' + result[i].defTypeId + ')';
                html += '</option>';
            }

            document.querySelector("#defectType").innerHTML = html;
        })
        .catch(function() {
            alert("불량 유형 목록 조회 실패");
        });
}

function openDefectModal() {
    clearDefectForm();
    document.querySelector("#defectModal").style.display = "flex";
}

function clearDefectForm() {
    document.querySelector("#defectType").value = "";
    document.querySelector("#defectQty").value = "";
    document.querySelector("#defectAction").value = "";
    document.querySelector("#defectDiscard").checked = false;
}

function addDefectRow() {
    const defectTypeSelect = document.querySelector("#defectType");
    const defectType = defectTypeSelect.value;
    const selectedOption = defectTypeSelect.options[defectTypeSelect.selectedIndex];

    const defectTypeName = selectedOption.dataset.name;
    let defectAction = document.querySelector("#defectAction").value;
    const defectQty = document.querySelector("#defectQty").value;
    const defectDiscard = document.querySelector("#defectDiscard").checked ? "Y" : "N";

    if (!defectType) {
        alert("불량 유형을 선택하세요.");
        return;
    }

    if (!defectQty || Number(defectQty) <= 0) {
        alert("불량 수량을 입력하세요.");
        return;
    }

    if (!defectAction) {
        defectAction = selectedOption.dataset.action || "";
    }

    const qcQty = Number(document.querySelector("#qcQty").value);
    const currentDefectTotal = getDefectTotalQty();

    if (currentDefectTotal + Number(defectQty) > qcQty) {
        alert("불량 수량 합계는 검사 수량보다 클 수 없습니다.");
        return;
    }

    const tbody = document.querySelector("#defectTbody");

    if (tbody.querySelector("td[colspan='5']") || tbody.querySelector("td[colspan='4']")) {
        tbody.innerHTML = "";
    }

    let html = "";

    html += "<tr class='defect-row'>";

    html += "<td>";
    html += defectTypeName + " (" + defectType + ")";
    html += "<input type='hidden' name='defectType' value='" + defectType + "'>";
    html += "</td>";

    html += "<td>";
    html += Number(defectQty).toLocaleString();
    html += "<input type='hidden' class='defectQtyValue' name='defectQty' value='" + defectQty + "'>";
    html += "</td>";

    html += "<td>";
    html += defectAction || "-";
    html += "<input type='hidden' name='defectAction' value='" + defectAction + "'>";
    html += "</td>";

    html += "<td>";
    html += defectDiscard;
    html += "<input type='hidden' class='defectDiscardValue' name='defectDiscard' value='" + defectDiscard + "'>";
    html += "</td>";

    html += "<td>";
    html += "<button type='button' class='remove-row-btn'>✕</button>";
    html += "</td>";

    html += "</tr>";

    tbody.insertAdjacentHTML("beforeend", html);

    bindDefectRemoveButtons();
    recalcByDefectRows();

    document.querySelector("#defectModal").style.display = "none";
}

function bindDefectRemoveButtons() {
    const buttons = document.querySelectorAll(".remove-row-btn");

    for (let i = 0; i < buttons.length; i++) {
        buttons[i].onclick = function() {
            this.closest("tr").remove();
            restoreEmptyDefectRow();
            recalcByDefectRows();
        };
    }
}

function restoreEmptyDefectRow() {
    const tbody = document.querySelector("#defectTbody");
    const rows = tbody.querySelectorAll(".defect-row");

    if (rows.length === 0) {
        tbody.innerHTML =
            "<tr>" +
                "<td colspan='5' style='text-align:center;'>" +
                    "등록된 불량 상세 내역이 없습니다." +
                "</td>" +
            "</tr>";
    }
}

function getDefectTotalQty() {
    const qtyInputs = document.querySelectorAll(".defectQtyValue");
    let total = 0;

    for (let i = 0; i < qtyInputs.length; i++) {
        total += Number(qtyInputs[i].value || 0);
    }

    return total;
}

function getDisposeTotalQty() {
    const rows = document.querySelectorAll(".defect-row");
    let total = 0;

    for (let i = 0; i < rows.length; i++) {
        const qty = Number(rows[i].querySelector(".defectQtyValue").value || 0);
        const discard = rows[i].querySelector(".defectDiscardValue").value;

        if (discard === "Y") {
            total += qty;
        }
    }

    return total;
}

function recalcByDefectRows() {
    const qcQty = Number(document.querySelector("#qcQty").value);
    const qcType = document.querySelector("#qcType").value;
    const lotQty = Number(document.querySelector("#lotQty").value);

    const failQty = getDefectTotalQty();
    const sampleDisposeQty = getDisposeTotalQty();
    const passQty = qcQty - failQty;

    let multiplier = 1;

    if (qcType === "20") {
        multiplier = 100;
    }

    let inQty = passQty * multiplier;
    let disposeQty = sampleDisposeQty * multiplier;

    if (inQty > lotQty) {
        inQty = lotQty;
    }

    if (disposeQty > lotQty) {
        disposeQty = lotQty;
    }

    document.querySelector("#qcPassQtyText").value =
        passQty.toLocaleString();

    document.querySelector("#qcPassQty").value =
        passQty;

    document.querySelector("#failQty").value =
        failQty.toLocaleString();

    document.querySelector("#inQty").value =
        inQty.toLocaleString();

    document.querySelector("#disposeQty").value =
        disposeQty.toLocaleString();
}

function validateForm() {
    const qcQty = Number(document.querySelector("#qcQty").value);
    const qcType = document.querySelector("#qcType").value;
    const lotQty = Number(document.querySelector("#lotQty").value);

    const passQty = Number(document.querySelector("#qcPassQty").value || 0);
    const failQty = getDefectTotalQty();
    const sampleDisposeQty = getDisposeTotalQty();
    const awhSec = document.querySelector("#awhsec");

    let multiplier = 1;

    if (qcType === "20") {
        multiplier = 100;
    }

    const inQty = passQty * multiplier;
    const disposeQty = sampleDisposeQty * multiplier;

    if (passQty < 0) {
        alert("합격 수량은 0 이상이어야 합니다.");
        return false;
    }

    if (passQty > qcQty) {
        alert("합격 수량은 검사 수량보다 클 수 없습니다.");
        return false;
    }

    if (failQty > qcQty) {
        alert("불량 수량 합계는 검사 수량보다 클 수 없습니다.");
        return false;
    }

    if (inQty > lotQty) {
        alert("입고 수량이 LOT 수량보다 클 수 없습니다.");
        return false;
    }

    if (disposeQty > lotQty) {
        alert("폐기 수량이 LOT 수량보다 클 수 없습니다.");
        return false;
    }

    if (!awhSec.value) {
        alert("입고 구역을 선택하세요.");
        awhSec.focus();
        return false;
    }

    return true;
}

function formatQty() {
    const qcQtyText = document.querySelector("#qcQtyText");
    const qcPassQtyText = document.querySelector("#qcPassQtyText");

    if (qcQtyText && qcQtyText.value !== "") {
        qcQtyText.value = Number(qcQtyText.value).toLocaleString();
    }

    if (qcPassQtyText && qcPassQtyText.value !== "") {
        qcPassQtyText.value = Number(qcPassQtyText.value).toLocaleString();
    }
}
</script>