package kr.or.chop.P05_plan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P05_plan.service.PlanService;
import kr.or.chop.P06_work.dto.WorkDTO;

@Controller
@RequestMapping("/plan")
public class PlanDetailController {
	
	@Autowired
	PlanService planService;
	
	@RequestMapping("/detail")
	public String detail(
			Model model,
			@RequestParam("planId") String planId,
			PlanDTO planDTO
		) {
		
		planDTO.setPlanId(planId);
		planDTO = planService.selectPlanDetail(planDTO);
		
		List<WorkDTO> woList = planService.selectWorkList(planDTO);
		
		model.addAttribute("planDTO", planDTO);
		model.addAttribute("woList", woList);
		
		return "P05_plan/planDetail.tiles";
	}
	
	@RequestMapping("/edit")
	public String edit (
			Model model,
			@RequestParam("planId") String planId,
			PlanDTO planDTO
		) {
		
		planDTO.setPlanId(planId);
		planDTO = planService.selectPlanDetail(planDTO);
		
		model.addAttribute("planDTO", planDTO);
		
		return "P05_plan/planEdit.tiles";
	}
	
	@RequestMapping("/update")
	public String update (
			PlanDTO planDTO
		) {
		planService.updatePlan(planDTO);
		
		return "redirect:/plan/detail?planId=" + planDTO.getPlanId();
	}
	
	@RequestMapping("/delete")
	public String delete (
			@RequestParam("planId") String planId
		) {
		PlanDTO planDTO = new PlanDTO();
		
		planDTO.setPlanId(planId);
		
		planService.deletePlan(planDTO);
		
		return "redirect:/plan/list";
	}

}