package kr.or.chop.P19_ghp.dao;

import java.util.List;
import java.util.Map;

import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface GhpDAO {

	List<GhpDTO> selectGhpList(GhpDTO dto, PageInfo pageInfo);
	
	int selectGhpCount(GhpDTO dto);

	GhpDTO selectGhpDetail(String ghpId);

	int insertGhp(GhpDTO dto);

	int updateGhp(GhpDTO dto);

	int deleteGhp(String ghpId);
	
	List<Map<String, Object>> selectTargetList(Map<String, Object> map);
	
}
