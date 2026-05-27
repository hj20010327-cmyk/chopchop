package kr.or.chop.P03_notice.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.service.NoticeService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/notice")
public class NoticeListController {

    @Autowired
    NoticeService noticeService;

    // 공지사항 목록
    @RequestMapping("/list")
    public String list(
            NoticeDTO noticeDTO,
            @RequestParam(value = "page", defaultValue = "1")
            int currentPage,
            Model model) {

        System.out.println("/notice/list 실행");

        int listCount =
                noticeService.selectNoticeCount(noticeDTO);

        PageInfo pageInfo =
                Pagination.getPageInfo(
                        listCount,
                        currentPage,
                        5,
                        10
                );

        List<NoticeDTO> list =
                noticeService.selectNoticeList(
                        noticeDTO,
                        pageInfo
                );

        model.addAttribute("list", list);
        model.addAttribute("noticeDTO", noticeDTO);
        model.addAttribute("page", pageInfo);

        return "P03_notice/noticeList.tiles";
    }
}