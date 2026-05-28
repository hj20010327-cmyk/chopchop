package kr.or.chop.P01_login.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;

public interface MyService {
	
	public List<UserWorkDTO> selectAllWork(EmpDTO loginUser);
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser);
	public List<NoticeDTO> selectAllNotice(EmpDTO loginUser);
	
	public void updateUser(EmpDTO empDTO, MultipartFile empImgFile, String uploadPath, String uploadUrl) throws IllegalStateException, IOException;

	public EmpDTO reSelectUserInfo(EmpDTO loginUser);
	
	public AdminActivityDTO workCnt(EmpDTO loginUser);
}
