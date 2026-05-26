package kr.or.chop.P14_warehouse.dao;

import java.util.List;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface SecDAO {

	public SecDTO selectSecDTO(SecDTO secDTO);
	public int selectLotCount(SecDTO secDTO);
	public List<LotDTO> selectLotList(SecDTO secDTO, PageInfo pageInfo);
	
	public int minusWhQty(SecDTO secDTO);
	public int deleteSection(SecDTO secDTO);
	
	public int insertSection(SecDTO secDTO);
	public int plusWhQty(SecDTO secDTO);
//	public int updateSecImg(SecDTO secDTO);
	
	int updateSecQty(SecDTO secDTO);
	int updateSecOrder(SecDTO secDTO);
	
}
