package kr.or.chop.P06_work.dao;

import java.util.List;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dto.WorkBomDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.dto.WorkLotDTO;
import kr.or.chop.common.pagination.PageInfo;

public interface WorkDAO {
	
	public int selectWorkCount(WorkDTO workDTO);
	public List<WorkDTO> selectAllWork(WorkDTO workDTO, PageInfo pageInfo);
	public WorkDTO selectWorkCardCnt(WorkDTO workDTO);
	
	public WorkDTO selectWorkDetail(WorkDTO workDTO);
	public List<WorkDTO> selectWorkProcList(WorkDTO workDTO);
	public List<WorkDTO> selectProcWpList(WorkDTO workDTO);
	public List<WorkDTO> selectProcEqList(WorkDTO workDTO);
	
	public List<PlanDTO> selectWorkPlanList();
	public List<WorkDTO> selectWorkerList(WorkDTO workDTO);
	
	// 작업지시 등록 수정
	public List<WorkBomDTO> selectBomListForWork (WorkDTO workDTO);
	public int reserveStock (WorkBomDTO bomDTO);
	public int insertWork(WorkDTO workDTO);
	
	public WorkDTO selectWorkModify(WorkDTO workDTO);
	public int updateWork(WorkDTO workDTO);
	
	// 작업 삭제, 결과 수정
	public List<WorkBomDTO> selectBomListForWorkResult(WorkDTO workDTO);
	public int settleReservedStock(WorkBomDTO bomDTO);

	public int deleteWork(WorkDTO workDTO);
	
	public int updateWorkResult(WorkDTO workDTO);
	public String selectAvailableSecId (WorkDTO workDTO);
	public int insertLot (WorkDTO workDTO);
	public int insertIo (WorkDTO workDTO);
	public int updateStock (WorkDTO workDTO);
	
	
	// LOT 사용 가능 수량 확인
	public int selectUsableLotQty(WorkBomDTO bomDTO);
	// 유통기한 빠른 순서로 사용 가능 LOT 조회
	public List<WorkLotDTO> selectUsableLotList(WorkBomDTO bomDTO);
	// LOT_USE 이력 등록
	public int insertLotUse(WorkLotDTO lotDTO);
	// LOT 잔량/상태 변경
	public int updateUsedLot(WorkLotDTO lotDTO);
}
