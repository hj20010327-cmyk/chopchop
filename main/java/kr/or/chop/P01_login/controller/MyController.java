package kr.or.chop.P01_login.controller;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P01_login.service.MyService;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;
import kr.or.chop.P23_alarm.dto.AlarmDTO;
import kr.or.chop.P23_alarm.service.AlarmService;

@Controller
@RequestMapping("/mypage")
public class MyController {

	@Autowired
	MyService myService;
	
	@Autowired
	HttpSession session;
	
	@Autowired
    private AlarmService alarmService;
	
	
	@RequestMapping("")
	public String mypage(
			Model model
		) {
		EmpDTO loginUser = (EmpDTO)session.getAttribute("loginUser");
		
		if (loginUser == null) {
            model.addAttribute("alarmList", Collections.emptyList());
            return "P01_login/myAlarm.tiles";
        }

        List<AlarmDTO> alarmList = alarmService.selectMyAlarmList(
            loginUser.getEmpId(),
            loginUser.getEmpDeptno(),
            loginUser.getEmpAuth()
        );
		
		List<UserWorkDTO> workList = myService.selectAllWork(loginUser); 
		List<SuggDTO> suggList = myService.selectAllSugg(loginUser);
		List<NoticeDTO> notList = myService.selectAllNotice(loginUser);
		
		AdminActivityDTO actWork = myService.workCnt(loginUser);
		
		model.addAttribute("user", loginUser);
		model.addAttribute("workList", workList);
		model.addAttribute("suggList", suggList);
		model.addAttribute("notList", notList);
		model.addAttribute("alarmList", alarmList);
		model.addAttribute("actWork", actWork);
		
		return "P01_login/mypage.tiles";
	}
	
	@RequestMapping("/edit")
	public String myEdit(
			Model model
			) {
		EmpDTO loginUser = (EmpDTO)session.getAttribute("loginUser");
		
		List<UserWorkDTO> workList = myService.selectAllWork(loginUser); 
		List<SuggDTO> suggList = myService.selectAllSugg(loginUser);
		
		model.addAttribute("user", loginUser);
		
		return "P01_login/myEdit.tiles";
	}
	

	@PostMapping("/update")
	public String update (
			EmpDTO empDTO,
			@RequestParam("empImgFile") MultipartFile empImgFile,
	        HttpServletRequest request,
	        HttpSession session
			) throws Exception {
		String uploadPath = "D:/chop_upload/P02_login/user_profile";
		String uploadUrl = "/upload/P02_login/user_profile";
	    
	    myService.updateUser(empDTO, empImgFile, uploadPath, uploadUrl);
		
	    EmpDTO loginUser = myService.reSelectUserInfo(empDTO);
	    
	    session.setAttribute("loginUser", loginUser);
	    
		return "redirect:/mypage?empId=" + empDTO.getEmpId();
	}
	
}
