package kr.or.chop.P06_work.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class WorkLotDTO {

    private String lotId;
    private String lotItem;

    private int lotFqty;
    private int useQty;

    private String workId;
    private int useType;

}