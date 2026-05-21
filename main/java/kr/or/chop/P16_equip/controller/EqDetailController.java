package kr.or.chop.P16_equip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;

@Controller
@RequestMapping("/equip")
public class EqDetailController {
	
	@Autowired
    EqService eqService;

    @RequestMapping("/detail")
    public String eqDetail(String eqId, Model model) {

        EqDTO eq = eqService.selectEqDetail(eqId);

        List<EqDTO> eqLogList = eqService.selectEqLogList(eqId);
        List<EqDTO> eqRunList = eqService.selectEqRunList(eqId);

        model.addAttribute("eqp", eq);
        model.addAttribute("eqLogList", eqLogList);
        model.addAttribute("eqRunList", eqRunList);

        return "P16_equipment/eqDetail.tiles";
    }
    
    @RequestMapping("/run")
    public String runEq(String eqId) {

        EqDTO eqDTO = new EqDTO();
        eqDTO.setEqId(eqId);
        eqDTO.setEqStatus(10); // 가동중

        eqService.updateEqStatus(eqDTO);

        return "redirect:/equip/detail?eqId=" + eqId;
    }

    @RequestMapping("/stop")
    public String stopEq(String eqId) {

        EqDTO eqDTO = new EqDTO();
        eqDTO.setEqId(eqId);
        eqDTO.setEqStatus(20); // 정지

        eqService.updateEqStatus(eqDTO);

        return "redirect:/equip/detail?eqId=" + eqId;
    }
    
    @RequestMapping("/delete")
    public String deleteEq(String eqId) {

    	eqService.deleteEq(eqId);

    	return "redirect:/equip/list";
    }
	
}
