package kr.or.chop.P15_workplace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.WPService;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/workplace")
public class WPDetailController {

	@Autowired
	WPService wpService;
	
	@RequestMapping("/detail")
	public String detail(
			Model model,
			WPDTO wpDTO,
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="wpId") String wpId
		) {
		System.out.println("/workplace/detail controller.detail");
		
		wpDTO.setWpId(wpId);
		
		// wpDTO 가져오기
		wpDTO = wpService.selectWpDTO(wpDTO);
		

		// 개수 가져와서 페이징
		int listCount = wpService.selectGlogCount(wpDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// glog 가져오기
		List<GlogDTO> glogList = wpService.selectGlogList(wpDTO, pageInfo);
		
		model.addAttribute("wpDTO", wpDTO);
		model.addAttribute("page", pageInfo);
		model.addAttribute("glogList", glogList);
		
		return "P15_workplace/wpDetail.tiles";
	}
	
	@RequestMapping("/delete")
	public String delete(
			WPDTO wpDTO,
			@RequestParam(value="wpId") String wpId
			) {
		System.out.println("/workplace/delete controller.delete");
		
		wpDTO.setWpId(wpId);
		
		wpService.deleteWp(wpDTO);
		
		return "redirect:/workplace/list";
	}
	
}