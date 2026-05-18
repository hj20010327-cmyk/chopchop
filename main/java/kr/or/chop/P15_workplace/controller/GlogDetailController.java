package kr.or.chop.P15_workplace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.GlogService;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/workplace/glog")
public class GlogDetailController {

	@Autowired
	GlogService glogService;

	@RequestMapping("/detail")
	public String detail(
			Model model,
			GlogDTO glogDTO,
			@RequestParam(value="glogId") String glogId
		) {
		System.out.println("/workplace/glog/detail controller.detail");
		
		glogDTO.setGlogId(glogId);
		
		// glogDTO 가져오기
		glogDTO = glogService.selectGlog(glogDTO);
		
		model.addAttribute("glog", glogDTO);
//		model.addAttribute("page", pageInfo);
//		model.addAttribute("glogList", glogList);
		
		return "P15_workplace/glogDetail.tiles";
	}
	
	@RequestMapping("/delete")
	public String delete(
			@RequestParam(value="glogId") String glogId,
			@RequestParam(value="wpId") String wpId,
			GlogDTO glogDTO
			) {
		System.out.println("/workplace/glog/detail controller.delete");
		
		glogDTO.setGlogId(glogId);
		
		glogService.deleteGlog(glogDTO);
		
		return "redirect:/workplace/detail?wpId=" + wpId;
	}
}
