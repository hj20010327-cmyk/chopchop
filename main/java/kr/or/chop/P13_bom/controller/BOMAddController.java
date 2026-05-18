package kr.or.chop.P13_bom.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.dto.BOMDetailDTO;
import kr.or.chop.P13_bom.service.BOMService;

@Controller
@RequestMapping("/bom")
public class BOMAddController {

	@Autowired
	BOMService bomService;

	@RequestMapping("/add")
	public String bomAdd(Model model) {

		List<BOMDTO> finishItemList = bomService.selectFinishItemList();
		List<BOMDTO> materialItemList = bomService.selectMaterialItemList();

		model.addAttribute("finishItemList", finishItemList);
		model.addAttribute("materialItemList", materialItemList);

		return "P13_bom/bomAdd.tiles";
	}

	@RequestMapping("/insert")
	public String bomInsert(
	        BOMDTO bomDTO,
	        BOMDetailDTO detailDTO) {

	    bomService.insertBom(bomDTO);

	    String[] itemList = detailDTO.getBomDtlItemList();
	    int[] qtyList = detailDTO.getBomDtlQtyList();

	    if (itemList != null && qtyList != null) {
	        for (int i = 0; i < itemList.length; i++) {

	            BOMDetailDTO dto = new BOMDetailDTO();

	            dto.setBomDtlBom(bomDTO.getBomId());
	            dto.setBomDtlItem(itemList[i]);
	            dto.setBomDtlQty(qtyList[i]);

	            bomService.insertBomDetail(dto);
	        }
	    }

	    return "redirect:/bom/list";
	}
}