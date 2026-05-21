package kr.or.chop.P12_rout.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.P12_rout.service.RoutService;

@Controller
@RequestMapping("/routing")
public class RoutAddController {

	@Autowired
	RoutService routService;

	@RequestMapping("/add")
	public String routAdd(Model model) {

		List<RoutDTO> routItemList = routService.selectRoutItemList();
		List<RoutDetailDTO> wpTypeList = routService.selectWpTypeList();

		model.addAttribute("routItemList", routItemList);
		model.addAttribute("wpTypeList", wpTypeList);

		return "P12_rout/routAdd.tiles";
	}

	@RequestMapping("/insert")
	public String routInsert(RoutDTO routDTO, RoutDetailDTO detailDTO) {

		routService.insertRoutWithDetail(routDTO, detailDTO);

		return "redirect:/routing/list";
	}
}