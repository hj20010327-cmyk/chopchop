package kr.or.chop.P17_vendor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.service.VendorService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/vendor")
public class VendorListController {

    @Autowired
    private VendorService vendorService;

    @RequestMapping("/list")
    public String vendorList(
            VendorDTO vendorDTO,
            @RequestParam(value = "page", defaultValue = "1") 
            int currentPage,
            Model model) {

        int listCount = vendorService.selectVendorCount(vendorDTO);

        PageInfo pageInfo = Pagination.getPageInfo(
                listCount,
                currentPage,
                5,
                10
        );

        List<VendorDTO> vendorList =
                vendorService.selectVendorList(vendorDTO, pageInfo);

        model.addAttribute("vendorList", vendorList);
        model.addAttribute("search", vendorDTO);
        model.addAttribute("page", pageInfo);

        return "P17_vendor/vendorList.tiles";
    }
}
