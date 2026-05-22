package kr.or.chop.P05_plan.dto;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class PlanDTO {
	
	private String planId;
	
	private String planItem;
	private String planItemName;
	private String planItemunit;
	
	private int planFinQty;
	private int planWpQty = 0;
	
	private Date planSdate;
	private Date planEdate;
	
	private String planDirector;
	private String planDname;

	private Date planCdate;
	private Date planMdate;
	
	private Date planSearchSdate;
	private Date planSearchEdate;
	private Integer searchType;
	private String searchKeyword;
	
//	private String cardType;
	private List<String> cardTypes;
	private int totalCnt;
	private int ingCnt;
	private int waitCnt;
	private int finCnt;
	private int stopCnt;
	private int etcCnt;
	
}
