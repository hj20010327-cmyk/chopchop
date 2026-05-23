package kr.or.chop.P10_io.dao;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface IoDAO {

	public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo);
	public int selectIoCount(IoDTO ioDTO);
	public IoDTO selectIoDetail(String ioId);
	public void insertIo(IoDTO ioDTO);
	public List<ItemDTO> selectItemListByType(String itemType);
	public List<VendorDTO> selectVendorList();
	public List<LotDTO> selectLotListByItem(String itemId);
	public void deleteIo(String ioId);
	public void updateIo(IoDTO ioDTO);
	public String selectVendorTypeById(String vendorId);
	public List<AdminDTO> selectWorkerList(String keyword);
	public void insertLotByIo(IoDTO ioDTO);
	public String selectLastLotId();
	public int minusLotFqty(IoDTO ioDTO);
	public List<VendorDTO> selectVendorByType(String vendorType);
	public List<WHDTO> selectWarehouseListByItem(String itemId);
	public List<SecDTO> selectWhSecList(String whId);
	public void updateLot(IoDTO ioDTO);
	public void plusStockByIo(IoDTO ioDTO);
	public int minusStockByIo(IoDTO dto);
	
}
