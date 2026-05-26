package kr.or.chop.P22_ai.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P22_ai.dao.AiDAO;
import kr.or.chop.P22_ai.dto.AiInsightDTO;
import kr.or.chop.P22_ai.dto.AiPredictDashboardDTO;
import kr.or.chop.P22_ai.dto.AiPredictHistoryDTO;
import kr.or.chop.P22_ai.dto.AiQualityDTO;
import kr.or.chop.P22_ai.dto.AiRiskChartDTO;
import kr.or.chop.P22_ai.dto.AiSummaryDTO;

@Service
public class AiServiceImpl implements AiService {

	@Autowired
	private AiDAO aiDAO;

	@Override
	public List<AiQualityDTO> selectAiQualityList() {
		return aiDAO.selectAiQualityList();
	}

	@Override
	public int selectAiQualityCount() {
		return aiDAO.selectAiQualityCount();
	}

	@Override
	public AiSummaryDTO selectAiSummary() {
		return aiDAO.selectAiSummary();
	}

	@Override
	public List<AiRiskChartDTO> selectRiskChartData() {
		return aiDAO.selectRiskChartData();
	}

	@Override
	public AiInsightDTO selectAiInsight() {
		return aiDAO.selectAiInsight();
	}
	
	@Override
	public int insertPredictHistory(AiPredictHistoryDTO history) {
	    return aiDAO.insertPredictHistory(history);
	}
	
	@Override
	public List<AiPredictHistoryDTO> selectRecentPredictHistory() {
	    return aiDAO.selectRecentPredictHistory();
	}
	
	@Override
	public AiPredictDashboardDTO selectPredictDashboard() {
	    return aiDAO.selectPredictDashboard();
	}
}