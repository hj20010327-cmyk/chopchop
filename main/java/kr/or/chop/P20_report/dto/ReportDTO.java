package kr.or.chop.P20_report.dto;

import lombok.Data;

@Data
public class ReportDTO {

    private String startDate;
    private String endDate;
    private String searchKeyword;

    private int totalQcCount;
    private int completeQcCount;
    private int failQcCount;

    private int totalQcQty;
    private int totalPassQty;
    private int totalDefQty;

    private double defectRate;

    private String maxDefectName;

    private String itemId;
    private String itemName;
    private int itemTotalQty;
    private int itemPassQty;
    private int itemDefQty;
    private double itemDefectRate;

    private String defTypeId;
    private String defTypeName;
    private int defCount;

    private String qcId;
    private String lotId;
    private String qcDate;
    private String qcTypeName;
    private String qcStatusName;
    private int qcQty;
    private int qcPassQty;
    private int qcDefQty;
    private String defNames;
}