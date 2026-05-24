package kr.or.chop.P17_vendor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
            VendorDTO search,
            Integer page,
            Model model) {

        int currentPage = 1;

        if(page != null) {
            currentPage = page;
        }

        int listCount =
                vendorService.selectVendorCount(search);

        PageInfo pageInfo =
                Pagination.getPageInfo(
                        listCount,
                        currentPage,
                        5,
                        10
                );

        List<VendorDTO> vendorList =
                vendorService.selectVendorList(search, pageInfo);

        int totalVendorCount =
                vendorService.selectVendorCount(new VendorDTO());

        List<VendorDTO> vendorTypeSummary =
                vendorService.selectVendorTypeSummary();

        model.addAttribute("vendorList", vendorList);
        model.addAttribute("search", search);
        model.addAttribute("page", pageInfo);

        model.addAttribute("totalVendorCount", totalVendorCount);
        model.addAttribute("vendorTypeSummary", vendorTypeSummary);

        return "P17_vendor/vendorList.tiles";
    }
}