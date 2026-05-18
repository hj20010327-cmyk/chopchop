package kr.or.chop.P09_lot.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P09_lot.service.LotService;
import kr.or.chop.common.pagination.PageInfo;

@Controller
@RequestMapping("/lot")
public class LotListController {
	
	@Autowired
    LotService lotService;

    @RequestMapping("/list")
    public String lotList(LotDTO lotDTO, Model model) {

        PageInfo pageInfo = new PageInfo();

        List<LotDTO> lotList = lotService.selectAllLot(lotDTO, pageInfo);

        model.addAttribute("lotList", lotList);
        model.addAttribute("lotDTO", lotDTO);

        return "P09_lot/lotList.tiles";
    }
	
}
