package kr.or.chop.P15_workplace.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
	public int selectGlogCount(WPDTO wpDTO) {
		
		System.out.println("/workplace/detail service.selectGlogCount");
		
		return wpDAO.selectGlogCount(wpDTO);
	}

	@Override
	public List<GlogDTO> selectGlogList(WPDTO wpDTO, PageInfo pageInfo) {
		
		System.out.println("/workplace/detail service.selectGlogList");
		
		return wpDAO.selectGlogList(wpDTO, pageInfo);
	}

	@Override
	public void insertWP(WPDTO wpDTO, MultipartFile wpImgFile, String uploadPath, String contextPath)
			throws IllegalStateException, IOException {
		
		System.out.println("/workplace/add service.insertWP");
		
		// 1. 이미지 없이 먼저 INSERT
	    // insert 후 wpDTO 안에 wpId가 들어오게 만들어야 함
	    wpDAO.insertWP(wpDTO);

	    String wpId = wpDTO.getWpId();

	    // 2. 이미지 없으면 여기서 종료
	    if (wpImgFile == null || wpImgFile.isEmpty()) {
	        return;
	    }

	    // 3. 업로드 폴더 생성
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    // 4. 확장자 추출
	    String originalName = wpImgFile.getOriginalFilename();
	    String ext = originalName.substring(originalName.lastIndexOf("."));

	    // 5. 파일명을 wpId로 생성
	    String savedName = wpId + ext;

	    File saveFile = new File(uploadPath, savedName);

	    // 6. 실제 파일 저장
	    wpImgFile.transferTo(saveFile);

	    // 7. DB에 이미지 파일명 UPDATE
	    String imgUrl = contextPath + "/resources/img/P15_workplace/" + savedName;
	    
	    wpDTO.setWpImg(imgUrl);
	    wpDAO.updateWpImg(wpDTO);
	}

	@Override
	public void updateWP(WPDTO wpDTO, MultipartFile wpImgFile, String uploadPath, String contextPath)
			throws IllegalStateException, IOException {

	    System.out.println("/workplace/update service.updateWP");

	    // 1. 작업장 기본 정보 먼저 UPDATE
	    wpDAO.updateWp(wpDTO);

	    // 2. 삭제 버튼을 눌렀고, 새 파일은 선택하지 않은 경우
	    if ("Y".equals(wpDTO.getDelImg()) && (wpImgFile == null || wpImgFile.isEmpty())) {
	        wpDTO.setWpImg(null);
	        wpDAO.updateWpImg(wpDTO);
	        return;
	    }

	    // 3. 새 이미지 선택 안 했으면 종료
	    if (wpImgFile == null || wpImgFile.isEmpty()) {
	        return;
	    }

	    // 4. 업로드 폴더 생성
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    String savedName;

	    // 5. 기존 이미지가 있으면 기존 파일명으로 덮어쓰기
	    if (wpDTO.getWpImg() != null && !wpDTO.getWpImg().trim().equals("")) {
	        String oldImgUrl = wpDTO.getWpImg();
	        savedName = oldImgUrl.substring(oldImgUrl.lastIndexOf("/") + 1);
	    } else {
	        String originalName = wpImgFile.getOriginalFilename();
	        String ext = originalName.substring(originalName.lastIndexOf("."));
	        savedName = wpDTO.getWpId() + ext;
	    }

	    // 6. 실제 파일 저장
	    File saveFile = new File(uploadPath, savedName);
	    wpImgFile.transferTo(saveFile);

	    // 7. DB 이미지 URL 수정
	    String imgUrl = contextPath + "/resources/img/P15_workplace/" + savedName;
	    wpDTO.setWpImg(imgUrl);
	    wpDAO.updateWpImg(wpDTO);
		
	}

	@Override
	public int deleteWp(WPDTO wpDTO) {

		System.out.println("/workplace/delete service.deleteWp");
		
		return wpDAO.deleteWp(wpDTO);
	}

}
