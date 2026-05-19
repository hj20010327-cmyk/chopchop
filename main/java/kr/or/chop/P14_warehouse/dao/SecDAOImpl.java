package kr.or.chop.P14_warehouse.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class SecDAOImpl implements SecDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public SecDTO selectSecDTO(SecDTO secDTO) {
		return sqlSession.selectOne("mapper.P14_warehouse.section.selectSecDTO", secDTO);
	}

	@Override
	public int selectLotCount(SecDTO secDTO) {
		return sqlSession.selectOne("mapper.P14_warehouse.section.selectLotCount", secDTO);
	}

	@Override
	public List<LotDTO> selectLotList(SecDTO secDTO, PageInfo pageInfo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("secDTO", secDTO);
		paramMap.put("page", pageInfo);

		System.out.println("paramMap : " + paramMap);
		
		return sqlSession.selectList("mapper.P14_warehouse.section.selectLotList", paramMap);
	}

}
