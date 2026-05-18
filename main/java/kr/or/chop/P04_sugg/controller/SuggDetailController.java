package kr.or.chop.P04_sugg.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P04_sugg.dto.CommentDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P04_sugg.service.CommentService;
import kr.or.chop.P04_sugg.service.SuggService;

@Controller
@RequestMapping("/sugg/detail")
public class SuggDetailController {

    @Autowired
    SuggService suggService;

    @Autowired
    CommentService commentService;

    @GetMapping
    public String detail(Integer sugg_no,
                         Model model) {

        System.out.println("/sugg/detail 실행");

        SuggDTO dto =
                suggService.selectSuggDetail(sugg_no);

        System.out.println("sugg_no : " + sugg_no);
        System.out.println("dto : " + dto);

        if (dto == null) {
            return "redirect:/sugg/list";
        }

        // 댓글 목록 가져오기
        List<CommentDTO> commList =
                commentService.selectCommentList(sugg_no);

        // jsp 전달
        model.addAttribute("dto", dto);
        model.addAttribute("commList", commList);

        return "P04_sugg/suggDetail.tiles";
    }
}