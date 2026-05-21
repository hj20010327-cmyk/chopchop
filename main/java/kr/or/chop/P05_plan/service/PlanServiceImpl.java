package kr.or.chop.P05_plan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P05_plan.dao.PlanDAO;
import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class PlanServiceImpl implements PlanService {
	
	@Autowired
	PlanDAO planDAO;

	@Override
	public int selectPlanCount(PlanDTO planDTO) {
		return planDAO.selectPlanCount(planDTO);
	}

	@Override
	public List<PlanDTO> selectAllPlan(PlanDTO planDTO, PageInfo pageInfo) {
		return planDAO.selectAllPlan(planDTO, pageInfo);
	}

	@Override
	public PlanDTO selectPlanCardCnt(PlanDTO planDTO) {
		return planDAO.selectPlanCardCnt(planDTO);
	}

}
