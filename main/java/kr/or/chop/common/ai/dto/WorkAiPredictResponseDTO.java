package kr.or.chop.common.ai.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class WorkAiPredictResponseDTO {

    @JsonProperty("risk_level")
    private String riskLevel;

    @JsonProperty("normal_prob")
    private double normalProb;

    @JsonProperty("delay_prob")
    private double delayProb;

    @JsonProperty("risk_prob")
    private double riskProb;
}