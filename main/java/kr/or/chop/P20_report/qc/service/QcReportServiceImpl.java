package kr.or.chop.P20_report.qc.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P20_report.qc.dao.QcReportDAO;
import kr.or.chop.P20_report.qc.dto.QcReportListDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSearchDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSummaryDTO;
import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.common.ai.dto.QcAiPredictRequestDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class QcReportServiceImpl implements QcReportService {

    @Autowired
    private QcReportDAO qcReportDAO;

    @Override
    public QcReportSummaryDTO selectQcSummary(QcReportSearchDTO searchDTO) {
        return qcReportDAO.selectQcSummary(searchDTO);
    }

    @Override
    public int selectQcReportCount(QcReportSearchDTO searchDTO) {
        return qcReportDAO.selectQcReportCount(searchDTO);
    }

    @Override
    public List<QcReportListDTO> selectQcReportList(QcReportSearchDTO searchDTO, PageInfo pageInfo) {
        return qcReportDAO.selectQcReportList(searchDTO, pageInfo);
    }

    @Override
    public List<ReportSelectDTO> selectItemTypeList() {
        return qcReportDAO.selectItemTypeList();
    }

    @Override
    public List<Map<String, Object>> selectDefectTrendList(QcReportSearchDTO searchDTO) {
        return qcReportDAO.selectDefectTrendList(searchDTO);
    }

    @Override
    public List<Map<String, Object>> selectRiskChartList(QcReportSearchDTO searchDTO) {
        return qcReportDAO.selectRiskChartList(searchDTO);
    }
    
    @Override
    public QcAiPredictRequestDTO selectQcAiTarget(QcReportSearchDTO searchDTO) {
        return qcReportDAO.selectQcAiTarget(searchDTO);
    }
}