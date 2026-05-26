package kr.or.chop.P20_report.service;

import kr.or.chop.P20_report.dto.QualityReportSearchDTO;
import kr.or.chop.P20_report.dto.QualityReportSummaryDTO;

public interface QualityReportService {

    QualityReportSummaryDTO selectQualitySummary(QualityReportSearchDTO searchDTO);
}