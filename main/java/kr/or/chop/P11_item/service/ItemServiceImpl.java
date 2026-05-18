package kr.or.chop.P11_item.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dao.ItemDAO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
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
		return itemDAO.insertItem(itemDTO);
	}

	@Override
	public List<VendorDTO> selectVendors(VendorDTO vendorDTO) {
		return itemDAO.selectVendors(vendorDTO);
	}

	@Override
	public int selectLotCount(LotDTO lotDTO) {
		return itemDAO.selectLotCount(lotDTO);
	}

}
