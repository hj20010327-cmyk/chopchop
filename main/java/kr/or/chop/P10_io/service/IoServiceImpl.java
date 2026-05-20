package kr.or.chop.P10_io.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P10_io.dao.IoDAO;
import kr.or.chop.P10_io.dto.IoDTO;
import kr.or.chop.P11_item.dto.ItemDTO;
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
	public void insertIo(IoDTO ioDTO) {

		if ("IN".equals(ioDTO.getIoType())) {

			// LOT 생성
			ioDAO.insertLotByIo(ioDTO);

			// 방금 생성된 LOT 번호 가져오기
			String lotId = ioDAO.selectLastLotId();

			// IO에 저장할 LOT 번호 세팅
			ioDTO.setIoLot(lotId);

			// IO 등록
			ioDAO.insertIo(ioDTO);

		}

		// 출고
		else if ("OUT".equals(ioDTO.getIoType())) {

			int result = ioDAO.minusLotFqty(ioDTO);

			if (result == 0) {
				throw new RuntimeException("LOT 잔량이 부족합니다.");
			}

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

}
