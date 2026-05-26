package kr.or.chop.P22_ai.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P22_ai.dto.AiInsightDTO;
import kr.or.chop.P22_ai.dto.AiPredictDashboardDTO;
import kr.or.chop.P22_ai.dto.AiPredictHistoryDTO;
import kr.or.chop.P22_ai.dto.AiQualityDTO;
import kr.or.chop.P22_ai.dto.AiRiskChartDTO;
import kr.or.chop.P22_ai.dto.AiSummaryDTO;

@Repository
public class AiDAOImpl implements AiDAO {

	@Autowired
	private SqlSession sqlSession;

	private static final String NAMESPACE = "mapper.P22_ai.";

	@Override
	public List<AiQualityDTO> selectAiQualityList() {
		return sqlSession.selectList(NAMESPACE + "selectAiQualityList");
	}

	@Override
	public int selectAiQualityCount() {
		return sqlSession.selectOne(NAMESPACE + "selectAiQualityCount");
	}

	@Override
	public AiSummaryDTO selectAiSummary() {
		return sqlSession.selectOne(NAMESPACE + "selectAiSummary");
	}

	@Override
	public List<AiRiskChartDTO> selectRiskChartData() {
		return sqlSession.selectList(NAMESPACE + "selectRiskChartData");
	}

	@Override
	public AiInsightDTO selectAiInsight() {
		return sqlSession.selectOne(NAMESPACE + "selectAiInsight");
	}
	
	@Override
	public int insertPredictHistory(AiPredictHistoryDTO history) {
	    return sqlSession.insert(NAMESPACE + "insertPredictHistory", history);
	}
	
	@Override
	public List<AiPredictHistoryDTO> selectRecentPredictHistory() {
	    return sqlSession.selectList(NAMESPACE + "selectRecentPredictHistory");
	}
	
	@Override
	public AiPredictDashboardDTO selectPredictDashboard() {
	    return sqlSession.selectOne(NAMESPACE + "selectPredictDashboard");
	}
}