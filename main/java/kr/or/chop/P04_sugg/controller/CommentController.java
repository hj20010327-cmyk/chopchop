package kr.or.chop.P04_sugg.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P04_sugg.dto.CommentDTO;
import kr.or.chop.P04_sugg.service.CommentService;

@Controller
@RequestMapping("/sugg/comment")
public class CommentController {

    @Autowired
    CommentService commentService;

    @PostMapping("/add")
    public String add(CommentDTO dto,
                      HttpSession session) {

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 로그인한 사람 사번 넣기
        dto.setComm_writer(
                loginUser.getEmpId()
        );

        commentService.insertComment(dto);

        return "redirect:/sugg/detail?sugg_no="
                + dto.getComm_sugg_no();
    }

    @PostMapping("/edit")
    public String edit(CommentDTO dto) {
        System.out.println("/sugg/comment/edit 실행");
        System.out.println("dto : " + dto);

        commentService.updateComment(dto);

        return "redirect:/sugg/detail?sugg_no=" + dto.getComm_sugg_no();
    }

    @PostMapping("/delete")
    public String delete(int comm_no,
                         int comm_sugg_no,
                         HttpSession session) {

        System.out.println("/sugg/comment/delete 실행");

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        int childCount =
                commentService.selectChildCommentCount(comm_no);

        // 자식 댓글이 있으면 내용만 삭제 표시
        if (childCount > 0) {
            commentService.maskComment(comm_no);
        } else {
            commentService.deleteComment(comm_no);
        }

        return "redirect:/sugg/detail?sugg_no=" + comm_sugg_no;
    }
}