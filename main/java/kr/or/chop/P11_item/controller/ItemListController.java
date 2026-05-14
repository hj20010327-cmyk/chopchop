package kr.or.chop.P11_item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P11_item.service.ItemService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/item")
public class ItemListController {

	@Autowired
	ItemService itemService;
	
	@RequestMapping("/list")
	public String list(Model model,
			ItemDTO itemDTO,
			@RequestParam(value="page", defaultValue="1")
			int currentPage
		) {
		
		int listCount = itemService.selectItemCount(itemDTO);
		
		PageInfo pageInfo = Pagination.getPageInfo(
				listCount, 
				currentPage, 
				5, 
				10);
		
		
		List<ItemDTO> result = itemService.ItemSelectAll(itemDTO, pageInfo);
		model.addAttribute("items", result);
		
		return "P11_item/itemList.tiles";
	}
	
}
