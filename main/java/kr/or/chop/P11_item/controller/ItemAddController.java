package kr.or.chop.P11_item.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P11_item.service.ItemService;
import kr.or.chop.P17_vendor.dto.VendorDTO;

@Controller
@RequestMapping("/item")
public class ItemAddController {

	@Autowired
	private ItemService itemService;
	
	// 등록 페이지 이동
	@RequestMapping("/add")
	public String itemAddForm(Model model,
				VendorDTO vendorDTO
			) {
		
		List<VendorDTO> vendors = itemService.selectVendors(vendorDTO);
		System.out.println("controller "+vendors);
		model.addAttribute("vendors",vendors);
		return "P11_item/itemAdd.tiles";
	}
	
	// 품목 등록
	@PostMapping("/insert")
	public String insertItem(
				@ModelAttribute ItemDTO itemDTO
			) {
		itemService.insertItem(itemDTO);
		
		return "redirect:/item/list";
	}
	
}
