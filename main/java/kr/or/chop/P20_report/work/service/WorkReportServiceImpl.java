package kr.or.chop.P20_report.work.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.P20_report.work.dao.WorkReportDAO;
import kr.or.chop.P20_report.work.dto.WorkReportListDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSearchDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSummaryDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class WorkReportServiceImpl implements WorkReportService {

	@Autowired
	private WorkReportDAO workReportDAO;

	@Override
	public WorkReportSummaryDTO selectWorkSummary(WorkReportSearchDTO searchDTO) {
		return workReportDAO.selectWorkSummary(searchDTO);
	}

	@Override
	public List<Map<String, Object>> selectWorkRiskChartList(WorkReportSearchDTO searchDTO) {
		return workReportDAO.selectWorkRiskChartList(searchDTO);
	}

	@Override
	public List<Map<String, Object>> selectWorkTrendList(WorkReportSearchDTO searchDTO) {
		return workReportDAO.selectWorkTrendList(searchDTO);
	}

	@Override
	public int selectWorkReportCount(WorkReportSearchDTO searchDTO) {
		return workReportDAO.selectWorkReportCount(searchDTO);
	}

	@Override
	public List<WorkReportListDTO> selectWorkReportList(WorkReportSearchDTO searchDTO, PageInfo pageInfo) {
		return workReportDAO.selectWorkReportList(searchDTO, pageInfo);
	}

	@Override
	public List<ReportSelectDTO> selectItemTypeList() {
		return workReportDAO.selectItemTypeList();
	}
	
	@Override
	public WorkAiPredictRequestDTO selectWorkAiTarget(WorkReportSearchDTO searchDTO) {
	    return workReportDAO.selectWorkAiTarget(searchDTO);
	}
}