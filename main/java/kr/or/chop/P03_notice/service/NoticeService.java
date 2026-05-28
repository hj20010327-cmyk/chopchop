package kr.or.chop.P03_notice.service;

import java.util.List;

import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface NoticeService {

    // 공지사항 전체 개수
    int selectNoticeCount(
            NoticeDTO noticeDTO
    );

    // 공지사항 목록
    List<NoticeDTO> selectNoticeList(
            NoticeDTO noticeDTO,
            PageInfo pageInfo
    );

    // 공지사항 상세
    NoticeDTO selectNoticeDetail(
            Integer not_no
    );

    // 공지사항 등록
    int insertNotice(
            NoticeDTO dto
    );

    // 공지사항 수정
    int updateNotice(
            NoticeDTO dto
    );

    // 공지사항 삭제
    int deleteNotice(
            int not_no
    );

    // 조회수 증가
    int updateNoticeView(
            int not_no
    );

    // 첨부파일 등록
    int insertNoticeFile(
            NoticeFileDTO fileDTO
    );

    // 첨부파일 목록
    List<NoticeFileDTO> selectNoticeFileList(
            int not_no
    );

    // 첨부파일 삭제
    int deleteNoticeFileByNoticeNo(
            int not_no
    );
    
    // 첨부파일 개별 삭제
    int deleteNoticeFile(int file_no);
}