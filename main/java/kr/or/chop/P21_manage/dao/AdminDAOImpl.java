package kr.or.chop.P21_manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P21_manage.dto.AdminActivityDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public int selectAdminCount(AdminDTO adminDTO) {
		return sqlSession.selectOne("mapper.P21_manage.selectAdminCount", adminDTO);
	}

	@Override
	public List<AdminDTO> selectAdminList(AdminDTO adminDTO, PageInfo page) {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("adminDTO", adminDTO);
		map.put("page", page);

		return sqlSession.selectList("mapper.P21_manage.selectAdminList", map);
	}

	@Override
	public AdminDTO selectAdminDetail(String empId) {
		return sqlSession.selectOne("mapper.P21_manage.selectAdminDetail", empId);
	}

	@Override
	public int insertAdmin(AdminDTO adminDTO) {
		return sqlSession.insert("mapper.P21_manage.insertAdmin", adminDTO);
	}

	@Override
	public int updateAdmin(AdminDTO adminDTO) {
		return sqlSession.update("mapper.P21_manage.updateAdmin", adminDTO);
	}

	@Override
	public int deleteAdmin(String empId) {
		return sqlSession.update("mapper.P21_manage.deleteAdmin", empId);
	}
	
	@Override
	public List<AdminDTO> selectDeptSummary() {
	    return sqlSession.selectList("mapper.P21_manage.selectDeptSummary");
	}
	
	@Override
	public AdminActivityDTO selectAdminActivity(String empId) {
	    return sqlSession.selectOne("mapper.P21_manage.selectAdminActivity", empId);
	}
}