package kr.or.chop.P20_report.work.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.P20_report.work.dto.WorkReportListDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSearchDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSummaryDTO;
import kr.or.chop.P20_report.work.service.WorkReportService;
import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictResponseDTO;
import kr.or.chop.common.ai.service.WorkAiPredictionService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
public class WorkReportController {

    @Autowired
    private WorkReportService workReportService;
    
    @Autowired
    private WorkAiPredictionService workAiPredictionService;

    @GetMapping("/report/work")
    public String workReport(
            WorkReportSearchDTO searchDTO,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {

        if (searchDTO.getStartDate() == null || searchDTO.getStartDate().isEmpty()) {
            searchDTO.setStartDate(LocalDate.now().minusMonths(6).toString());
        }

        if (searchDTO.getEndDate() == null || searchDTO.getEndDate().isEmpty()) {
            searchDTO.setEndDate(LocalDate.now().toString());
        }

        WorkReportSummaryDTO summary =
                workReportService.selectWorkSummary(searchDTO);

        int listCount =
                workReportService.selectWorkReportCount(searchDTO);

        PageInfo pageInfo =
                Pagination.getPageInfo(listCount, currentPage, 5, 10);

        List<WorkReportListDTO> workList =
                workReportService.selectWorkReportList(searchDTO, pageInfo);

        List<Map<String, Object>> riskChartList =
                workReportService.selectWorkRiskChartList(searchDTO);

        List<Map<String, Object>> workTrendList =
                workReportService.selectWorkTrendList(searchDTO);

        List<ReportSelectDTO> itemTypeList =
                workReportService.selectItemTypeList();
        
        WorkAiPredictResponseDTO aiResult = null;
        String aiErrorMessage = null;

        try {
            WorkAiPredictRequestDTO aiRequestDTO =
                    workReportService.selectWorkAiTarget(searchDTO);

            if (aiRequestDTO != null) {
                aiResult = workAiPredictionService.predict(aiRequestDTO);
            }
        } catch (Exception e) {
            aiErrorMessage = "AI 서버 연결 또는 예측 처리 중 문제가 발생했습니다.";
        }

        model.addAttribute("summary", summary);
        model.addAttribute("riskChartList", riskChartList);
        model.addAttribute("workTrendList", workTrendList);
        model.addAttribute("workList", workList);
        model.addAttribute("itemTypeList", itemTypeList);
        model.addAttribute("searchDTO", searchDTO);
        
        model.addAttribute("aiResult", aiResult);
        model.addAttribute("aiErrorMessage", aiErrorMessage);

        model.addAttribute("page", pageInfo);

        return "P20_report/work/workReport.tiles";
    }
}