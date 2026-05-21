package kr.or.chop.P16_equip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;

@Controller
@RequestMapping("/equip")
public class EqEditController {

    @Autowired
    EqService eqService;

    @RequestMapping("/edit")
    public String editForm(String eqId, Model model) {

        EqDTO eqp = eqService.selectEqDetail(eqId);
        List<WPDTO> wpList = eqService.selectWpList();

        model.addAttribute("eqp", eqp);
        model.addAttribute("wpList", wpList);

        return "P16_equipment/eqEdit.tiles";
    }
    
    @RequestMapping("/update")
    public String updateEq(EqDTO eqDTO) {

        eqService.updateEq(eqDTO);

        return "redirect:/equip/detail?eqId=" + eqDTO.getEqId();
    }
    
  
    
    
}