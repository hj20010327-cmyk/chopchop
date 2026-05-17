package kr.or.chop.P15_workplace.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.WPService;

@Controller
@RequestMapping("/workplace")
public class WPEditController {

	@Autowired
	WPService wpService;
	
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String add (
			Model model,
			WPDTO wpDTO,
			@RequestParam String wpId
			) {
		System.out.println("/workplace/edit controller.edit");
		
		wpDTO.setWpId(wpId);
		wpDTO = wpService.selectWpDTO(wpDTO);
		
		model.addAttribute("wpDTO", wpDTO);

		return "P15_workplace/wpEdit.tiles";
	}
	
}
