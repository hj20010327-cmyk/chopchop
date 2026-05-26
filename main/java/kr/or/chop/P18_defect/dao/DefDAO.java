package kr.or.chop.P18_defect.dao;

import java.util.List;

import kr.or.chop.P18_defect.dto.DefDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface DefDAO {

	List<DefDTO> selectAllDef(DefDTO defDTO, PageInfo pageInfo);
	int selectDefCount(DefDTO defDTO);
	
	DefDTO selectDefDetail(String defTypeId);
	
	int insertDef(DefDTO defDTO);
	
	int updateDefect(DefDTO defDTO);
	
	int deleteDefect(String defTypeId);
	
	// 상세 - 추가
	int selectDefHistoryCount(String defTypeId);
	int selectDefTotalCnt(String defTypeId);
	List<DefDTO> selectDefTrend(String defTypeId);
	List<DefDTO> selectDefHistory(String defTypeId, PageInfo pageInfo);
}
