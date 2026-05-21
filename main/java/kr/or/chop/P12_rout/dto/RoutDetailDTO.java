package kr.or.chop.P12_rout.dto;

import lombok.Data;

@Data
public class RoutDetailDTO {

    // ROUTING_DETAIL
    private String routDtlId;
    private String routDtlRout;
    private int routDtlStep;
    private String routDtlProc;
    private String routDtlUsage;

    // PROCESS
    private String procId;
    private String procName;
    private String procContent;
    private String procUsage;
    private int procWpType;

    // WP_TYPE
    private int wpTypeNo;
    private String wpTypeName;
    private String wpTypeContent;
    
    // EQUIPMENT 요약
    private int eqCount;
    private String firstEqName;

    // 등록/수정 form 배열
    private String[] procIdList;
    private String[] procNameList;
    private String[] procContentList;
    private int[] procWpTypeList;
}