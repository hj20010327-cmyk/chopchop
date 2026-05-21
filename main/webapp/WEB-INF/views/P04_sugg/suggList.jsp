<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">건의사항</h2>
		</div>

		<div>
			<p class="page-route">홈 > 건의사항</p>

			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/sugg/add">
				건의사항 등록
			</a>
		</div>
	</div>

	<form class="search-box"
		action="${pageContext.request.contextPath}/sugg/list"
		method="get"
		id="searchForm">

		<div class="search-item date-item">

			<label>기간</label>

			<div class="date-row">

				<input type="date"
					id="startDate"
					name="startDate"
					value="${suggDTO.startDate}">

				<span>~</span>

				<input type="date"
					id="endDate"
					name="endDate"
					value="${suggDTO.endDate}">

			</div>

		</div>

		<div class="search-item status-item">

			<label>상태</label>

			<select name="sugg_answer">

				<option value="">전체</option>

				<option value="N"
					${suggDTO.sugg_answer == 'N' ? 'selected' : ''}>
					답변대기
				</option>

				<option value="Y"
					${suggDTO.sugg_answer == 'Y' ? 'selected' : ''}>
					답변완료
				</option>

			</select>

		</div>

		<div class="search-item keyword">

			<label>제목/작성자 검색</label>

			<input type="text"
				class="short"
				name="keyword"
				value="${suggDTO.keyword}"
				placeholder="내용을 입력하세요.">

		</div>

		<div class="search-btn-area">

			<button type="submit"
				class="btn btn-main">
				검색
			</button>

			<a class="btn btn-white reset-btn"
				href="${pageContext.request.contextPath}/sugg/list">
				초기화
			</a>

		</div>

	</form>

	<div>

		<div class="table-wrap">

			<table class="table">

				<thead>

					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>등록일</th>
						<th>작성자</th>
						<th>댓글</th>
						<th>조회수</th>
						<th>상태</th>
					</tr>

				</thead>

				<tbody>

					<c:forEach var="dto" items="${list}">

						<tr>

							<td class="suggNo">
								${dto.sugg_no}
							</td>

							<td class="suggTitle"
								onclick="openPwdModal(${dto.sugg_no})">

								${dto.sugg_title}

							</td>

							<td>${dto.sugg_cdate}</td>
							<td>${dto.sugg_writer}</td>
							<td>${dto.comment_count}</td>
							<td>${dto.sugg_view}</td>

							<td>

								<c:choose>

									<c:when test="${dto.sugg_answer eq 'N'}">

										<span style="color:var(--dark-gray);">
											• 답변대기
										</span>

									</c:when>

									<c:otherwise>

										<span style="color:var(--success);">
											• 답변완료
										</span>

									</c:otherwise>

								</c:choose>

							</td>

						</tr>

					</c:forEach>

					<c:if test="${empty list}">

						<tr>

							<td colspan="7"
								style="text-align:center;">

								조회된 건의사항이 없습니다.

							</td>

						</tr>

					</c:if>

				</tbody>

			</table>

		</div>

		<jsp:include page="/WEB-INF/views/common/paging.jsp" />

	</div>

</div>

<!-- 비밀번호 모달 -->
<div id="pwdModal" class="overlay"
>
<!--
	style="
	display:none;
	position:fixed;
	inset:0;
	background:rgba(0,0,0,0.45);
	z-index:9999;
	justify-content:center;
	align-items:center;"
-->

	<div class="modal search-item">

		<!-- 헤더 -->
		<h2 class="modal-title">
			건의사항 비밀번호
		</h2>
		<p class="modal-subTitle">
			게시글 확인을 위해 비밀번호를 입력해주세요
		</p>

		<form action="${pageContext.request.contextPath}/sugg/detail"
			method="post">

			<input type="hidden" id="modal_sugg_no" name="sugg_no">
				<input type="password"
					style="width: 335px;"
					name="sugg_pw"
					maxlength="4"
					placeholder="숫자 4자리 비밀번호 입력"
					required>

				<!-- 버튼 -->
				<div style="
					margin-top: 15px;
					display:flex;
					justify-content:center;
					align-items:center;
					gap:12px;
					background:#fff;
				">
	
					<button type="submit" class="btn btn-main">
						확인
					</button>
	
					<button type="button" class="btn btn-white"
						onclick="closePwdModal()">
						취소
					</button>

			</div>
			</div>

		</form>

	</div>

</div>

<script>

window.addEventListener("load", () => {
	const errorMsg =
		"${sessionScope.pwdError}";

	if(errorMsg &&
		errorMsg !== "null" &&
		errorMsg !== "") {

		alert(errorMsg);
		<% session.removeAttribute("pwdError"); %>
	}
});

function init() {
	bind();
}

function bind() {
	dateCheck();
}

function openPwdModal(suggNo) {

	document.querySelector("#modal_sugg_no").value
		= suggNo;
	
	document.querySelector("input[name='sugg_pw']").value
		= "";

	document.querySelector("#pwdModal").style.display
		= "flex";
}

function closePwdModal() {

	document.querySelector("input[name='sugg_pw']").value
	= "";
	
	document.querySelector("#pwdModal").style.display
		= "none";
}


function dateCheck() {

	const startDate =
		document.querySelector("#startDate");

	const endDate =
		document.querySelector("#endDate");

	if (startDate.value) {
		endDate.min = startDate.value;
	}

	startDate.addEventListener("change", function () {

		endDate.min = startDate.value;

		if (endDate.value &&
			endDate.value < startDate.value) {

			endDate.value = "";
		}
	});
}

</script>

<style>
.search-box {
	display: flex;
	align-items: flex-end;
	gap: 10px;
	flex-wrap: nowrap;
}

.date-item {
	width: auto;
}

.date-row {
	display: flex;
	align-items: center;
	gap: 8px;
}

/* .date-row input { */
/* 	width: 230px; */
/* 	min-width: 230px; */
/* } */

/* .status-item select { */
/* 	width: 110px; */
/* 	min-width: 110px; */
/* } */

/* .keyword input { */
/* 	width: 240px; */
/* 	min-width: 240px; */
/* } */

.search-btn-area {
	display: flex;
	align-items: center;
	gap: 8px;
	flex-wrap: nowrap;
	min-width: 145px;
}

.reset-btn {
	width: 66px;
	white-space: nowrap;
	text-align:center;
}

.suggTitle {
	cursor: pointer;
	transition: 0.2s;
}

.suggTitle:hover {
	color: #2d7a46;
	text-decoration: underline;
}

@media (min-width:1200px) {
	.search-box {
		flex-wrap: nowrap;
	}
}

@media (max-width:768px) {
	.date-row {
		flex-wrap: wrap;
	}

	.date-row input,
	.status-item select,
	.keyword input {
		width: 100%;
	}

	.search-item,
	.search-btn-area {
		width: 100%;
	}
}
</style>