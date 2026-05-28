package kr.or.chop.P07_qc.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class QcDTO {

	private String qcId;
	private String qcLot;
	private String qcType;
	private String qcContent;
	private int qcQty;
	private int qcStatus;
	private Timestamp qcOdate;
	private String qcDirector;
	private String qcDmsg;
	private Timestamp qcDate;
	private String qcWmsg;
	private int qcPassQty;
	private String qcUsage;
	private String qcTypeName;
	private String qcStatusName;

	private String directorName;
	private String workerName;

	
	private String qcWorker;

	private String lotId;
	private int lotQty;
	private String itemId;
	private String itemName;
	private String itemQcType;
	private String itemQcTypeName;
	
	private int todayQty;
	private int passQty;
	private int failQty;
	private double failRate;
	
	private String defTypeId;
	private String defTypeName;
	private String defStandardAction;
	
	private String awhsec;
	private String secId;
	private String whId;
	private String whName;
	private String whTypeNo;
	
	private int secQty;
	private int secPrevQty;
	
	private String startDate;
	private String endDate;
	private String searchKeyword;
	private String searchType;
	
	private String[] defectType;
	private int[] defectQty;
	private String[] defectAction;
	private String[] defectDiscard;
	
	private String defType;
	private int defQty;
	private String defAction;
	private String defDiscard;
	
	private int inQty;
	private int disposeQty;
	
	
}
