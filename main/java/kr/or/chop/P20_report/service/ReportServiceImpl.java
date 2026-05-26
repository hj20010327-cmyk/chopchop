package kr.or.chop.P20_report.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P20_report.dao.ReportDAO;
import kr.or.chop.P20_report.dto.ReportDTO;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportDAO reportDAO;

    @Override
    public ReportDTO selectQualitySummary(ReportDTO searchDTO) {
        return reportDAO.selectQualitySummary(searchDTO);
    }

    @Override
    public List<ReportDTO> selectDefectTopList(ReportDTO searchDTO) {
        return reportDAO.selectDefectTopList(searchDTO);
    }

    @Override
    public List<ReportDTO> selectItemDefectRateList(ReportDTO searchDTO) {
        return reportDAO.selectItemDefectRateList(searchDTO);
    }

    @Override
    public List<ReportDTO> selectQualityDetailList(ReportDTO searchDTO) {
        return reportDAO.selectQualityDetailList(searchDTO);
    }

    @Override
    public List<String> makeQualityAiComments(
            ReportDTO summary,
            List<ReportDTO> defectTopList,
            List<ReportDTO> itemDefectRateList) {

        List<String> comments = new ArrayList<String>();

        if (summary == null || summary.getTotalQcCount() == 0) {
            comments.add("조회 기간 내 품질 검사 데이터가 부족하여 AI 분석 코멘트를 생성하기 어렵습니다.");
            return comments;
        }

        if (summary.getDefectRate() >= 10) {
            comments.add("전체 불량률이 높은 편입니다. 최근 검사 LOT와 주요 불량 유형을 우선 확인하는 것이 좋습니다.");
        } else if (summary.getDefectRate() >= 5) {
            comments.add("불량률이 주의 구간에 있습니다. 반복 발생하는 불량 유형을 중심으로 원인 점검이 필요합니다.");
        } else {
            comments.add("전체 품질 흐름은 비교적 안정적인 상태입니다.");
        }

        if (summary.getMaxDefectName() != null && !"없음".equals(summary.getMaxDefectName())) {
            comments.add("'" + summary.getMaxDefectName() + "' 유형이 가장 많이 발생했습니다. 해당 공정 또는 검사 기준을 우선 점검하세요.");
        }

        if (itemDefectRateList != null && !itemDefectRateList.isEmpty()) {
            ReportDTO topItem = itemDefectRateList.get(0);

            if (topItem.getItemDefectRate() >= 10) {
                comments.add("'" + topItem.getItemName() + "' 품목의 불량률이 높게 나타났습니다. 원재료, 작업 조건, 검사 결과를 함께 확인하는 것이 좋습니다.");
            }
        }

        if (summary.getFailQcCount() > 0) {
            comments.add("불량이 발생한 검사 건이 존재합니다. LOT 단위 추적을 통해 출고 전 품질 리스크를 줄일 수 있습니다.");
        }

        return comments;
    }
}