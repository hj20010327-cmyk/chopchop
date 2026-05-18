package kr.or.chop.P04_sugg.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class SuggDTO {
    private int sugg_no; // PK 건의사항 id
    private String sugg_title; // 건의사항 제목
    private String sugg_content; // 건의사항 내용
    private String sugg_writer; // 작성자 
    private Integer sugg_pw; // 비밀번호
    private String sugg_answer; // 답변여부
    private Date sugg_cdate; // 작성일
    private Date sugg_mdate; // 수정일
    private String sugg_usage; // 유효여부
    private String keyword;
    private int sugg_view; // 조회수 
    private int comment_count; // 댓글 수 
    private String startDate; // 검색 시작일
    private String endDate; // 검색 종료일
    private String file_origin_name;
    private String file_save_name;
}
