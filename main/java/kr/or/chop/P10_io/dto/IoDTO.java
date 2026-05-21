package kr.or.chop.P10_io.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class IoDTO {

	private String ioId;
    private String ioType;
    private String ioReason;
    private String ioVendor;
    private String vendorName;
    private String ioLot;
    private int ioQty;
    private Timestamp ioDate;
    private String ioDay;
    private String ioTime;
    
    private String ioWorker;
    private String ioMsg;
    private String itemId;
    private String itemName;
    private String itemType;
    private String workerName;
    private String whSec;
    private String whId;

    private String startDate;
    private String endDate;
    private String searchKeyword;
    private String searchType;
	
}
