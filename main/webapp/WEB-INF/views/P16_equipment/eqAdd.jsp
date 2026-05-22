<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">설비 등록</h2>
			<p class="page-subtitle">새로운 설비를 등록해주세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 설비관리 &gt; 등록</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/equip/insert"
		method="post">

		<div class="btn-row">
			<div></div>

			<div>
				<a class="btn btn-white"
					href="${pageContext.request.contextPath}/equip/list"
					onclick="return confirm('확인을 누르시면 입력한 내용이 모두 사라집니다.\n정말로 취소하시겠습니까?');"> 취소 </a>

				<button type="submit" class="btn btn-main">등록</button>
			</div>
		</div>

		<div class="content-content">

			<div class="content-content-content">

				<div class="content-content-content-title">설비 기본정보</div>

				<div class="grid-form">

					<div class="grid-wrap">

						<div class="search-item">
							<label>설비명 <span class="red">*</span></label> <input type="text"
								name="eqName" placeholder="설비명 입력" required>
						</div>

					</div>

					<div class="grid-wrap">

						<div class="search-item">
							<label>설비 책임자 <span class="red">*</span></label>

							<div class="search-btn-area">

								<input type="text" name="eqManager" id="eqManager"
									placeholder="책임자 조회" readonly>

								<button type="button" class="btn btn-main" id="openManagerModal">
									조회</button>

							</div>
						</div>

						<div class="search-item">
							<label>관리업체 <span class="red">*</span></label>

							<div class="search-btn-area">

								<input type="text" name="eqVendor" id="eqVendor"
									placeholder="거래처 조회" readonly>

								<button type="button" class="btn btn-main" id="openVendorModal">

									조회</button>

							</div>
						</div>

					</div>

					<div class="grid-wrap">

						<div class="search-item">
							<label>작업구역</label> 
							<select id="wpType">
								<option value="" disabled selected>작업구역 선택</option>
								<option value="10">전처리</option>
								<option value="20">배합</option>
								<option value="30">반죽</option>
								<option value="40">제피</option>
								<option value="50">성형</option>
								<option value="60">증숙</option>
								<option value="70">냉각</option>
								<option value="80">급속냉동</option>
								<option value="90">포장</option>
								<option value="100">검사</option>
							</select>
						</div>
						
						<div class="search-item">
							<label>작업장</label> 
							<select name="eqWpid" id="eqWpid"
									style="width: 240px;">
								<option value="" disabled selected>작업장 선택</option>
							</select>
						</div>

					</div>

				</div>

			</div>

		</div>

	</form>

</div>


<!-- 설비 책임자 조회 모달 -->
<div id="managerOverlay" class="overlay">

	<div class="modal" style="width: 620px;">

		<h2 class="modal-title">설비 책임자 조회</h2>

		<p class="modal-subTitle">설비 책임자를 조회 후 선택해주세요.</p>

		<div class="search-item"
			style="display: flex; justify-content: center; gap: 10px; margin-bottom: 20px; flex-direction: row;">

			<input type="text" id="managerKeyword" placeholder="이름/사원번호 검색"
				style="width: 60%;" oninput="loadManagerList()">
		</div>

		<table class="table">

			<thead>
				<tr>
					<th>사원번호</th>
					<th>사원명</th>
					<th>선택</th>
				</tr>
			</thead>

			<tbody id="managerResultBody">
			</tbody>

		</table>

		<div
			style="display: flex; justify-content: center; gap: 10px; margin-top: 25px;">

			<button type="button" class="btn btn-white" id="closeManagerModal">
				취소</button>

			<button type="button" class="btn btn-main" id="managerSelectBtn">

				선택</button>

		</div>

	</div>

</div>

<!-- 관리업체 조회 모달 -->
<div id="vendorOverlay" class="overlay">

	<div class="modal" style="width:620px;">

		<h2 class="modal-title">
			관리업체 조회
		</h2>

		<p class="modal-subTitle">
			관리업체를 조회 후 선택해주세요.
		</p>

		<div class="search-item"
			style="display:flex;
			justify-content:center;
			gap:10px;
			margin-bottom:20px;
			flex-direction:row;">

			<input type="text"
				id="vendorKeyword"
				placeholder="업체명/업체코드 검색"
				style="width:60%;"
				oninput="loadVendorList()">

		</div>

		<table class="table">

			<thead>
				<tr>
					<th>업체코드</th>
					<th>업체명</th>
					<th>선택</th>
				</tr>
			</thead>

			<tbody id="vendorResultBody">

			</tbody>

		</table>

		<div style="
			display:flex;
			justify-content:center;
			gap:10px;
			margin-top:25px;">

			<button type="button"
				class="btn btn-white"
				id="closeVendorModal">

				취소

			</button>

			<button type="button"
				class="btn btn-main"
				id="vendorSelectBtn">

				선택

			</button>

		</div>

	</div>

</div>




<script>
	document
			.querySelector("#openManagerModal")
			.addEventListener(
					"click",
					function() {

						document.querySelector("#managerOverlay").style.display = "flex";

						loadManagerList();
					});

	document
			.querySelector("#closeManagerModal")
			.addEventListener(
					"click",
					function() {

						document.querySelector("#managerOverlay").style.display = "none";
					});

	document.querySelector("#managerKeyword").addEventListener("keyup",
			function(e) {

				if (e.key === "Enter") {
					loadManagerList();
				}
			});

	function loadManagerList() {

		const keyword = document.querySelector("#managerKeyword").value;

		fetch(
				"${pageContext.request.contextPath}/equip/managerList?keyword="
						+ encodeURIComponent(keyword))

				.then(function(response) {
					return response.json();
				})

				.then(
						function(list) {

							console.log(list);
							const tbody = document
									.querySelector("#managerResultBody");

							tbody.innerHTML = "";

							if (list.length === 0) {

								tbody.innerHTML = "<tr><td colspan='3'>검색 결과가 없습니다.</td></tr>";

								return;
							}

							for (let i = 0; i < list.length; i++) {

								const manager = list[i];

								tbody.innerHTML += "<tr>"
										+ "<td>"
										+ manager.eqManager
										+ "</td>"
										+ "<td>"
										+ manager.eqManagerName
										+ "</td>"
										+ "<td>"
										+ "<input type='radio' " +
						"name='selectedManager' " +
						"value='" + manager.eqManager + "' " +
						"data-name='" + manager.eqManagerName + "'>"
										+ "</td>" + "</tr>";
							}
						});
	}

	function selectManager(managerId, managerName) {

		document.querySelector("#eqManager").value = managerId;

		document.querySelector("#managerOverlay").style.display = "none";
	}

	document
			.querySelector("#managerSelectBtn")
			.addEventListener(
					"click",
					function() {

						const selected = document
								.querySelector("input[name='selectedManager']:checked");

						if (!selected) {
							alert("책임자를 선택해주세요.");
							return;
						}

						const managerId = selected.value;
						const managerName = selected.dataset.name;

						selectManager(managerId, managerName);
					});

	document.querySelector("#openVendorModal")
	.addEventListener("click", function () {

		document.querySelector("#vendorOverlay")
			.style.display = "flex";

		loadVendorList();
	});


	document.querySelector("#closeVendorModal")
	.addEventListener("click", function () {

		document.querySelector("#vendorOverlay")
			.style.display = "none";
	});


	function loadVendorList() {

		const keyword =
			document.querySelector("#vendorKeyword").value;

		fetch(
			"${pageContext.request.contextPath}/equip/vendorList?keyword="
			+ encodeURIComponent(keyword)
		)

		.then(function(response) {
			return response.json();
		})

		.then(function(list) {

			const tbody =
				document.querySelector("#vendorResultBody");

			tbody.innerHTML = "";

			if (list.length === 0) {

				tbody.innerHTML =
					"<tr><td colspan='3'>검색 결과가 없습니다.</td></tr>";

				return;
			}

			for(let i = 0; i < list.length; i++) {

				const vendor = list[i];

				tbody.innerHTML +=
					"<tr>" +
						"<td>" +
							vendor.eqVendor +
						"</td>" +

						"<td>" +
							vendor.eqVendorName +
						"</td>" +

						"<td>" +
							"<input type='radio' " +
							"name='selectedVendor' " +
							"value='" + vendor.eqVendor + "' " +
							"data-name='" + vendor.eqVendorName + "'>" +
						"</td>" +
					"</tr>";
			}
		});
	}


	document.querySelector("#vendorSelectBtn")
	.addEventListener("click", function () {

		const selected =
			document.querySelector(
				"input[name='selectedVendor']:checked"
			);

		if (!selected) {
			alert("관리업체를 선택해주세요.");
			return;
		}

		const vendorId = selected.value;

		document.querySelector("#eqVendor")
			.value = vendorId;

		document.querySelector("#vendorOverlay")
			.style.display = "none";
	});
	
	document.querySelector("#wpType")
	.addEventListener("change", function () {

		const wpType = this.value;

		const select =
			document.querySelector("#eqWpid");

		select.innerHTML =
			"<option value=''>작업장 선택</option>";

		if (!wpType) {
			return;
		}

		fetch(
			"${pageContext.request.contextPath}/equip/wpList?wpType="
			+ wpType
		)

		.then(response => response.json())

		.then(function(list) {

			for(let i = 0; i < list.length; i++) {

				const wp = list[i];

				select.innerHTML +=
					"<option value='" + wp.wpId + "'>" +
						wp.wpName +
						" (" + wp.wpId + ")" +
					"</option>";
			}
		});
	});
</script>