<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">품질검사 지시 등록</h2>

            <p class="page-subtitle">
                새로운 품질검사 지시를 작성하세요.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 품질검사 &gt; 지시 &gt; 등록
            </p>
        </div>

    </div>

    <form action="${pageContext.request.contextPath}/quality/insertDo"
        method="post"
        style="width:100%; max-width:1100px;">

        <div style="display:flex; justify-content:flex-end; gap:12px;">

            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/quality/list">
                취소
            </a>

            <button type="submit" class="btn btn-main">
                등록
            </button>

        </div>

        <div style="margin-top:45px;
            margin-bottom:35px;
            font-size:20px;
            font-weight:700;">

            담당자 :
            ${sessionScope.loginUser.empName}
            (${sessionScope.loginUser.empId})

        </div>

        <input type="hidden"
            name="qcDirector"
            value="${sessionScope.loginUser.empId}">

        <div style="display:flex; gap:40px; margin-bottom:26px;">

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사대상 <span class="red">*</span>
                </label>

                <select name="qcLot" id="qcLot">
                    <option value="" disabled selected>
                        검사할 LOT 선택
                    </option>
                </select>

            </div>
            
            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사자 <span class="red">*</span>
                </label>

                <div style="display:flex; gap:10px;">

                    <input type="hidden" id="qcWorker" name="qcWorker">
					<input type="text" id="qcWorkerText" placeholder="작업자 조회" readonly required
						style="min-width: 310px;"
					>

                    <button type="button"
                        class="btn btn-main"
                        id="workerSearchBtn">
                        조회
                    </button>

                </div>

            </div>

            

        </div>

        <div style="display:flex; gap:40px; margin-bottom:26px;">
        
        <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사유형 <span class="red">*</span>
                </label>

                <select name="qcType">

                    <option value="" disabled selected>
                        검사 유형 선택
                    </option>

                    <option value="10">
                        수입검사
                    </option>

                    <option value="20">
                        공정검사
                    </option>

                    <option value="30">
                        출하검사
                    </option>

                    <option value="0">
                        기타
                    </option>

                </select>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    검사 수량
                </label>

                <input type="text"
                    name="qcQty"
                    id="qcQty"
                    placeholder="검사 수량"
                    readonly>

            </div>

            <div class="search-item"
                style="display:flex; flex-direction:column; flex:1;">

                <label>
                    품목
                </label>

                <input type="text"
                    id="qcContent"
                    placeholder="품목명 (품목코드)"
                    readonly>

            </div>

        </div>


        <div class="search-item"
            style="display:flex;
            flex-direction:column;">

            <label>
                전달사항
            </label>

            <textarea name="qcDmsg"
                placeholder="작업 지시 전달사항을 입력하세요. (선택)"
                style="height:220px;"></textarea>

        </div>

        <input type="hidden" name="qcStatus" value="10">
        <input type="hidden" name="qcPassQty" value="0">
        <input type="hidden" name="qcUsage" value="Y">

    </form>

</div>

<div class="overlay" id="workerModal">
	<div class="modal" style="width:650px;">

		<div class="modal-title">작업자 조회</div>
		<p class="modal-subTitle">작업자를 검색 후 선택하세요.</p>

		<div style="display:flex; gap:10px; margin-bottom:15px;">
			<input type="text"
				id="workerKeyword"
				placeholder="사원번호/이름 검색"
				style="width: 350px; height:36px; padding:0 12px; border:1px solid var(--dark-gray); border-radius:6px; margin: 0 auto;">
		</div>

		<div class="table-wrap" style="max-height:300px; overflow:auto;">
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
							조회된 작업자 내역이 없습니다.
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div style="display:flex; justify-content:flex-end; gap:10px; margin-top:20px;">
			<button type="button" class="btn btn-white" id="workerModalClose">
				닫기
			</button>
			<button type="button" class="btn btn-main" id="workerSelectBtn">
				선택
			</button>
		</div>

	</div>
</div>

<style>
	.modal .table tbody tr:hover {
		background-color: var(--white-hover);
	}
</style>

<script>

window.addEventListener("load", function() {
    bind();
    loadLotList();
    bindLotChange();
    setToday();
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
    	
    	const qty = document.querySelector("#qcQty");

        qty.value = qty.value.replaceAll(",", "");
    	
        if (!validateForm()) {
            e.preventDefault();
            return;
        }
    });
}

function loadWorkerList(keyword) {
    const workerTbody = document.querySelector("#workerTbody");

    fetch("${pageContext.request.contextPath}/work/workerList?searchKeyword="
        + encodeURIComponent(keyword))
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html = "";

            for (let i = 0; i < result.length; i++) {
                html += "<tr class='workers'>";
                html += "<td>" + result[i].empId + "</td>";
                html += "<td>" + result[i].empName + "</td>";
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
            alert("작업자 목록 조회 실패");
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

function loadLotList() {
    fetch("${pageContext.request.contextPath}/quality/lotList")
        .then(function(response) {
            return response.json();
        })
        .then(function(result) {
            let html =
                '<option value="" disabled selected>검사할 LOT 선택</option>';

            for (let i = 0; i < result.length; i++) {
                html += '<option ';
                html += 'value="' + result[i].lotId + '" ';
                html += 'data-qty="' + result[i].lotQty + '" ';
                html += 'data-item="' + result[i].itemName + ' (' + result[i].itemId + ')' + '">';
                html += result[i].lotId + ' / ' + result[i].itemName;
                html += '</option>';
            }

            document.querySelector("#qcLot").innerHTML = html;
        })
        .catch(function() {
            alert("LOT 목록 조회 실패");
        });
}

function bindLotChange() {
	const lotSelect = document.querySelector("#qcLot");

    lotSelect.addEventListener("change", function() {

        const option = this.options[this.selectedIndex];

        document.querySelector("#qcQty").value =
            Number(option.dataset.qty).toLocaleString();

        document.querySelector("#qcContent").value =
            option.dataset.item;

    });
}

function validateForm() {
    const qcLot = document.querySelector("#qcLot");
    const qcType = document.querySelector("select[name='qcType']");
    const qcQty = document.querySelector("#qcQty");
    const qcWorker = document.querySelector("#qcWorker");
    const qcDate = document.querySelector("input[name='qcDate']");

    if (qcLot.value === "") {
        alert("검사대상을 선택하세요.");
        qcLot.focus();
        return false;
    }

    if (qcType.value === "") {
        alert("검사유형을 선택하세요.");
        qcType.focus();
        return false;
    }

    if (qcQty.value === "") {
        alert("검사 수량이 없습니다.");
        qcLot.focus();
        return false;
    }

    if (qcWorker.value === "") {
        alert("검사자를 선택하세요.");
        document.querySelector("#workerSearchBtn").focus();
        return false;
    }

    if (qcDate.value === "") {
        alert("검사일을 입력하세요.");
        qcDate.focus();
        return false;
    }

    return true;
}

function setToday() {
    const qcDate = document.querySelector("input[name='qcDate']");
    const today = new Date();

    const yyyy = today.getFullYear();
    const mm = String(today.getMonth() + 1).padStart(2, "0");
    const dd = String(today.getDate()).padStart(2, "0");

    qcDate.value = yyyy + "-" + mm + "-" + dd;
}

</script>