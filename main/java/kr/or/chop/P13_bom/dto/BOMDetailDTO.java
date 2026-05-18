package kr.or.chop.P13_bom.dto;

import lombok.Data;

@Data
public class BOMDetailDTO {

    private String bomDtlId;
    private String bomDtlBom;
    private String bomDtlItem;
    private int bomDtlQty;
    private String bomDtlUsage;

    private String itemName;
    private String itemType;
    
    private String[] bomDtlItemList;
    private int[] bomDtlQtyList;
}