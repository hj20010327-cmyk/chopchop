package kr.or.chop.P11_item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

}
