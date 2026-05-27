package kr.or.chop.P04_sugg.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class SuggDAOImpl implements SuggDAO {
	@Autowired
	SqlSession sqlSession;

	private final String namespace = "mapper.P04_sugg.";

//	  @Override
//	    public List<SuggDTO> selectSuggList(SuggDTO suggDTO) {
//	        return sqlSession.selectList(namespace + "selectSuggList", suggDTO);
//	    }

	@Override
	public SuggDTO selectSuggDetail(Integer sugg_no) {
		return sqlSession.selectOne(namespace + "selectSuggDetail", sugg_no);
	}

	@Override
	public int insertSugg(SuggDTO dto) {
		return sqlSession.insert(namespace + "insertSugg", dto);
	}

	@Override
	public int updateSugg(SuggDTO dto) {
		return sqlSession.update(namespace + "updateSugg", dto);
	}

	@Override
	public int deleteSugg(int sugg_no) {
		// mapper에서는 <update id="deleteSugg"> 로 작성해야 함
		return sqlSession.update(namespace + "deleteSugg", sugg_no);
	}

	@Override
	public int selectSuggCount(SuggDTO suggDTO) {
		return sqlSession.selectOne(namespace + "selectSuggCount", suggDTO);
	}

	@Override
	public List<SuggDTO> selectSuggList(SuggDTO suggDTO, PageInfo pageInfo) {

		Map<String, Object> param = new HashMap<String, Object>();

		param.put("search", suggDTO);
		param.put("page", pageInfo);

		return sqlSession.selectList(namespace + "selectSuggList", param);
	}

	@Override
	public int updateSuggAnswer(SuggDTO dto) {
		return sqlSession.update(namespace + "updateSuggAnswer", dto);
	}

	@Override
	public int updateSuggView(int sugg_no) {

		// 조회수 증가
		return sqlSession.update(namespace + "updateSuggView", sugg_no);
	}
}
