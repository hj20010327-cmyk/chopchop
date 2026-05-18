package kr.or.chop.P04_sugg.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

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
    public String add(SuggDTO dto,
    				  MultipartFile uploadFile,
    				  HttpServletRequest request,
    				  HttpSession session) throws Exception {
    	System.out.println("/sugg/add 실행");
    	
    	if (uploadFile != null && !uploadFile.isEmpty()) {

            String originName = uploadFile.getOriginalFilename();

            String saveName =
                    System.currentTimeMillis() + "_" + originName;

            String uploadPath =
                    request.getSession().getServletContext().getRealPath("/resources/upload/sugg");

            File folder = new File(uploadPath);

            if (!folder.exists()) {
                folder.mkdirs();
            }

            File saveFile = new File(uploadPath, saveName);

            uploadFile.transferTo(saveFile);

            dto.setFile_origin_name(originName);
            dto.setFile_save_name(saveName);
        }
    	
    	
    	//    	  LoginDTO loginDto =
//    	            (LoginDTO) session.getAttribute("dto");

//    	    dto.setSugg_writer(loginDto.getEmp_id());
    	
        suggService.insertSugg(dto);

        return "redirect:/sugg/list";
    }
}
