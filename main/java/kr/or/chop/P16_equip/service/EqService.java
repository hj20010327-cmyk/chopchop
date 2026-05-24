package kr.or.chop.P16_equip.service;

import java.util.List;
import java.util.Map;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface EqService {

	List<EqDTO> selectEqList(EqDTO eqDTO, PageInfo pageInfo);

	int selectEqTotalCount(EqDTO eqDTO);

	int selectEqCountByStatus(int eqStatus);

	EqDTO selectEqDetail(String eqId);

	List<EqDTO> selectEqLogList(String eqId);

	List<EqDTO> selectEqRunList(String eqId);
	
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
}

