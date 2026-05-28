package kr.or.chop.P02_dashboard.service;

import java.util.List;
import java.util.Map;

public interface DashboardService {

	// 오늘 생산/완료/검사/불량 수량 조회
	Map<String, Object> selectTodaySummary();

	// 설비 상태별 개수 및 가동률 조회
	Map<String, Object> selectEqStatusSummary();

	// 적재율 높은 창고 TOP5 조회
	List<Map<String, Object>> selectWarehouseTopList();

	// 최근 7일 작업 수량 조회
	List<Map<String, Object>> selectWeeklyWorkChart();

	// 최근 7일 불량률 조회
	List<Map<String, Object>> selectWeeklyDefectChart();

	// 오늘 작업 예정인 작업지시 목록 조회
	List<Map<String, Object>> selectTodayWorkList();

	// KPI 지표 목록 조회
	List<Map<String, Object>> selectKpiList();
	
	// 최근 공지사항 5개 조회
	List<Map<String, Object>> selectRecentNoticeList();

}