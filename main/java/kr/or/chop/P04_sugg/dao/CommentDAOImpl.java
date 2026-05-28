package kr.or.chop.P04_sugg.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P04_sugg.dto.CommentDTO;

@Repository
public class CommentDAOImpl implements CommentDAO {

    @Autowired
    SqlSession sqlSession;

    private final String namespace = "mapper.comment.";

    @Override
    public List<CommentDTO> selectCommentList(int comm_sugg_no) {
        return sqlSession.selectList(
                namespace + "selectCommentList",
                comm_sugg_no
        );
    }

    @Override
    public int insertComment(CommentDTO dto) {
        return sqlSession.insert(
                namespace + "insertComment",
                dto
        );
    }

    @Override
    public int updateComment(CommentDTO dto) {
        return sqlSession.update(
                namespace + "updateComment",
                dto
        );
    }

    @Override
    public int deleteComment(int comm_no) {
        return sqlSession.update(
                namespace + "deleteComment",
                comm_no
        );
    }
    
    @Override
    public int selectChildCommentCount(int comm_no) {
        return sqlSession.selectOne(
                namespace + "selectChildCommentCount",
                comm_no
        );
    }

    @Override
    public int maskComment(int comm_no) {
        return sqlSession.update(
                namespace + "maskComment",
                comm_no
        );
    }
    
}
