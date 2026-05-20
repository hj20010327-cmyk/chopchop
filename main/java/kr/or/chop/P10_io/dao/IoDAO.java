package kr.or.chop.P10_io.dao;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface IoDAO {

	List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo);
	IoDTO selectIoDetail(String ioId);
	void insertIo(IoDTO ioDTO);
	List<ItemDTO> selectItemListByType(String itemType);
	List<VendorDTO> selectVendorList();
	List<LotDTO> selectLotListByItem(String itemId);
	void deleteIo(String ioId);
	void updateIo(IoDTO ioDTO);
	String selectVendorTypeById(String vendorId);
	List<AdminDTO> selectWorkerList(String keyword);
	void insertLotByIo(IoDTO ioDTO);
	String selectLastLotId();
	int minusLotFqty(IoDTO ioDTO);
	
}
