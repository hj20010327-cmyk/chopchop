package kr.or.chop.common.ai.service;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictResponseDTO;

@Service
public class WorkAiPredictionServiceImpl implements WorkAiPredictionService {

    private static final String AI_SERVER_URL = "http://192.168.0.50:8000/predict/work";

    @Override
    public WorkAiPredictResponseDTO predict(WorkAiPredictRequestDTO requestDTO) {

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<WorkAiPredictRequestDTO> entity =
                new HttpEntity<WorkAiPredictRequestDTO>(requestDTO, headers);

        RestTemplate restTemplate = new RestTemplate();

        return restTemplate.postForObject(
                AI_SERVER_URL,
                entity,
                WorkAiPredictResponseDTO.class
        );
    }
}