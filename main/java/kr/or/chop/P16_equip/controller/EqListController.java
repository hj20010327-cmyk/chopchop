package kr.or.chop.P16_equip.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P16_equip.dto.EqDTO;
import kr.or.chop.P16_equip.service.EqService;
import kr.or.chop.common.pagination.PageInfo;

@Controller
@RequestMapping("/equip")
public class EqListController {

	@Autowired
    EqService eqService;

    @RequestMapping("/list")
    public String eqList(EqDTO eqDTO, Model model) {

        PageInfo pageInfo = new PageInfo();

        List<EqDTO> eqList = eqService.selectEqList(eqDTO, pageInfo);

        model.addAttribute("eqList", eqList);
        model.addAttribute("search", eqDTO);
        model.addAttribute("pageInfo", pageInfo);

        model.addAttribute("totalCount", eqService.selectEqTotalCount());
        model.addAttribute("runCount", eqService.selectEqCountByStatus(10));
        model.addAttribute("stopCount", eqService.selectEqCountByStatus(20));
        model.addAttribute("checkCount", eqService.selectEqCountByStatus(30));
        model.addAttribute("brokenCount", eqService.selectEqCountByStatus(40));

        return "P16_equipment/eqList.tiles";
    }
	
}
