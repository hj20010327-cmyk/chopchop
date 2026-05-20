package kr.or.chop.P10_io.controller;

import java.sql.Timestamp;
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
import kr.or.chop.P21_manage.dto.AdminDTO;

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

		ioDTO.setIoDate(toTimestamp(ioDTO.getIoDay(),ioDTO.getIoTime()));
		
		ioService.insertIo(ioDTO);
		
		return "redirect:/io/list";
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
	
	@ResponseBody
	@RequestMapping("/workerList")
	public List<AdminDTO> workerList(String keyword) {

		return ioService.selectWorkerList(keyword);
	}
	
	private Timestamp toTimestamp(String day, String time) {
	    if (day == null || day.isEmpty() || time == null || time.isEmpty()) {
	        return null;
	    }

	    // 0:00 -> 00:00
	    if (time.length() == 4) {
	        time = "0" + time;
	    }

	    // 00:00:00 -> 00:00
	    if (time.length() >= 5) {
	        time = time.substring(0, 5);
	    }

	    return Timestamp.valueOf(day + " " + time + ":00");
	}

}