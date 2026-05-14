package kr.or.chop.P11_item.dao;

import java.util.List;

import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface ItemDAO {

	List<ItemDTO> selectAllItem(ItemDTO itemDTO, PageInfo pageInfo);
	int selectItemCount(ItemDTO itemDTO);
	
	
}
