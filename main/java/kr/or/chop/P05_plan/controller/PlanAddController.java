package kr.or.chop.P05_plan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P05_plan.service.PlanService;
import kr.or.chop.P10_io.service.IoService;
import kr.or.chop.P11_item.dto.ItemDTO;

@Controller
@RequestMapping("/plan")
public class PlanAddController {
	
	@Autowired
	PlanService planService;
	@Autowired
	IoService ioService;
	
	@RequestMapping("/add")
	public String add () {
		return "P05_plan/planAdd.tiles";
	}
	
	@RequestMapping("/insert")
	public String insert (
			PlanDTO planDTO
		) {
		planService.insertPlan(planDTO);
		return "redirect:/plan/list";
	}
	
	@ResponseBody
	@RequestMapping("/itemList")
	public List<ItemDTO> itemList(String itemType) {

		return ioService.selectItemListByType(itemType);
	}

}
