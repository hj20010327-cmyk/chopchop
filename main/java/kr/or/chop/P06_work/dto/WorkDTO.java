package kr.or.chop.P06_work.dto;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class WorkDTO {
	
	private String workId;
	private String workPlan;
	
	private String workItem;
    private String workItemName;
    private String workItemUnit;
	
    private int workOrderQty;
	private Integer workPrevQty;
	
	// 작업지시는 시간 안 따지고 일자까지만 따질 거니까 그냥 date로 했음
	private Date workDate;
	
	private String workDirector;
	private String workDname;
	private String workDmsg;
	
	private String workWorker;
	private String workWname;
	private String workWmsg;
	
	private int workStatus;
	
	private Timestamp workCdate;
	private Timestamp workMdate;
	
	// 검색 조건
    private String workSearchSdate;
    
    private String workSearchEdate;
    private Integer searchType;
    private String searchKeyword;

    // 카드 선택
    private List<String> cardTypes;

    // 카드 수량
    private int totalCnt;
    private int finCnt;
    private int ingCnt;
    private int waitCnt;
    private int delayCnt;
    private int etcCnt;
    
    
    
    // Detail
    private String routId;
    private String routName;
    private String routContent;
    private String routDtlId;
    private int routDtlStep;

    private String procId;
    private String procName;
    private String procContent;
    private Integer procWpType;

    private String wpId;
    private String wpName;
    private Integer wpType;

    private String eqId;
    private String eqName;
    
    // 공정별 작업장/설비 목록
    private List<WorkDTO> wpList;
    private List<WorkDTO> eqList;
    
    public int getProgressRate() {
    	if (workOrderQty <= 0) {
    		return 0;
    	}
    	
    	int prevQty = (workPrevQty == null) ? 0 : workPrevQty;
    	
    	return (int) Math.round((workPrevQty * 100.0) / workOrderQty);
    }
    
    // 수량 제한용
    private int planFinQty;
    private int planWorkingQty;
    private int otherWorkingQty;
    private int editableMaxQty;
    
    private Date planSdate;
    private Date planEdate;
    
    // LOT 위치
    private String lotBwhsec;
    
    // BOM
    private List<WorkBomDTO> bomList;
    
    // 완료 시 생성 LOT
    private String lotId;
    
}
