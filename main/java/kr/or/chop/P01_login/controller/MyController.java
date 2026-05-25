package kr.or.chop.P01_login.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P01_login.service.MyService;
import kr.or.chop.P04_sugg.dto.SuggDTO;

@Controller
@RequestMapping("/mypage")
public class MyController {

	@Autowired
	MyService myService;
	
	@Autowired
	HttpSession session;
	
	
	@RequestMapping("")
	public String mypage(
			Model model
		) {
		EmpDTO loginUser = (EmpDTO)session.getAttribute("loginUser");
		
		List<UserWorkDTO> workList = myService.selectAllWork(loginUser); 
		List<SuggDTO> suggList = myService.selectAllSugg(loginUser);
		
		model.addAttribute("user", loginUser);
		model.addAttribute("workList", workList);
		model.addAttribute("suggList", suggList);
		
		return "P01_login/mypage.tiles";
	}
	
}
