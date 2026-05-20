package kr.or.chop.P16_equip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;

@Controller
@RequestMapping("/equip")
public class EqAddController {

	@Autowired
	EqService eqService;

	@RequestMapping("/add")
	public String eqAddForm(Model model) {

	    List<WPDTO> wpList = eqService.selectWpList();

	    model.addAttribute("wpList", wpList);

	    return "P16_equipment/eqAdd.tiles";
	}

	@RequestMapping("/insert")
	public String insertEq(EqDTO eqDTO) {

		eqService.insertEq(eqDTO);

		return "redirect:/equip/list";
	}

}
