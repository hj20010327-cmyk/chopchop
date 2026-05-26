package kr.or.chop.P22_ai.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import kr.or.chop.P22_ai.dto.AiInsightDTO;
import kr.or.chop.P22_ai.dto.AiPredictDashboardDTO;
import kr.or.chop.P22_ai.dto.AiPredictHistoryDTO;
import kr.or.chop.P22_ai.dto.AiPredictResponseDTO;
import kr.or.chop.P22_ai.dto.AiQualityDTO;
import kr.or.chop.P22_ai.dto.AiRiskChartDTO;
import kr.or.chop.P22_ai.dto.AiSummaryDTO;
import kr.or.chop.P22_ai.service.AiService;

@Controller
@RequestMapping("/ai")
public class AiController {

	@Autowired
	private AiService aiService;

	@RequestMapping("/dashboard")
	public String aiDashboard(Model model) {

		AiSummaryDTO summary = aiService.selectAiSummary();

		List<AiRiskChartDTO> riskChart = aiService.selectRiskChartData();

		AiInsightDTO insight = aiService.selectAiInsight();

		List<AiPredictHistoryDTO> recentHistory = aiService.selectRecentPredictHistory();

		AiPredictDashboardDTO predictDashboard = aiService.selectPredictDashboard();

		model.addAttribute("predictDashboard", predictDashboard);
		model.addAttribute("summary", summary);
		model.addAttribute("riskChart", riskChart);
		model.addAttribute("insight", insight);
		model.addAttribute("recentHistory", recentHistory);
		
		try {
	        String weatherUrl =
	                "https://api.openweathermap.org/data/2.5/weather"
	                + "?q=Seoul"
	                + "&appid=ce5737005f4ad5ff72d2c2d4cd2a55e5"
	                + "&units=metric";

	        RestTemplate weatherRestTemplate = new RestTemplate();

	        Map<String, Object> weatherResponse =
	                weatherRestTemplate.getForObject(weatherUrl, Map.class);

	        Map<String, Object> main =
	                (Map<String, Object>) weatherResponse.get("main");

	        List<Map<String, Object>> weatherList =
	                (List<Map<String, Object>>) weatherResponse.get("weather");

	        Map<String, Object> weather =
	                weatherList.get(0);

	        double outsideTemp =
	                Double.parseDouble(main.get("temp").toString());

	        int outsideHumidity =
	                Integer.parseInt(main.get("humidity").toString());

	        String weatherMain =
	                weather.get("main").toString();

	        model.addAttribute("outsideTemp", outsideTemp);
	        model.addAttribute("outsideHumidity", outsideHumidity);
	        model.addAttribute("weatherMain", weatherMain);

	    } catch (Exception e) {
	        model.addAttribute("outsideTemp", "-");
	        model.addAttribute("outsideHumidity", "-");
	        model.addAttribute("weatherMain", "조회 실패");
	    }

		return "P22_ai/aiDashboard.tiles";
	}

	@RequestMapping("/quality")
	public String aiQualityReport(Model model) {

		List<AiQualityDTO> aiList = aiService.selectAiQualityList();

		model.addAttribute("aiList", aiList);

		return "P22_ai/aiQualityReport.tiles";
	}

	@RequestMapping("/predict-test")
	public String predictTest(Model model) {

		String url = "http://192.168.0.50:8000/predict";

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		Map<String, Object> request = new HashMap<String, Object>();

		request.put("prod_qty", 1800);
		request.put("temperature", 35.5);
		request.put("humidity", 88.0);
		request.put("equipment_runtime", 25);
		request.put("work_shift_num", 1);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<Map<String, Object>>(request, headers);

		AiPredictResponseDTO response = restTemplate.postForObject(url, entity, AiPredictResponseDTO.class);

		model.addAttribute("predictResult", response.getRisk());

		return "P22_ai/predictResult.tiles";
	}

	@RequestMapping("/predict-form")
	public String predictForm() {

		return "P22_ai/predictForm.tiles";
	}

	@RequestMapping("/predict")
	public String predict(int prodQty, double temperature, double humidity, int equipmentRuntime, int workShiftNum,
			Model model) {

		String url = "http://192.168.0.50:8000/predict";

		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		Map<String, Object> request = new HashMap<String, Object>();

		request.put("prod_qty", prodQty);
		request.put("temperature", temperature);
		request.put("humidity", humidity);
		request.put("equipment_runtime", equipmentRuntime);
		request.put("work_shift_num", workShiftNum);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<Map<String, Object>>(request, headers);

		AiPredictResponseDTO response = restTemplate.postForObject(url, entity, AiPredictResponseDTO.class);

		AiPredictHistoryDTO history = new AiPredictHistoryDTO();

		history.setProdQty(prodQty);
		history.setTemperature(temperature);
		history.setHumidity(humidity);
		history.setEquipmentRuntime(equipmentRuntime);
		history.setWorkShiftNum(workShiftNum);
		history.setRiskLevel(response.getRisk());

		List<String> analysisReasons = getAnalysisReasons(temperature, humidity, equipmentRuntime, workShiftNum,
				response.getRisk());

		model.addAttribute("analysisReasons", analysisReasons);

		aiService.insertPredictHistory(history);

		model.addAttribute("predictResult", response.getRisk());

		model.addAttribute("prodQty", prodQty);
		model.addAttribute("temperature", temperature);
		model.addAttribute("humidity", humidity);
		model.addAttribute("equipmentRuntime", equipmentRuntime);
		model.addAttribute("workShiftNum", workShiftNum);

		return "P22_ai/predictResult.tiles";
	}

	private List<String> getAnalysisReasons(double temperature, double humidity, int equipmentRuntime, int workShiftNum,
			String riskLevel) {

		List<String> reasons = new ArrayList<String>();

		if (temperature >= 34) {
			reasons.add("생산 온도가 높아 냉동 품질 저하 가능성이 있습니다.");
		} else if (temperature >= 30) {
			reasons.add("생산 온도가 다소 높아 품질 변동 가능성이 있습니다.");
		}

		if (humidity >= 85) {
			reasons.add("습도가 높아 원재료 상태 및 결로 문제가 발생할 수 있습니다.");
		} else if (humidity >= 75) {
			reasons.add("습도가 다소 높아 품질 편차 가능성이 있습니다.");
		}

		if (equipmentRuntime >= 24) {
			reasons.add("설비 연속 가동 시간이 길어 설비 부담이 증가한 상태입니다.");
		} else if (equipmentRuntime >= 16) {
			reasons.add("설비 가동 시간이 다소 길어 점검이 필요할 수 있습니다.");
		}

		if (workShiftNum == 1) {
			reasons.add("야간 작업으로 인해 품질 관리 위험도가 증가할 수 있습니다.");
		}

		if (reasons.isEmpty()) {
			reasons.add("입력된 생산 환경 조건이 비교적 안정적인 범위에 있습니다.");
		}

		if ("HIGH".equals(riskLevel)) {
			reasons.add("종합적으로 품질 위험도가 높으므로 생산 전 설비 및 작업 환경 점검을 권장합니다.");
		} else if ("MEDIUM".equals(riskLevel)) {
			reasons.add("일부 위험 요인이 확인되어 작업 중 품질 모니터링이 필요합니다.");
		} else {
			reasons.add("현재 조건에서는 품질 위험도가 낮은 편입니다.");
		}

		return reasons;
	}
	
	@ResponseBody
	@RequestMapping("/weather")
	public Map<String, Object> getWeather() {

	    Map<String, Object> result = new HashMap<String, Object>();

	    try {

	        String weatherUrl =
	                "https://api.openweathermap.org/data/2.5/weather"
	                + "?q=Seoul"
	                + "&appid=ce5737005f4ad5ff72d2c2d4cd2a55e5"
	                + "&units=metric";

	        RestTemplate restTemplate = new RestTemplate();

	        Map<String, Object> weatherResponse =
	                restTemplate.getForObject(weatherUrl, Map.class);

	        Map<String, Object> main =
	                (Map<String, Object>) weatherResponse.get("main");

	        double temp =
	                Double.parseDouble(main.get("temp").toString());

	        int humidity =
	                Integer.parseInt(main.get("humidity").toString());

	        result.put("temp", temp);
	        result.put("humidity", humidity);
	        result.put("success", true);

	    } catch (Exception e) {

	        result.put("success", false);
	    }

	    return result;
	}
}