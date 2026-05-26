package kr.or.chop.P21_manage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P21_manage.dto.AdminActivityDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.P21_manage.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminDetailController {

    @Autowired
    AdminService adminService;

    @RequestMapping("/detail")
    public String adminDetail(String empId, Model model) {

        AdminDTO admin = adminService.selectAdminDetail(empId);
        AdminActivityDTO activity = adminService.selectAdminActivity(empId);

        model.addAttribute("admin", admin);
        model.addAttribute("activity", activity);

        return "P21_manage/adminDetail.tiles";
    }
}