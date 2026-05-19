package kr.or.chop.P14_warehouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.service.WHService;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping ("/warehouse")
public class WHDetailController {
	
	@Autowired
	WHService whService;
	
	@RequestMapping("/detail")
	public String detail(
			Model model,
			WHDTO whDTO,
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="whId") String whId
		) {
		System.out.println("/warehouse/detail controller.detail");
		
		whDTO.setWhId(whId);
		
		// whDTO 가져오기
		whDTO = whService.selectWhDTO(whDTO);
		
		// glog 개수 가져와서 페이징
		int listCount = whService.selectGlogCount(whDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// glog 가져오기
		List<GlogDTO> glogList = whService.selectGlogList(whDTO, pageInfo);
		
		// sec 가져오기
		List<SecDTO> secList = whService.selectSecList(whDTO);
		
		model.addAttribute("whDTO", whDTO);
		model.addAttribute("page", pageInfo);
		model.addAttribute("glogList", glogList);
		model.addAttribute("secList", secList);
		
		return "P14_warehouse/whDetail.tiles";
	}
	

	@RequestMapping("/delete")
	public String delete(
			WHDTO whDTO,
			@RequestParam(value="whId") String whId
			) {
		System.out.println("/warehouse/delete controller.delete");
		
		whDTO.setWhId(whId);
		
		whService.deleteWh(whDTO);
		
		return "redirect:/warehouse/list";
	}

}
