package kr.or.chop.P01_login.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P01_login.dao.MyDAO;
import kr.or.chop.P01_login.dto.EmpDTO;
import kr.or.chop.P01_login.dto.UserWorkDTO;
import kr.or.chop.P03_notice.dto.NoticeDTO;
import kr.or.chop.P04_sugg.dto.SuggDTO;
import kr.or.chop.P21_manage.dto.AdminActivityDTO;

@Service
public class MyServiceImpl implements MyService {
	
	@Autowired
	MyDAO myDAO;

	@Override
	public List<UserWorkDTO> selectAllWork(EmpDTO loginUser) {
		
		List<UserWorkDTO> workList = new ArrayList();
		
		if (loginUser.getEmpDeptno() == 10) {
			workList = myDAO.selectAllWo(loginUser);
		} else if (loginUser.getEmpDeptno() == 20) {
			workList = myDAO.selectAllQc(loginUser);
		} else {
			workList = null;
		}
		
		return workList;
	}

	@Override
	public List<SuggDTO> selectAllSugg(EmpDTO loginUser) {
		return myDAO.selectAllSugg(loginUser);
	}
	
	@Override
	public List<NoticeDTO> selectAllNotice(EmpDTO loginUser) {
		return myDAO.selectAllNotice(loginUser);
	}

	@Override
	public void updateUser(EmpDTO empDTO, MultipartFile empImgFile, String uploadPath, String uploadUrl) throws IllegalStateException, IOException {
		// 1. 작업장 기본 정보 먼저 UPDATE
	    myDAO.updateUser(empDTO);

	    // 2. 삭제 버튼을 눌렀고, 새 파일은 선택하지 않은 경우
	    if ("Y".equals(empDTO.getDelImg()) && (empImgFile == null || empImgFile.isEmpty())) {
	        empDTO.setEmpImg(null);
	        myDAO.updateUserImg(empDTO);
	        return;
	    }

	    // 3. 새 이미지 선택 안 했으면 종료
	    if (empImgFile == null || empImgFile.isEmpty()) {
	        return;
	    }

	    // 4. 업로드 폴더 생성
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    // 5. 기존 파일 삭제 및 새 파일명 생성
	    if (empDTO.getEmpImg() != null && !empDTO.getEmpImg().trim().equals("")) {
	        String oldImgUrl = empDTO.getEmpImg();
	        String oldFileName = oldImgUrl.substring(oldImgUrl.lastIndexOf("/") + 1);

	        File oldFile = new File(uploadPath, oldFileName);
	        if (oldFile.exists()) {
	            oldFile.delete();
	        }
	    }
	    
	    String originalName = empImgFile.getOriginalFilename();
	    String ext = originalName.substring(originalName.lastIndexOf("."));

	    String savedName = empDTO.getEmpId() + "_" + System.currentTimeMillis() + ext;

	    // 6. 실제 파일 저장
	    File saveFile = new File(uploadPath, savedName);
	    empImgFile.transferTo(saveFile);

	    // 7. DB 이미지 URL 수정
	    String imgUrl = uploadUrl + "/" + savedName;
	    empDTO.setEmpImg(imgUrl);
	    myDAO.updateUserImg(empDTO);
		
	}

	@Override
	public EmpDTO reSelectUserInfo(EmpDTO loginUser) {
		return myDAO.reSelectUserInfo(loginUser);
	}

	@Override
	public AdminActivityDTO workCnt(EmpDTO loginUser) {
		return myDAO.workCnt(loginUser);
	}
	
}
