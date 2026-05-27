package kr.or.chop.P11_item.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dao.ItemDAO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	ItemDAO itemDAO;

	@Override
	public List<ItemDTO> ItemSelectAll(ItemDTO itemDTO, PageInfo pageInfo) {

		return itemDAO.selectAllItem(itemDTO, pageInfo);
	}

	@Override
	public int selectItemCount(ItemDTO itemDTO) {

		return itemDAO.selectItemCount(itemDTO);
	}

	@Override
	public int insertItem(ItemDTO itemDTO) {
		int result = itemDAO.insertItem(itemDTO);

		itemDAO.insertStockByItem(itemDTO);

		return result;
	}


	@Override
	public int selectLotCount(String itemId) {
		return itemDAO.selectLotCount(itemId);
	}

	@Override
	public ItemDTO selectItemDetail(ItemDTO itemDTO) {

		return itemDAO.selectItemDetail(itemDTO);
	}

	
	@Override
	public void deleteItem(String itemId) {

		itemDAO.deleteItem(itemId);

	}
	
	@Override
	public void updateItem(ItemDTO itemDTO) {
		itemDAO.updateItem(itemDTO);
	}
	
	@Override
	public List<LotDTO> selectLotListByItem(String itemId, PageInfo pageInfo) {
		return itemDAO.selectLotListByItem(itemId, pageInfo);
	}

	@Override
	public List<String> selectUnitList() {
		return itemDAO.selectUnitList();
	}
	
	@Override
	public List<Map<String, Object>> selectSpecList() {
		return itemDAO.selectSpecList();
	}

}
