package kr.or.chop.P21_manage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.service.MyService;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.P21_manage.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminDetailController {

    @Autowired
    AdminService adminService;
    @Autowired
    MyService myService;

    @RequestMapping("/detail")
    public String adminDetail(String empId, Model model) {

        AdminDTO admin = adminService.selectAdminDetail(empId);
        AdminActivityDTO activity = adminService.selectAdminActivity(empId);
        
        EmpDTO emp = new EmpDTO();
        emp.setEmpId(empId);
        List<SuggDTO> suggList = myService.selectAllSugg(emp);

        model.addAttribute("admin", admin);
        model.addAttribute("activity", activity);
        model.addAttribute("suggList", suggList);

        return "P21_manage/adminDetail.tiles";
    }
}