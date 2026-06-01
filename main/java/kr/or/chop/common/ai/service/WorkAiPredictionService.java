package kr.or.chop.common.ai.service;

import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictResponseDTO;

public interface WorkAiPredictionService {

    WorkAiPredictResponseDTO predict(WorkAiPredictRequestDTO requestDTO);
}