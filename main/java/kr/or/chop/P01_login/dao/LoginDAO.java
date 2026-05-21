package kr.or.chop.P01_login.dao;

import kr.or.chop.P01_login.dto.EmpDTO;

public interface LoginDAO {
	
	public EmpDTO selectEmp(EmpDTO chkEmpDTO);
	public int checkEmpEmail(EmpDTO empDTO);
	public int updateTempPw(EmpDTO empDTO);

}
