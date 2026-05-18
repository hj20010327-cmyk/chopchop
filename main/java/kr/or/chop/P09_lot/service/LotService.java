package kr.or.chop.P09_lot.service;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface LotService {

	 List<LotDTO> selectAllLot(LotDTO lotDTO, PageInfo pageInfo);
	 LotDTO selectLotDetail(String lotId);
	 
}
