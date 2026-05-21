package kr.or.chop.P16_equip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;

@Controller
@RequestMapping("/equip/mt")
public class EqMtAddController {

	@Autowired
	EqService eqService;

	@RequestMapping("/add")
	public String addForm(String eqId, Model model) {

		EqDTO eqp = eqService.selectEqDetail(eqId);

		model.addAttribute("eqp", eqp);

		return "P16_equipment/eqMtAdd.tiles";
	}

	@RequestMapping("/insert")
	public String insertMt(EqDTO eqDTO) {

		eqService.insertEqLog(eqDTO);

		return "redirect:/equip/mt/list?eqId=" + eqDTO.getElogEqid();
	}
}