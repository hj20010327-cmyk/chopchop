package kr.or.chop.P14_warehouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.service.SecService;
import kr.or.chop.P14_warehouse.service.WHService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/warehouse/section")
public class SecDetailController {
	

	@Autowired
	SecService secService;
	@Autowired
	WHService whService;
	

	@RequestMapping("/detail")
	public String detail(
			Model model,
			SecDTO secDTO,
			@RequestParam(value="page", defaultValue="1") int currentPage,
			@RequestParam(value="secId") String secId
		) {
		System.out.println("/warehouse/sec/detail controller.detail");
		
		secDTO.setSecId(secId);
		
		// secDTO 가져오기
		secDTO = secService.selectSecDTO(secDTO);
		
		// 전체 sec 가져오기
		WHDTO whDTO = new WHDTO();
		whDTO.setWhId(secDTO.getSecWhId());
		List<SecDTO> secList = whService.selectSecList(whDTO);
		
		// LOT 개수 가져와서 페이징
		int listCount = secService.selectLotCount(secDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// LOT 가져오기
		List<LotDTO> lotList = secService.selectLotList(secDTO, pageInfo);
		
		model.addAttribute("secDTO", secDTO);
		model.addAttribute("secList", secList);
		model.addAttribute("page", pageInfo);
		model.addAttribute("lotList", lotList);
		
		return "P14_warehouse/secDetail.tiles";
	}
	
	@RequestMapping("/delete")
	public String delete(
			SecDTO secDTO,
			@RequestParam(value="secId") String secId
		) {
		System.out.println("/warehouse/sec/delete controller.detail");
		
		secDTO.setSecId(secId);
		
		// secDTO 가져오기
		secDTO = secService.selectSecDTO(secDTO);
		
		// 창고 개수 마이너스 및 섹션 비활
		secService.deleteSection(secDTO);
		
		return "redirect:/warehouse/detail?whId=" + secDTO.getSecWhId();
	}

}
