package kr.or.chop.P09_lot.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class LotDTO {

	private String lotId;
	private String lotItem;
	private String lotVendor;
	private String lotWork;
	private int lotIqty;
	private int lotFqty;
	private Date lotMfd;
	private Date lotEtw;
	private Date lotExp;
	private String lotQc;
	private String lotStatus;
	private String lotMemo;
	private String lotBwhsec;
	private String lotAwhsec;
	
	private String searchType;
	private String searchKeyword;
	
}
