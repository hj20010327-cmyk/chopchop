package kr.or.chop.P20_report.qc.dto;

import lombok.Data;

@Data
public class QcReportSearchDTO {

    private String startDate;
    private String endDate;

    private String itemType;
    private String itemKeyword;

    private String riskLevel;
}