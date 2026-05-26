package kr.or.chop.P18_defect.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P18_defect.dto.DefDTO;
import kr.or.chop.P18_defect.service.DefService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/defect")
public class DefDetailController {

	@Autowired
	DefService defService;

	@RequestMapping("/detail")
	public String detail(
			@RequestParam("defTypeId") String defTypeId,
			@RequestParam(value = "page", defaultValue = "1") int currentPage,
			Model model
		) {

		DefDTO def = defService.selectDefDetail(defTypeId);

		if (def == null) {
			return "redirect:/defect/list";
		}

		int historyCount = defService.selectDefHistoryCount(defTypeId);

		PageInfo pageInfo = Pagination.getPageInfo(
				historyCount,
				currentPage,
				5,
				10
		);

		int totalDefectCnt = defService.selectDefTotalCnt(defTypeId);
		List<DefDTO> trendList = defService.selectDefTrend(defTypeId);
		List<DefDTO> historyList = defService.selectDefHistory(defTypeId, pageInfo);

		model.addAttribute("def", def);
		model.addAttribute("totalDefectCnt", totalDefectCnt);
		model.addAttribute("trendList", trendList);
		model.addAttribute("historyList", historyList);
		model.addAttribute("page", pageInfo);

		return "P18_defect/defectDetail.tiles";
	}
	
	
}
