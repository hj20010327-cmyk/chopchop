package kr.or.chop.P13_bom.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P13_bom.dto.BOMDTO;
import kr.or.chop.P13_bom.dto.BOMDetailDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class BOMDAOImpl implements BOMDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public int selectBomCount(BOMDTO bomDTO) {

		return sqlSession.selectOne("mapper.P13_bom.selectBomCount", bomDTO);
	}

	@Override
	public List<BOMDTO> selectBomList(BOMDTO bomDTO, PageInfo page) {

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("bomDTO", bomDTO);
		map.put("page", page);

		return sqlSession.selectList("mapper.P13_bom.selectBomList", map);
	}

	@Override
	public BOMDTO selectBomDetail(String bomId) {

		return sqlSession.selectOne("mapper.P13_bom.selectBomDetail", bomId);
	}

	@Override
	public List<BOMDetailDTO> selectBomDetailList(String bomId) {

		return sqlSession.selectList("mapper.P13_bom.selectBomDetailList", bomId);
	}

	@Override
	public int insertBom(BOMDTO bomDTO) {
		return sqlSession.insert("mapper.P13_bom.insertBom", bomDTO);
	}

	@Override
	public List<BOMDTO> selectFinishItemList() {
		return sqlSession.selectList("mapper.P13_bom.selectFinishItemList");
	}

	@Override
	public List<BOMDTO> selectMaterialItemList() {
		return sqlSession.selectList("mapper.P13_bom.selectMaterialItemList");
	}

	@Override
	public int insertBomDetail(BOMDetailDTO detailDTO) {
		return sqlSession.insert("mapper.P13_bom.insertBomDetail", detailDTO);
	}
}