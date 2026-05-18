package kr.or.chop.P15_workplace.dao;

import java.util.List;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WPDAO {
	
	public int selectWPCount(WPDTO wpDTO);
	public List<WPDTO> selectAllWP(WPDTO wpDTO, PageInfo pageInfo);
	
	public WPDTO selectWPDTO(WPDTO wpDTO);
	public int selectGlogCount(WPDTO wpDTO);
	public List<GlogDTO> selectGlogList(WPDTO wpDTO);
	
	public int insertWP(WPDTO wpDTO);
	public int updateWpImg(WPDTO wpDTO);

	public int updateWp(WPDTO wpDTO);
	
	public int deleteWp(WPDTO wpDTO);

}
