package kr.or.chop.P11_item.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class ItemDAOImpl implements ItemDAO {

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ItemDTO> selectAllItem(ItemDTO itemDTO, PageInfo pageInfo) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("itemDTO", itemDTO);
		paramMap.put("page", pageInfo);
		
		return sqlSession.selectList("mapper.P11_item.selectitemList", paramMap);
	}

	@Override
	public int selectItemCount(ItemDTO itemDTO) {

		return sqlSession.selectOne("mapper.P11_item.selectItemCount", itemDTO);
	}

}
