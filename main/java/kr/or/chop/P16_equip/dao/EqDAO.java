package kr.or.chop.P16_equip.dao;

import java.util.List;
import java.util.Map;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface EqDAO {

	List<EqDTO> selectEqList(EqDTO eqDTO, PageInfo pageInfo);

	int selectEqTotalCount(EqDTO eqDTO);

	int selectEqCountByStatus(int eqStatus);
	
	EqDTO selectEqDetail(String eqId);

	int selectEqLogCount(String eqId);

	int selectEqRunCount(String eqId);

	List<EqDTO> selectEqLogList(String eqId, PageInfo pageInfo);

	List<EqDTO> selectEqRunList(String eqId, PageInfo pageInfo);
	
	void insertEq(EqDTO eqDTO);
	
	void updateEq(EqDTO eqDTO);
	
	void updateEqStatus(EqDTO eqDTO);
	
	void insertEqLog(EqDTO eqDTO);
	
	List<WPDTO> selectWpList();
	
	List<Map<String, Object>> selectEqManagerList(String keyword);
	
	List<Map<String, Object>> selectEqVendorList(String keyword);
	
	List<WPDTO> selectWpListByType(int wpType);
	
	void deleteEq(String eqId);
	
	void insertEqRunLog(String eqId);

	void updateEqRunLogStop(EqDTO eqDTO);
	
	void updateEqLog(EqDTO eqDTO);
	
	void deleteEqLog(String elogId);
	
	void updateEqRunReason(EqDTO eqDTO);
	
	

}
