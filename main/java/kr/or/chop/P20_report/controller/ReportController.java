package kr.or.chop.P20_report.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P20_report.dto.ReportDTO;
import kr.or.chop.P20_report.service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ReportService reportService;

    @RequestMapping("/quality")
    public String qualityReport(ReportDTO searchDTO, Model model) {

        ReportDTO summary = reportService.selectQualitySummary(searchDTO);

        List<ReportDTO> defectTopList =
                reportService.selectDefectTopList(searchDTO);

        List<ReportDTO> itemDefectRateList =
                reportService.selectItemDefectRateList(searchDTO);

        List<ReportDTO> qualityDetailList =
                reportService.selectQualityDetailList(searchDTO);

        List<String> aiComments =
                reportService.makeQualityAiComments(
                        summary,
                        defectTopList,
                        itemDefectRateList
                );

        model.addAttribute("searchDTO", searchDTO);
        model.addAttribute("summary", summary);
        model.addAttribute("defectTopList", defectTopList);
        model.addAttribute("itemDefectRateList", itemDefectRateList);
        model.addAttribute("qualityDetailList", qualityDetailList);
        model.addAttribute("aiComments", aiComments);

        return "P20_report/qualityReport.tiles";
    }
}