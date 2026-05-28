package kr.or.chop.P04_sugg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P04_sugg.dao.CommentDAO;
import kr.or.chop.P04_sugg.dto.CommentDTO;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentDAO commentDAO;

    @Override
    public List<CommentDTO> selectCommentList(int comm_sugg_no) {
        return commentDAO.selectCommentList(comm_sugg_no);
    }

    @Override
    public int insertComment(CommentDTO dto) {
        return commentDAO.insertComment(dto);
    }

    @Override
    public int updateComment(CommentDTO dto) {
        return commentDAO.updateComment(dto);
    }

    @Override
    public int deleteComment(int comm_no) {
        return commentDAO.deleteComment(comm_no);
    }
    
    @Override
    public int selectChildCommentCount(int comm_no) {
        return commentDAO.selectChildCommentCount(comm_no);
    }

    @Override
    public int maskComment(int comm_no) {
        return commentDAO.maskComment(comm_no);
    }
}
