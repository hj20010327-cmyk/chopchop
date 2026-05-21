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
public class RoutEditController {

	@Autowired
	RoutService routService;

	@RequestMapping("/edit")
	public String routEdit(String routId, Model model) {

		RoutDTO rout = routService.selectRoutDetail(routId);
		List<RoutDetailDTO> routDetailList = routService.selectRoutDetailList(routId);
		List<RoutDTO> routItemList = routService.selectRoutItemList();
		List<RoutDetailDTO> wpTypeList = routService.selectWpTypeList();

		model.addAttribute("rout", rout);
		model.addAttribute("routDetailList", routDetailList);
		model.addAttribute("routItemList", routItemList);
		model.addAttribute("wpTypeList", wpTypeList);

		return "P12_rout/routEdit.tiles";
	}

	@RequestMapping("/update")
	public String routUpdate(RoutDTO routDTO, RoutDetailDTO detailDTO) {

		routService.updateRoutWithDetail(routDTO, detailDTO);

		return "redirect:/routing/detail?routId=" + routDTO.getRoutId();
	}

	@RequestMapping("/delete")
	public String routDelete(String routId) {

		routService.deleteRout(routId);

		return "redirect:/routing/list";
	}
}