package kr.or.chop.P01_login.service;

import kr.or.chop.P01_login.dto.EmpDTO;

public interface LoginService {
	
	public EmpDTO selectEmp(EmpDTO chkEmpDTO);
	public void sendTempPw(EmpDTO empDTO, String tempPw) throws Exception;
	public boolean issueTempPw(EmpDTO empDTO);
	public int updatePw(EmpDTO loginUser);

}
