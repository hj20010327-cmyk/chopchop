package kr.or.chop.P08_stock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P08_stock.dto.StockDTO;
import kr.or.chop.P08_stock.service.StockService;
import kr.or.chop.common.pagination.PageInfo;

@Controller
@RequestMapping("/stock")
public class StockListController {

	@Autowired
	StockService stockService;

	@RequestMapping("/list")
	public String stockList(StockDTO stockDTO, Model model) {

		PageInfo pageInfo = new PageInfo();

		List<StockDTO> stockList = stockService.selectStockList(stockDTO, pageInfo);

		int totalCount = stockService.selectStockTotalCount(stockDTO);
		int safeCount = stockService.selectStockSafeCount();
		int warningCount = stockService.selectStockWarningCount();
		int dangerCount = stockService.selectStockDangerCount();

		model.addAttribute("stockList", stockList);
		model.addAttribute("search", stockDTO);
		model.addAttribute("pageInfo", pageInfo);

		model.addAttribute("stockTotalCount", totalCount);
		model.addAttribute("safeCount", safeCount);
		model.addAttribute("warningCount", warningCount);
		model.addAttribute("dangerCount", dangerCount);

		return "P08_stock/stockList.tiles";
	}
}