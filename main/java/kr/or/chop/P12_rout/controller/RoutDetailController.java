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
public class RoutDetailController {

	@Autowired
	RoutService routService;

	@RequestMapping("/detail")
	public String routDetail(String routId, Model model) {

		RoutDTO rout = routService.selectRoutDetail(routId);
		List<RoutDetailDTO> routDetailList = routService.selectRoutDetailList(routId);

		model.addAttribute("rout", rout);
		model.addAttribute("routDetailList", routDetailList);

		return "P12_rout/routDetail.tiles";
	}
}