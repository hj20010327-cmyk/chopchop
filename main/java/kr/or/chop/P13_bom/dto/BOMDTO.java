package kr.or.chop.P13_bom.dto;

import lombok.Data;

@Data
public class BOMDTO {

	private String bomId;
	private String bomItem;
	private String bomName;
	private String bomContent;
	private String bomUsage;

	private String itemId;
	private String itemName;
	private int itemType;
	private int itemPrice;
	private String itemSpec;
	private String itemUnit;

	private String searchType;
	private String searchKeyword;
	
}
