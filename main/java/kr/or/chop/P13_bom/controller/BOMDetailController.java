package kr.or.chop.P13_bom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.dto.BOMDetailDTO;
import kr.or.chop.P13_bom.service.BOMService;

@Controller
@RequestMapping("/bom")
public class BOMDetailController {

    @Autowired
    BOMService bomService;

    @RequestMapping("/detail")
    public String bomDetail(
            String bomId,
            Model model) {

        BOMDTO bom =
                bomService.selectBomDetail(bomId);

        List<BOMDetailDTO> detailList =
                bomService.selectBomDetailList(bomId);

        model.addAttribute("bom", bom);
        model.addAttribute("detailList", detailList);

        return "P13_bom/bomDetail.tiles";
    }
}