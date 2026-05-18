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
		System.out.println(paramMap);
		
		return sqlSession.selectList("mapper.P11_item.selectitemList", paramMap);
	}

	@Override
	public int selectItemCount(ItemDTO itemDTO) {

		return sqlSession.selectOne("mapper.P11_item.selectItemCount", itemDTO);
	}

	@Override
	public int insertItem(ItemDTO itemDTO) {
		return sqlSession.insert("mapper.P11_item.insertItem",itemDTO);
	}

	@Override
	public List<VendorDTO> selectVendors(VendorDTO vendorDTO) {
		System.out.println("DAO"+sqlSession.selectList("mapper.P11_item.selectVendors"));
	
		return sqlSession.selectList("mapper.P11_item.selectVendors",vendorDTO);
	}

	@Override
	public int selectLotCount(LotDTO lotDTO) {
		return sqlSession.selectOne("mapper.P11_item.selectLotCount", lotDTO);
	}

}
