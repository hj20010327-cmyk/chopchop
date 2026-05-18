package kr.or.chop.P15_workplace.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class WPDAOImpl implements WPDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int selectWPCount(WPDTO wpDTO) {

		System.out.println("/workplace/list dao.selectWPCount");
		System.out.println("wpDTO : " + wpDTO);
		
		return sqlSession.selectOne("mapper.P15_workplace.selectWPCount", wpDTO);
	}

	@Override
	public List<WPDTO> selectAllWP(WPDTO wpDTO, PageInfo pageInfo) {
		
		System.out.println("/workplace/list dao.selectAllWP");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("wpDTO", wpDTO);
		paramMap.put("page", pageInfo);

		System.out.println("paramMap : " + paramMap);
		
		return sqlSession.selectList("mapper.P15_workplace.selectAllWP", paramMap);
	}

	@Override
	public WPDTO selectWPDTO(WPDTO wpDTO) {
		System.out.println("/workplace/detail dao.selectWPDTO");
		
		return sqlSession.selectOne("mapper.P15_workplace.selectWPDTO", wpDTO);
	}
	
	@Override
	public int selectGlogCount(WPDTO wpDTO) {
		System.out.println("/workplace/detail dao.selectGlogCount");

		return sqlSession.selectOne("mapper.P15_workplace.selectGlogCount", wpDTO);
	}

	@Override
	public List<GlogDTO> selectGlogList(WPDTO wpDTO) {
		System.out.println("/workplace/detail dao.selectGlogList");
		
		return sqlSession.selectOne("mapper.P15_workplace.selectGlogList", wpDTO);
	}

	@Override
	public int insertWP(WPDTO wpDTO) {
		System.out.println("/workplace/add dao.insertWP");
		
		return sqlSession.insert("mapper.P15_workplace.insertWP", wpDTO);
	}
	
	@Override
	public int updateWpImg(WPDTO wpDTO) {
		System.out.println("/workplace/add dao.updateWpImg");
		
	    return sqlSession.update("mapper.P15_workplace.updateWpImg", wpDTO);
	}

	@Override
	public int updateWp(WPDTO wpDTO) {
		System.out.println("/workplace/edit dao.updateWP");

		return sqlSession.update("mapper.P15_workplace.updateWp", wpDTO);
	}

	@Override
	public int deleteWp(WPDTO wpDTO) {
		System.out.println("/workplace/delete dao.deleteWp");

		return sqlSession.update("mapper.P15_workplace.deleteWp", wpDTO);
	}

}
