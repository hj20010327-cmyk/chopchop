package kr.or.chop.P20_report.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P20_report.dto.QualityReportSearchDTO;
import kr.or.chop.P20_report.dto.QualityReportSummaryDTO;
import kr.or.chop.P20_report.service.QualityReportService;

@Controller
@RequestMapping("/report")
public class QualityReportController {

    @Autowired
    private QualityReportService qualityReportService;

    @RequestMapping("/quality")
    public String qualityReport(
            QualityReportSearchDTO searchDTO,
            Model model) {

        QualityReportSummaryDTO summary =
                qualityReportService.selectQualitySummary(searchDTO);

        model.addAttribute("summary", summary);
        model.addAttribute("searchDTO", searchDTO);

        return "P20_report/qualityReport.tiles";
    }
}