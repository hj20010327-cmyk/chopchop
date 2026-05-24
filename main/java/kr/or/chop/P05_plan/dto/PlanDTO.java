package kr.or.chop.P05_plan.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class PlanDTO {
	
	private String planId;
	private String planStatus;
	
	private String planItem;
	private String planItemType;
	private String planItemName;
	private String planItemUnit;
	
	private int planFinQty;
	private int planWpQty = 0;
	private int planWorkingQty;
	
	private Date planSdate;
	private Date planEdate;
	
	private String planDirector;
	private String planDname;

	private Timestamp planCdate;
	private Timestamp planMdate;
	
	private String planDmsg;
	
	private String planSearchSdate;
	private String planSearchEdate;
	private Integer searchType;
	private String searchKeyword;
	
//	private String cardType;
	private List<String> cardTypes;
	private int totalCnt;
	private int ingCnt;
	private int waitCnt;
	private int finCnt;
	private int delayCnt;
	private int etcCnt;
	
	public int getProgressRate() {
		if (planFinQty <= 0) {
			return 0;
		}
		
		return (int) Math.round((planWpQty * 100.0) / planFinQty);
	}
	
	public int getWorkingRate() {
		if (planFinQty <= 0) {
			return 0;
		}
		
		return (int) Math.round((planWorkingQty * 100.0) / planFinQty);
	}
	
}
