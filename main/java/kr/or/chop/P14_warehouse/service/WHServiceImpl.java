package kr.or.chop.P14_warehouse.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.chop.P14_warehouse.dao.SecDAO;
import kr.or.chop.P14_warehouse.dao.WHDAO;
import kr.or.chop.P14_warehouse.dto.SecDTO;
import kr.or.chop.P14_warehouse.dto.WHDTO;
import kr.or.chop.P19_ghp.dto.GlogDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class WHServiceImpl implements WHService {
	
	@Autowired
	WHDAO whDAO;
	@Autowired
	SecDAO secDAO;

	@Override
	public List<WHDTO> selectAllWH(WHDTO whDTO, PageInfo pageInfo) {

		System.out.println("/warehouse/list service.selectAllWH");
		
		return whDAO.selectAllWH(whDTO, pageInfo);
	}

	@Override
	public int selectWHCount(WHDTO whDTO) {

		System.out.println("/warehouse/list service.selectWHCount");
		
		return whDAO.selectWHCount(whDTO);
	}

	@Override
	public WHDTO selectWhCardCnt(WHDTO whDTO) {
		
		System.out.println("/warehouse/list service.selectWhCardCnt");
		
		return whDAO.selectWhCardCnt(whDTO);
	}

	@Override
	public WHDTO selectWhDTO(WHDTO whDTO) {

		System.out.println("/warehouse/detail service.selectWhDTO");
		
		return whDAO.selectWHDTO(whDTO);
	}

	@Override
	public int selectGlogCount(WHDTO whDTO) {

		System.out.println("/warehouse/detail service.selectGlogCount");

		return whDAO.selectGlogCount(whDTO);
	}

	@Override
	public List<GlogDTO> selectGlogList(WHDTO whDTO, PageInfo pageInfo) {

		System.out.println("/warehouse/detail service.selectGlogList");

		return whDAO.selectGlogList(whDTO, pageInfo);
	}

	@Override
	public List<SecDTO> selectSecList(WHDTO whDTO) {

		System.out.println("/warehouse/detail service.selectSecList");

		return whDAO.selectSecList(whDTO);
	}

	@Override
	public void insertWH(WHDTO whDTO) throws IllegalStateException, IOException {

		System.out.println("/warehouse/add service.insertWH");
		
		// 1. 이미지 없이 먼저 INSERT
	    // insert 후 whDTO 안에 whId가 들어오게 만들어야 함
	    whDAO.insertWH(whDTO);

	    // 1-1. 시퀀스 생성
	    whDAO.createSecSeq(whDTO);

//	    // 2. 이미지 없으면 여기서 종료
//	    if (whImgFile == null || whImgFile.isEmpty()) {
//	        return;
//	    }
//
//	    // 3. 업로드 폴더 생성
//	    File uploadDir = new File(uploadPath);
//	    if (!uploadDir.exists()) {
//	        uploadDir.mkdirs();
//	    }
//
//	    // 4. 확장자 추출
//	    String originalName = whImgFile.getOriginalFilename();
//	    String ext = originalName.substring(originalName.lastIndexOf("."));
//
//	    // 5. 파일명을 wpId로 생성
//	    String savedName = whDTO.getWhId() + "_" + System.currentTimeMillis() + ext;
//
//	    File saveFile = new File(uploadPath, savedName);
//
//	    // 6. 실제 파일 저장
//	    whImgFile.transferTo(saveFile);
//
//	    // 7. DB에 이미지 파일명 UPDATE
//	    String imgUrl = uploadUrl + "/" + savedName;
//	    
//	    whDTO.setWhImg(imgUrl);
//	    whDAO.updateWhImg(whDTO);
	}

	@Override
	public void updateWH(WHDTO whDTO) throws IllegalStateException, IOException {

	    System.out.println("/warehouse/update service.updateWH");

	    // 1. 작업장 기본 정보 먼저 UPDATE
	    whDAO.updateWh(whDTO);

//	    // 2. 삭제 버튼을 눌렀고, 새 파일은 선택하지 않은 경우
//	    if ("Y".equals(whDTO.getDelImg()) && (whImgFile == null || whImgFile.isEmpty())) {
//	        whDTO.setWhImg(null);
//	        whDAO.updateWhImg(whDTO);
//	        return;
//	    }
//
//	    // 3. 새 이미지 선택 안 했으면 종료
//	    if (whImgFile == null || whImgFile.isEmpty()) {
//	        return;
//	    }
//
//	    // 4. 업로드 폴더 생성
//	    File uploadDir = new File(uploadPath);
//	    if (!uploadDir.exists()) {
//	        uploadDir.mkdirs();
//	    }
//
//	    // 5. 기존 파일 삭제 및 새 파일명 생성
//	    if (whDTO.getWhImg() != null && !whDTO.getWhImg().trim().equals("")) {
//	        String oldImgUrl = whDTO.getWhImg();
//	        String oldFileName = oldImgUrl.substring(oldImgUrl.lastIndexOf("/") + 1);
//
//	        File oldFile = new File(uploadPath, oldFileName);
//	        if (oldFile.exists()) {
//	            oldFile.delete();
//	        }
//	    }
//	    
//	    String originalName = whImgFile.getOriginalFilename();
//	    String ext = originalName.substring(originalName.lastIndexOf("."));
//
//	    String savedName = whDTO.getWhId() + "_" + System.currentTimeMillis() + ext;
//
//	    // 6. 실제 파일 저장
//	    File saveFile = new File(uploadPath, savedName);
//	    whImgFile.transferTo(saveFile);
//
//	    // 7. DB 이미지 URL 수정
//	    String imgUrl = uploadUrl + "/" + savedName;
//	    whDTO.setWhImg(imgUrl);
//	    whDAO.updateWhImg(whDTO);
		
	}
	
	@Override
	public int deleteWh(WHDTO whDTO) {

		System.out.println("/warehouse/delete service.deleteWp");
		
		return whDAO.deleteWh(whDTO);
	}

	@Override
	@Transactional
	public void insertWHWithSections(
			WHDTO whDTO,
			String secQtyList
	) throws Exception {

		if (secQtyList == null || secQtyList.trim().isEmpty()) {
			throw new RuntimeException("섹션 정보가 없습니다.");
		}

		// 1. 창고 먼저 등록. 현재 XML 기준 WH_QTY는 0으로 들어감.
		whDAO.insertWH(whDTO);

		// 2. 창고별 섹션 시퀀스 생성.
		//    기존 insertSection이 ${secWhId}_SEQ를 사용하므로 필요함.
		whDAO.createSecSeq(whDTO);

//		// 3. 이미지 있으면 저장 후 WH_IMG 업데이트.
//		if (whImgFile != null && !whImgFile.isEmpty()) {
//			File dir = new File(uploadPath);
//
//			if (!dir.exists()) {
//				dir.mkdirs();
//			}
//
//			String originalName = whImgFile.getOriginalFilename();
//			String ext = "";
//
//			if (originalName != null && originalName.lastIndexOf(".") != -1) {
//				ext = originalName.substring(originalName.lastIndexOf("."));
//			}
//
//			String saveName = whDTO.getWhId() + "_" + System.currentTimeMillis() + ext;
//			File saveFile = new File(uploadPath, saveName);
//
//			whImgFile.transferTo(saveFile);
//
//			whDTO.setWhImg(uploadUrl + "/" + saveName);
//			whDAO.updateWhImg(whDTO);
//		}

		// 3. 섹션 등록.
		String[] qtyArr = secQtyList.split(",");

		for (int i = 0; i < qtyArr.length; i++) {
			String qtyStr = qtyArr[i];

			if (qtyStr == null || qtyStr.trim().isEmpty()) {
				continue;
			}

			int secQty = Integer.parseInt(qtyStr.trim());

			if (secQty <= 0) {
				throw new RuntimeException("섹션 수용량은 1 이상이어야 합니다.");
			}

			SecDTO sec = new SecDTO();
			sec.setSecWhId(whDTO.getWhId());
			sec.setSecQty(secQty);

			// 핵심: add에서도 순서 저장
			sec.setSecOrder(i + 1);

			secDAO.insertSection(sec);
			secDAO.plusWhQty(sec);
		}

	}
	
	
	@Override
	@Transactional
	public void updateWHWithSections(
			WHDTO whDTO,
			String sectionPayload,
			String deleteSecIds
	) throws Exception {

		System.out.println("/warehouse/update service.updateWHWithSections");

		if (sectionPayload == null || sectionPayload.trim().isEmpty()) {
			throw new RuntimeException("섹션 정보가 없습니다.");
		}

		// 1. 창고 기본정보 수정
		whDAO.updateWh(whDTO);

		// 2. 삭제된 기존 섹션 처리
		if (deleteSecIds != null && !deleteSecIds.trim().isEmpty()) {
			String[] deleteArr = deleteSecIds.split(",");

			for (String secId : deleteArr) {
				if (secId == null || secId.trim().isEmpty()) {
					continue;
				}

				SecDTO findDTO = new SecDTO();
				findDTO.setSecId(secId.trim());

				SecDTO oldSec = secDAO.selectSecDTO(findDTO);

				if (oldSec == null) {
					throw new RuntimeException("삭제할 섹션을 찾을 수 없습니다. secId=" + secId);
				}

				if (oldSec.getSecPrevQty() > 0) {
					throw new RuntimeException("현재 적재량이 있는 섹션은 삭제할 수 없습니다. secId=" + secId);
				}

				// 창고 총 수용량 감소
				secDAO.minusWhQty(oldSec);

				// 섹션 논리삭제
				secDAO.deleteSection(oldSec);
			}
		}

		// 3. 화면에 남아있는 섹션 처리
		String[] itemArr = sectionPayload.split(",");

		for (int i = 0; i < itemArr.length; i++) {
			String item = itemArr[i];

			if (item == null || item.trim().isEmpty()) {
				continue;
			}

			String[] parts = item.split(":");

			if (parts.length != 2) {
				throw new RuntimeException("섹션 payload 형식 오류: " + item);
			}

			String secId = parts[0].trim();
			int newQty = Integer.parseInt(parts[1].trim());
			int newOrder = i + 1;

			if (newQty <= 0) {
				throw new RuntimeException("섹션 수용량은 1 이상이어야 합니다.");
			}

			// 3-1. 신규 섹션
			if ("NEW".equals(secId)) {
				SecDTO newSec = new SecDTO();
				newSec.setSecWhId(whDTO.getWhId());
				newSec.setSecQty(newQty);
				newSec.setSecOrder(newOrder);

				secDAO.insertSection(newSec);
				secDAO.plusWhQty(newSec);

				continue;
			}

			// 3-2. 기존 섹션
			SecDTO findDTO = new SecDTO();
			findDTO.setSecId(secId);

			SecDTO oldSec = secDAO.selectSecDTO(findDTO);

			if (oldSec == null) {
				throw new RuntimeException("수정할 섹션을 찾을 수 없습니다. secId=" + secId);
			}

			if (oldSec.getSecPrevQty() > newQty) {
				throw new RuntimeException("현재 적재량보다 수용량을 작게 수정할 수 없습니다. secId=" + secId);
			}

			int diff = newQty - oldSec.getSecQty();

			SecDTO updateSec = new SecDTO();
			updateSec.setSecId(secId);
			updateSec.setSecWhId(whDTO.getWhId());
			updateSec.setSecQty(newQty);
			updateSec.setSecOrder(newOrder);

			// 섹션 수용량 수정
			secDAO.updateSecQty(updateSec);

			// 섹션 순서 수정
			secDAO.updateSecOrder(updateSec);

			// 창고 총 수용량 보정
			if (diff > 0) {
				SecDTO diffSec = new SecDTO();
				diffSec.setSecWhId(whDTO.getWhId());
				diffSec.setSecQty(diff);
				secDAO.plusWhQty(diffSec);
			} else if (diff < 0) {
				SecDTO diffSec = new SecDTO();
				diffSec.setSecWhId(whDTO.getWhId());
				diffSec.setSecQty(Math.abs(diff));
				secDAO.minusWhQty(diffSec);
			}
		}
	}
	
	
	
}
