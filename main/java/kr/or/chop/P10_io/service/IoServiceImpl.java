package kr.or.chop.P10_io.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dao.IoDAO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P17_vendor.dto.VendorDTO;
import kr.or.chop.P21_manage.dto.AdminDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class IoServiceImpl implements IoService {

	@Autowired
	IoDAO ioDAO;

	@Override
	public List<IoDTO> selectIoList(IoDTO ioDTO, PageInfo pageInfo) {
		return ioDAO.selectIoList(ioDTO, pageInfo);
	}
	
	@Override
	public int selectIoCount(IoDTO ioDTO) {

		return ioDAO.selectIoCount(ioDTO);
	}

	@Override
	public IoDTO selectIoDetail(String ioId) {
		return ioDAO.selectIoDetail(ioId);
	}

	@Override
	@Transactional
	public void insertIo(IoDTO ioDTO) {

		if ("IN".equals(ioDTO.getIoType())) {

			if(ioDTO.getIoWorker() != null) {
				// 1. LOT 생성
				ioDAO.insertLotByIo(ioDTO);
			}

			// 2. 방금 생성된 LOT 번호 가져오기
			String lotId = ioDAO.selectLastLotId();

			// 3. IO에 저장할 LOT 번호 세팅
			ioDTO.setIoLot(lotId);

			// 4. IO 등록
			ioDAO.insertIo(ioDTO);

			// 5. STOCK 증가
			ioDAO.plusStockByIo(ioDTO);
		}

		else if ("OUT".equals(ioDTO.getIoType())) {

			// 1. LOT 수량 차감
			int result = ioDAO.minusLotFqty(ioDTO);

			if (result == 0) {
				throw new RuntimeException("LOT 잔량이 부족합니다.");
			}

			// 2. STOCK 감소
			int stockResult = ioDAO.minusStockByIo(ioDTO);

			if (stockResult == 0) {
				throw new RuntimeException("재고 수량이 부족합니다.");
			}

			// 3. IO 등록
			ioDAO.insertIo(ioDTO);
		}
	}

	@Override
	public List<ItemDTO> selectItemListByType(String itemType) {
		return ioDAO.selectItemListByType(itemType);
	}

	@Override
	public List<VendorDTO> selectVendorList() {
		return ioDAO.selectVendorList();
	}
	
	@Override
	public List<VendorDTO> selectVendorByType(String vendorType) {
		return ioDAO.selectVendorByType(vendorType);
	}

	@Override
	public List<LotDTO> selectLotListByItem(String itemId) {
		return ioDAO.selectLotListByItem(itemId);
	}

	@Override
	public void deleteIo(String ioId) {

		ioDAO.deleteIo(ioId);

	}

	@Override
	public void updateIo(IoDTO ioDTO) {
		ioDAO.updateIo(ioDTO);
	}

	@Override
	public String selectVendorTypeById(String vendorId) {
		return ioDAO.selectVendorTypeById(vendorId);
	}

	@Override
	public List<AdminDTO> selectWorkerList(String keyword) {

		return ioDAO.selectWorkerList(keyword);
	}

	@Override
	public List<WHDTO> selectWarehouseListByItem(String itemId) {
		return ioDAO.selectWarehouseListByItem(itemId);
	}

	@Override
	public List<SecDTO> selectWhSecList(String whId) {
		return ioDAO.selectWhSecList(whId);
	}
	
	@Override
	public void updateLot(IoDTO ioDTO) {
		ioDAO.updateLot(ioDTO);
	}

}
