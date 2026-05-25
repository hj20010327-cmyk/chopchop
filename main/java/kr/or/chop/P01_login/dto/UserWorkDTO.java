package kr.or.chop.P01_login.dto;

import lombok.Data;

@Data
public class UserWorkDTO {
	
	private String workId;
	
	private String item;
	private String itemName;
	private String itemUnit;
	
	private String qty;
	
	private String directorId;
	private String directorName;
	private String workerId;
	private String workerName;
	
	private String status;

}
