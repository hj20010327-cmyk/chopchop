package kr.or.chop.P22_ai.dto;

import lombok.Data;

@Data
public class AiPredictDashboardDTO {

    private int totalPredictCount;
    private int highPredictCount;
    private double highPredictRate;
    private String lastHighCreatedAt;
}