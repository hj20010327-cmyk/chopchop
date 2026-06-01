package kr.or.chop.P20_report.work.dto;

import lombok.Data;

@Data
public class WorkReportListDTO {

    private String workId;
    private String workDate;

    private String itemId;
    private String itemName;

    private int planQty;
    private int orderQty;
    private int prodQty;

    private double achievementRate;

    private String riskLevel;
}