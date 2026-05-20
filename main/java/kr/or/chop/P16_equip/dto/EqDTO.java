package kr.or.chop.P16_equip.dto;

import lombok.Data;

@Data
public class EqDTO {

	private String eqId;
	private String eqName;
	private int eqStatus;
	private String eqSdate;
	private String eqWpid;

	private String eqStatusName;

	private int totalTime;
	private int runTime;
	private String runRate;
	
	private String elogId;
	private String elogEqid;
	private String elogSdate;
	private String elogEdate;
	private String elogReason;
	private String elogContent;
	private String elogResult;
	private String elogWorker;
	private String elogUsage;

	private int eqRunNo;
	private String eqRunEqid;
	private String eqRunStime;
	private String eqRunEtime;
	private String eqStopReason;

	private String searchKeyword;

}
