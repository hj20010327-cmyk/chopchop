package kr.or.chop.P14_warehouse.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;


@Repository
public class WHDAOImpl implements WHDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public int selectWHCount(WHDTO whDTO) {

		System.out.println("/warehouse/list dao.selectWHCount");
		System.out.println("WHDTO : " + whDTO);
		
		return sqlSession.selectOne("mapper.P14_warehouse.selectWHCount", whDTO);
	}
	
	@Override
	public WHDTO selectWhCardCnt(WHDTO whDTO) {
		System.out.println("/warehouse/list dao.selectWhCardCnt");
		
	    return sqlSession.selectOne("mapper.P14_warehouse.selectWhCardCnt", whDTO);
	}
	
	@Override
	public List<WHDTO> selectAllWH(WHDTO whDTO, PageInfo pageInfo) {
		System.out.println("/warehouse/list dao.selectAllWH");
		
	    Map map = new HashMap();
	    map.put("whDTO", whDTO);
	    map.put("page", pageInfo);

	    return sqlSession.selectList("mapper.P14_warehouse.selectAllWH", map);
	}

	@Override
	public WHDTO selectWHDTO(WHDTO whDTO) {
		System.out.println("/warehouse/detail dao.selectWHDTO");
		
		return sqlSession.selectOne("mapper.P14_warehouse.selectWHDTO", whDTO);
	}

	@Override
	public int selectGlogCount(WHDTO whDTO) {
		System.out.println("/warehouse/detail dao.selectGlogCount");

		return sqlSession.selectOne("mapper.P14_warehouse.selectGlogCount", whDTO);
	}

	@Override
	public List<GlogDTO> selectGlogList(WHDTO whDTO, PageInfo pageInfo) {
		System.out.println("/warehouse/detail dao.selectGlogList");

	    Map map = new HashMap();
	    map.put("whDTO", whDTO);
	    map.put("page", pageInfo);

		return sqlSession.selectList("mapper.P14_warehouse.selectGlogList", map);
	}

	@Override
	public List<SecDTO> selectSecList(WHDTO whDTO) {
		System.out.println("/warehouse/detail dao.selectSecList");

		return sqlSession.selectList("mapper.P14_warehouse.selectSecList", whDTO);
	}

	@Override
	public int insertWH(WHDTO whDTO) {
		System.out.println("/warehouse/add dao.insertWH");
		
		return sqlSession.insert("mapper.P14_warehouse.insertWH", whDTO);
	}

	@Override
	public int updateWhImg(WHDTO whDTO) {
		System.out.println("/warehouse/add dao.updateWhImg");
		
	    return sqlSession.update("mapper.P14_warehouse.updateWhImg", whDTO);
	}
	

	@Override
	public int updateWh(WHDTO whDTO) {
		System.out.println("/warehouse/edit dao.updateWh");

		return sqlSession.update("mapper.P14_warehouse.updateWh", whDTO);
	}

	@Override
	public int deleteWh(WHDTO whDTO) {
		System.out.println("/warehouse/delete dao.deleteWh");

		return sqlSession.update("mapper.P14_warehouse.deleteWh", whDTO);
	}


}
