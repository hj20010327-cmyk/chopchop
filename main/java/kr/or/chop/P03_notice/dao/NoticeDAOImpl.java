package kr.or.chop.P03_notice.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P03_notice.dto.NoticeFileDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class NoticeDAOImpl implements NoticeDAO {

    @Autowired
    SqlSession sqlSession;

    private final String namespace =
            "mapper.P03_notice.";

    @Override
    public int selectNoticeCount(
            NoticeDTO noticeDTO) {

        // 공지사항 전체 개수
        return sqlSession.selectOne(
                namespace + "selectNoticeCount",
                noticeDTO
        );
    }

    @Override
    public List<NoticeDTO> selectNoticeList(
            NoticeDTO noticeDTO,
            PageInfo pageInfo) {

        Map<String, Object> param =
                new HashMap<String, Object>();

        param.put("search", noticeDTO);
        param.put("page", pageInfo);

        // 공지사항 목록
        return sqlSession.selectList(
                namespace + "selectNoticeList",
                param
        );
    }

    @Override
    public NoticeDTO selectNoticeDetail(
            Integer not_no) {

        // 공지사항 상세
        return sqlSession.selectOne(
                namespace + "selectNoticeDetail",
                not_no
        );
    }

    @Override
    public int insertNotice(
            NoticeDTO dto) {

        // 공지사항 등록
        return sqlSession.insert(
                namespace + "insertNotice",
                dto
        );
    }

    @Override
    public int updateNotice(
            NoticeDTO dto) {

        // 공지사항 수정
        return sqlSession.update(
                namespace + "updateNotice",
                dto
        );
    }

    @Override
    public int deleteNotice(
            int not_no) {

        // 공지사항 삭제
        return sqlSession.update(
                namespace + "deleteNotice",
                not_no
        );
    }

    @Override
    public int updateNoticeView(
            int not_no) {

        // 조회수 증가
        return sqlSession.update(
                namespace + "updateNoticeView",
                not_no
        );
    }

    @Override
    public int insertNoticeFile(
            NoticeFileDTO fileDTO) {

        // 첨부파일 등록
        return sqlSession.insert(
                namespace + "insertNoticeFile",
                fileDTO
        );
    }

    @Override
    public List<NoticeFileDTO> selectNoticeFileList(
            int not_no) {

        // 첨부파일 목록
        return sqlSession.selectList(
                namespace + "selectNoticeFileList",
                not_no
        );
    }

    @Override
    public int deleteNoticeFileByNoticeNo(
            int not_no) {

        // 첨부파일 삭제
        return sqlSession.update(
                namespace + "deleteNoticeFileByNoticeNo",
                not_no
        );
    }
}