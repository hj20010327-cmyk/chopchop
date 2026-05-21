<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="content">

	<div class="header-row">
		<div>
			<h2 class="page-title">설비 점검이력 등록</h2>
			<p class="page-subtitle">새로운 설비 점검이력을 등록해주세요.</p>
		</div>

		<div>
			<p class="page-route">홈 &gt; 설비관리 &gt; 점검이력 &gt; 등록</p>
		</div>
	</div>

	<form action="${pageContext.request.contextPath}/equip/mt/insert"
		method="post">

		<input type="hidden" name="elogEqid" value="${eqp.eqId}">

		<div class="btn-row">
			<div></div>

			<div>
				<a class="btn btn-white"
					href="${pageContext.request.contextPath}/equip/mt/list?eqId=${eqp.eqId}">
					취소
				</a>

				<button type="submit" class="btn btn-main">등록</button>
			</div>
		</div>

		<div class="content-content">

			<div class="content-content-content">

				<div class="content-content-content-title">
					점검 설비 : ${eqp.eqName} (${eqp.eqId})
				</div>

				<div class="grid-form">

					<div class="grid-wrap">
						<div class="search-item">
							<label>점검 시작일 <span class="red">*</span></label>
							<input type="datetime-local" name="elogSdate" required>
						</div>

						<div class="search-item">
							<label>점검 종료일</label>
							<input type="datetime-local" name="elogEdate">
						</div>
					</div>

					<div class="grid-wrap">
						<div class="search-item">
							<label>점검 사유 <span class="red">*</span></label>
							<select name="elogReason" required>
								<option value="">사유 선택</option>
								<option value="정기점검">정기점검</option>
								<option value="수리">수리</option>
								<option value="기타">기타</option>
							</select>
						</div>

						<div class="search-item">
							<label>점검 결과 <span class="red">*</span></label>
							<input type="text" name="elogResult" required
								placeholder="점검 결과 입력">
						</div>
					</div>

					<div class="grid-wrap">
						<div class="search-item">
							<label>점검자 <span class="red">*</span></label>
							<input type="text" name="elogWorker" required
								placeholder="점검자 EMP_ID">
						</div>
					</div>

					<div class="search-item">
						<label>상세 내용</label>
						<textarea name="elogContent"
							placeholder="설비 점검 상세 내용을 입력하세요."></textarea>
					</div>

				</div>

			</div>

		</div>

	</form>

</div>