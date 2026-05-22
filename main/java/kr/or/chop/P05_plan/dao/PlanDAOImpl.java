package kr.or.chop.P05_plan.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class PlanDAOImpl implements PlanDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public int selectPlanCount(PlanDTO planDTO) {
		return sqlSession.selectOne("mapper.P05_plan.selectPlanCount", planDTO);
	}

	@Override
	public List<PlanDTO> selectAllPlan(PlanDTO planDTO, PageInfo pageInfo) {
		Map map = new HashMap();
		
		map.put("page", pageInfo);
		map.put("planDTO", planDTO);
		
		return sqlSession.selectList("mapper.P05_plan.selectAllPlan", map);
	}

	@Override
	public PlanDTO selectPlanCardCnt(PlanDTO planDTO) {
		return sqlSession.selectOne("mapper.P05_plan.selectPlanCardCnt", planDTO);
	}

}
