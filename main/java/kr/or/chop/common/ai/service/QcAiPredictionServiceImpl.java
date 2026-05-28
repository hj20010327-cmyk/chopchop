package kr.or.chop.common.ai.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.or.chop.common.ai.dto.QcAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.QcAiPredictResponseDTO;

@Service
public class QcAiPredictionServiceImpl implements QcAiPredictionService {

    private static final String AI_SERVER_URL = "http://192.168.0.50:8000/predict/qc";

    @Override
    public QcAiPredictResponseDTO predict(QcAiPredictRequestDTO requestDTO) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<QcAiPredictRequestDTO> entity =
                new HttpEntity<QcAiPredictRequestDTO>(requestDTO, headers);

        RestTemplate restTemplate = new RestTemplate();

        return restTemplate.postForObject(
                AI_SERVER_URL,
                entity,
                QcAiPredictResponseDTO.class
        );
    }
}