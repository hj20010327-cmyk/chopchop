<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="content">
	
	<div class="header-row">
		<div>
			<h2 class="page-title">작업장 점검이력 상세</h2>
			<p class="page-subtitle">점검이력(${glog.glogId})의 상세 정보를 확인하세요.</p>
		</div>
		
		<div>
			<p class="page-route">홈 > 작업장 관리 > 위생점검 결과 > 상세</p>
		</div>
	</div>
	<div class="btn-row">
		<div class="left">
			<a class="btn btn-white"
				href="${pageContext.request.contextPath}/workplace/detail?wpId=${glog.glogWpId}">
				작업장 상세
			</a>
		</div>
		<div class="right">
			<a class="btn btn-main"
				href="${pageContext.request.contextPath}/workplace/glog/edit?glogId=${glog.glogId}">
				수정
			</a>
			<a class="btn btn-red"
				href="${pageContext.request.contextPath}/workplace/glog/delete?wpId=${glog.glogWpId}&glogId=${glog.glogId}">
				삭제
			</a>
		</div>
	</div>
	
	<div class="content-content">
		<div class="content-content-content">
			<div style="display: flex; justify-content: space-between; align-items: flex-end;">
				<div class="content-content-content-title">
					위생점검 결과 상세정보
				</div>
				<c:if test="${glog.glogResult == 'pass'}">
					<div class="status-back status-back-success">
						• 적합
					</div>
				</c:if>
				<c:if test="${glog.glogResult == 'fail'}">
					<div class="status-back status-back-danger">
						• 부적합
					</div>
				</c:if>
			</div>
			<div class="info-table-wrap">
				<table class="info-table">
					<tbody>
						<tr>
							<th>점검대상</th>
							<td>${glog.glogWpName} (${glog.glogWpId})</td>
							<th>GHP 기준</th>
							<td>${glog.ghpName} (${glog.ghpId})</td>
						</tr>
						<tr>
							<th>점검일시</th>
							<td>${glog.glogDate}</td>
							<th>측정값</th>
							<td>${glog.glogValue}</td>
						</tr>
						<tr>
							<th>등록일시</th>
							<td>${glog.glogCdate}</td>
							<th>점검자</th>
							<td>${glog.glogWName} (${glog.glogWorker})</td>
						</tr>
						<tr>
							<th>비고</th>
							<td colspan="3">${glog.glogMemo}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				점검 결과 이미지
			</div>
			<c:if test="${empty glog.glogImg or glog.glogImg == null}">
				<div style="padding: 10px 40px;">이미지 없음</div>
			</c:if>
			<c:if test="${not empty glog.glogImg and glog.glogImg != null }">
				<div class="info-image" style="padding: 10px 40px;">
					<img src="${glog.glogImg}"
						title="${glog.glogId}_img" alt="${glog.glogId}_img"
						 style="min-width: 400px; max-width: 800px; min-height: 300px; margin: 0 auto;">
				</div>
			</c:if>
		</div>
		
		<div class="content-content-content">
			<div class="content-content-content-title">
				조치사항
			</div>
			<div class="info-table-wrap">
				<table class="info-table col2">
					<colgroup>
						<col style="width: 140px;">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th>조치일시</th>
							<c:if test="${not empty glog.glogAdate and glog.glogAdate != null}">
								<td>${glog.glogAdate}</td>
							</c:if>
							<c:if test="${!(not empty glog.glogAdate and glog.glogAdate != null)}">
								<td>조치사항 없음</td>
							</c:if>
						</tr>
						<tr>
							<th>조치 내용</th>
							<c:if test="${not empty glog.glogAction and glog.glogAction != null}">
								<td>${glog.glogAction}</td>
							</c:if>
							<c:if test="${!(not empty glog.glogAction and glog.glogAction != null)}">
								<td>조치내용 없음</td>
							</c:if>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
	</div>
	
</div>

<style>
	.info-table.col2 {
		width: 100% !important;
		table-layout: fixed;
	}
	
	.info-table.col2 .th-col {
		width: 140px;
	}
	
	.info-table.col2 th {
		width: 140px !important;
		min-width: 140px !important;
		max-width: 140px !important;
		white-space: nowrap;
	}
	
	.info-table.col2 td {
		width: auto !important;
	}		
</style>
