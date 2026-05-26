package kr.or.chop.P20_report.dao;

import java.util.List;

import kr.or.chop.P20_report.dto.ReportDTO;

public interface ReportDAO {

    ReportDTO selectQualitySummary(ReportDTO searchDTO);

    List<ReportDTO> selectDefectTopList(ReportDTO searchDTO);

    List<ReportDTO> selectItemDefectRateList(ReportDTO searchDTO);

    List<ReportDTO> selectQualityDetailList(ReportDTO searchDTO);
}