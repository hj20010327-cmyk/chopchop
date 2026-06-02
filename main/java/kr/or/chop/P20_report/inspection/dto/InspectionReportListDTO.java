package kr.or.chop.P20_report.inspection.dto;

import lombok.Data;

@Data
public class InspectionReportListDTO {

    private String inspectionType;
    private String targetType;
    private String targetName;

    private String inspectionDate;
    private String inspectionResult;
    private String inspectionReason;

    private String riskLevel;
}