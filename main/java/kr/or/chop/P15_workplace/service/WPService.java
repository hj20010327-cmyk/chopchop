package kr.or.chop.P15_workplace.service;

import java.util.List;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WPService {
	
	public List<WPDTO> selectAllWP(WPDTO wpDTO, PageInfo pageInfo);
	public int selectWPCount(WPDTO wpDTO);
	
	public WPDTO selectWpDTO(WPDTO wpDTO);
	public List<GlogDTO> selectGlogList(WPDTO wpDTO);

}
