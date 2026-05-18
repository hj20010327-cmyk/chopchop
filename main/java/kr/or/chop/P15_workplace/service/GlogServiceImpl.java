package kr.or.chop.P15_workplace.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P15_workplace.dao.GlogDAO;
import kr.or.chop.P15_workplace.dto.WPDTO;
import kr.or.chop.P19_ghp.dto.GhpDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;

@Service
public class GlogServiceImpl implements GlogService {
	
	@Autowired
	GlogDAO glogDAO;

	@Override
	public List<GhpDTO> selectAllGhp(WPDTO wpDTO) {
		System.out.println("/workplace/glog/add service.selectAllGhp");
		
		return glogDAO.selectAllGhp(wpDTO);
	}

	@Override
	public GhpDTO selectGhp(GhpDTO ghpDTO) {
		System.out.println("/workplace/glog/add service.selectGhp");
		
		return glogDAO.selectGhp(ghpDTO);
	}

	@Override
	public void insertGlog(GlogDTO glogDTO, MultipartFile ghpImgFile, String uploadPath, String contextPath)
			throws IllegalStateException, IOException {
		System.out.println("/workplace/glog/add service.insertGlog");
		
		// 1. 이미지 없이 먼저 INSERT
		glogDAO.insertGlog(glogDTO);
		
		String glogId = glogDTO.getGlogId();
		
		// 2. 이미지 없으면 여기서 종료
		if (ghpImgFile == null || ghpImgFile.isEmpty()) {
			return;
		}
		
		// 3. 업로드 폴더 생성
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		
		// 4. 확장자 추출
		String originalName = ghpImgFile.getOriginalFilename();
		String ext = originalName.substring(originalName.lastIndexOf("."));
		
		// 5. 파일명을 glogId로 생성
		String savedName = glogId + ext;
		File saveFile = new File(uploadPath, savedName);
		
		// 6. 실제 파일 저장
		ghpImgFile.transferTo(saveFile);
		
		// 7. DB에 이미지 파일명 update
		String imgUrl = contextPath + "/resources/img/P15_workplace/glog/" + savedName;
		
		glogDTO.setGlogImg(imgUrl);
		glogDAO.updateGhpImg(glogDTO);
	}

	@Override
	public GlogDTO selectGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/detail service.selectGlog");
		
		return glogDAO.selectGlog(glogDTO);
	}

	@Override
	public int deleteGlog(GlogDTO glogDTO) {
		System.out.println("/workplace/glog/detail service.deleteGlog");
		
		return glogDAO.deleteGlog(glogDTO);
	}

	@Override
	public void updateGlog(GlogDTO glogDTO, MultipartFile ghpImgFile, String uploadPath, String contextPath)
			throws IllegalStateException, IOException {
		System.out.println("/workplace/glog/detail service.updateGlog");

	    // 1. 작업장 기본 정보 먼저 UPDATE
	    glogDAO.updateGlog(glogDTO);

	    // 2. 삭제 버튼을 눌렀고, 새 파일은 선택하지 않은 경우
	    if ("Y".equals(glogDTO.getDelImg()) && (ghpImgFile == null || ghpImgFile.isEmpty())) {
	        glogDTO.setGlogImg(null);
	        glogDAO.updateGhpImg(glogDTO);
	        return;
	    }

	    // 3. 새 이미지 선택 안 했으면 종료
	    if (ghpImgFile == null || ghpImgFile.isEmpty()) {
	        return;
	    }

	    // 4. 업로드 폴더 생성
	    File uploadDir = new File(uploadPath);
	    if (!uploadDir.exists()) {
	        uploadDir.mkdirs();
	    }

	    String savedName;

	    // 5. 기존 이미지가 있으면 기존 파일명으로 덮어쓰기
	    if (glogDTO.getGlogImg() != null && !glogDTO.getGlogImg().trim().equals("")) {
	        String oldImgUrl = glogDTO.getGlogImg();
	        savedName = oldImgUrl.substring(oldImgUrl.lastIndexOf("/") + 1);
	    } else {
	        String originalName = ghpImgFile.getOriginalFilename();
	        String ext = originalName.substring(originalName.lastIndexOf("."));
	        savedName = glogDTO.getGlogId() + ext;
	    }

	    // 6. 실제 파일 저장
	    File saveFile = new File(uploadPath, savedName);
	    ghpImgFile.transferTo(saveFile);

	    // 7. DB 이미지 URL 수정
	    String imgUrl = contextPath + "/resources/img/P15_workplace/glog/" + savedName;
	    glogDTO.setGlogImg(imgUrl);
	    glogDAO.updateGhpImg(glogDTO);
		
	}

}
