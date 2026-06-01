package kr.or.chop.P20_report.work.dao;

import java.util.List;
import java.util.Map;

import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.P20_report.work.dto.WorkReportListDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSearchDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSummaryDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WorkReportDAO {

    WorkReportSummaryDTO selectWorkSummary(WorkReportSearchDTO searchDTO);

    List<Map<String, Object>> selectWorkRiskChartList(WorkReportSearchDTO searchDTO);

    List<Map<String, Object>> selectWorkTrendList(WorkReportSearchDTO searchDTO);

    int selectWorkReportCount(WorkReportSearchDTO searchDTO);

    List<WorkReportListDTO> selectWorkReportList(WorkReportSearchDTO searchDTO, PageInfo pageInfo);
    
    List<ReportSelectDTO> selectItemTypeList();
    
    WorkAiPredictRequestDTO selectWorkAiTarget(WorkReportSearchDTO searchDTO);
}