package kr.or.chop.P12_rout.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P12_rout.dto.RoutDTO;
import kr.or.chop.P12_rout.dto.RoutDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class RoutDAOImpl implements RoutDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public int selectRoutCount(RoutDTO routDTO) {
		return sqlSession.selectOne("mapper.P12_rout.selectRoutCount", routDTO);
	}

	@Override
	public List<RoutDTO> selectRoutList(RoutDTO routDTO, PageInfo page) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("routDTO", routDTO);
		map.put("page", page);

		return sqlSession.selectList("mapper.P12_rout.selectRoutList", map);
	}

	@Override
	public List<RoutDTO> selectRoutItemList() {
		return sqlSession.selectList("mapper.P12_rout.selectRoutItemList");
	}

	@Override
	public List<RoutDetailDTO> selectWpTypeList() {
		return sqlSession.selectList("mapper.P12_rout.selectWpTypeList");
	}

	@Override
	public int insertProcess(RoutDetailDTO detailDTO) {
		return sqlSession.insert("mapper.P12_rout.insertProcess", detailDTO);
	}

	@Override
	public int updateProcess(RoutDetailDTO detailDTO) {
		return sqlSession.update("mapper.P12_rout.updateProcess", detailDTO);
	}

	@Override
	public int deleteProcess(String procId) {
		return sqlSession.update("mapper.P12_rout.deleteProcess", procId);
	}

	@Override
	public int insertRout(RoutDTO routDTO) {
		return sqlSession.insert("mapper.P12_rout.insertRout", routDTO);
	}

	@Override
	public int insertRoutDetail(RoutDetailDTO detailDTO) {
		return sqlSession.insert("mapper.P12_rout.insertRoutDetail", detailDTO);
	}

	@Override
	public RoutDTO selectRoutDetail(String routId) {
		return sqlSession.selectOne("mapper.P12_rout.selectRoutDetail", routId);
	}

	@Override
	public List<RoutDetailDTO> selectRoutDetailList(String routId) {
		return sqlSession.selectList("mapper.P12_rout.selectRoutDetailList", routId);
	}

	@Override
	public int updateRout(RoutDTO routDTO) {
		return sqlSession.update("mapper.P12_rout.updateRout", routDTO);
	}

	@Override
	public int deleteRoutDetail(String routId) {
		return sqlSession.delete("mapper.P12_rout.deleteRoutDetail", routId);
	}

	@Override
	public int deleteRout(String routId) {
		return sqlSession.update("mapper.P12_rout.deleteRout", routId);
	}

	@Override
	public int softDeleteRoutDetail(String routId) {
		return sqlSession.update("mapper.P12_rout.softDeleteRoutDetail", routId);
	}
}