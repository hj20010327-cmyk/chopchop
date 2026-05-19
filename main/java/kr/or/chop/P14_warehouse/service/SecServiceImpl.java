package kr.or.chop.P14_warehouse.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P14_warehouse.dao.SecDAO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class SecServiceImpl implements SecService {

	@Autowired
	SecDAO secDAO;
	
	@Override
	public SecDTO selectSecDTO(SecDTO secDTO) {
		return secDAO.selectSecDTO(secDTO);
	}

	@Override
	public int selectLotCount(SecDTO secDTO) {
		return secDAO.selectLotCount(secDTO);
	}

	@Override
	public List<LotDTO> selectLotList(SecDTO secDTO, PageInfo pageInfo) {
		return secDAO.selectLotList(secDTO, pageInfo);
	}

}
