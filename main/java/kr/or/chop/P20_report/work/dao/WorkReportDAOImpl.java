package kr.or.chop.P20_report.work.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.P20_report.work.dto.WorkReportListDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSearchDTO;
import kr.or.chop.P20_report.work.dto.WorkReportSummaryDTO;
import kr.or.chop.common.ai.dto.WorkAiPredictRequestDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class WorkReportDAOImpl implements WorkReportDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE =
            "mapper.P20_report.work.work_report_mapper.";

    @Override
    public WorkReportSummaryDTO selectWorkSummary(WorkReportSearchDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectWorkSummary", searchDTO);
    }

    @Override
    public List<Map<String, Object>> selectWorkRiskChartList(WorkReportSearchDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectWorkRiskChartList", searchDTO);
    }

    @Override
    public List<Map<String, Object>> selectWorkTrendList(WorkReportSearchDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectWorkTrendList", searchDTO);
    }

    @Override
    public int selectWorkReportCount(WorkReportSearchDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectWorkReportCount", searchDTO);
    }

    @Override
    public List<WorkReportListDTO> selectWorkReportList(WorkReportSearchDTO searchDTO, PageInfo pageInfo) {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("search", searchDTO);
        paramMap.put("page", pageInfo);

        return sqlSession.selectList(NAMESPACE + "selectWorkReportList", paramMap);
    }

    @Override
    public List<ReportSelectDTO> selectItemTypeList() {
        return sqlSession.selectList(NAMESPACE + "selectItemTypeList");
    }
    
    @Override
    public WorkAiPredictRequestDTO selectWorkAiTarget(WorkReportSearchDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectWorkAiTarget", searchDTO);
    }
}