package kr.or.chop.P03_notice.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.P03_notice.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeEditController {

    @Autowired
    NoticeService noticeService;

    // 공지사항 수정 화면
    @GetMapping("/edit")
    public String editForm(
            Integer not_no,
            Model model,
            HttpSession session) {

        System.out.println("/notice/edit 화면 실행");

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 관리자만 수정 가능
        if (loginUser.getEmpAuth() < 20) {
            return "redirect:/notice/detail?not_no=" + not_no;
        }

        NoticeDTO dto =
                noticeService.selectNoticeDetail(not_no);

        if (dto == null) {
            return "redirect:/notice/list";
        }

        List<NoticeFileDTO> fileList =
                noticeService.selectNoticeFileList(not_no);

        model.addAttribute("dto", dto);
        model.addAttribute("fileList", fileList);

        return "P03_notice/noticeEdit.tiles";
    }

    // 공지사항 수정
    @PostMapping("/edit")
    public String edit(
            NoticeDTO dto,
            MultipartFile[] uploadFiles,
            HttpServletRequest request,
            HttpSession session) throws Exception {

        System.out.println("/notice/edit 실행");

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 관리자만 수정 가능
        if (loginUser.getEmpAuth() < 20) {
            return "redirect:/notice/detail?not_no="
                    + dto.getNot_no();
        }

        noticeService.updateNotice(dto);

        String uploadPath =
                request.getSession()
                       .getServletContext()
                       .getRealPath("/resources/upload/notice");

        File folder = new File(uploadPath);

        if (!folder.exists()) {
            folder.mkdirs();
        }

        // 파일이 있을 때만 추가 등록
        if (uploadFiles != null) {

            for (MultipartFile uploadFile : uploadFiles) {

                if (uploadFile != null
                        && !uploadFile.isEmpty()) {

                    String originName =
                            uploadFile.getOriginalFilename();

                    String saveName =
                            System.currentTimeMillis()
                            + "_"
                            + originName;

                    File saveFile =
                            new File(uploadPath, saveName);

                    uploadFile.transferTo(saveFile);

                    NoticeFileDTO fileDTO =
                            new NoticeFileDTO();

                    fileDTO.setNot_no(dto.getNot_no());
                    fileDTO.setFile_origin_name(originName);
                    fileDTO.setFile_save_name(saveName);

                    noticeService.insertNoticeFile(fileDTO);
                }
            }
        }

        return "redirect:/notice/detail?not_no="
                + dto.getNot_no();
    }

    // 공지사항 삭제
    @PostMapping("/delete")
    public String delete(
            int not_no,
            HttpSession session) {

        System.out.println("/notice/delete 실행");

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 관리자만 삭제 가능
        if (loginUser.getEmpAuth() < 20) {
            return "redirect:/notice/detail?not_no=" + not_no;
        }

        // 첨부파일 먼저 소프트 삭제
        noticeService.deleteNoticeFileByNoticeNo(not_no);

        // 공지사항 소프트 삭제
        noticeService.deleteNotice(not_no);

        return "redirect:/notice/list";
    }
}