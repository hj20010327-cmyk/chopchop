package kr.or.chop.P20_report.service;

import java.util.List;

import kr.or.chop.P20_report.dto.ReportDTO;

public interface ReportService {

    ReportDTO selectQualitySummary(ReportDTO searchDTO);

    List<ReportDTO> selectDefectTopList(ReportDTO searchDTO);

    List<ReportDTO> selectItemDefectRateList(ReportDTO searchDTO);

    List<ReportDTO> selectQualityDetailList(ReportDTO searchDTO);

    List<String> makeQualityAiComments(
            ReportDTO summary,
            List<ReportDTO> defectTopList,
            List<ReportDTO> itemDefectRateList
    );
}