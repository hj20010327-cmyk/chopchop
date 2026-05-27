package kr.or.chop.P04_sugg.service;

import java.util.List;

import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface SuggService {

	int selectSuggCount(SuggDTO suggDTO);
	
    List<SuggDTO> selectSuggList(SuggDTO suggDTO,PageInfo pageInfo);

    SuggDTO selectSuggDetail(Integer sugg_no);

    int insertSugg(SuggDTO dto);

    int updateSugg(SuggDTO dto);

    int deleteSugg(int sugg_no);
    
    int updateSuggAnswer(SuggDTO dto);
    
    // 조회수 증가
    int updateSuggView(int sugg_no);
    
}