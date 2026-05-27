package kr.or.chop.P04_sugg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P04_sugg.dao.SuggDAO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class SuggServiceImpl implements SuggService {

	@Autowired
	SuggDAO suggDAO;

	@Override
	public List<SuggDTO> selectSuggList(SuggDTO suggDTO, PageInfo pageInfo) {
		return suggDAO.selectSuggList(suggDTO, pageInfo);
	}

	@Override
	public SuggDTO selectSuggDetail(Integer sugg_no) {
		return suggDAO.selectSuggDetail(sugg_no);
	}

	@Override
	public int insertSugg(SuggDTO dto) {
		return suggDAO.insertSugg(dto);
	}

	@Override
	public int updateSugg(SuggDTO dto) {
		return suggDAO.updateSugg(dto);
	}

	@Override
	public int deleteSugg(int sugg_no) {
		return suggDAO.deleteSugg(sugg_no);
	}

	@Override
	public int selectSuggCount(SuggDTO suggDTO) {
		return suggDAO.selectSuggCount(suggDTO);
	}

	@Override
	public int updateSuggAnswer(SuggDTO dto) {
		return suggDAO.updateSuggAnswer(dto);
	}

	@Override
	public int updateSuggView(int sugg_no) {
		// 조회수 증가
		return suggDAO.updateSuggView(sugg_no);
	}
}