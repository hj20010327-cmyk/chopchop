package kr.or.chop.P03_notice.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P03_notice.dao.NoticeDAO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class NoticeServiceImpl
        implements NoticeService {

    @Autowired
    NoticeDAO noticeDAO;

    @Override
    public int selectNoticeCount(
            NoticeDTO noticeDTO) {

        // 공지사항 전체 개수
        return noticeDAO.selectNoticeCount(
                noticeDTO
        );
    }

    @Override
    public List<NoticeDTO> selectNoticeList(
            NoticeDTO noticeDTO,
            PageInfo pageInfo) {

        // 공지사항 목록
        return noticeDAO.selectNoticeList(
                noticeDTO,
                pageInfo
        );
    }

    @Override
    public NoticeDTO selectNoticeDetail(
            Integer not_no) {

        // 공지사항 상세
        return noticeDAO.selectNoticeDetail(
                not_no
        );
    }

    @Override
    public int insertNotice(
            NoticeDTO dto) {

        // 공지사항 등록
        return noticeDAO.insertNotice(
                dto
        );
    }

    @Override
    public int updateNotice(
            NoticeDTO dto) {

        // 공지사항 수정
        return noticeDAO.updateNotice(
                dto
        );
    }

    @Override
    public int deleteNotice(
            int not_no) {

        // 공지사항 삭제
        return noticeDAO.deleteNotice(
                not_no
        );
    }

    @Override
    public int updateNoticeView(
            int not_no) {

        // 조회수 증가
        return noticeDAO.updateNoticeView(
                not_no
        );
    }

    @Override
    public int insertNoticeFile(
            NoticeFileDTO fileDTO) {

        // 첨부파일 등록
        return noticeDAO.insertNoticeFile(
                fileDTO
        );
    }

    @Override
    public List<NoticeFileDTO> selectNoticeFileList(
            int not_no) {

        // 첨부파일 목록
        return noticeDAO.selectNoticeFileList(
                not_no
        );
    }

    @Override
    public int deleteNoticeFileByNoticeNo(
            int not_no) {

        // 첨부파일 삭제
        return noticeDAO.deleteNoticeFileByNoticeNo(
                not_no
        );
    }
}