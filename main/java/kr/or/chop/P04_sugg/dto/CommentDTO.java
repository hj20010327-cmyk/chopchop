package kr.or.chop.P04_sugg.dto;

import java.sql.Date;

import lombok.Data;
@Data
public class CommentDTO {
    private int comm_no; // PK 댓글 id
    private int comm_sugg_no; // FK 원글 id
    private Integer comm_parent; // FK  부모 댓글
    private String comm_content; // 댓글 내용
    private Date comm_cdate; // 작성일
    private Date comm_mdate; // 수정일
    private String comm_usage; // 유효여부 
    private String comm_writer; // FK
    private int comm_level;
    private String empName;

}
