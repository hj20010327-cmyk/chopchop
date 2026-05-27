package kr.or.chop.P03_notice.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.P03_notice.service.NoticeService;

@Controller
@RequestMapping("/notice/add")
public class NoticeAddController {

    @Autowired
    NoticeService noticeService;

    // 공지사항 등록 화면
    @GetMapping
    public String addForm(
            HttpSession session) {

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 관리자만 등록 가능
        if (loginUser.getEmpAuth() < 20) {
            return "redirect:/notice/list";
        }

        return "P03_notice/noticeAdd.tiles";
    }

    // 공지사항 등록
    @PostMapping
    public String add(
            NoticeDTO dto,
            MultipartFile[] uploadFiles,
            HttpServletRequest request,
            HttpSession session) throws Exception {

        System.out.println("/notice/add 실행");

        EmpDTO loginUser =
                (EmpDTO) session.getAttribute("loginUser");

        if (loginUser == null) {
            return "redirect:/login";
        }

        // 관리자만 등록 가능
        if (loginUser.getEmpAuth() < 20) {
            return "redirect:/notice/list";
        }

        dto.setNot_writer(loginUser.getEmpId());

        // 공지사항 먼저 등록
        noticeService.insertNotice(dto);

        /*
         * 중요:
         * mapper에서 selectKey를 쓰지 않으면
         * dto.getNot_no()가 0일 수 있음.
         * notice.xml insertNotice에 selectKey 추가 필요.
         */
        int not_no = dto.getNot_no();

        // 첨부파일 저장 경로
        String uploadPath =
                request.getSession()
                       .getServletContext()
                       .getRealPath("/resources/upload/notice");

        File folder = new File(uploadPath);

        if (!folder.exists()) {
            folder.mkdirs();
        }

        // 파일이 있을 때만 첨부파일 등록
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

                    fileDTO.setNot_no(not_no);
                    fileDTO.setFile_origin_name(originName);
                    fileDTO.setFile_save_name(saveName);

                    noticeService.insertNoticeFile(fileDTO);
                }
            }
        }

        return "redirect:/notice/list";
    }
}