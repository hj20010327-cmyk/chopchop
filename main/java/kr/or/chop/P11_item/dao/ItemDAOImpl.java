package kr.or.chop.P11_item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class ItemDAOImpl implements ItemDAO {

	@Autowired
	SqlSession sqlSession;

	@Override
	public List<ItemDTO> selectAllItem(ItemDTO itemDTO, PageInfo pageInfo) {

		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("searchType", itemDTO.getSearchType());
		paramMap.put("searchKeyword", itemDTO.getSearchKeyword());
		paramMap.put("page", pageInfo);

		return sqlSession.selectList("mapper.P11_item.selectitemList", paramMap);
	}

	@Override
	public int selectItemCount(ItemDTO itemDTO) {

		return sqlSession.selectOne("mapper.P11_item.selectItemCount", itemDTO);
	}

	@Override
	public int insertItem(ItemDTO itemDTO) {
		return sqlSession.insert("mapper.P11_item.insertItem", itemDTO);
	}

	@Override
	public int selectLotCount(String itemId) {
		return sqlSession.selectOne("mapper.P11_item.selectLotCount", itemId);
	}

	@Override
	public ItemDTO selectItemDetail(ItemDTO itemDTO) {

		return sqlSession.selectOne("mapper.P11_item.selectItemDetail", itemDTO);
	}


	@Override
	public void deleteItem(String itemId) {

		sqlSession.update("mapper.P11_item.deleteItem", itemId);

	}

	@Override
	public void updateItem(ItemDTO itemDTO) {

		sqlSession.update("mapper.P11_item.updateItem", itemDTO);
	}



	@Override
	public List<LotDTO> selectLotListByItem(String itemId, PageInfo pageInfo) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("itemId", itemId);
		paramMap.put("page", pageInfo);
		
		return sqlSession.selectList("mapper.P11_item.selectLotListByItem", paramMap);
	}

	@Override
	public List<String> selectUnitList() {
		return sqlSession.selectList("mapper.P11_item.selectUnitList");
	}
	
	@Override
	public List<Map<String, Object>> selectSpecList() {
		return sqlSession.selectList("mapper.P11_item.selectSpecList");
	}
	
	@Override
	public int insertStockByItem(ItemDTO itemDTO) {
		return sqlSession.insert("mapper.P11_item.insertStockByItem", itemDTO);
	}

}
