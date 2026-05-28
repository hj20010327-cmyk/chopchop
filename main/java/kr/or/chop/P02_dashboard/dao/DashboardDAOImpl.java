package kr.or.chop.P02_dashboard.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DashboardDAOImpl implements DashboardDAO {

	@Autowired
	SqlSession session;

	// 오늘 생산/완료/검사/불량 수량 조회
	@Override
	public Map<String, Object> selectTodaySummary() {
		return session.selectOne("mapper.P02_dashboard.selectTodaySummary");
	}

	// 설비 상태별 개수 및 가동률 조회
	@Override
	public Map<String, Object> selectEqStatusSummary() {
		return session.selectOne("mapper.P02_dashboard.selectEqStatusSummary");
	}

	// 적재율 높은 창고 TOP5 조회
	@Override
	public List<Map<String, Object>> selectWarehouseTopList() {
		return session.selectList("mapper.P02_dashboard.selectWarehouseTopList");
	}

	// 최근 7일 작업 수량 조회
	@Override
	public List<Map<String, Object>> selectWeeklyWorkChart() {
		return session.selectList("mapper.P02_dashboard.selectWeeklyWorkChart");
	}

	// 최근 7일 불량률 조회
	@Override
	public List<Map<String, Object>> selectWeeklyDefectChart() {
		return session.selectList("mapper.P02_dashboard.selectWeeklyDefectChart");
	}

	// 오늘 작업 예정인 작업지시 목록 조회
	@Override
	public List<Map<String, Object>> selectTodayWorkList() {
		return session.selectList("mapper.P02_dashboard.selectTodayWorkList");
	}

	// KPI 지표 목록 조회
	@Override
	public List<Map<String, Object>> selectKpiList() {
		return session.selectList("mapper.P02_dashboard.selectKpiList");
	}
	
	// 최근 공지사항 5개 조회
	@Override
	public List<Map<String, Object>> selectRecentNoticeList() {
		return session.selectList("mapper.P02_dashboard.selectRecentNoticeList");
	}

}