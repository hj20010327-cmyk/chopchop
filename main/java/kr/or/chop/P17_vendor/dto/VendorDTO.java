package kr.or.chop.P17_vendor.dto;

import java.util.List;

import lombok.Data;

@Data
public class VendorDTO {

	private String vendorId;
	private String vendorName;
	private String vendorType;
	private String vendorTel;
	private String vendorEmail;
	private String vendorZipcode;
	private String vendorAddr;
	private String vendorAddrDetail;
	private String vendorUsage;
	
	private String searchType;
	private String searchKeyword;
	
	private int vendorTypeCount;
	private List<String> searchTypes;
	
}
