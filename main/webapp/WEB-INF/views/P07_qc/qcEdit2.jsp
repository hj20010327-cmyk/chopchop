<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn"
uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="content">

    <div class="header-row">

        <div>
            <h2 class="page-title">
                품질검사 지시 수정
            </h2>

            <p class="page-subtitle">
                ${qc.qcId}
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 > 품질검사 > 지시 > 수정
            </p>
        </div>

    </div>

    <form action="${pageContext.request.contextPath}/quality/updateDo"
        method="post">

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
            name="qcContent"
            value="${qc.qcContent}">

        <input type="hidden"
            name="qcDirector"
            value="${qc.qcDirector}">

        <div style="display:flex;
            justify-content:flex-end;
            gap:12px;">

            <a class="btn btn-white"
                href="${pageContext.request.contextPath}/quality/detail?qcId=${qc.qcId}">
                취소
            </a>

            <button type="submit"
                class="btn btn-main">
                수정
            </button>

        </div>

        <div style="
            margin-top:45px;
            margin-bottom:35px;
            font-size:20px;
            font-weight:700;">

            담당자 :
            ${qc.directorName}
            (${qc.qcDirector})

        </div>

        <!-- 1줄 -->
        <div style="
            display:flex;
            gap:40px;
            margin-bottom:26px;">

            <!-- LOT -->
            <div class="search-item"
                style="display:flex;
                flex-direction:column;
                flex:1;">

                <label>
                    검사대상
                </label>

                <input type="text"
                    value="${qc.qcLot}"
                    readonly>

            </div>
            
            <!-- 검사자 -->
            <div class="search-item"
                style="display:flex;
                flex-direction:column;
                flex:1;">

                <label>
                    검사자
                    <span class="red">*</span>
                </label>

                <div style="display:flex; gap:10px;">

                    <input type="hidden"
                        id="qcWorker"
                        name="qcWorker"
                        value="${qc.qcWorker}">

                    <input type="text"
                        id="qcWorkerText"
                        value="${qc.workerName} (${qc.qcWorker})"
                        readonly
                        style="flex:1;">

                    <button type="button"
                        class="btn btn-main"
                        id="workerSearchBtn">
                        조회
                    </button>

                </div>

            </div>

            

        </div>

        <!-- 2줄 -->
        <div style="
            display:flex;
            gap:40px;
            margin-bottom:26px;">

			<!-- 유형 -->
            <div class="search-item"
                style="display:flex;
                flex-direction:column;
                flex:1;">

                <label>
                    검사유형
                    <span class="red">*</span>
                </label>

                <select name="qcType">

                    <option value="10"
                        ${qc.qcType == 10 ? 'selected' : ''}>
                        수입검사
                    </option>

                    <option value="20"
                        ${qc.qcType == 20 ? 'selected' : ''}>
                        공정검사
                    </option>

                    <option value="30"
                        ${qc.qcType == 30 ? 'selected' : ''}>
                        출하검사
                    </option>

                    <option value="0"
                        ${qc.qcType == 0 ? 'selected' : ''}>
                        기타
                    </option>

                </select>

            </div>

            <!-- 수량 -->
            <div class="search-item"
                style="display:flex;
                flex-direction:column;
                flex:1;">

                <label>
                    검사 수량
                </label>

                <input type="text"
                    id="qcQtyText"
                    value="${qc.qcQty}"
                    readonly>

            </div>

            <!-- 품목 -->
            <div class="search-item"
                style="display:flex;
                flex-direction:column;
                flex:1;">

                <label>
                    품목
                </label>

                <input type="text"
                    value="${qc.itemName} (${qc.itemId})"
                    readonly>

            </div>

        </div>

        <!-- 3줄 -->
        <div style="
            display:flex;
            gap:40px;
            margin-bottom:26px;">

            


        </div>

        <!-- 전달사항 -->
        <div class="search-item"
            style="display:flex;
            flex-direction:column;">

            <label>
                전달사항
            </label>

            <textarea name="qcDmsg"
                style="height:220px;">${qc.qcDmsg}</textarea>

        </div>

    </form>

</div>

<!-- 검사자 모달 -->
<div class="overlay" id="workerModal">

    <div class="modal" style="width:650px;">

        <div class="modal-title">
            검사자 조회
        </div>

        <p class="modal-subTitle">
            검사자를 검색 후 선택하세요.
        </p>

        <div style="
            display:flex;
            gap:10px;
            margin-bottom:15px;">

            <input type="text"
                id="workerKeyword"
                placeholder="사원번호/이름 검색"
                style="
                    width:350px;
                    height:36px;
                    padding:0 12px;
                    border:1px solid var(--dark-gray);
                    border-radius:6px;
                    margin:0 auto;">

        </div>

        <div class="table-wrap"
            style="max-height:300px;
            overflow:auto;">

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
                        <td colspan="3"
                            style="text-align:center;">
                            조회된 검사자 내역이 없습니다.
                        </td>
                    </tr>

                </tbody>

            </table>

        </div>

        <div style="
            display:flex;
            justify-content:flex-end;
            gap:10px;
            margin-top:20px;">

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

input[readonly]{
    background-color: var(--light-gray);
    color:#000;
    cursor:not-allowed;
}

.modal .table tbody tr:hover{
    background-color: var(--white-hover);
}

</style>

<script>

window.addEventListener("load", function(){

    formatQty();

    bind();

});

function bind(){

    const workerSearchBtn =
        document.querySelector("#workerSearchBtn");

    const workerModal =
        document.querySelector("#workerModal");

    const workerModalClose =
        document.querySelector("#workerModalClose");

    const workerSelectBtn =
        document.querySelector("#workerSelectBtn");

    const workerKeyword =
        document.querySelector("#workerKeyword");

    const form =
        document.querySelector("form");

    workerSearchBtn.addEventListener("click", function(){

        workerModal.style.display = "flex";

        workerKeyword.value = "";

        loadWorkerList(workerKeyword.value);

    });

    workerModalClose.addEventListener("click", function(){

        workerModal.style.display = "none";

    });

    workerKeyword.addEventListener("input", function(){

        loadWorkerList(workerKeyword.value);

    });

    workerSelectBtn.addEventListener("click", function(){

        selectWorker();

    });

    form.addEventListener("submit", function(e){

        if(!validateForm()){

            e.preventDefault();

            return;

        }

    });

}

function loadWorkerList(keyword){

    const workerTbody =
        document.querySelector("#workerTbody");

    fetch("${pageContext.request.contextPath}/work/workerList?searchKeyword="
        + encodeURIComponent(keyword))

    .then(response => response.json())

    .then(result => {

        let html = "";

        for(let i=0; i<result.length; i++){

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

        workerTbody.innerHTML = html;

        const workers =
            document.querySelectorAll(".workers");

        for(let i=0; i<workers.length; i++){

            workers[i].addEventListener("click", function(){

                const radio =
                    workers[i].querySelector("input[type='radio']");

                radio.checked = true;

            });

        }

    });

}

function selectWorker(){

    const checked =
        document.querySelector("input[name='workerRadio']:checked");

    if(!checked){

        alert("검사자를 선택하세요.");

        return;

    }

    const workerId = checked.value;

    const workerName =
        checked.getAttribute("data-name");

    document.querySelector("#qcWorker").value =
        workerId;

    document.querySelector("#qcWorkerText").value =
        workerName + " (" + workerId + ")";

    document.querySelector("#workerModal").style.display =
        "none";

}

function validateForm(){

    const qcWorker =
        document.querySelector("#qcWorker");

    const qcDate =
        document.querySelector("input[name='qcDate']");

    if(!qcWorker.value){

        alert("검사자를 선택하세요.");

        return false;

    }

    if(!qcDate.value){

        alert("검사일을 입력하세요.");

        qcDate.focus();

        return false;

    }

    return true;

}

function formatQty(){

    const qcQtyText =
        document.querySelector("#qcQtyText");

    qcQtyText.value =
        Number(qcQtyText.value).toLocaleString();

}

</script>