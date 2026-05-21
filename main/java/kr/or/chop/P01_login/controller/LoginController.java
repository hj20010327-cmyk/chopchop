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
import kr.or.chop.common.util.Sha256Util;

@Controller
public class LoginController {
	
	@Autowired
	LoginService loginService;
	
	@RequestMapping("/login")
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

		System.out.println("chkEmpDTO : " + chkEmpDTO);

		EmpDTO resultEmpDTO = new EmpDTO();
		resultEmpDTO = loginService.selectEmp(chkEmpDTO);
		System.out.println("resultEmpDTO : " + resultEmpDTO);

		String encPw = Sha256Util.encrypt(empPw);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (resultEmpDTO == null) {
			result.put("result", "fail");
			result.put("reason", "noId");
		} else if (!encPw.equals(resultEmpDTO.getEmpPw())) {
			result.put("result", "fail");
			result.put("reason", "wrongPw");
		} else {
			result.put("result", "success");
			result.put("emp", resultEmpDTO);
			
			// 세션 저장
			session.setAttribute("loginUser", resultEmpDTO);
			
			// 최초 로그인 여부 및 이동할 url
			if ("Y".equals(resultEmpDTO.getEmpFirst())) {
				result.put("redirectUrl", "/login/changePw");
			} else {
				result.put("redirectUrl", "/dashboard");
			}
		}
		
		return result;
	}
	
	
	/* ==================================== */
	
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
	    session.invalidate();
	    return "redirect:/login";
	}
	
	
	/* ==================================== */
	
	
	@RequestMapping("/login/tempPw")
	public String tempPw() {
		return "P01_login/tempPw.empty";
	}
	
	@RequestMapping(value="/login/tempPw.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> sendTempPw(
			EmpDTO empDTO
		) {
		System.out.println(empDTO);
		Map<String, Object> result = new HashMap<String, Object>();
		
		try {
            boolean success = loginService.issueTempPw(empDTO);

            if (success) {
                result.put("result", "success");
            } else {
                result.put("result", "fail");
                result.put("message", "wrongEmail");
            }
        } catch (Exception e) {
            e.printStackTrace();

            result.put("result", "fail");
            result.put("message", "error");
        }

        return result;
	}




/* ==================================== */



	@RequestMapping("/login/changePw")
	public String changePw() {
		return "P01_login/changePw.empty";
	}
	
	@RequestMapping("/login/changePw.do")
	public String changePwDo(
			@RequestParam (value="empPw", required=true) String empPw,
			HttpSession session
		) {
		EmpDTO loginUser = (EmpDTO) session.getAttribute("loginUser");
		System.out.println("loginUser : " + loginUser);
		
		loginUser.setEmpPw(empPw);
		loginService.updatePw(loginUser);
		
		return "redirect:/login";
	}
	
	
}