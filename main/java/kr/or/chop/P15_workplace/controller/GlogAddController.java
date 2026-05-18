package kr.or.chop.P15_workplace.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P15_workplace.service.GlogService;
import kr.or.chop.P15_workplace.service.WPService;
import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;

@Controller
@RequestMapping("/workplace/glog")
public class GlogAddController {
	
	@Autowired
	GlogService glogService;
	@Autowired
	WPService wpService;
	
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add (
			Model model,
			WPDTO wpDTO,
			@RequestParam String wpId
			) {
		System.out.println("/workplace/glog/add controller.add");
		
		wpDTO.setWpId(wpId);
		wpDTO = wpService.selectWpDTO(wpDTO);
		List<GhpDTO> ghpDTOList = new ArrayList();
		ghpDTOList = glogService.selectAllGhp(wpDTO);
		
		model.addAttribute("wpDTO", wpDTO);
		model.addAttribute("ghpList", ghpDTOList);
		
		return "P15_workplace/glogAdd.tiles";
	}
	
	@RequestMapping(value="/selectGhp", method = RequestMethod.GET)
	@ResponseBody
	public GhpDTO selectGhp(
			@RequestParam("ghpId") String ghpId,
			GhpDTO ghpDTO
			) {
		System.out.println("/workplace/glog/add controller.selectGhp");
		ghpDTO.setGhpId(ghpId);
		
		ghpDTO = glogService.selectGhp(ghpDTO);
		
		return ghpDTO;
	} 
	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertGlog(
			GlogDTO glogDTO,
			@RequestParam(value = "ghpImgFile", required = false) MultipartFile ghpImgFile,
			HttpServletRequest request
			) throws IllegalStateException, IOException {
		System.out.println("/workplace/glog/add controller.insertGlog");
		
//		String dayStr = glogDTO.getGlogDay();
//		String timeStr = glogDTO.getGlogTime();
//		String dateStr = dayStr + " " + timeStr;
//		
//		Date date = Date.valueOf(dateStr);
//		glogDTO.setGlogDate(date);
//		
//		String adayStr = "";
//		String atimeStr = "";
//		String adateStr = "";
//		if (glogDTO.getGlogAday() != null && "".equals(glogDTO.getGlogAday())) {
//			adayStr = glogDTO.getGlogAday();
//			adateStr = adayStr;
//			
//			if (glogDTO.getGlogAtime() != null && "".equals(glogDTO.getGlogAtime())) {
//				adateStr += " " + atimeStr;
//			}
//			
//			Date aDate = Date.valueOf(adateStr);
//			glogDTO.setGlogAdate(aDate);
//		}
		
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
		
		glogService.insertGlog(glogDTO, ghpImgFile, uploadPath, contextPath);
		
		return "redirect:/workplace/detail?wpId=" + glogDTO.getGlogWpId();
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
