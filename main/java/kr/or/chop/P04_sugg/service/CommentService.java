package kr.or.chop.P04_sugg.service;

import java.util.List;

import kr.or.chop.P04_sugg.dto.CommentDTO;

public interface CommentService {

    List<CommentDTO> selectCommentList(int comm_sugg_no);

    int insertComment(CommentDTO dto);

    int updateComment(CommentDTO dto);

    int deleteComment(int comm_no);
    
    // 자식 댓글 개수
    int selectChildCommentCount(int comm_no);

    // 댓글 삭제 표시 처리
    int maskComment(int comm_no);
}
