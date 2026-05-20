package kr.or.chop.P09_lot.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P09_lot.dto.UseDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class LotDAOImpl implements LotDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<LotDTO> selectAllLot(LotDTO lotDTO, PageInfo pageInfo) {
	
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("searchType", lotDTO.getSearchType());
		paramMap.put("searchKeyword", lotDTO.getSearchKeyword());
		paramMap.put("lotStatus", lotDTO.getLotStatus());
	    paramMap.put("lotMfd", lotDTO.getLotMfd());
	    paramMap.put("lotExp", lotDTO.getLotExp());
		paramMap.put("page", pageInfo);
		
		
		return sqlSession.selectList("mapper.P09_lot.selectlotList", paramMap);
	}
	
	@Override
	public int selectLotCount(LotDTO lotDTO) {
		return sqlSession.selectOne("mapper.P09_lot.selectLotCount", lotDTO);
	}
	
	@Override
	public LotDTO selectLotDetail(String lotId) {
	    return sqlSession.selectOne("mapper.P09_lot.selectLotDetail", lotId);
	}
	
	@Override
	public List<UseDTO> selectLotUseList(String lotId) {

		return sqlSession.selectList(
			"mapper.P09_lot.selectLotUseList",
			lotId
		);
	}

	@Override
	public List<UseDTO> selectLotIoList(String lotId) {

		return sqlSession.selectList(
			"mapper.P09_lot.selectLotIoList",
			lotId
		);
	}

}
