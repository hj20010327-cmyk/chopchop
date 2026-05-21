package kr.or.chop.P05_plan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P05_plan.service.PlanService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/plan")
public class PlanListController {
	
	@Autowired
	PlanService planService;
	
	@RequestMapping("/list")
	public String list (
			Model model,
			PlanDTO planDTO,
			@RequestParam(value="page", defaultValue="1") int currentPage
		) {
		
		// 페이징
		int listCount = planService.selectPlanCount(planDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// 목록 가져오기
		List<PlanDTO> planList = planService.selectAllPlan(planDTO, pageInfo);
		
		// 카드 가져오기
		PlanDTO planCard = planService.selectPlanCardCnt(planDTO);
		
		model.addAttribute("page", pageInfo);
		model.addAttribute("planList", planList);
		model.addAttribute("planCard", planCard);
		model.addAttribute("search", planDTO);
		
		return "P05_plan/planList.tiles";
	}

}
