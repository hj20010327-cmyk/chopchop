package kr.or.chop.P20_report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P20_report.dto.ReportDTO;

@Repository
public class ReportDAOImpl implements ReportDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "mapper.P20_report.";

    @Override
    public ReportDTO selectQualitySummary(ReportDTO searchDTO) {
        return sqlSession.selectOne(NAMESPACE + "selectQualitySummary", searchDTO);
    }

    @Override
    public List<ReportDTO> selectDefectTopList(ReportDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectDefectTopList", searchDTO);
    }

    @Override
    public List<ReportDTO> selectItemDefectRateList(ReportDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectItemDefectRateList", searchDTO);
    }

    @Override
    public List<ReportDTO> selectQualityDetailList(ReportDTO searchDTO) {
        return sqlSession.selectList(NAMESPACE + "selectQualityDetailList", searchDTO);
    }
}