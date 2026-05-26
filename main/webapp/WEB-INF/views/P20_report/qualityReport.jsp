<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="content">

    <div class="header-row">
        <div>
            <h2 class="page-title">품질 리포트</h2>
            <p class="page-subtitle">
                검사 및 불량 데이터를 기반으로 품질 현황을 분석합니다.
            </p>
        </div>

        <div>
            <p class="page-route">
                홈 &gt; 리포트 &gt; 품질 리포트
            </p>
        </div>
    </div>

    <!-- 검색 조건 -->
    <form class="search-box" method="get">

        <div class="search-item">
            <label>시작일</label>
            <input type="date" name="startDate" value="${searchDTO.startDate}">
        </div>

        <div class="search-item">
            <label>종료일</label>
            <input type="date" name="endDate" value="${searchDTO.endDate}">
        </div>

        <div class="search-item">
            <label>품목</label>
            <select name="itemId">
                <option value="">전체</option>
            </select>
        </div>

        <div class="search-item">
            <label>불량유형</label>
            <select name="defTypeId">
                <option value="">전체</option>
            </select>
        </div>

        <div class="search-btn-area"
             style="width:100%; justify-content:flex-end;">
            <button type="submit" class="btn btn-main">
                조회
            </button>
        </div>

    </form>

    <!-- 요약 카드 -->
    <div class="report-card-grid">

        <div class="report-card">
		    <p>총 검사 수량</p>
		    <strong>${summary.totalQcQty}</strong>
		    <span>EA</span>
		</div>
		
		<div class="report-card">
		    <p>합격 수량</p>
		    <strong>${summary.totalPassQty}</strong>
		    <span>EA</span>
		</div>
		
		<div class="report-card">
		    <p>불량 수량</p>
		    <strong class="danger">${summary.totalDefectQty}</strong>
		    <span>EA</span>
		</div>
		
		<div class="report-card">
		    <p>평균 불량률</p>
		    <strong class="danger">${summary.defectRate}</strong>
		    <span>%</span>
		</div>

    </div>

    <!-- 차트 영역 -->
    <div class="report-chart-grid">

        <div class="report-section">
            <div class="section-title-row">
                <h3>불량률 추이</h3>
            </div>

            <div class="chart-placeholder">
                날짜별 불량률 차트 영역
            </div>
        </div>

        <div class="report-section">
            <div class="section-title-row">
                <h3>불량 유형 현황</h3>
            </div>

            <div class="chart-placeholder">
                불량 유형 비율 차트 영역
            </div>
        </div>

    </div>

    <!-- AI 분석 코멘트 -->
    <div class="ai-comment-box">

        <div class="ai-comment-header">
            <strong>AI 품질 분석 결과</strong>
            <span>QC / LOT / 불량 이력 기반</span>
        </div>

        <ul>
            <li>조회된 품질 데이터를 기반으로 불량률 변화와 반복 불량 유형을 분석합니다.</li>
            <li>특정 품목 또는 불량 유형의 비율이 높을 경우 품질 점검 코멘트를 제공합니다.</li>
            <li>현재는 실제 QC 데이터를 연결하기 전 화면 구조 확인 단계입니다.</li>
        </ul>

    </div>

    <!-- 상세 리스트 -->
    <div class="report-section">

        <div class="section-title-row">
            <h3>LOT별 검사 현황</h3>
        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th>LOT 번호</th>
                        <th>품목명</th>
                        <th>검사수량</th>
                        <th>합격수량</th>
                        <th>불량수량</th>
                        <th>불량률</th>
                        <th>판정</th>
                        <th>검사일자</th>
                    </tr>
                </thead>

                <tbody>
                    <tr>
                        <td colspan="8" style="text-align:center;">
                            조회된 품질 리포트 데이터가 없습니다.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>

</div>

<style>
    .report-card-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;

        margin-bottom: 24px;
    }

    .report-card {
        padding: 22px;

        border: 1px solid #e5e7eb;
        border-radius: 14px;
        background-color: #fff;
    }

    .report-card p {
        margin: 0 0 12px 0;

        font-size: 14px;
        color: #666;
        font-weight: 700;
    }

    .report-card strong {
        font-size: 32px;
        color: #222;
    }

    .report-card span {
        margin-left: 4px;

        color: #777;
        font-size: 14px;
        font-weight: 700;
    }

    .report-card .danger {
        color: #d93025;
    }

    .report-chart-grid {
        display: grid;
        grid-template-columns: 1.4fr 1fr;
        gap: 20px;

        margin-bottom: 24px;
    }

    .report-section {
        margin-bottom: 24px;
        padding: 22px;

        border: 1px solid #e5e7eb;
        border-radius: 14px;
        background-color: #fff;
    }

    .section-title-row {
        display: flex;
        align-items: center;
        justify-content: space-between;

        margin-bottom: 16px;
    }

    .section-title-row h3 {
        margin: 0;

        font-size: 18px;
        color: #222;
    }

    .chart-placeholder {
        height: 260px;

        display: flex;
        align-items: center;
        justify-content: center;

        border-radius: 12px;
        background-color: #f8fafc;
        border: 1px dashed #cbd5e1;

        color: #777;
        font-weight: 700;
    }

    .ai-comment-box {
        margin-bottom: 24px;
        padding: 22px 26px;

        border-radius: 14px;
        border: 1px solid #bbf7d0;
        background-color: #f0fdf4;
    }

    .ai-comment-header {
        display: flex;
        align-items: center;
        justify-content: space-between;

        margin-bottom: 14px;
    }

    .ai-comment-header strong {
        font-size: 18px;
        color: #166534;
    }

    .ai-comment-header span {
        font-size: 13px;
        color: #15803d;
        font-weight: 700;
    }

    .ai-comment-box ul {
        margin: 0;
        padding-left: 20px;
    }

    .ai-comment-box li {
        margin-bottom: 8px;

        color: #14532d;
        font-size: 14px;
        line-height: 1.6;
    }
</style>