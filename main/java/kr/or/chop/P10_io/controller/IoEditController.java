package kr.or.chop.P10_io.controller;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P10_io.service.IoService;
import kr.or.chop.P21_manage.dto.AdminDTO;

@Controller
@RequestMapping("/io")
public class IoEditController {

	@Autowired
	IoService ioService;
	
	@RequestMapping("/update")
	public String updateForm(String ioId, Model model) { 
		
		IoDTO io = ioService.selectIoDetail(ioId);
		
		String dateStr = String.valueOf(io.getIoDate());
		String day = dateStr.split(" ")[0];
		String time = dateStr.split(" ")[1];

		String vendorType = "";

		if (io != null && io.getIoVendor() != null && !io.getIoVendor().equals("")) {
			vendorType = ioService.selectVendorTypeById(io.getIoVendor());
		}

		
		io.setIoDay(day);
		io.setIoTime(time);
		
		model.addAttribute("io",io);
		model.addAttribute("vendorType", vendorType);
		
		return "P10_io/ioEdit.tiles";
	}
	
	@RequestMapping("/updateDo")
	public String updateDo(IoDTO ioDTO) {
		
		// 점검 일시
		ioDTO.setIoDate(
		    toTimestamp(ioDTO.getIoDay(), ioDTO.getIoTime())
		);

		ioService.updateIo(ioDTO);
		ioService.updateLot(ioDTO);
		
		return "redirect:/io/detail?ioId=" + ioDTO.getIoId();
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
