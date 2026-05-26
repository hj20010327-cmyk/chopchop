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
@RequestMapping("/equip/mt")
public class EqMtListController {

    @Autowired
    EqService eqService;

    @RequestMapping("/list")
    public String mtList(
            String eqId,
            @RequestParam(
                value = "page",
                defaultValue = "1"
            )
            int currentPage,
            Model model) {

        EqDTO eqp =
                eqService.selectEqDetail(eqId);

        int listCount =
                eqService.selectEqLogCount(eqId);

        PageInfo pageInfo =
                Pagination.getPageInfo(
                        listCount,
                        currentPage,
                        10,
                        5
                );

        List<EqDTO> eqLogList =
                eqService.selectEqLogList(
                        eqId,
                        pageInfo
                );

        model.addAttribute("eqp", eqp);
        model.addAttribute("eqLogList", eqLogList);
        model.addAttribute("page", pageInfo);

        return "P16_equipment/eqMtList.tiles";
    }
}