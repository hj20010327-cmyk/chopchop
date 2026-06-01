package kr.or.chop.common.ai.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;

@Data
public class QcAiPredictResponseDTO {

    @JsonProperty("risk_level")
    private String riskLevel;

    @JsonProperty("low_prob")
    private double lowProb;

    @JsonProperty("medium_prob")
    private double mediumProb;

    @JsonProperty("high_prob")
    private double highProb;
}