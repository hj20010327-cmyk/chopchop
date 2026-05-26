package kr.or.chop.P20_report.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P20_report.dao.QualityReportDAO;
import kr.or.chop.P20_report.dto.QualityReportSearchDTO;
import kr.or.chop.P20_report.dto.QualityReportSummaryDTO;

@Service
public class QualityReportServiceImpl implements QualityReportService {

    @Autowired
    private QualityReportDAO qualityReportDAO;

    @Override
    public QualityReportSummaryDTO selectQualitySummary(QualityReportSearchDTO searchDTO) {
        return qualityReportDAO.selectQualitySummary(searchDTO);
    }
}