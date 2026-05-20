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

	/**
	 * 라우팅 수정 페이지
	 */
	@RequestMapping("/edit")
	public String routEdit(String routId, Model model) {

		// 라우팅 기본 정보
		RoutDTO rout = routService.selectRoutDetail(routId);

		// 기존 공정 흐름
		List<RoutDetailDTO> routDetailList = routService.selectRoutDetailList(routId);

		// 반제품 + 완제품 목록
		List<RoutDTO> routItemList = routService.selectRoutItemList();

		// 공정 목록
		List<RoutDetailDTO> processList = routService.selectProcessList();

		model.addAttribute("rout", rout);
		model.addAttribute("routDetailList", routDetailList);
		model.addAttribute("routItemList", routItemList);
		model.addAttribute("processList", processList);

		return "P12_rout/routEdit.tiles";
	}

	/**
	 * 라우팅 수정
	 */
	@RequestMapping("/update")
	public String routUpdate(RoutDTO routDTO, RoutDetailDTO detailDTO) {

		routService.updateRoutWithDetail(routDTO, detailDTO.getRoutDtlProcList());

		return "redirect:/routing/detail?routId=" + routDTO.getRoutId();
	}

	/**
	 * 라우팅 삭제
	 */
	@RequestMapping("/delete")
	public String routDelete(String routId) {

		routService.deleteRout(routId);

		return "redirect:/routing/list";
	}
}