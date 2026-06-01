package kr.or.chop.P16_equip.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;

@Controller
@RequestMapping("/equip")
public class EqAddController {

	@Autowired
	EqService eqService;

	@RequestMapping("/add")
	public String eqAddForm(Model model,
	                        HttpSession session) {

		EmpDTO loginUser =
				(EmpDTO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/login";
		}

		if (loginUser.getEmpAuth() < 20) {
			return "redirect:/equip/list";
		}

	    List<WPDTO> wpList = eqService.selectWpList();

	    model.addAttribute("wpList", wpList);

	    return "P16_equipment/eqAdd.tiles";
	}

	@RequestMapping("/insert")
	public String insertEq(EqDTO eqDTO,
	                       HttpSession session) {

		EmpDTO loginUser =
				(EmpDTO) session.getAttribute("loginUser");

		if (loginUser == null) {
			return "redirect:/login";
		}

		if (loginUser.getEmpAuth() < 20) {
			return "redirect:/equip/list";
		}

		eqService.insertEq(eqDTO);

		return "redirect:/equip/list";
	}
	
	@ResponseBody
	@RequestMapping("/managerList")
	public List<Map<String, Object>> managerList(String keyword) {
		return eqService.selectEqManagerList(keyword);
	}

	@ResponseBody
	@RequestMapping("/vendorList")
	public List<Map<String, Object>> vendorList(String keyword) {
		return eqService.selectEqVendorList(keyword);
	}
	
	@ResponseBody
	@RequestMapping("/wpList")
	public List<WPDTO> wpList(int wpType) {

		return eqService.selectWpListByType(wpType);
	}

}