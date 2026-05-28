package kr.or.chop.P20_report.qc.dto;

import lombok.Data;

@Data
public class QcReportListDTO {

    private String qcId;
    private String qcDate;

    private String lotId;
    private String itemId;
    private String itemName;
    private String itemType;
    private String itemQcType;

    private int qcQty;
    private int qcPassQty;
    private int defectQty;
    private double defectRate;

    private String qcStatus;
    private String qcType;
    private String riskLevel;

    private String workerId;
    private String workerName;
}