package kr.or.chop.P01_login.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P01_login.dto.EmpDTO;

@Repository
public class LoginDAOImpl implements LoginDAO {
	
	@Autowired
	SqlSession sqlSession;

	@Override
	public EmpDTO selectEmp(EmpDTO chkEmpDTO) {
		return sqlSession.selectOne("mapper.P01_login.selectEmp", chkEmpDTO);
	}
	
	@Override
	public int checkEmpEmail(EmpDTO empDTO) {
		return sqlSession.selectOne("mapper.P01_login.checkEmpEmail", empDTO);
	}

	@Override
	public int updateTempPw(EmpDTO empDTO) {
		return sqlSession.update("mapper.P01_login.updateTempPw", empDTO);
	}

}
