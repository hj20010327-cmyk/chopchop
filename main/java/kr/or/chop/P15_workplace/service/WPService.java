package kr.or.chop.P15_workplace.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WPService {
	
	public List<WPDTO> selectAllWP(WPDTO wpDTO, PageInfo pageInfo);
	public int selectWPCount(WPDTO wpDTO);
	
	public WPDTO selectWpDTO(WPDTO wpDTO);
	public int selectGlogCount(WPDTO wpDTO);
	public List<GlogDTO> selectGlogList(WPDTO wpDTO);
	
	public void insertWP(WPDTO wpDTO, MultipartFile wpImgFile, String uploadPath, String contextPath) throws IllegalStateException, IOException;
	public void updateWP(WPDTO wpDTO, MultipartFile wpImgFile, String uploadPath, String contextPath) throws IllegalStateException, IOException;
	
	public int deleteWp(WPDTO wpDTO);
}
