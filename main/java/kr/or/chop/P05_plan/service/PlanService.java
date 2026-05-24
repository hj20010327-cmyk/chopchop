package kr.or.chop.P05_plan.service;

import java.util.List;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface PlanService {
	
	public int selectPlanCount(PlanDTO planDTO);
	public List<PlanDTO> selectAllPlan(PlanDTO planDTO, PageInfo pageInfo);
	public PlanDTO selectPlanCardCnt(PlanDTO planDTO);
	
	public int insertPlan(PlanDTO planDTO);
	
	public PlanDTO selectPlanDetail(PlanDTO planDTO);
	public List<WorkDTO> selectWorkList(PlanDTO planDTO);
	
	public int updatePlan(PlanDTO planDTO);
	
	public int deletePlan(PlanDTO planDTO);

}
