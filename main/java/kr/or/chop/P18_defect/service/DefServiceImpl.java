package kr.or.chop.P18_defect.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P18_defect.dao.DefDAO;
import kr.or.chop.P18_defect.dto.DefDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class DefServiceImpl implements DefService {

	@Autowired
	DefDAO defDAO;

	@Override
	public List<DefDTO> defSelectAll(DefDTO defDTO, PageInfo pageInfo) {

		return defDAO.selectAllDef(defDTO, pageInfo);
	}

	@Override
	public int selectDefCount(DefDTO defDTO) {

		return defDAO.selectDefCount(defDTO);
	}
	
	@Override
	public DefDTO selectDefDetail(String defTypeId) {
	    return defDAO.selectDefDetail(defTypeId);
	}

	@Override
	public int insertDef(DefDTO defDTO) {
		return defDAO.insertDef(defDTO);
	}
	
	@Override
	public int updateDefect(DefDTO defDTO) {
	    return defDAO.updateDefect(defDTO);
	}

	@Override
	public int deleteDefect(String defTypeId) {
	    return defDAO.deleteDefect(defTypeId);
	}
	
	@Override
	public int selectDefHistoryCount(String defTypeId) {
		return defDAO.selectDefHistoryCount(defTypeId);
	}

	@Override
	public int selectDefTotalCnt(String defTypeId) {
		return defDAO.selectDefTotalCnt(defTypeId);
	}

	@Override
	public List<DefDTO> selectDefTrend(String defTypeId) {
		return defDAO.selectDefTrend(defTypeId);
	}

	@Override
	public List<DefDTO> selectDefHistory(String defTypeId, PageInfo pageInfo) {
		return defDAO.selectDefHistory(defTypeId, pageInfo);
	}
}
