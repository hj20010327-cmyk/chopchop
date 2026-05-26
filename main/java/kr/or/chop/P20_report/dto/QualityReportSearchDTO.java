package kr.or.chop.P20_report.dto;

import lombok.Data;

@Data
public class QualityReportSearchDTO {

    private String startDate;
    private String endDate;
    private String itemId;
    private String defTypeId;
}