package kr.or.chop.P01_login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P01_login.dao.LoginDAO;
import kr.or.chop.P01_login.dto.EmpDTO;

@Service
public class LoginServiceImpl implements LoginService {
	
	@Autowired
	LoginDAO loginDAO;

	@Override
	public EmpDTO selectEmp(EmpDTO chkEmpDTO) {
		return loginDAO.selectEmp(chkEmpDTO);
	}

	
}
