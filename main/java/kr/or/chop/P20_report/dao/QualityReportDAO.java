package kr.or.chop.P20_report.dao;

import kr.or.chop.P20_report.dto.QualityReportSearchDTO;
import kr.or.chop.P20_report.dto.QualityReportSummaryDTO;

public interface QualityReportDAO {

    QualityReportSummaryDTO selectQualitySummary(QualityReportSearchDTO searchDTO);
}