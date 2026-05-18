package kr.or.chop.P15_workplace.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;

@Repository
public class GlogDAOImpl implements GlogDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public List<GhpDTO> selectAllGhp(WPDTO wpDTO) {
		System.out.println("/workplace/glog/add dao.selectAllGhp");
		System.out.println("wpDTO : " + wpDTO);
		
		return sqlSession.selectList("mapper.P15_workplace.glog.selectAllGhp", wpDTO);
	}

	@Override
	public GhpDTO selectGhp(GhpDTO ghpDTO) {
		System.out.println("/workplace/glog/add dao.selectGhp");
		System.out.println("ghpDTO : " + ghpDTO);
		
		return sqlSession.selectOne("mapper.P15_workplace.glog.selectGhp", ghpDTO);
	}

	@Override
	public int insertGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/add dao.insertGlog");
		System.out.println("glogDTO : " + glogDTO);
		
		return sqlSession.insert("mapper.P15_workplace.glog.insertGlog", glogDTO);
	}

	@Override
	public int updateGhpImg(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/add dao.updateGhpImg");
		return sqlSession.update("mapper.P15_workplace.glog.updateGhpImg", glogDTO);
	}

	@Override
	public GlogDTO selectGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/detail dao.selectGlog");
		return sqlSession.selectOne("mapper.P15_workplace.glog.selectGlog", glogDTO);
	}

	@Override
	public int deleteGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/detail dao.deleteGlog");
		return sqlSession.update("mapper.P15_workplace.glog.deleteGlog", glogDTO);
	}

	@Override
	public int updateGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/edit dao.updateGlog");
		return sqlSession.update("mapper.P15_workplace.glog.updateGlog", glogDTO);
	}

}
