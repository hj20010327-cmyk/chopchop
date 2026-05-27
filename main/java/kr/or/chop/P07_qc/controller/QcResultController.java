package kr.or.chop.P07_qc.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.P07_qc.service.QcService;

@Controller
@RequestMapping("/quality/result")
public class QcResultController {

	@Autowired
	private QcService qcService;

	@RequestMapping("/add")
	public String resultAdd(String qcId, Model model) {

		QcDTO qc = qcService.selectQcDetail(qcId);
		List<QcDTO> defLogList = qcService.selectDefLogList(qcId);

		model.addAttribute("qc", qc);
		model.addAttribute("defLogList", defLogList);

		return "P07_qc/qcResultAdd.tiles";
	}

	@RequestMapping("/insertDo")
	public String resultInsertDo(QcDTO qcDTO) {

		qcService.updateQcResult(qcDTO);

		return "redirect:/quality/detail?qcId=" + qcDTO.getQcId();
	}
	
	@ResponseBody
	@RequestMapping("/defectTypeList")
	public List<QcDTO> defectTypeList() {
	    return qcService.selectDefectTypeList();
	}
	
	@ResponseBody
	@RequestMapping("/warehouseList")
	public List<QcDTO> warehouseList(String itemId) {

	    return qcService.selectWarehouseListByItem(itemId);

	}

	@ResponseBody
	@RequestMapping("/sectionList")
	public List<QcDTO> sectionList(String whId) {

	    return qcService.selectSectionListByWarehouse(whId);

	}

}
