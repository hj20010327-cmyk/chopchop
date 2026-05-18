package kr.or.chop.P08_stock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P08_stock.dto.StockDTO;
import kr.or.chop.P08_stock.service.StockService;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.common.pagination.PageInfo;

@Controller
@RequestMapping("/stock")
public class StockDetailController {

	@Autowired
	StockService stockService;

	@RequestMapping("/detail")
	public String stockDetail(String stockId, Model model) {

		PageInfo pageInfo = new PageInfo();

		StockDTO stock = stockService.selectStockDetail(stockId);

		List<IoDTO> ioList = stockService.selectStockIoList(stockId, pageInfo);

		model.addAttribute("stock", stock);
		model.addAttribute("ioList", ioList);
		model.addAttribute("pageInfo", pageInfo);

		return "P08_stock/stockDetail.tiles";
	}

}
