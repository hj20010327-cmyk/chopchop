package kr.or.chop.P19_ghp.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class GlogDTO {
	
	private String glogId;
	
	private Date glogDate;
	private String glogDay;
	private String glogTime;
	
	private String glogWorker;
	private int glogValue = -9999;
	private String glogResult;
	
	private	String glogAction;
	private Date glogAdate;
	private String glogAday;
	private String glogAtime;
	
	private String glogImg;
	private String glogMemo;
	
	private Date glogCdate;
	
	private String glogWhId;
	private String glogWpId;
	
	private String ghpId;
	private String ghpName;
	private String ghpCategory;
	private String ghpStandard;
	private String ghpCheckMethod;
	private String ghpCycle;
	private int ghpWhType;
	private int  ghpWpType;
	private Integer ghpMinValue;
	private Integer ghpMaxvalue;
	private String ghpUnit;
	
}
