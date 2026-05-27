package kr.or.chop.P03_notice.dto;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class NoticeDTO {

    // 공지사항 번호 (PK)
    private int not_no;

    // 공지 제목
    private String not_title;

    // 공지 내용
    private String not_content;

    // 작성자 (EMP_ID FK)
    private String not_writer;

    // 조회수
    private int not_view;

    // 작성일
    private Date not_cdate;

    // 수정일
    private Date not_mdate;

    // 사용 여부 (Y / N)
    private String not_usage;

    // 작성자 이름 조인용
    private String empName;

    // 검색용
    private String keyword;

    // 기간 검색용
    private String startDate;

    private String endDate;

    // 첨부파일 리스트
    private List<NoticeFileDTO> fileList;
}