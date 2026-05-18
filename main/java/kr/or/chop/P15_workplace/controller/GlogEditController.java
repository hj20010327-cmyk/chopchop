package kr.or.chop.P15_workplace.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.GlogService;
import kr.or.chop.P19_ghp.dto.GlogDTO;

@Controller
@RequestMapping("/workplace/glog")
public class GlogEditController {

	@Autowired
	GlogService glogService;

	@RequestMapping("/edit")
	public String edit(
			Model model,
			GlogDTO glogDTO,
			@RequestParam(value="glogId") String glogId
		) {
		System.out.println("/workplace/glog/edit controller.edit");
		
		// glogDTO 가져오기
		glogDTO = glogService.selectGlog(glogDTO);
		
		String dateStr = String.valueOf(glogDTO.getGlogDate());
		String day = dateStr.split(" ")[0];
		String time = dateStr.split(" ")[1];
		
		glogDTO.setGlogDay(day);
		glogDTO.setGlogTime(time);
		
		if(!( glogDTO.getGlogAdate() == null || "".equals( glogDTO.getGlogAdate() ) )) {
			String aStr = String.valueOf(glogDTO.getGlogAdate());
			String aDay = aStr.split(" ")[0];
			String aTime = aStr.split(" ")[1];
			
			glogDTO.setGlogAday(aDay);
			glogDTO.setGlogAtime(aTime);
		}
		
		model.addAttribute("glog", glogDTO);
		
		return "P15_workplace/glogEdit.tiles";
	}
	
}
