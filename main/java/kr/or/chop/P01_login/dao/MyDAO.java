package kr.or.chop.P01_login.dao;

import java.util.List;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;

public interface MyDAO {
	
	public List<UserWorkDTO> selectAllWo (EmpDTO loginUser);
	public List<UserWorkDTO> selectAllQc (EmpDTO loginUser);
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser);

}
