package kr.or.chop.P09_lot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dao.LotDAO;
import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class LotServiceImpl implements LotService {

	@Autowired
    LotDAO lotDAO;

    @Override
    public List<LotDTO> selectAllLot(LotDTO lotDTO, PageInfo pageInfo) {
        return lotDAO.selectAllLot(lotDTO, pageInfo);
    }
    
    @Override
    public LotDTO selectLotDetail(String lotId) {
        return lotDAO.selectLotDetail(lotId);
    }
	
}
