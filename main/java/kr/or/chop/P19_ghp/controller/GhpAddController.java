package kr.or.chop.P19_ghp.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.P19_ghp.service.GhpService;

@Controller
@RequestMapping("/ghp")
public class GhpAddController {

	@Autowired
	private GhpService ghpService;

	@RequestMapping("/add")
	public String addForm() {
		return "P19_ghp/ghpAdd.tiles";
	}

	@RequestMapping("/insertDo")
	public String insertDo(GhpDTO ghpDTO) {

		ghpService.insertGhp(ghpDTO);

		return "redirect:/ghp/list";
	}
	
	@ResponseBody
	@RequestMapping("/targetList")
	public List<Map<String, Object>> targetList(String targetType, String keyword) {
		return ghpService.selectTargetList(targetType, keyword);
	}
	
}
