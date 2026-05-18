package kr.or.chop.P15_workplace.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class WPDTO {
	
	private String wpId;
	private String wpName;
	private int wpTypeNo;
	private String wpType;
	private String wpUsage;
	private String wpImg;
	
	private String delImg;
	
	private String wpTypeContent;
	
	private String ghpId;
	private String ghpName;
	
	private Date lastGlogDate;

	private String searchType;
	private String searchKeyword;

}
