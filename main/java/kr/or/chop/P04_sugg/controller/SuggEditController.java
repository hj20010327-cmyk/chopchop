package kr.or.chop.P04_sugg.controller;

import java.io.File;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P04_sugg.service.SuggService;

@Controller
@RequestMapping("/sugg")
public class SuggEditController {

    @Autowired
    SuggService suggService;
    
    @GetMapping("/edit")
    public String editForm(Integer sugg_no, Model model) {
        System.out.println("/sugg/edit 화면 실행");
        System.out.println("sugg_no : " + sugg_no);

        SuggDTO dto = suggService.selectSuggDetail(sugg_no);

        if (dto == null) {
            return "redirect:/sugg/list";
        }

        model.addAttribute("dto", dto);

        return "P04_sugg/suggEdit.tiles";
    }

    @PostMapping("/edit")
    public String edit(SuggDTO dto,
                       MultipartFile uploadFile,
                       HttpSession session) throws Exception {

        System.out.println("/sugg/edit 실행");
        System.out.println("dto" + dto);

        if (uploadFile != null && !uploadFile.isEmpty()) {

            String originName = uploadFile.getOriginalFilename();

            String saveName =
                    System.currentTimeMillis() + "_" + originName;

            String uploadPath =
                    session.getServletContext().getRealPath("/resources/upload/sugg");

            File folder = new File(uploadPath);

            if (!folder.exists()) {
                folder.mkdirs();
            }

            File saveFile = new File(uploadPath, saveName);

            uploadFile.transferTo(saveFile);

            dto.setFile_origin_name(originName);
            dto.setFile_save_name(saveName);
        }

        suggService.updateSugg(dto);

        return "redirect:/sugg/detail?sugg_no="
                + dto.getSugg_no();
    }

    @PostMapping("/delete")
    public String delete(int sugg_no) {
    	
        suggService.deleteSugg(sugg_no);

        return "redirect:/sugg/list";
    }
}