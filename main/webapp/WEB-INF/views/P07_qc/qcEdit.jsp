<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">품질검사 지시 수정</h2>

            <p class="page-subtitle">
                품질검사 지시(${qc.qcId})의 내용을 수정하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 품질검사 &gt; 지시 &gt; 수정
            </p>
        </div>

    </div>

    <form action="${pageContext.request.contextPath}/quality/updateDo"
        method="post"
        style="width:100%; max-width:1100px;">

        <input type="hidden"
            name="qcId"
            value="${qc.qcId}">

        <input type="hidden"
            name="qcLot"
            value="${qc.qcLot}">

        <input type="hidden"
            name="qcQty"
            id="qcQty"
            value="${qc.qcQty}">

        <input type="hidden"
            name="lotQty"
            id="lotQty"
            value="${qc.lotQty}">

        <input type="hidden"
            name="qcType"
            id="qcType"
            value="${qc.qcType}">

        <div style="display:flex; justify-content:flex-end; gap:12px;">

            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/quality/detail?qcId=${qc.qcId}">
                취소
            </a>

            <button type="submit" class="btn btn-main">
                수정
            </button>

        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사대상
                </label>

                <input type="text"
                    value="${qc.qcLot}"
                    readonly>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    품목
                </label>

                <input type="text"
                    value="${qc.itemName} (${qc.itemId})"
                    readonly>

            </div>

        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;">

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    LOT 수량
                </label>

                <input type="text"
                    id="lotQtyText"
                    value="${qc.lotQty}"
                    readonly>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사유형
                </label>

                <input type="text"
                    id="qcTypeText"
                    value="${qc.qcTypeName}"
                    readonly>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    실제 검사 수량
                </label>

                <input type="text"
                    id="qcQtyText"
                    value="${qc.qcQty}"
                    readonly>

            </div>

        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;" class="column">

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    담당자
                </label>

                <input type="text"
                    value="${qc.directorName} (${qc.qcDirector})"
                    readonly>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사자 <span class="red">*</span>
                </label>

                <div style="display:flex; gap:10px;">

                    <input type="hidden"
                        id="qcWorker"
                        name="qcWorker"
                        value="${qc.qcWorker}">

                    <input type="text"
                        id="qcWorkerText"
                        value="${qc.workerName} (${qc.qcWorker})"
                        placeholder="검사자 조회"
                        readonly
                        required
                        style="min-width:310px;">

                    <button type="button"
                        class="btn btn-main"
                        id="workerSearchBtn">
                        조회
                    </button>

                </div>

            </div>

        </div>

        <div class="search-item textarea"
            style="display:flex; flex-direction:column;">

            <label>
                전달사항
            </label>

            <textarea name="qcDmsg"
                placeholder="작업 지시 전달사항을 입력하세요. (선택)"
                style="height:220px;">${qc.qcDmsg}</textarea>

        </div>

    </form>

</div>

<div class="overlay" id="workerModal">

    <div class="modal" style="width:650px;">

        <div class="modal-title">
            검사자 조회
        </div>

        <p class="modal-subTitle">
            검사자를 검색 후 선택하세요.
        </p>

        <div style="display:flex; gap:10px; margin-bottom:15px;">

            <input type="text"
                id="workerKeyword"
                placeholder="사원번호/이름 검색"
                style="width:350px; height:36px; padding:0 12px; border:1px solid var(--dark-gray); border-radius:6px; margin:0 auto;">

        </div>

        <div class="table-wrap"
            style="max-height:300px; overflow:auto;">

            <table class="table">

                <thead>
                    <tr>
                        <th>사원번호</th>
                        <th>이름</th>
                        <th>선택</th>
                    </tr>
                </thead>

                <tbody id="workerTbody">
                    <tr>
                        <td colspan="3" style="text-align:center;">
                            조회된 검사자 내역이 없습니다.
                        </td>
                    </tr>
                </tbody>

            </table>

        </div>

        <div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px;">

            <button type="button"
                class="btn btn-white"
                id="workerModalClose">
                닫기
            </button>

            <button type="button"
                class="btn btn-main"
                id="workerSelectBtn">
                선택
            </button>

        </div>

    </div>

</div>

<style>
input[readonly] {
    background-color: var(--light-gray);
    color: #000;
    cursor: not-allowed;
}

.modal .table tbody tr:hover {
    background-color: var(--white-hover);
}

.search-item textarea {
    width: 90%;
}


/* ==============================
   Mobile Layout
============================== */

@media screen and (max-width: 768px) {
	form div {
		gap: 12px !important;
	}
	
	.search-item, .search-item input {
		min-width: 0px !important;
		max-width: 260px !important;
	}
	
	.textarea {
		min-width: 500px !important;
		max-width: 700px !important;
	}
}


@media screen and (max-width: 480px) {
	.column {
		flex-direction: column;
	}
	
	.textarea {
		min-width: 0px !important;
	}
}



@media screen and (max-width: 480px) {
	.column {
		flex-direction: column;
	}
	
	.textarea {
		min-width: 0px !important;
	}
}


</style>

<script>

window.addEventListener("load", function() {
    formatQty();
    bind();
});

function bind() {
    const workerSearchBtn = document.querySelector("#workerSearchBtn");
    const workerModal = document.querySelector("#workerModal");
    const workerModalClose = document.querySelector("#workerModalClose");
    const workerSelectBtn = document.querySelector("#workerSelectBtn");
    const workerKeyword = document.querySelector("#workerKeyword");
    const form = document.querySelector("form");

    workerSearchBtn.addEventListener("click", function() {
        workerModal.style.display = "flex";
        workerKeyword.value = "";
        loadWorkerList(workerKeyword.value);
    });

    workerModalClose.addEventListener("click", function() {
        workerModal.style.display = "none";
    });

    workerKeyword.addEventListener("input", function() {
        loadWorkerList(workerKeyword.value);
    });

    workerKeyword.addEventListener("keydown", function(e) {
        if (e.key === "Enter") {
            e.preventDefault();
            loadWorkerList(workerKeyword.value);
        }
    });

    workerSelectBtn.addEventListener("click", function() {
        selectWorker();
    });

    form.addEventListener("submit", function(e) {
    	
    	document.querySelector("form").addEventListener("submit", function(e) {

    	    const targets = this.querySelectorAll("input[type=text], textarea");

    	    for (let i = 0; i < targets.length; i++) {

    	        if (targets[i].value.trim() === "") {

    	            alert("공백만 입력할 수 없습니다.");

    	            targets[i].focus();

    	            e.preventDefault();
    	            return false;
    	        }
    	    }
    	});
    	
    	document.querySelectorAll("input, textarea").forEach(el => {
    	    el.addEventListener("blur", function() {
    	        this.value = this.value.trim();
    	    });
    	});
    	
        if (!validateForm()) {
            e.preventDefault();
            return;
        }
    });
}

function loadWorkerList(keyword) {
    const workerTbody = document.querySelector("#workerTbody");

    fetch("${pageContext.request.contextPath}/quality/workerList?searchKeyword="
        + encodeURIComponent(keyword))
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html = "";

            for (let i = 0; i < result.length; i++) {
                html += "<tr class='workers'>";

                html += "<td>";
                html += result[i].empId;
                html += "</td>";

                html += "<td>";
                html += result[i].empName;
                html += "</td>";

                html += "<td>";
                html += "<input type='radio' ";
                html += "name='workerRadio' ";
                html += "value='" + result[i].empId + "' ";
                html += "data-name='" + result[i].empName + "'>";
                html += "</td>";

                html += "</tr>";
            }

            if (result.length === 0) {
                html =
                    "<tr>" +
                        "<td colspan='3' style='text-align:center;'>" +
                            "검색 결과가 없습니다." +
                        "</td>" +
                    "</tr>";
            }

            workerTbody.innerHTML = html;

            const workers = document.querySelectorAll(".workers");

            for (let i = 0; i < workers.length; i++) {
                workers[i].addEventListener("click", function() {
                    const radio = workers[i].querySelector("input[type='radio']");
                    radio.checked = true;
                });
            }
        })
        .catch(function() {
            alert("검사자 목록 조회 실패");
        });
}

function selectWorker() {
    const checked = document.querySelector("input[name='workerRadio']:checked");

    if (!checked) {
        alert("검사자를 선택하세요.");
        return;
    }

    const workerId = checked.value;
    const workerName = checked.getAttribute("data-name");

    document.querySelector("#qcWorker").value = workerId;

    document.querySelector("#qcWorkerText").value =
        workerName + " (" + workerId + ")";

    document.querySelector("#workerModal").style.display = "none";
}

function validateForm() {
    const qcWorker = document.querySelector("#qcWorker");

    if (!qcWorker.value) {
        alert("검사자를 선택하세요.");
        document.querySelector("#workerSearchBtn").focus();
        return false;
    }

    return true;
}

function formatQty() {
    const qcQtyText = document.querySelector("#qcQtyText");
    const lotQtyText = document.querySelector("#lotQtyText");

    if (qcQtyText && qcQtyText.value !== "") {
        qcQtyText.value = Number(qcQtyText.value).toLocaleString();
    }

    if (lotQtyText && lotQtyText.value !== "") {
        lotQtyText.value = Number(lotQtyText.value).toLocaleString();
    }
}

</script>