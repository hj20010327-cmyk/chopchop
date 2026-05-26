package kr.or.chop.P16_equip.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class EqDTO {

	// EQUIPMENT
	private String eqId;          // EQ_ID 설비코드
	private String eqName;        // EQ_NAME 설비명
	private int eqStatus;         // EQ_STATUS 설비상태번호
	private Date eqSdate;       // EQ_SDATE 가동시작일
	private String eqWpid;        // EQ_WPID 작업장코드
	private String eqVendor;      // EQ_VENDOR 관리업체코드
	private String eqManager;     // EQ_MANAGER 책임자(EMP_ID)

	
	// JOIN 해서 가져올 이름
	private String eqStatusName;  // EQ_STATUS_NAME 설비상태명
	private String eqVendorName;  // VENDOR_NAME 관리업체명
	private String eqManagerName; // EMP_NAME 책임자명
	private String wpName;        // WP_NAME 작업장명
	private String wpTypeName;
	private String elogWorkerName;
	
	
	// 설비 통계 (임시 계산값)
	private double totalTime;        // 전체시간
	private double runTime;          // 가동시간
	private String runRate;       // 가동률


	// EQ_LOG (점검이력)

	private String elogId;        // ELOG_ID 점검코드
	private String elogEqid;      // ELOG_EQID 설비코드
	private Date elogSdate;     // ELOG_SDATE 점검시작일
	private Date elogEdate;     // ELOG_EDATE 점검종료일
	private String elogReason;    // ELOG_REASON 점검사유
	private String elogContent;   // ELOG_CONTENT 점검내용
	private String elogResult;    // ELOG_RESULT 점검결과
	private String elogWorker;    // ELOG_WORKER 점검자(EMP_ID)
	private String elogUsage;     // ELOG_USAGE 사용여부(Y/N)


	// EQ_RUN_LOG (설비 가동이력)

	private int eqRunNo;          // EQ_RUN_NO 설비가동번호
	private String eqRunEqid;     // EQ_RUN_EQID 설비코드
	private Date eqRunStime;    // EQ_RUN_STIME 가동시작시간
	private Date eqRunEtime;    // EQ_RUN_ETIME 가동종료시간
	private String eqStopReason;  // EQ_STOP_REASON 정지사유

	// 검색
	private String searchKeyword; // 검색어

}