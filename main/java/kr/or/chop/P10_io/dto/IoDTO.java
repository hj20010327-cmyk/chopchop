package kr.or.chop.P10_io.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class IoDTO {

	private String ioId;
    private String ioType;
    private String ioReason;
    private String ioVendor;
    private String ioLot;
    private int ioQty;
    private Date ioDate;
    private String ioWorker;
    private String ioMsg;

    private String startDate;
    private String endDate;
    private String searchKeyword;
    private String searchType;
	
}
