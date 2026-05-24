package kr.or.chop.P17_vendor.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P17_vendor.dto.VendorIoDTO;
import kr.or.chop.P17_vendor.service.VendorService;
import kr.or.chop.common.pagination.PageInfo;
import kr.or.chop.common.pagination.Pagination;

@Controller
@RequestMapping("/vendor")
public class VendorDetailController {

    @Autowired
    private VendorService vendorService;

    @RequestMapping("/detail")
    public String vendorDetail(
            @RequestParam("vendorId") String vendorId,
            @RequestParam(value = "page", defaultValue = "1") int currentPage,
            Model model) {

        VendorDTO vendor =
                vendorService.selectVendorDetail(vendorId);

        int listCount =
                vendorService.selectVendorIoCount(vendorId);

        PageInfo pageInfo =
                Pagination.getPageInfo(
                        listCount,
                        currentPage,
                        5,
                        10
                );

        List<VendorIoDTO> vendorIoList =
                vendorService.selectVendorIoList(vendorId, pageInfo);

        model.addAttribute("vendor", vendor);
        model.addAttribute("vendorIoList", vendorIoList);
        model.addAttribute("page", pageInfo);

        return "P17_vendor/vendorDetail.tiles";
    }
}