package kr.or.chop.P01_login.dao;

import java.util.List;

import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;

public interface MyDAO {
	
	public List<UserWorkDTO> selectAllWo (EmpDTO loginUser);
	public List<UserWorkDTO> selectAllQc (EmpDTO loginUser);
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser);
	public List<NoticeDTO> selectAllNotice(EmpDTO loginUser);
	
	public int updateUser(EmpDTO empDTO);
	public int updateUserImg(EmpDTO empDTO);
	
	public EmpDTO reSelectUserInfo(EmpDTO loginUser);
	
	public AdminActivityDTO workCnt (EmpDTO loginUser);

}
