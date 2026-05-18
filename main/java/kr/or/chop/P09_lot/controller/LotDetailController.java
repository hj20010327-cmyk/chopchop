package kr.or.chop.P09_lot.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P09_lot.service.LotService;

@Controller
public class LotDetailController {

	 @Autowired
	    LotService lotService;

	    @RequestMapping("/detail")
	    public String lotDetail(String lotId, Model model) {

	        LotDTO lot = lotService.selectLotDetail(lotId);

	        model.addAttribute("lot", lot);

	        return "P09_lot/lotDetail";
	    }
	
}
