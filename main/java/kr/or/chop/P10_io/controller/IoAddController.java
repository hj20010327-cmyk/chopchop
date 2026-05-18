package kr.or.chop.P10_io.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P10_io.service.IoService;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;

@Controller
@RequestMapping("/io")
public class IoAddController {

	@Autowired
	IoService ioService;

	@RequestMapping("/insert")
	public String insertForm(Model model) {

		List<VendorDTO> vendorList = ioService.selectVendorList();

		model.addAttribute("vendorList", vendorList);

		return "P10_io/ioAdd.tiles";
	}

	@RequestMapping("/insertDo")
	public String insertDo(IoDTO ioDTO) {

		ioService.insertIo(ioDTO);

		return "redirect:/io/list.tiles";
	}

	@ResponseBody
	@RequestMapping("/itemList")
	public List<ItemDTO> itemList(String itemType) {

		return ioService.selectItemListByType(itemType);
	}
	
	@ResponseBody
	@RequestMapping("/lotList")
	public List<LotDTO> lotList(String itemId) {

	    return ioService.selectLotListByItem(itemId);
	}

}