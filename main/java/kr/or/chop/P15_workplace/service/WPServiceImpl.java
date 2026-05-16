package kr.or.chop.P15_workplace.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P15_workplace.dao.WPDAO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class WPServiceImpl implements WPService {
	
	@Autowired
	WPDAO wpDAO;

	@Override
	public List<WPDTO> selectAllWP(WPDTO wpDTO, PageInfo pageInfo) {

		System.out.println("/workplace/list service.selectAllWP");
		
		return wpDAO.selectAllWP(wpDTO, pageInfo);
	}

	@Override
	public int selectWPCount(WPDTO wpDTO) {

		System.out.println("/workplace/list service.selectWPCount");
		
		return wpDAO.selectWPCount(wpDTO);
	}

	@Override
	public WPDTO selectWpDTO(WPDTO wpDTO) {
		
		System.out.println("/workplace/detail service.selectWPDTO");
		
		return wpDAO.selectWPDTO(wpDTO);
	}

	@Override
	public List<GlogDTO> selectGlogList(WPDTO wpDTO) {
		
		System.out.println("/workplace/detail service.selectGlogList");
		
		return wpDAO.selectGlogList(wpDTO);
	}

}
