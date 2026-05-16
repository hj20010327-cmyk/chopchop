package kr.or.chop.P19_ghp.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class GlogDTO {
	
	private String glogId;
	private Date glogDate;
	private String glogWorker;
	private int glogValue = -9999;
	private String glogResult;
	private	String glogAction;
	private Date glogAdate;
	private String glogImg;
	private String glogMemo;
	private Date glogCdate;
	
	private String ghpId;
	private String ghpName;
	private String ghpCategory;
	private String ghpStandard;
	private String ghpCheckMethod;
	private String ghpCycle;
	private String ghpWhId;
	private String ghpWpId;
	private int ghpMinValue = -9999;
	private int ghpMaxvalue = -9999;
	private String ghpUnit;
	
}
