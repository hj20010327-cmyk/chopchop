package kr.or.chop.P02_dashboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P02_dashboard.service.DashboardService;
import kr.or.chop.P02_dashboard.service.RefreshService;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

	@Autowired
	RefreshService refService;

	@Autowired
	DashboardService dashboardService;

	@RequestMapping("")
	public String dashboard(Model model) {

		refService.refreshStatus();

		model.addAttribute("todaySummary", dashboardService.selectTodaySummary());
		model.addAttribute("eqStatusSummary", dashboardService.selectEqStatusSummary());
		model.addAttribute("warehouseTopList", dashboardService.selectWarehouseTopList());
		model.addAttribute("weeklyWorkChart", dashboardService.selectWeeklyWorkChart());
		model.addAttribute("weeklyDefectChart", dashboardService.selectWeeklyDefectChart());
		model.addAttribute("todayWorkList", dashboardService.selectTodayWorkList());
		model.addAttribute("kpiList", dashboardService.selectKpiList());
		model.addAttribute("recentNoticeList", dashboardService.selectRecentNoticeList());

		return "P02_dashboard/dashboard.tiles";
	}

}