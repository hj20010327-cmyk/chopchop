package kr.or.chop.P03_notice.dto;

import lombok.Data;

@Data
public class NoticeFileDTO {

    // 파일 번호 (PK)
    private int file_no;

    // 공지사항 번호 (FK)
    private int not_no;

    // 원본 파일명
    private String file_origin_name;

    // 저장 파일명
    private String file_save_name;

    // 사용 여부
    private String file_usage;
}