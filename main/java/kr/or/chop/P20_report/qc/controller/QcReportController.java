package kr.or.chop.P20_report.qc.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P20_report.qc.dto.QcReportListDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSearchDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSummaryDTO;
import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.P20_report.qc.service.QcReportService;
import kr.or.chop.common.ai.dto.QcAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.QcAiPredictResponseDTO;
import kr.or.chop.common.ai.service.QcAiPredictionService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/report")
public class QcReportController {

    @Autowired
    private QcReportService qcReportService;
    @Autowired
    private QcAiPredictionService qcAiPredictionService;

    @RequestMapping("/quality")
    public String qualityReport(
            QcReportSearchDTO searchDTO,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {
    	
    	if (searchDTO.getStartDate() == null || searchDTO.getStartDate().isEmpty()) {
			searchDTO.setStartDate(LocalDate.now().minusMonths(6).toString());
		}
		
		if (searchDTO.getEndDate() == null || searchDTO.getEndDate().isEmpty()) {
			searchDTO.setEndDate(LocalDate.now().toString());
		}

        QcReportSummaryDTO summary = qcReportService.selectQcSummary(searchDTO);

        int listCount = qcReportService.selectQcReportCount(searchDTO);

        PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);

        List<QcReportListDTO> qualityList =
                qcReportService.selectQcReportList(searchDTO, pageInfo);

        List<ReportSelectDTO> itemTypeList =
                qcReportService.selectItemTypeList();

        List<Map<String, Object>> defectTrendList =
                qcReportService.selectDefectTrendList(searchDTO);

        List<Map<String, Object>> riskChartList =
                qcReportService.selectRiskChartList(searchDTO);
        
        QcAiPredictResponseDTO aiResult = null;
        String aiErrorMessage = null;

        try {
            QcAiPredictRequestDTO aiRequestDTO =
                    qcReportService.selectQcAiTarget(searchDTO);

            if (aiRequestDTO != null) {
                aiResult = qcAiPredictionService.predict(aiRequestDTO);
            }
        } catch (Exception e) {
            aiErrorMessage = "AI 서버 연결 또는 예측 처리 중 문제가 발생했습니다.";
        }

        model.addAttribute("summary", summary);
        model.addAttribute("qualityList", qualityList);
        model.addAttribute("itemTypeList", itemTypeList);
        model.addAttribute("defectTrendList", defectTrendList);
        model.addAttribute("riskChartList", riskChartList);
        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("page", pageInfo);
        
        model.addAttribute("aiResult", aiResult);
        model.addAttribute("aiErrorMessage", aiErrorMessage);

        return "P20_report/qc/qualityReport.tiles";
    }
}