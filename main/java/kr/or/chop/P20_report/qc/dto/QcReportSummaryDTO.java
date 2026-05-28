package kr.or.chop.P20_report.qc.dto;

import lombok.Data;

@Data
public class QcReportSummaryDTO {

    private long totalQcQty;
    private long totalPassQty;
    private long totalDefectQty;

    private double defectRate;

    private long highRiskCount;
    private double highRiskRate;
}