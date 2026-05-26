package kr.or.chop.P18_defect.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P18_defect.dto.DefDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class DefDAOImpl implements DefDAO{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<DefDTO> selectAllDef(DefDTO defDTO, PageInfo pageInfo) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("defDTO", defDTO);
		paramMap.put("page", pageInfo);
		System.out.println(paramMap);
		
		return sqlSession.selectList("mapper.P18_defect.selectDefList", paramMap);
	}

	@Override
	public int selectDefCount(DefDTO defDTO) {

		return sqlSession.selectOne("mapper.P18_defect.selectDefCount", defDTO);
	}
	
	@Override
	public DefDTO selectDefDetail(String defTypeId) {
	    return sqlSession.selectOne("mapper.P18_defect.selectDefDetail", defTypeId);
	}

	@Override
	public int insertDef(DefDTO defDTO) {
		return sqlSession.insert("mapper.P18_defect.insertDef", defDTO);
	}
	
	@Override
	public int updateDefect(DefDTO defDTO) {
	    return sqlSession.update("mapper.P18_defect.updateDefect", defDTO);
	}
	
	@Override
	public int deleteDefect(String defTypeId) {
	    return sqlSession.update("mapper.P18_defect.deleteDefect", defTypeId);
	}


	@Override
	public int selectDefHistoryCount(String defTypeId) {
		return sqlSession.selectOne("mapper.P18_defect.selectDefHistoryCount", defTypeId);
	}

	@Override
	public int selectDefTotalCnt(String defTypeId) {
		return sqlSession.selectOne("mapper.P18_defect.selectDefTotalCnt", defTypeId);
	}

	@Override
	public List<DefDTO> selectDefTrend(String defTypeId) {
		return sqlSession.selectList("mapper.P18_defect.selectDefTrend", defTypeId);
	}

	@Override
	public List<DefDTO> selectDefHistory(String defTypeId, PageInfo pageInfo) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("defTypeId", defTypeId);
		paramMap.put("page", pageInfo);
		
		return sqlSession.selectList("mapper.P18_defect.selectDefHistory", paramMap);
	}
	
}
