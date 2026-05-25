package kr.or.chop.P06_work.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.service.WorkService;

@Controller
@RequestMapping("/work/result")
public class WorkResultController {
	
	@Autowired
	WorkService workService;
	
	@RequestMapping("/edit")
	public String resultEdit(
			Model model,
			@RequestParam (value="workId", required=true) String workId,
			WorkDTO workDTO
		) {
		
		workDTO.setWorkId(workId);
		workDTO = workService.selectWorkModify(workDTO);
		
		model.addAttribute("workDTO", workDTO);
		
		return "P06_work/workResultEdit.tiles";
	}
	
	@RequestMapping("/update")
	public String resultUpdate(
			@RequestParam (value="workId", required=true) String workId,
			WorkDTO workDTO
		) {
		workDTO.setWorkId(workId);
		workService.updateWorkResult(workDTO);
		
		return "redirect:/work/detail?workId=" + workDTO.getWorkId();
	}

}
