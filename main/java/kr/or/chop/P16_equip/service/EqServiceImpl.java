package kr.or.chop.P16_equip.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dao.EqDAO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class EqServiceImpl implements EqService {

	@Autowired
	EqDAO eqDAO;

	@Override
	public List<EqDTO> selectEqList(EqDTO eqDTO, PageInfo pageInfo) {
		return eqDAO.selectEqList(eqDTO, pageInfo);
	}

	@Override
	public int selectEqTotalCount(EqDTO eqDTO) {
	    return eqDAO.selectEqTotalCount(eqDTO);
	}

	@Override
	public int selectEqCountByStatus(int eqStatus) {
		return eqDAO.selectEqCountByStatus(eqStatus);
	}

	@Override
	public EqDTO selectEqDetail(String eqId) {
		return eqDAO.selectEqDetail(eqId);
	}

	@Override
	public List<EqDTO> selectEqLogList(String eqId) {
		return eqDAO.selectEqLogList(eqId);
	}

	@Override
	public List<EqDTO> selectEqRunList(String eqId) {
		return eqDAO.selectEqRunList(eqId);
	}

	@Override
	public void insertEq(EqDTO eqDTO) {
		eqDAO.insertEq(eqDTO);
	}

	@Override
	public void updateEq(EqDTO eqDTO) {
		eqDAO.updateEq(eqDTO);
	}

	@Override
	public List<WPDTO> selectWpList() {
		return eqDAO.selectWpList();
	}

	@Override
	public List<Map<String, Object>> selectEqManagerList(String keyword) {
		return eqDAO.selectEqManagerList(keyword);
	}

	@Override
	public List<Map<String, Object>> selectEqVendorList(String keyword) {
		return eqDAO.selectEqVendorList(keyword);
	}

	@Override
	public void updateEqStatus(EqDTO eqDTO) {
		eqDAO.updateEqStatus(eqDTO);
	}

	@Override
	public void insertEqLog(EqDTO eqDTO) {
		eqDAO.insertEqLog(eqDTO);
	}

	@Override
	public List<WPDTO> selectWpListByType(int wpType) {
		return eqDAO.selectWpListByType(wpType);
	}

	@Override
	public void deleteEq(String eqId) {
		eqDAO.deleteEq(eqId);
	}
	
	@Override
	public void insertEqRunLog(String eqId) {
	    eqDAO.insertEqRunLog(eqId);
	}

	@Override
	public void updateEqRunLogStop(EqDTO eqDTO) {
	    eqDAO.updateEqRunLogStop(eqDTO);
	}

}
