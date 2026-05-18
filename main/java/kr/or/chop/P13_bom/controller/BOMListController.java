package kr.or.chop.P13_bom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.service.BOMService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/bom")
public class BOMListController {

    @Autowired
    BOMService bomService;

    @RequestMapping("/list")
    public String bomList(
            BOMDTO bomDTO,
            @RequestParam(value = "page", defaultValue = "1")
            int currentPage,
            Model model) {

        int listCount =
                bomService.selectBomCount(bomDTO);

        PageInfo page =
                Pagination.getPageInfo(
                        listCount,
                        currentPage,
                        5,
                        10
                );

        List<BOMDTO> bomList =
                bomService.selectBomList(bomDTO, page);

        model.addAttribute("bomList", bomList);
        model.addAttribute("page", page);
        model.addAttribute("search", bomDTO);

        return "P13_bom/bomList.tiles";
    }
}