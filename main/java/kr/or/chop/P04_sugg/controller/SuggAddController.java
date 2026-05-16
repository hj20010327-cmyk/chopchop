package kr.or.chop.P04_sugg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P04_sugg.service.SuggService;

@Controller
@RequestMapping("/sugg/add")
public class SuggAddController {
	
    @Autowired
    SuggService suggService;

    @GetMapping
    public String addForm() {
        return "P04_sugg/suggAdd.tiles";
    }
    
    @PostMapping
    public String add(SuggDTO dto) {
    	System.out.println("/sugg/add 실행");
        suggService.insertSugg(dto);

        return "redirect:/sugg/list";
    }
}
