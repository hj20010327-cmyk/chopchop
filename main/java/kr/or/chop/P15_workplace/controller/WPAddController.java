package kr.or.chop.P15_workplace.controller;

import java.io.File;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.WPService;

@Controller
@RequestMapping("/workplace")
public class WPAddController {

	@Autowired
	WPService wpService;
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add () {
		System.out.println("/workplace/add controller.add");

		return "P15_workplace/wpAdd.tiles";
	}
	
	@PostMapping("/insert")
	public String insertWP(
	        WPDTO wpDTO,
	        @RequestParam("wpImgFile") MultipartFile wpImgFile,
	        HttpServletRequest request
	) throws Exception {
		
		System.out.println("/workplace/add controller.add");
		System.out.println("이름 : " + wpDTO.getWpName() + ", 유형 : " + wpDTO.getWpType());
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/img/P15_workplace");
		String contextPath = request.getContextPath();

	    wpService.insertWP(wpDTO, wpImgFile, uploadPath, contextPath);

	    return "redirect:/workplace/list";
	}

}
