<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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

	<form action="${pageContext.request.contextPath}/eq/insert"
		method="post">

		<div class="btn-row">
			<div></div>

			<div>
				<a class="btn btn-white"
					href="${pageContext.request.contextPath}/eq/list"> 취소 </a>

				<button type="submit" class="btn btn-main">등록</button>
			</div>
		</div>

		<div class="content-content" style="max-width: 900px; margin: 0 auto;">

			<div class="content-content-content">

				<div class="grid-form" style="gap: 28px;">

					<div class="grid-wrap" style="align-items: center; gap: 40px;">

						<div style="width: 100px; font-weight: 700;">
							설비명 <span class="red">*</span>
						</div>

						<input type="text" name="eqName" placeholder="설비명 입력" required
							style="width: 240px; min-width: 240px;">
					</div>

					<div class="grid-wrap"
						style="justify-content: space-between; gap: 40px;">

						<div style="display: flex; align-items: center; gap: 40px;">
							<div style="width: 100px; font-weight: 700;">
								설비 책임자 <span class="red">*</span>
							</div>

							<input type="text" name="eqWorker" placeholder="검사자 조회" readonly
								style="width: 180px; min-width: 180px; background: #ddd;">

							<button type="button" class="btn btn-main">조회</button>
						</div>

						<div style="display: flex; align-items: center; gap: 40px;">
							<div style="width: 100px; font-weight: 700;">
								관리업체 <span class="red">*</span>
							</div>

							<input type="text" name="eqVendor" placeholder="거래처 조회" readonly
								style="width: 180px; min-width: 180px; background: #ddd;">

							<button type="button" class="btn btn-main">조회</button>
						</div>

					</div>

					<div class="grid-wrap"
						style="justify-content: space-between; gap: 40px;">

						<div style="display: flex; align-items: center; gap: 40px;">
							<div style="width: 100px; font-weight: 700;">작업장</div>

							<select name="eqWpid" style="width: 240px; min-width: 240px;">

								<option value="">작업장 선택</option>

								<c:forEach var="wp" items="${wpList}">
									<option value="${wp.wpId}">${wp.wpName} (${wp.wpId})</option>
								</c:forEach>

							</select>
						</div>

						<div style="display: flex; align-items: center; gap: 40px;">
							<div style="width: 100px; font-weight: 700;">작업구역</div>

							<select name="eqArea" style="width: 240px; min-width: 240px;">
								<option value="">작업구역 선택</option>
								<option value="WP1001-01">WP1001-01</option>
								<option value="WP1001-02">WP1001-02</option>
							</select>
						</div>

					</div>

				</div>

			</div>

		</div>

	</form>

</div>