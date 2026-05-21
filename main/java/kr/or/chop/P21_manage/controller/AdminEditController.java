package kr.or.chop.P21_manage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.P21_manage.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminEditController {

	@Autowired
	AdminService adminService;

	@RequestMapping("/edit")
	public String adminEdit(String empId, Model model) {

		AdminDTO admin = adminService.selectAdminDetail(empId);

		model.addAttribute("admin", admin);

		return "P21_manage/adminEdit.tiles";
	}

	@RequestMapping("/update")
	public String adminUpdate(AdminDTO adminDTO) {

		adminService.updateAdmin(adminDTO);

		return "redirect:/admin/detail?empId=" + adminDTO.getEmpId();
	}

	@RequestMapping("/delete")
	public String adminDelete(String empId) {

		adminService.deleteAdmin(empId);

		return "redirect:/admin/list";
	}
}