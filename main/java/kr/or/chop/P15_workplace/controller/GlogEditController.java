package kr.or.chop.P15_workplace.controller;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

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
		
		System.out.println(glogDTO);
		
		return "P15_workplace/glogEdit.tiles";
	}

	@PostMapping("/update")
	public String update (
			GlogDTO glogDTO,
			@RequestParam(value = "ghpImgFile", required = false) MultipartFile ghpImgFile,
	        HttpServletRequest request
			) throws Exception {
		
		System.out.println("/workplace/glog/edit controller.update");
		
		// 점검 일시
		glogDTO.setGlogDate(
		    toTimestamp(glogDTO.getGlogDay(), glogDTO.getGlogTime())
		);

		// 조치 일시
		glogDTO.setGlogAdate(
		    toTimestamp(glogDTO.getGlogAday(), glogDTO.getGlogAtime())
		);
		
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/img/P15_workplace/glog");
	    String contextPath = request.getContextPath();
	    
	    glogService.updateGlog(glogDTO, ghpImgFile, uploadPath, contextPath);
		
		return "redirect:/workplace/glog/detail?glogId=" + glogDTO.getGlogId();
	}
	
	private Timestamp toTimestamp(String day, String time) {
	    if (day == null || day.isEmpty() || time == null || time.isEmpty()) {
	        return null;
	    }

	    // 0:00 -> 00:00
	    if (time.length() == 4) {
	        time = "0" + time;
	    }

	    // 00:00:00 -> 00:00
	    if (time.length() >= 5) {
	        time = time.substring(0, 5);
	    }

	    return Timestamp.valueOf(day + " " + time + ":00");
	}
}
