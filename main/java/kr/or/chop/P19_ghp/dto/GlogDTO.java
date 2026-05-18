package kr.or.chop.P19_ghp.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class GlogDTO {
	
	private String glogId;
	
	private Timestamp glogDate;
	private String glogDay;
	private String glogTime;
	
	private String glogWorker;
	private String glogWName;
	private int glogValue = -9999;
	private String glogResult;
	
	private	String glogAction;
	private Timestamp glogAdate;
	private String glogAday;
	private String glogAtime;
	
	private String glogImg;
	private String glogMemo;
	
	private Timestamp glogCdate;
	
	private String glogWhId;
	private String glogWhName;
	private String glogWpId;
	private String glogWpName;
	
	private String ghpId;
	private String ghpName;
	private String ghpCategory;
	private String ghpStandard;
	private String ghpCheckMethod;
	private String ghpCycle;
	private Integer ghpWhType;
	private Integer  ghpWpType;
	private Integer ghpMinValue;
	private Integer ghpMaxValue;
	private String ghpUnit;
	
	private String delImg;
	
}
