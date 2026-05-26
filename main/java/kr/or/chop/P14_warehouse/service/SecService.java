package kr.or.chop.P14_warehouse.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P09_lot.dto.LotDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface SecService {
	
	public SecDTO selectSecDTO(SecDTO secDTO);
	public int selectLotCount(SecDTO secDTO);
	public List<LotDTO> selectLotList(SecDTO secDTO, PageInfo pageInfo);
	
	public void deleteSection(SecDTO secDTO);
	
	public void insertSection(SecDTO secDTO, MultipartFile secImgFile, String uploadPath, String uploadUrl) throws IllegalStateException, IOException;

//	public void updateSection(SecDTO secDTO, MultipartFile secImgFile, String uploadPath, String uploadUrl) throws IllegalStateException, IOException;

}
