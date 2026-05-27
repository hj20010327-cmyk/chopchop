package kr.or.chop.P11_item.dao;

import java.util.List;
import java.util.Map;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface ItemDAO {

	List<ItemDTO> selectAllItem(ItemDTO itemDTO, PageInfo pageInfo);
	int selectItemCount(ItemDTO itemDTO);
	int selectLotCount(String itemId);
	int insertItem(ItemDTO itemDTO);
	ItemDTO selectItemDetail(ItemDTO itemDTO);
	void deleteItem(String itemId);
	void updateItem(ItemDTO itemDTO);
	List<LotDTO> selectLotListByItem(String itemId, PageInfo pageInfo);
	List<String> selectUnitList();
	List<Map<String, Object>> selectSpecList();
	int insertStockByItem(ItemDTO itemDTO);
	
}
