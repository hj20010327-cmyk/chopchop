package kr.or.chop.P01_login.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;

@Repository
public class MyDAOImpl implements MyDAO {
	
	@Autowired
	SqlSession session;

	@Override
	public List<UserWorkDTO> selectAllWo(EmpDTO loginUser) {
		return session.selectList("mapper.P01_login.selectAllWo", loginUser);
	}

	@Override
	public List<UserWorkDTO> selectAllQc(EmpDTO loginUser) {
		return session.selectList("mapper.P01_login.selectAllQc", loginUser);
	}

	@Override
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser) {
		return session.selectList("mapper.P01_login.selectAllSugg", loginUser);
	}
	
}
