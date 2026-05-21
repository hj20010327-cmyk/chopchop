package kr.or.chop.P21_manage.service;

import java.util.List;

import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface AdminService {

	int selectAdminCount(AdminDTO adminDTO);

	List<AdminDTO> selectAdminList(AdminDTO adminDTO, PageInfo page);

	AdminDTO selectAdminDetail(String empId);

	int insertAdmin(AdminDTO adminDTO);

	int updateAdmin(AdminDTO adminDTO);

	int deleteAdmin(String empId);
}