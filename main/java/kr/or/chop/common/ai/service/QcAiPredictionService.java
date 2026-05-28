package kr.or.chop.common.ai.service;

import kr.or.chop.common.ai.dto.QcAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.QcAiPredictResponseDTO;

public interface QcAiPredictionService {

    QcAiPredictResponseDTO predict(QcAiPredictRequestDTO requestDTO);
}