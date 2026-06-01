package kr.or.chop.P20_report.qc.dao;

import java.util.List;
import java.util.Map;

import kr.or.chop.P20_report.qc.dto.QcReportListDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSearchDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSummaryDTO;
import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.common.ai.dto.QcAiPredictRequestDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface QcReportDAO {

    QcReportSummaryDTO selectQcSummary(QcReportSearchDTO searchDTO);

    int selectQcReportCount(QcReportSearchDTO searchDTO);

    List<QcReportListDTO> selectQcReportList(QcReportSearchDTO searchDTO, PageInfo pageInfo);

    List<ReportSelectDTO> selectItemTypeList();

    List<Map<String, Object>> selectDefectTrendList(QcReportSearchDTO searchDTO);

    List<Map<String, Object>> selectRiskChartList(QcReportSearchDTO searchDTO);
    
    QcAiPredictRequestDTO selectQcAiTarget(QcReportSearchDTO searchDTO);
}