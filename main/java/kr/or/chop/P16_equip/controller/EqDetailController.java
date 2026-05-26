package kr.or.chop.P16_equip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/equip")
public class EqDetailController {
	
	@Autowired
    EqService eqService;

	@RequestMapping("/detail")
	public String eqDetail(
	        String eqId,
	        @RequestParam(value = "mtPage", defaultValue = "1")
	        int mtCurrentPage,
	        @RequestParam(value = "runPage", defaultValue = "1")
	        int runCurrentPage,
	        Model model) {

	    EqDTO eq = eqService.selectEqDetail(eqId);

	    int mtCount = eqService.selectEqLogCount(eqId);
	    PageInfo mtPage = Pagination.getPageInfo(
	            mtCount,
	            mtCurrentPage,
	            5,
	            5
	    );

	    int runCount = eqService.selectEqRunCount(eqId);
	    PageInfo runPage = Pagination.getPageInfo(
	            runCount,
	            runCurrentPage,
	            5,
	            5
	    );

	    List<EqDTO> eqLogList =
	            eqService.selectEqLogList(eqId, mtPage);

	    List<EqDTO> eqRunList =
	            eqService.selectEqRunList(eqId, runPage);

	    model.addAttribute("eqp", eq);
	    model.addAttribute("eqLogList", eqLogList);
	    model.addAttribute("eqRunList", eqRunList);

	    model.addAttribute("mtPage", mtPage);
	    model.addAttribute("runPage", runPage);

	    return "P16_equipment/eqDetail.tiles";
	}
	
	@RequestMapping("/run")
	public String runEq(String eqId) {

	    EqDTO eqDTO = new EqDTO();
	    eqDTO.setEqId(eqId);
	    eqDTO.setEqStatus(10);

	    eqService.updateEqStatus(eqDTO);

	    eqService.insertEqRunLog(eqId);

	    return "redirect:/equip/detail?eqId=" + eqId;
	}

    @RequestMapping("/stop")
    public String stopEq(EqDTO eqDTO) {

        
        eqDTO.setEqStatus(20); // 정지

        // 설비 상태 변경
        eqService.updateEqStatus(eqDTO);

        // 가동이력 종료 처리
        eqService.updateEqRunLogStop(eqDTO);

        return "redirect:/equip/detail?eqId=" + eqDTO.getEqId();
    }
    
    @RequestMapping("/status/update")
    public String updateStatus(EqDTO eqDTO) {

        eqService.updateEqStatus(eqDTO);

        return "redirect:/equip/detail?eqId=" + eqDTO.getEqId();
    }
    
    @RequestMapping("/delete")
    public String deleteEq(String eqId) {

    	eqService.deleteEq(eqId);

    	return "redirect:/equip/list";
    }
	
}
