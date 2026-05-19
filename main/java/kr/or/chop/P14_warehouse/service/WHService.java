package kr.or.chop.P14_warehouse.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WHService {

	public List<WHDTO> selectAllWH(WHDTO whDTO, PageInfo pageInfo);
	public int selectWHCount(WHDTO whDTO);
	public WHDTO selectWhCardCnt(WHDTO whDTO);

	public WHDTO selectWhDTO(WHDTO whDTO);
	public int selectGlogCount(WHDTO whDTO);
	public List<GlogDTO> selectGlogList(WHDTO whDTO, PageInfo pageInfo);
	public List<SecDTO> selectSecList(WHDTO whDTO);
	
	public void insertWH(WHDTO whDTO, MultipartFile whImgFile, String uploadPath, String contextPath) throws IllegalStateException, IOException;
	public void updateWH(WHDTO whDTO, MultipartFile whImgFile, String uploadPath, String contextPath) throws IllegalStateException, IOException;

	public int deleteWh(WHDTO whDTO);
}
