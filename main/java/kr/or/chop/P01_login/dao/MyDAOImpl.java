package kr.or.chop.P01_login.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;

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
	
	@Override
	public List<NoticeDTO> selectAllNotice(EmpDTO loginUser) {
		return session.selectList("mapper.P01_login.selectAllNotice", loginUser);
	}

	@Override
	public int updateUser(EmpDTO empDTO) {
		return session.update("mapper.P01_login.updateUser", empDTO);
	}

	@Override
	public int updateUserImg(EmpDTO empDTO) {
		return session.update("mapper.P01_login.updateUserImg", empDTO);
	}

	@Override
	public EmpDTO reSelectUserInfo(EmpDTO loginUser) {
		return session.selectOne("mapper.P01_login.reSelectUserInfo", loginUser);
	}

	@Override
	public AdminActivityDTO workCnt(EmpDTO loginUser) {
		return session.selectOne("mapper.P01_login.workCnt", loginUser);
	}
	
}
