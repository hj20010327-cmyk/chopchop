package kr.or.chop.P19_ghp.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P19_ghp.dao.GhpDAO;
import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class GhpServiceImpl implements GhpService {

	@Autowired
	private GhpDAO ghpDAO;

	@Override
	public List<GhpDTO> selectGhpList(GhpDTO dto, PageInfo pageInfo) {
		return ghpDAO.selectGhpList(dto, pageInfo);
	}
	
	@Override
	public int selectGhpCount(GhpDTO dto) {
		return ghpDAO.selectGhpCount(dto);
	}

	@Override
	public GhpDTO selectGhpDetail(String ghpId) {
		return ghpDAO.selectGhpDetail(ghpId);
	}

	@Override
	public int insertGhp(GhpDTO dto) {
		setTargetType(dto);
		return ghpDAO.insertGhp(dto);
	}

	@Override
	public int updateGhp(GhpDTO dto) {
		setTargetType(dto);
		return ghpDAO.updateGhp(dto);
	}

	@Override
	public int deleteGhp(String ghpId) {
		return ghpDAO.deleteGhp(ghpId);
	}

	private void setTargetType(GhpDTO dto) {

		if ("WH".equals(dto.getTargetType())) {
			dto.setGhpWpType(0);
		} else if ("WP".equals(dto.getTargetType())) {
			dto.setGhpWhType(0);
		} else {
			dto.setGhpWhType(0);
			dto.setGhpWpType(0);
		}
	}
	
	@Override
	public List<Map<String, Object>> selectTargetList(String targetType, String keyword) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("targetType", targetType);
		map.put("keyword", keyword);

		return ghpDAO.selectTargetList(map);
	}
	
}
