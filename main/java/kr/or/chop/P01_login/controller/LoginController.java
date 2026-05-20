package kr.or.chop.P01_login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping("")
	public String login() {
		return "P01_login/login.empty";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loginChk(
			@RequestParam(value="empId", required=true) String empId,
			@RequestParam(value="empPw", required=true) String empPw,
			HttpSession session
		) {
		
		EmpDTO chkEmpDTO = new EmpDTO();
		chkEmpDTO.setEmpId(empId);
		chkEmpDTO.setEmpPw(empPw);
		System.out.println("chkEmpDTO : " + chkEmpDTO);

		EmpDTO resultEmpDTO = new EmpDTO();
		resultEmpDTO = loginService.selectEmp(chkEmpDTO);
		System.out.println("resultEmpDTO : " + resultEmpDTO);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (resultEmpDTO == null) {
			result.put("result", "fail");
			result.put("reason", "noId");
		} else if (!empPw.equals(resultEmpDTO.getEmpPw())) {
			result.put("result", "fail");
			result.put("reason", "wrongPw");
		} else {
			result.put("result", "success");
			result.put("emp", resultEmpDTO);
			
			// 세션 저장
			session.setAttribute("loginUser", resultEmpDTO);
		}
		
		return result;
	}

}
