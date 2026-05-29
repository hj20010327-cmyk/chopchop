package kr.or.chop.P16_equip.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class EqDAOImpl implements EqDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<EqDTO> selectEqList(EqDTO eqDTO, PageInfo pageInfo) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("eqWpid", eqDTO.getEqWpid());
		paramMap.put("eqStatus", eqDTO.getEqStatus());
		paramMap.put("eqStatusList", eqDTO.getEqStatusList());
		paramMap.put("searchKeyword", eqDTO.getSearchKeyword());
		paramMap.put("page", pageInfo);

		return sqlSession.selectList("mapper.P16_equipment.selectEqList", paramMap);
	}

	@Override
	public int selectEqTotalCount(EqDTO eqDTO) {

	    Map<String, Object> paramMap = new HashMap<String, Object>();

	    paramMap.put("eqWpid", eqDTO.getEqWpid());
	    paramMap.put("eqStatus", eqDTO.getEqStatus());
	    paramMap.put("eqStatusList", eqDTO.getEqStatusList());
	    paramMap.put("searchKeyword", eqDTO.getSearchKeyword());

	    return sqlSession.selectOne(
	            "mapper.P16_equipment.selectEqTotalCount",
	            paramMap
	    );
	}

	@Override
	public int selectEqCountByStatus(int eqStatus) {
		return sqlSession.selectOne("mapper.P16_equipment.selectEqCountByStatus", eqStatus);
	}

	@Override
	public EqDTO selectEqDetail(String eqId) {
		return sqlSession.selectOne("mapper.P16_equipment.selectEqDetail", eqId);
	}

	@Override
	public int selectEqLogCount(String eqId) {
	    return sqlSession.selectOne(
	            "mapper.P16_equipment.selectEqLogCount",
	            eqId
	    );
	}

	@Override
	public int selectEqRunCount(String eqId) {
	    return sqlSession.selectOne(
	            "mapper.P16_equipment.selectEqRunCount",
	            eqId
	    );
	}

	@Override
	public List<EqDTO> selectEqLogList(String eqId, PageInfo pageInfo) {

	    Map<String, Object> paramMap =
	            new HashMap<String, Object>();

	    paramMap.put("eqId", eqId);
	    paramMap.put("page", pageInfo);

	    return sqlSession.selectList(
	            "mapper.P16_equipment.selectEqLogList",
	            paramMap
	    );
	}

	@Override
	public List<EqDTO> selectEqRunList(String eqId, PageInfo pageInfo) {

	    Map<String, Object> paramMap =
	            new HashMap<String, Object>();

	    paramMap.put("eqId", eqId);
	    paramMap.put("page", pageInfo);

	    return sqlSession.selectList(
	            "mapper.P16_equipment.selectEqRunList",
	            paramMap
	    );
	}

	@Override
	public void insertEq(EqDTO eqDTO) {

		sqlSession.insert("mapper.P16_equipment.insertEq", eqDTO);
	}

	@Override
	public void updateEq(EqDTO eqDTO) {
		sqlSession.update("mapper.P16_equipment.updateEq", eqDTO);
	}

	@Override
	public List<WPDTO> selectWpList() {
		return sqlSession.selectList("mapper.P16_equipment.selectWpList");
	}

	@Override
	public List<Map<String, Object>> selectEqManagerList(String keyword) {
		return sqlSession.selectList("mapper.P16_equipment.selectEqManagerList", keyword);
	}

	@Override
	public List<Map<String, Object>> selectEqVendorList(String keyword) {
		return sqlSession.selectList("mapper.P16_equipment.selectEqVendorList", keyword);
	}

	@Override
	public void updateEqStatus(EqDTO eqDTO) {
		sqlSession.update("mapper.P16_equipment.updateEqStatus", eqDTO);
	}

	@Override
	public void insertEqLog(EqDTO eqDTO) {
		sqlSession.insert("mapper.P16_equipment.insertEqLog", eqDTO);
	}

	@Override
	public List<WPDTO> selectWpListByType(int wpType) {
		return sqlSession.selectList("mapper.P16_equipment.selectWpListByType", wpType);
	}

	@Override
	public void deleteEq(String eqId) {
		sqlSession.update("mapper.P16_equipment.deleteEq", eqId);
	}
	
	@Override
	public void insertEqRunLog(String eqId) {
	    sqlSession.insert("mapper.P16_equipment.insertEqRunLog", eqId);
	}

	@Override
	public void updateEqRunLogStop(EqDTO eqDTO) {
	    sqlSession.update("mapper.P16_equipment.updateEqRunLogStop", eqDTO);
	}
	
	@Override
	public void updateEqLog(EqDTO eqDTO) {
	    sqlSession.update("mapper.P16_equipment.updateEqLog", eqDTO);
	}

}
