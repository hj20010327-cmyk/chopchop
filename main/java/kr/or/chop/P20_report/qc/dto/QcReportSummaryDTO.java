package kr.or.chop.P20_report.qc.dto;

import lombok.Data;

@Data
public class QcReportSummaryDTO {

    private int totalQcQty;
    private int totalPassQty;
    private int totalDefectQty;

    private double defectRate;

    private int highRiskCount;
    private double highRiskRate;
}