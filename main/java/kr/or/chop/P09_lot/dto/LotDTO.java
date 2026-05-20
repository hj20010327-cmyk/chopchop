package kr.or.chop.P09_lot.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class LotDTO {

	private String lotId;
	private String lotItem;
	private String lotItemName;
	private String lotVendor;
	private String lotWork;
	private int lotQty;
	private int lotFqty;
	private Timestamp lotMfd;
	private Timestamp lotEtw;
	private Timestamp lotExp;
	private String lotQc;
	private String lotStatus;
	private String lotMemo;
	private String lotBwhsec;
	private String lotAwhsec;
	private String itemType;
	private int lotCqty;
	
	private String searchType;
	private String searchKeyword;
	
}
