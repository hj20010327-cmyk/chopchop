package kr.or.chop.P20_report.qc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P20_report.qc.dto.QcReportListDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSearchDTO;
import kr.or.chop.P20_report.qc.dto.QcReportSummaryDTO;
import kr.or.chop.P20_report.qc.dto.ReportSelectDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class QcReportDAOImpl implements QcReportDAO {

    private static final String NAMESPACE = "mapper.P20_report.qc.qc_report_mapper.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public QcReportSummaryDTO selectQcSummary(QcReportSearchDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectQcSummary", searchDTO);
    }

    @Override
    public int selectQcReportCount(QcReportSearchDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectQcReportCount", searchDTO);
    }

    @Override
    public List<QcReportListDTO> selectQcReportList(QcReportSearchDTO searchDTO, PageInfo pageInfo) {

        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("search", searchDTO);
        paramMap.put("page", pageInfo);

        return sqlSession.selectList(NAMESPACE + "selectQcReportList", paramMap);
    }

    @Override
    public List<ReportSelectDTO> selectItemTypeList() {
        return sqlSession.selectList(NAMESPACE + "selectItemTypeList");
    }

    @Override
    public List<Map<String, Object>> selectDefectTrendList(QcReportSearchDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectDefectTrendList", searchDTO);
    }

    @Override
    public List<Map<String, Object>> selectRiskChartList(QcReportSearchDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectRiskChartList", searchDTO);
    }
}