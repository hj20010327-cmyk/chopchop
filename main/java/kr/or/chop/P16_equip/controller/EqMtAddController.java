package kr.or.chop.P16_equip.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P01_login.dto.EmpDTO;
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
	public String insertMt(EqDTO eqDTO,
	                       HttpSession session) {

	    EmpDTO loginUser =
	            (EmpDTO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        return "redirect:/login";
	    }

	    // 점검자는 로그인 사용자로 고정
	    eqDTO.setElogWorker(loginUser.getEmpId());

	    eqService.insertEqLog(eqDTO);

	    return "redirect:/equip/detail?eqId=" + eqDTO.getElogEqid();
	}
	
	@RequestMapping("/update")
	public String updateMt(EqDTO eqDTO) {

	    eqService.updateEqLog(eqDTO);

	    return "redirect:/equip/detail?eqId=" + eqDTO.getElogEqid();
	}
}