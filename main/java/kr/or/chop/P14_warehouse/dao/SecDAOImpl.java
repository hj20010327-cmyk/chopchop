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

	@Override
	public int minusWhQty(SecDTO secDTO) {
		return sqlSession.update("mapper.P14_warehouse.section.minusWhQty", secDTO);
	}

	@Override
	public int deleteSection(SecDTO secDTO) {
		return sqlSession.update("mapper.P14_warehouse.section.deleteSection", secDTO);
	}

	@Override
	public int insertSection(SecDTO secDTO) {
		return sqlSession.insert("mapper.P14_warehouse.section.insertSection", secDTO);		
	}

	@Override
	public int plusWhQty(SecDTO secDTO) {
		return sqlSession.update("mapper.P14_warehouse.section.plusWhQty", secDTO);
	}

//	@Override
//	public int updateSecImg(SecDTO secDTO) {
//		return sqlSession.update("mapper.P14_warehouse.section.updateSecImg", secDTO);
//	}
	
	@Override
	public int updateSecQty(SecDTO secDTO) {
		return sqlSession.update("mapper.P14_warehouse.section.updateSecQty", secDTO);
	}

	@Override
	public int updateSecOrder(SecDTO secDTO) {
		return sqlSession.update("mapper.P14_warehouse.section.updateSecOrder", secDTO);
	}

}
