package kr.or.chop.P07_qc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.P07_qc.service.QcService;

@Controller
@RequestMapping("/quality")
public class QcDetailController {

	@Autowired
	private QcService qcService;

	@RequestMapping("/detail")
	public String detail(String qcId, Model model) {

		QcDTO qc = qcService.selectQcDetail(qcId);
		List<QcDTO> defLogList = qcService.selectDefLogList(qcId);

		model.addAttribute("qc", qc);
		model.addAttribute("defLogList", defLogList);

		return "P07_qc/qcDetail.tiles";
	}

}
