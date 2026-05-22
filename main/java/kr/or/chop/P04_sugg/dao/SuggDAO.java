package kr.or.chop.P04_sugg.dao;

import java.util.List;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface SuggDAO {
//	 	List<SuggDTO> selectSuggList(SuggDTO suggDTO);

	    SuggDTO selectSuggDetail(Integer sugg_no);

	    int insertSugg(SuggDTO dto);

	    int updateSugg(SuggDTO dto);

	    int deleteSugg(int sugg_no);
	    
	    int selectSuggCount(SuggDTO suggDTO);
	    
	    int updateSuggAnswer(SuggDTO dto);
	    
	    List<SuggDTO> selectSuggList(SuggDTO suggDTO, PageInfo pageInfo);
	    
}
