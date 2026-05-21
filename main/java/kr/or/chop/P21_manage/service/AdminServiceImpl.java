package kr.or.chop.P21_manage.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P21_manage.dao.AdminDAO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int selectAdminCount(AdminDTO adminDTO) {
		return adminDAO.selectAdminCount(adminDTO);
	}

	@Override
	public List<AdminDTO> selectAdminList(AdminDTO adminDTO, PageInfo page) {
		return adminDAO.selectAdminList(adminDTO, page);
	}

	@Override
	public AdminDTO selectAdminDetail(String empId) {
		return adminDAO.selectAdminDetail(empId);
	}

	@Override
	public int insertAdmin(AdminDTO adminDTO) {
		return adminDAO.insertAdmin(adminDTO);
	}

	@Override
	public int updateAdmin(AdminDTO adminDTO) {
		return adminDAO.updateAdmin(adminDTO);
	}

	@Override
	public int deleteAdmin(String empId) {
		return adminDAO.deleteAdmin(empId);
	}
}