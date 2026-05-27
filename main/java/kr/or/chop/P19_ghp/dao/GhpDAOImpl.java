package kr.or.chop.P19_ghp.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class GhpDAOImpl implements GhpDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private final String namespace = "kr.or.chop.P19_ghp.";

	@Override
	public List<GhpDTO> selectGhpList(GhpDTO dto, PageInfo pageInfo) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		paramMap.put("ghpCategorySearch", dto.getGhpCategorySearch());
		paramMap.put("searchKeyword", dto.getSearchKeyword());
		paramMap.put("page", pageInfo);
		
		return sqlSession.selectList(namespace + "selectGhpList", paramMap);
	}
	
	@Override
	public int selectGhpCount(GhpDTO dto) {
		return sqlSession.selectOne(namespace + "selectGhpCount", dto);
	}

	@Override
	public GhpDTO selectGhpDetail(String ghpId) {
		return sqlSession.selectOne(namespace + "selectGhpDetail", ghpId);
	}

	@Override
	public int insertGhp(GhpDTO dto) {
		return sqlSession.insert(namespace + "insertGhp", dto);
	}

	@Override
	public int updateGhp(GhpDTO dto) {
		return sqlSession.update(namespace + "updateGhp", dto);
	}

	@Override
	public int deleteGhp(String ghpId) {
		return sqlSession.update(namespace + "deleteGhp", ghpId);
	}
	
	@Override
	public List<Map<String, Object>> selectTargetList(Map<String, Object> map) {
		return sqlSession.selectList(namespace + "selectTargetList", map);
	}
	
}
