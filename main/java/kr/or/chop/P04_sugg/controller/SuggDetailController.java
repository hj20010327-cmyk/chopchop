package kr.or.chop.P04_sugg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P04_sugg.service.SuggService;

@Controller
@RequestMapping("/sugg/detail")
public class SuggDetailController {

    @Autowired
    SuggService suggService;

    @GetMapping
    public String detail(Integer sugg_no,
                         Model model) {
    	System.out.println("/sugg/detail 실행");
    	System.out.println("sugg_no : " + sugg_no);

        SuggDTO dto = suggService.selectSuggDetail(sugg_no);
        
        System.out.println("dto : " + dto);

        if(dto == null) {
            return "redirect:/sugg/list";
        }

        model.addAttribute("dto", dto);

        return "P04_sugg/suggDetail.tiles";
    }
}
