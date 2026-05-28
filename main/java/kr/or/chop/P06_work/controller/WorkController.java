package kr.or.chop.P06_work.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P02_dashboard.service.RefreshService;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.service.WorkService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/work")
public class WorkController {
	
	@Autowired
	WorkService workService;
	@Autowired
	RefreshService refService;
	
	@RequestMapping("/list")
	public String list (
		Model model,
		WorkDTO workDTO,
		@RequestParam(value="page", defaultValue="1") int currentPage
	) {
		
		refService.refreshStatus();
		
		if (workDTO.getWorkSearchSdate() == null || workDTO.getWorkSearchSdate().isEmpty()) {
			workDTO.setWorkSearchSdate(LocalDate.now().minusMonths(6).toString());
		}
		
		if (workDTO.getWorkSearchEdate() == null || workDTO.getWorkSearchEdate().isEmpty()) {
			workDTO.setWorkSearchEdate(LocalDate.now().toString());
		}
		
		// 페이징
		int listCount = workService.selectWorkCount(workDTO);
		PageInfo pageInfo = Pagination.getPageInfo(listCount, currentPage, 5, 10);
		
		// 목록 가져오기
		List<WorkDTO> workList = workService.selectAllWork(workDTO, pageInfo);
		
		// 카드 가져오기
		WorkDTO workCard = workService.selectWorkCardCnt(workDTO);
		
		model.addAttribute("page", pageInfo);
		model.addAttribute("workList", workList);
		model.addAttribute("workCard", workCard);
		model.addAttribute("search", workDTO);
		
		
		return "P06_work/workList.tiles";
	}
	
	
	
	/* ============================ */
	
	
	@RequestMapping("/detail")
	public String detail(
			Model model,
			@RequestParam("workId") String workId
		) {
		
		refService.refreshStatus();
		
		WorkDTO workDTO = new WorkDTO();
		workDTO.setWorkId(workId);

		WorkDTO workInfo = workService.selectWorkDetail(workDTO);
		List<WorkDTO> workProcList = workService.selectWorkProcList(workDTO);

		model.addAttribute("workDTO", workInfo);
		model.addAttribute("workProcList", workProcList);

		return "P06_work/workDetail.tiles";
	}
	
	
	
	/* ============================ */

	
	@RequestMapping("/delete")
	public String delete(
			@RequestParam("workId") String workId,
			WorkDTO workDTO
		) {
		workDTO.setWorkId(workId);
		workService.deleteWork(workDTO);
		
		return "redirect:/work/list";
	}
	
	
}
