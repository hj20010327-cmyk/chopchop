package kr.or.chop.P14_warehouse.dto;

import lombok.Data;

@Data
public class SecDTO {
	
	private String secId;
	private String secWhId;
	private String secWhName;
	private int secQty;
	private int secPrevQty;
	private double secUsageRate;
	private String secUsage;
	private String secImg;

}
