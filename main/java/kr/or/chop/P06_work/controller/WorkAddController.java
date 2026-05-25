package kr.or.chop.P06_work.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkAddController {

	@Autowired
	WorkService workService;
	
	@RequestMapping("/order/add")
	public String add() {
		return "P06_work/workAdd.tiles";
	}

	@GetMapping("/planList")
	@ResponseBody
	public List<PlanDTO> planList() {
		return workService.selectWorkPlanList();
	}

	@GetMapping("/workerList")
	@ResponseBody
	public List<WorkDTO> workerList(WorkDTO workDTO) {
		return workService.selectWorkerList(workDTO);
	}

	@RequestMapping("/order/insert")
	public String insert(
			WorkDTO workDTO,
			RedirectAttributes rttr
		) {
		
		System.out.println("workPlan = " + workDTO.getWorkPlan());
	    System.out.println("workOrderQty = " + workDTO.getWorkOrderQty());
	    System.out.println("workDate = " + workDTO.getWorkDate());
	    System.out.println("workDirector = " + workDTO.getWorkDirector());
	    System.out.println("workWorker = " + workDTO.getWorkWorker());
	    System.out.println("workDmsg = " + workDTO.getWorkDmsg());
		
		int result = workService.insertWork(workDTO);

		return "redirect:/work/list";
	}
	
	
	/* ======================= */
	
	
	@RequestMapping("/order/edit")
	public String orderEdit(
			WorkDTO workDTO,
			@RequestParam(value="workId", required=true) String workId,
			Model model
		) {
		
		workDTO.setWorkId(workId);
		workDTO = workService.selectWorkModify(workDTO);
		
		model.addAttribute("workDTO", workDTO);
		
		return "P06_work/workOrderEdit.tiles";
	}
	
	@RequestMapping("/order/update")
	public String orderUpdate(
			@RequestParam String workId,
			WorkDTO workDTO,
			Model model
			) {
		
		System.out.println(workDTO);
		
		workService.updateWork(workDTO);
		
		return "redirect:/work/detail?workId=" + workDTO.getWorkId();
	}
}