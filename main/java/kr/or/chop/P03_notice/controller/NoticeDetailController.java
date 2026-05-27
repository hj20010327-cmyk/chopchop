package kr.or.chop.P03_notice.controller;

import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.P03_notice.service.NoticeService;

@Controller
@RequestMapping("/notice/detail")
public class NoticeDetailController {

    @Autowired
    NoticeService noticeService;

    // 공지사항 상세
    @GetMapping
    public String detail(
            @RequestParam("not_no") Integer not_no,
            HttpSession session,
            Model model) {

        System.out.println("/notice/detail 실행");
        System.out.println("not_no : " + not_no);

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        NoticeDTO dto =
                noticeService.selectNoticeDetail(not_no);

        if (dto == null) {
            return "redirect:/notice/list";
        }

        // 오늘 날짜
        String today =
                LocalDate.now().toString();

        // 사용자 + 글번호 + 날짜 기준 조회수 키
        String viewKey =
                "noticeView_"
                + not_no
                + "_"
                + loginUser.getEmpId()
                + "_"
                + today;

        Boolean viewed =
                (Boolean) session.getAttribute(viewKey);

        // 오늘 이 사용자가 이 글을 처음 본 경우만 조회수 증가
        if (viewed == null || !viewed) {

            noticeService.updateNoticeView(not_no);

            session.setAttribute(
                    viewKey,
                    true
            );

            // 화면에 바로 증가된 조회수 보이게 다시 조회
            dto = noticeService.selectNoticeDetail(not_no);
        }

        // 첨부파일 목록
        List<NoticeFileDTO> fileList =
                noticeService.selectNoticeFileList(not_no);

        // 관리자 여부
        boolean isAdmin = false;

        if (loginUser.getEmpAuth() >= 20) {
            isAdmin = true;
        }

        model.addAttribute("dto", dto);
        model.addAttribute("fileList", fileList);
        model.addAttribute("isAdmin", isAdmin);

        return "P03_notice/noticeDetail.tiles";
    }
}