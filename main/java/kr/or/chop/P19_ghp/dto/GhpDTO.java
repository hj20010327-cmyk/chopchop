package kr.or.chop.P19_ghp.dto;

import lombok.Data;

@Data
public class GhpDTO {
	
	private String ghpId;
	private String ghpName;
	private String ghpCategory;
	private String ghpStandard;
	private String ghpCheckMethod;
	private String ghpCycle;
	private int ghpWhType;
	private int ghpWpType;
	private Integer ghpMinValue;
	private Integer ghpMaxValue;
	private String ghpUnit;
	
}
