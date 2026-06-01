package kr.or.chop.P20_report.work.dto;

import lombok.Data;

@Data
public class WorkReportSummaryDTO {

    private int totalPlanQty;
    private int totalOrderQty;
    private int totalProdQty;

    private double achievementRate;

    private int delayCount;
    private int riskCount;
}