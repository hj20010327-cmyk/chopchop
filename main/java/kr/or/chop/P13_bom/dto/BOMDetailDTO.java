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
    private int itemType;
    private String itemUnit;
    private String itemSpec;
    private int itemPrice;
    
    private String[] bomDtlItemList;
    private int[] bomDtlQtyList;
}