package kr.or.chop.P09_lot.service;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P09_lot.dto.UseDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface LotService {

	 List<LotDTO> selectAllLot(LotDTO lotDTO, PageInfo pageInfo);
	 int selectLotCount(LotDTO lotDTO);
	 LotDTO selectLotDetail(String lotId);
	 List<UseDTO> selectLotUseList(String lotId);

	 List<UseDTO> selectLotIoList(String lotId);
	 
}
