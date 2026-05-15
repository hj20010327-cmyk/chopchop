package kr.or.chop.P15_workplace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.WPService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/workplace")
public class WPListController {

	@Autowired
	WPService wpService;
	
	@RequestMapping("/list")
	public String list(
			Model model,
			WPDTO wpDTO,
			@RequestParam(value="page", defaultValue="1")
			int currentPage
		) {
		
		System.out.println("/workplace/list controller.list");
		System.out.println("wpDTO 초기 : " + wpDTO);
		
		// 개수 가져와서 페이징
		int listCount = wpService.selectWPCount(wpDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// 목록 가져오기
		List<WPDTO> wpList = wpService.selectAllWP(wpDTO, pageInfo);
		
		model.addAttribute("wpList", wpList);
		model.addAttribute("search", wpDTO);
		model.addAttribute("page", pageInfo);
		
		return "P15_workplace/wpList.tiles";
	}
	
}