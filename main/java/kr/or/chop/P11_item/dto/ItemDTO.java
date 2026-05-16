package kr.or.chop.P11_item.dto;

import lombok.Data;

@Data
public class ItemDTO {

	private String itemId;
	private String itemName;
	private String itemType;
	private String unit;
	private String spec;
	private int unitPrice;
	private String itemStorage;
	private String itemVendor;
	private int useDate;
	private int safetyStock;
	private String itemUsage;
	
	private String searchType;
	private String searchKeyword;
	

	
	
}
