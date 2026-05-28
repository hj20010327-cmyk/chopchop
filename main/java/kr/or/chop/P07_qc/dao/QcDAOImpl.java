package kr.or.chop.P07_qc.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class QcDAOImpl implements QcDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private final String namespace = "kr.or.chop.P07_qc.";

	@Override
	public int selectQcCount(QcDTO dto) {
		return sqlSession.selectOne(namespace + "selectQcCount", dto);
	}

	@Override
	public List<QcDTO> selectQcList(QcDTO dto, PageInfo pageInfo) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("page", pageInfo);
		map.put("status", dto.getQcStatus());
		map.put("startDate", dto.getStartDate());
		map.put("endDate", dto.getEndDate());
		map.put("searchKeyword", dto.getSearchKeyword());

		return sqlSession.selectList(namespace + "selectQcList", map);
	}

	@Override
	public QcDTO selectQcSummary(QcDTO dto) {
		return sqlSession.selectOne(namespace + "selectQcSummary", dto);
	}

	@Override
	public QcDTO selectQcDetail(String qcId) {
		return sqlSession.selectOne(namespace + "selectQcDetail", qcId);
	}

	@Override
	public int insertQc(QcDTO dto) {
		return sqlSession.insert(namespace + "insertQc", dto);
	}

	@Override
	public int updateQc(QcDTO dto) {
		return sqlSession.update(namespace + "updateQc", dto);
	}

	@Override
	public int deleteQc(String qcId) {
		return sqlSession.update(namespace + "deleteQc", qcId);
	}

	@Override
	public List<QcDTO> selectQcLotList() {
		return sqlSession.selectList(namespace + "selectQcLotList");
	}

	@Override
	public int updateQcResult(QcDTO dto) {
		return sqlSession.update(namespace + "updateQcResult", dto);
	}

	@Override
	public int updateLotByQcResult(QcDTO dto) {
		return sqlSession.update(namespace + "updateLotByQcResult", dto);
	}

	@Override
	public List<QcDTO> selectDefectTypeList() {
		return sqlSession.selectList(namespace + "selectDefectTypeList");
	}

	@Override
	public List<QcDTO> selectWarehouseListByItem(String itemId) {
		return sqlSession.selectList(namespace + "selectWarehouseListByItem", itemId);
	}

	@Override
	public List<QcDTO> selectSectionListByWarehouse(String whId) {
		return sqlSession.selectList(namespace + "selectSectionListByWarehouse", whId);
	}

	@Override
	public int insertDefLog(QcDTO dto) {
		return sqlSession.insert(namespace + "insertDefLog", dto);
	}
	
	@Override
	public List<QcDTO> selectDefLogList(String qcId) {
		return sqlSession.selectList(namespace + "selectDefLogList", qcId);
	}

	@Override
	public int deleteDefLog(String qcId) {
		return sqlSession.delete(namespace + "deleteDefLog", qcId);
	}
	
	@Override
	public int plusStockAvailByQcResult(QcDTO dto) {
		return sqlSession.update(namespace + "plusStockAvailByQcResult", dto);
	}
	
	@Override
	public int plusStockByQcResult(QcDTO dto) {
		return sqlSession.update(namespace + "plusStockByQcResult", dto);
	}

	@Override
	public QcDTO selectLotForQc(String lotId) {
		return sqlSession.selectOne(namespace + "selectLotForQc", lotId);
	}

}
