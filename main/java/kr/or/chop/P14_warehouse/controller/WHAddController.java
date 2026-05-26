package kr.or.chop.P14_warehouse.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.service.WHService;

@Controller
@RequestMapping("/warehouse")
public class WHAddController {

	@Autowired
	WHService whService;
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add () {
		System.out.println("/warehouse/add controller.add");

		return "P14_warehouse/whAdd.tiles";
	}
	
	@PostMapping("/insert")
	public String insertWH(
	        WHDTO whDTO,
	        @RequestParam("secQtyList") String secQtyList,
	        HttpServletRequest request
	) throws Exception {
		
		System.out.println("/warehouse/insert controller.insertWH");
		System.out.println("이름 : " + whDTO.getWhName() + ", 유형 : " + whDTO.getWhTypeNo());
		System.out.println("섹션 수용량 목록 : " + secQtyList);
		
		whService.insertWHWithSections(whDTO, secQtyList);

		return "redirect:/warehouse/list";
	}

}
