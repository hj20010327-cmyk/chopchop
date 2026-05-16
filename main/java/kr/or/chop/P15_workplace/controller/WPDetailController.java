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
public class WPDetailController {

	@Autowired
	WPService wpService;
	
	@RequestMapping("/detail")
	public String detail(
			Model model,
			WPDTO wpDTO,
			@RequestParam(value="wpId") String wpId
		) {
		System.out.println("/workplace/list controller.list");
		
		wpDTO.setWpId(wpId);
		
		// wpDTO 가져오기
		wpDTO = wpService.selectWpDTO(wpDTO);
		
		// glog 가져오기
		
		model.addAttribute("wpDTO", wpDTO);
//		model.addAttribute("page", pageInfo);
		
		return "P15_workplace/wpDetail.tiles";
	}
	
}