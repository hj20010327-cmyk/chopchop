package kr.or.chop.P07_qc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.chop.P07_qc.dao.QcDAO;
import kr.or.chop.P07_qc.dto.QcDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class QcServiceImpl implements QcService{

	@Autowired
	private QcDAO qcDAO;

	@Override
	public int selectQcCount(QcDTO dto) {
		return qcDAO.selectQcCount(dto);
	}

	@Override
	public List<QcDTO> selectQcList(QcDTO dto, PageInfo pageInfo) {
		return qcDAO.selectQcList(dto, pageInfo);
	}

	@Override
	public QcDTO selectQcSummary(QcDTO dto) {
		return qcDAO.selectQcSummary(dto);
	}

	@Override
	public QcDTO selectQcDetail(String qcId) {
		return qcDAO.selectQcDetail(qcId);
	}

	@Override
	@Transactional
	public int insertQc(QcDTO dto) {

	    QcDTO lot = qcDAO.selectLotForQc(dto.getQcLot());

	    if (lot == null) {
	        throw new RuntimeException("검사 가능한 LOT가 아닙니다.");
	    }

	    int lotQty = lot.getLotQty();

	    String qcType = lot.getItemQcType();

	    int qcQty;

	    if ("10".equals(qcType)) {
	        // 전수조사: LOT 전체 수량 검사
	        qcQty = lotQty;

	    } else if ("20".equals(qcType)) {
	        // 샘플조사: LOT 수량의 5% 검사
	        qcQty = (int) Math.ceil(lotQty * 0.01);

	    } else {
	        throw new RuntimeException("품목에 검사유형이 설정되어 있지 않습니다.");
	    }

	    // 화면값 믿지 말고 서버에서 다시 세팅
	    dto.setQcType(qcType);
	    dto.setQcQty(qcQty);
	    dto.setQcContent(lot.getItemName() + " (" + lot.getItemId() + ")");

	    return qcDAO.insertQc(dto);
	}

	@Override
	@Transactional
	public int updateQc(QcDTO dto) {

	    QcDTO origin = qcDAO.selectQcDetail(dto.getQcId());

	    if (origin == null) {
	        throw new RuntimeException("품질검사 지시 정보를 찾을 수 없습니다.");
	    }

	    if (origin.getQcStatus() == 30) {
	        throw new RuntimeException("완료된 품질검사 지시는 수정할 수 없습니다.");
	    }

	    if (dto.getQcWorker() == null || dto.getQcWorker().trim().isEmpty()) {
	        throw new RuntimeException("검사자를 선택하세요.");
	    }

	    return qcDAO.updateQc(dto);
	}

	@Override
	public int deleteQc(String qcId) {
		return qcDAO.deleteQc(qcId);
	}
	
	@Override
	public List<QcDTO> selectQcLotList() {
	    return qcDAO.selectQcLotList();
	}
	
	@Override
	@Transactional
	public int updateQcResult(QcDTO dto) {

	    QcDTO origin = qcDAO.selectQcDetail(dto.getQcId());

	    if (origin == null) {
	        throw new RuntimeException("품질검사 정보를 찾을 수 없습니다.");
	    }

	    // 원본 검사 정보 기준으로 다시 세팅
	    dto.setQcLot(origin.getQcLot());
	    dto.setQcType(origin.getQcType());
	    dto.setQcQty(origin.getQcQty());
	    dto.setLotQty(origin.getLotQty());

	    int failQty = 0;
	    int disposeQty = 0;

	    if (dto.getDefectQty() != null) {
	        for (int i = 0; i < dto.getDefectQty().length; i++) {

	            failQty += dto.getDefectQty()[i];

	            if (dto.getDefectDiscard() != null
	                    && dto.getDefectDiscard().length > i
	                    && "Y".equals(dto.getDefectDiscard()[i])) {

	                disposeQty += dto.getDefectQty()[i];
	            }
	        }
	    }

	    if (failQty > dto.getQcQty()) {
	        throw new RuntimeException("불량 수량 합계는 검사 수량보다 클 수 없습니다.");
	    }

	    int passQty = dto.getQcQty() - failQty;

	    int multiplier = 1;

	    if ("20".equals(dto.getQcType())) {
	        multiplier = 100;
	    }

	    int inQty = passQty * multiplier;
	    int realDisposeQty = disposeQty * multiplier;

	    // LOT 수량 초과 방지
	    if (inQty > dto.getLotQty()) {
	        inQty = dto.getLotQty();
	    }

	    if (realDisposeQty > dto.getLotQty()) {
	        realDisposeQty = dto.getLotQty();
	    }

	    // 검사 기준 합격 수량
	    dto.setQcPassQty(passQty);

	    // LOT/STOCK 반영용 실제 수량
	    dto.setInQty(inQty);
	    dto.setDisposeQty(realDisposeQty);

	    if (dto.getQcStatus() == 30) {
	        qcDAO.plusStockByQcResult(dto);
	        qcDAO.updateLotByQcResult(dto);
	    }

	    int result = qcDAO.updateQcResult(dto);

	    qcDAO.deleteDefLog(dto.getQcId());

	    if (dto.getDefectType() != null) {
	        for (int i = 0; i < dto.getDefectType().length; i++) {
	            QcDTO def = new QcDTO();

	            def.setQcId(dto.getQcId());
	            def.setDefType(dto.getDefectType()[i]);
	            def.setDefQty(dto.getDefectQty()[i]);
	            def.setDefAction(dto.getDefectAction()[i]);
	            def.setDefDiscard(dto.getDefectDiscard()[i]);

	            qcDAO.insertDefLog(def);
	        }
	    }

	    return result;
	}

	@Override
	public List<QcDTO> selectDefLogList(String qcId) {
		return qcDAO.selectDefLogList(qcId);
	}
	
	@Override
	public List<QcDTO> selectDefectTypeList() {
	    return qcDAO.selectDefectTypeList();
	}
	
	@Override
	public List<QcDTO> selectWarehouseListByItem(String itemId) {

	    return qcDAO.selectWarehouseListByItem(itemId);

	}

	@Override
	public List<QcDTO> selectSectionListByWarehouse(String whId) {

	    return qcDAO.selectSectionListByWarehouse(whId);

	}

}
