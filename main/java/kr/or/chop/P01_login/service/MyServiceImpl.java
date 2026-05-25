package kr.or.chop.P01_login.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P01_login.dao.MyDAO;
import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;

@Service
public class MyServiceImpl implements MyService {
	
	@Autowired
	MyDAO myDAO;

	@Override
	public List<UserWorkDTO> selectAllWork(EmpDTO loginUser) {
		
		List<UserWorkDTO> workList = new ArrayList();
		
		if (loginUser.getEmpDeptno() == 10) {
			workList = myDAO.selectAllWo(loginUser);
		} else if (loginUser.getEmpDeptno() == 20) {
			workList = myDAO.selectAllQc(loginUser);
		} else {
			workList = null;
		}
		
		return workList;
	}

	@Override
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser) {
		return myDAO.selectAllSugg(loginUser);
	}
	
}
