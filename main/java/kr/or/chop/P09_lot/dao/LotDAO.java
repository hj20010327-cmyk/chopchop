package kr.or.chop.P09_lot.dao;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface LotDAO {

	List<LotDTO> selectAllLot(LotDTO lotDTO, PageInfo pageInfo);
	LotDTO selectLotDetail(String lotId);
	
}
