package kr.or.chop.P20_report.dto;

import lombok.Data;

@Data
public class QualityReportSummaryDTO {

    private int totalQcQty;
    private int totalPassQty;
    private int totalDefectQty;
    private double defectRate;
}