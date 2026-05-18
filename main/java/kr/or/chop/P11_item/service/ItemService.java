package kr.or.chop.P11_item.service;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface ItemService {

	public List<ItemDTO> ItemSelectAll(ItemDTO itemDTO, PageInfo pageInfo);
	public int selectItemCount(ItemDTO itemDTO);
	public int selectLotCount(LotDTO lotDTO);
	public int insertItem(ItemDTO itemDTO);
	
	
	public List<VendorDTO> selectVendors(VendorDTO vendorDTO);
	
}
