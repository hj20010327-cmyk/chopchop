package kr.or.chop.P22_ai.service;

import java.util.List;

import kr.or.chop.P22_ai.dto.AiInsightDTO;
import kr.or.chop.P22_ai.dto.AiPredictDashboardDTO;
import kr.or.chop.P22_ai.dto.AiPredictHistoryDTO;
import kr.or.chop.P22_ai.dto.AiQualityDTO;
import kr.or.chop.P22_ai.dto.AiRiskChartDTO;
import kr.or.chop.P22_ai.dto.AiSummaryDTO;

public interface AiService {

    List<AiQualityDTO> selectAiQualityList();

    int selectAiQualityCount();

    AiSummaryDTO selectAiSummary();

    List<AiRiskChartDTO> selectRiskChartData();
    
    AiInsightDTO selectAiInsight();
    
    int insertPredictHistory(AiPredictHistoryDTO history);
    
    List<AiPredictHistoryDTO> selectRecentPredictHistory();
    
    AiPredictDashboardDTO selectPredictDashboard();
    
}