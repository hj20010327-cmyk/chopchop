package kr.or.chop.P10_io.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P10_io.service.IoService;

@Controller
@RequestMapping("/io")
public class IoDetailController {

    @Autowired
    IoService ioService;

    @RequestMapping("/detail")
    public String ioDetail(String ioId, Model model) {

        IoDTO io = ioService.selectIoDetail(ioId);

        model.addAttribute("io", io);

        return "P10_io/ioDetail.tiles";
    }
}