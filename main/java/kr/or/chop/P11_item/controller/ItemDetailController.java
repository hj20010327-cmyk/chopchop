package kr.or.chop.P11_item.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P11_item.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemDetailController {

	@Autowired
	ItemService itemService;
	
	@RequestMapping("/detail")
	public String detail(Model model,
				LotDTO lotDTO,
				ItemDTO itemDTO,
				@RequestParam(value="page", defaultValue="1")
				int currentPage
			) {
		
		
		
		return "P11_item/itemDetail.tiles";
	}
	
}
