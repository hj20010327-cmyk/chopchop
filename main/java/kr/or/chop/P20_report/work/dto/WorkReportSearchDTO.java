package kr.or.chop.P20_report.work.dto;

import lombok.Data;

@Data
public class WorkReportSearchDTO {

    private String startDate;
    private String endDate;

    private String workStatus;
    private String itemType;
    private String itemKeyword;

    private int currentPage = 1;
}