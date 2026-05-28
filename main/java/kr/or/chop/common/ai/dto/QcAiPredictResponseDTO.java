package kr.or.chop.common.ai.dto;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class QcAiPredictResponseDTO {

    @JsonProperty("risk_level")
    private String riskLevel;

    private Map<String, Double> probabilities;
}