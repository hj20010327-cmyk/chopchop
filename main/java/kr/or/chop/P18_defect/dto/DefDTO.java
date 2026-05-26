package kr.or.chop.P18_defect.dto;

import lombok.Data;

@Data
public class DefDTO {

	private String defTypeId;
	private String defTypeName;
	private String defStandardAction;
	private String defUsage;
	
	private String searchType;
	private String searchKeyword;
	
	// 상세 - 전체 누적 개수
	private int totalDefectCnt;

	// 상세 - 최근 6개월 월별 발생 추이
	private String trendDate;
	private int trendCnt;

	// 상세 - 발생 이력
	private String dlogId;
	private String qcId;
	private int defCnt;
	private String dlogAction;
	private String dlogDispose;
	private String qcDate;
		
}
