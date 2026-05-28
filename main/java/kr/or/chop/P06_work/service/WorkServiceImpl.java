package kr.or.chop.P06_work.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.chop.P02_dashboard.dao.RefreshDAO;
import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dao.WorkDAO;
import kr.or.chop.P06_work.dto.WorkBomDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.dto.WorkLotDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class WorkServiceImpl implements WorkService {
	
	@Autowired
	WorkDAO workDAO;
	@Autowired
	RefreshDAO refDAO;
	
	@Override
	public int selectWorkCount(WorkDTO workDTO) {
		return workDAO.selectWorkCount(workDTO);
	}

	@Override
	public List<WorkDTO> selectAllWork(WorkDTO workDTO, PageInfo pageInfo) {
		return workDAO.selectAllWork(workDTO, pageInfo);
	}

	@Override
	public WorkDTO selectWorkCardCnt(WorkDTO workDTO) {
		return workDAO.selectWorkCardCnt(workDTO);
	}

	@Override
	public WorkDTO selectWorkDetail(WorkDTO workDTO) {
		workDTO = workDAO.selectWorkDetail(workDTO);
		
		List<WorkBomDTO> bomList = workDAO.selectBomListForWork(workDTO);
		
		workDTO.setBomList(bomList);
		
		return workDTO;
	}

	@Override
	public List<WorkDTO> selectWorkProcList(WorkDTO workDTO) {

	    List<WorkDTO> procList = workDAO.selectWorkProcList(workDTO);

	    if (procList == null || procList.isEmpty()) {
	        return new ArrayList<WorkDTO>();
	    }

	    for (WorkDTO proc : procList) {

	        if (proc == null) {
	            continue;
	        }

	        List<WorkDTO> wpList = workDAO.selectProcWpList(proc);
	        List<WorkDTO> eqList = workDAO.selectProcEqList(proc);

	        if (wpList == null) {
	            wpList = new ArrayList<WorkDTO>();
	        }

	        if (eqList == null) {
	            eqList = new ArrayList<WorkDTO>();
	        }

	        proc.setWpList(wpList);
	        proc.setEqList(eqList);
	    }

	    return procList;
	}
	
	@Override
	public List<WorkDTO> selectProcWpList(WorkDTO workDTO) {
		return workDAO.selectProcWpList(workDTO);
	}

	@Override
	public List<WorkDTO> selectProcEqList(WorkDTO workDTO) {
		return workDAO.selectProcEqList(workDTO);
	}

	@Override
	public List<PlanDTO> selectWorkPlanList() {
		return workDAO.selectWorkPlanList();
	}

	@Override
	public List<WorkDTO> selectWorkerList(WorkDTO workDTO) {
		return workDAO.selectWorkerList(workDTO);
	}

	@Transactional
	@Override
	public void insertWork(WorkDTO workDTO) {
		// 작업에 필요한 bomList 가져오기
		List<WorkBomDTO> bomList = workDAO.selectBomListForWork(workDTO);
		
		if (bomList == null || bomList.isEmpty()) {
	        throw new RuntimeException("해당 작업 품목에 사용 가능한 BOM이 없습니다.");
	    }
		
		workDTO.setBomList(bomList);
		
		// 재고 확인
		for (WorkBomDTO bom : bomList) {

	        if (bom.getStockId() == null || bom.getStockId().equals("")) {
	            throw new RuntimeException(
	                "재고 정보가 없는 자재입니다: " + bom.getItemName()
	            );
	        }

	        if (bom.getStockAvailQty() < bom.getReqQty()) {
	            throw new RuntimeException(
	                bom.getItemName()
	                + " 재고 부족 / 필요: " + bom.getReqQty()
	                + ", 가용: " + bom.getStockAvailQty()
	            );
	        }
	    }
		
		// 자재 예약
		for (WorkBomDTO bom : bomList) {
	        int result = workDAO.reserveStock(bom);

	        if (result == 0) {
	            throw new RuntimeException(
	                bom.getItemName() + " 재고 예약 실패. 다른 작업에서 먼저 예약했을 수 있습니다."
	            );
	        }
	    }
		
		// 작업 지시
		int insertResult = workDAO.insertWork(workDTO);

	    if (insertResult == 0) {
	        throw new RuntimeException("작업지시 등록 실패");
	    }
	    
//	    refDAO.updatePlanWpQtyOne(workDTO.getWorkPlan());
	    
	}

	@Override
	public WorkDTO selectWorkModify(WorkDTO workDTO) {
		return workDAO.selectWorkModify(workDTO);
	}

	@Transactional
	@Override
	public void updateWork(WorkDTO workDTO) {
		// 상태 변경
		workDAO.updateWork(workDTO);
		
//		refDAO.updatePlanWpQtyOne(workDTO.getWorkPlan());
	}

	@Transactional
	@Override
	public void deleteWork(WorkDTO workDTO) {

	    WorkDTO origin = workDAO.selectWorkDetail(workDTO);

	    if (origin == null) {
	        throw new RuntimeException("삭제할 작업지시 정보를 찾을 수 없습니다.");
	    }

	    int oldStatus = origin.getWorkStatus();

	    if (oldStatus != 10) {
	        throw new RuntimeException("대기 상태의 작업지시만 삭제할 수 있습니다.");
	    }

	    List<WorkBomDTO> bomList = workDAO.selectBomListForWorkResult(origin);

	    if (bomList == null || bomList.isEmpty()) {
	        throw new RuntimeException("정산할 BOM 정보가 없습니다.");
	    }

	    for (WorkBomDTO bom : bomList) {

	        if (bom.getStockId() == null || bom.getStockId().equals("")) {
	            throw new RuntimeException("재고 정보가 없는 자재입니다: " + bom.getItemName());
	        }

	        int result = workDAO.settleReservedStock(bom);

	        if (result == 0) {
	            throw new RuntimeException(
	                bom.getItemName() + " 예약 재고 해제 실패"
	            );
	        }
	    }

	    int deleteResult = workDAO.deleteWork(origin);

	    if (deleteResult == 0) {
	        throw new RuntimeException("작업지시 삭제 실패");
	    }
	    
//	    refDAO.updatePlanWpQtyOne(origin.getWorkPlan());
	}

	@Transactional
	@Override
	public void updateWorkResult(WorkDTO workDTO) {

	    // 1. 기존 작업 조회
	    WorkDTO origin = workDAO.selectWorkDetail(workDTO);

	    if (origin == null) {
	        throw new RuntimeException("작업지시 정보를 찾을 수 없습니다.");
	    }

	    int oldStatus = origin.getWorkStatus();
	    int newStatus = workDTO.getWorkStatus();

	    // 2. 이미 정산된 작업 재처리 방지
	    if (oldStatus == 30 || oldStatus == 0) {
	        throw new RuntimeException("이미 결과 처리된 작업지시입니다.");
	    }

	    // 3. 화면 입력값 반영
	    origin.setWorkPrevQty(workDTO.getWorkPrevQty());
	    origin.setWorkStatus(newStatus);
	    origin.setWorkWmsg(workDTO.getWorkWmsg());

	    // 4. 완료수량 검증
	    if (origin.getWorkPrevQty() < 0) {
	        throw new RuntimeException("완료수량은 0보다 작을 수 없습니다.");
	    }

	    if (origin.getWorkPrevQty() > origin.getWorkOrderQty()) {
	        throw new RuntimeException("완료수량은 작업지시수량보다 클 수 없습니다.");
	    }

	    // 5. 작업중 처리: 재고 건드리지 않음
	    if (newStatus == 20) {

	        int updateResult = workDAO.updateWorkResult(origin);

	        if (updateResult == 0) {
	            throw new RuntimeException("작업 진행 상태 변경 실패");
	        }

	        return;
	    }

	    // 6. 완료/보류 외 상태는 차단
	    if (newStatus != 30 && newStatus != 0) {
	        throw new RuntimeException("처리할 수 없는 작업 상태입니다.");
	    }

	    // 7. 완료/보류일 때만 BOM 기준 원자재 정산
	    List<WorkBomDTO> bomList = workDAO.selectBomListForWorkResult(origin);

	    if (bomList == null || bomList.isEmpty()) {
	        throw new RuntimeException("정산할 BOM 정보가 없습니다.");
	    }

	    for (WorkBomDTO bom : bomList) {

	        if (bom.getStockId() == null || bom.getStockId().equals("")) {
	            throw new RuntimeException("재고 정보가 없는 자재입니다: " + bom.getItemName());
	        }

	        // 완료/보류 수량만큼 실제 LOT 차감
	        consumeLotForWork(origin, bom);

	        // 기존 STOCK 정산
	        int result = workDAO.settleReservedStock(bom);

	        if (result == 0) {
	            throw new RuntimeException(
	                bom.getItemName() + " 재고 정산 실패. 예약수량 또는 전체수량을 확인하세요."
	            );
	        }
	    }

	    // 8. 작업 결과 업데이트
	    int updateResult = workDAO.updateWorkResult(origin);

	    if (updateResult == 0) {
	        throw new RuntimeException("작업 결과 업데이트 실패");
	    }
	    
	    refDAO.updatePlanWpQtyOne(origin.getWorkPlan());

	    // 9. 완료일 때만 완제품 LOT 생성 + 완제품 stock 증가 + 입고 등록
	    if (newStatus == 30) {

	        String lotBwhsec = workDAO.selectAvailableSecId(origin);

	        if (lotBwhsec == null || lotBwhsec.equals("")) {
	            throw new RuntimeException("완제품 LOT을 배치할 창고 섹션이 없습니다.");
	        }

	        origin.setLotBwhsec(lotBwhsec);

	        int lotResult = workDAO.insertLot(origin);

	        if (lotResult == 0) {
	            throw new RuntimeException("완제품 LOT 생성 실패");
	        }
	        
	        int ioResult = workDAO.insertIo(origin);
	        
	        if (ioResult == 0) {
	        	throw new RuntimeException("완제품 LOT 입고 실패");
	        }

	        int stockResult = workDAO.updateStock(origin);

	        if (stockResult == 0) {
	            throw new RuntimeException("완제품 재고 업데이트 실패");
	        }
	    }
	}
	
	
	
	////////////////////////////////////////////////////////////
	
	private void consumeLotForWork(WorkDTO workDTO, WorkBomDTO bom) {

	    int usedQty = bom.getUsedQty();

	    // 보류인데 완료수량이 0이면 실제 사용량도 0일 수 있음
	    if (usedQty <= 0) {
	        return;
	    }

	    // 1. LOT 총량 검증
	    int usableLotQty = workDAO.selectUsableLotQty(bom);

	    if (usableLotQty < usedQty) {
	        throw new RuntimeException(
	            bom.getItemName()
	            + " 사용 가능한 LOT 수량 부족 / 필요: "
	            + usedQty
	            + ", 가능: "
	            + usableLotQty
	        );
	    }

	    // 2. LOT 목록 조회
	    List<WorkLotDTO> lotList = workDAO.selectUsableLotList(bom);

	    if (lotList == null || lotList.isEmpty()) {
	        throw new RuntimeException(
	            bom.getItemName() + " 사용 가능한 LOT이 없습니다."
	        );
	    }

	    int remainQty = usedQty;

	    for (WorkLotDTO lot : lotList) {

	        if (remainQty <= 0) {
	            break;
	        }

	        int lotFqty = lot.getLotFqty();
	        int useQty = Math.min(lotFqty, remainQty);

	        lot.setWorkId(workDTO.getWorkId());
	        lot.setUseQty(useQty);
	        lot.setUseType(10); // 작업투입

	        int useResult = workDAO.insertLotUse(lot);

	        if (useResult == 0) {
	            throw new RuntimeException(
	                bom.getItemName() + " LOT 사용 이력 등록 실패"
	            );
	        }

	        int lotResult = workDAO.updateUsedLot(lot);

	        if (lotResult == 0) {
	            throw new RuntimeException(
	                bom.getItemName() + " LOT 잔량 차감 실패: " + lot.getLotId()
	            );
	        }

	        remainQty -= useQty;
	    }

	    if (remainQty > 0) {
	        throw new RuntimeException(
	            bom.getItemName()
	            + " LOT 차감 실패 / 미차감 수량: "
	            + remainQty
	        );
	    }
	}
	
}
