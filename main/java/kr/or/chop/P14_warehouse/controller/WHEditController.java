package kr.or.chop.P14_warehouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.service.WHService;

@Controller
@RequestMapping("/warehouse")
public class WHEditController {
	
	@Autowired
	WHService whService;
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(
			Model model,
			WHDTO whDTO,
			@RequestParam String whId
	) {
		System.out.println("/warehouse/edit controller.edit");
		
		whDTO.setWhId(whId);
		
		// 1. 창고 기본정보 조회
		WHDTO result = whService.selectWhDTO(whDTO);
		
		// 2. 해당 창고의 섹션 목록 조회
		List<SecDTO> secList = whService.selectSecList(result);
		
		model.addAttribute("whDTO", result);
		model.addAttribute("secList", secList);

		return "P14_warehouse/whEdit.tiles";
	}
	
	@PostMapping("/update")
	public String update(
			WHDTO whDTO,
			@RequestParam("sectionPayload") String sectionPayload,
			@RequestParam(value = "deleteSecIds", required = false) String deleteSecIds
	) throws Exception {
		
		System.out.println("/warehouse/edit controller.update");
		System.out.println("whId : " + whDTO.getWhId());
		System.out.println("sectionPayload : " + sectionPayload);
		System.out.println("deleteSecIds : " + deleteSecIds);
		
		whService.updateWHWithSections(whDTO, sectionPayload, deleteSecIds);
		
		return "redirect:/warehouse/detail?whId=" + whDTO.getWhId();
	}
}