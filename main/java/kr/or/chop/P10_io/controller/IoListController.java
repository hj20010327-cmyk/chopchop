package kr.or.chop.P10_io.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P10_io.service.IoService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/io")
public class IoListController {

	@Autowired
    IoService ioService;

    @RequestMapping("/list")
    public String ioList(IoDTO ioDTO, Model model,
    		@RequestParam(value="page", defaultValue="1")
    		int currentPage
    		) {

    	int listCount = ioService.selectIoCount(ioDTO);
		
		PageInfo pageInfo = Pagination.getPageInfo(
				listCount, 
				currentPage, 
				5, 
				10);
    	
    	

        List<IoDTO> ioList = ioService.selectIoList(ioDTO, pageInfo);

        model.addAttribute("ioList", ioList);
        model.addAttribute("search", ioDTO);
        model.addAttribute("page", pageInfo);

        return "P10_io/ioList.tiles";
    }
	
}
