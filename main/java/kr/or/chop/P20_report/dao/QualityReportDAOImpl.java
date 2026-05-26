package kr.or.chop.P20_report.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P20_report.dto.QualityReportSearchDTO;
import kr.or.chop.P20_report.dto.QualityReportSummaryDTO;

@Repository
public class QualityReportDAOImpl implements QualityReportDAO {

    private static final String NAMESPACE = "mapper.P20_report.";

    @Autowired
    private SqlSession sqlSession;

    @Override
    public QualityReportSummaryDTO selectQualitySummary(QualityReportSearchDTO searchDTO) {
        return sqlSession.selectOne(
                NAMESPACE + "selectQualitySummary",
                searchDTO
        );
    }
}