package kr.or.chop.P06_work.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dto.WorkBomDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.P06_work.dto.WorkLotDTO;
import kr.or.chop.common.pagination.PageInfo;

@Repository
public class WorkDAOImpl implements WorkDAO {

	@Autowired
	SqlSession session;

	@Override
	public int selectWorkCount(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectWorkCount", workDTO);
	}

	@Override
	public List<WorkDTO> selectAllWork(WorkDTO workDTO, PageInfo pageInfo) {
		Map map = new HashMap();
		map.put("workDTO", workDTO);
		map.put("page", pageInfo);

		return session.selectList("mapper.P06_work.selectAllWork", map);
	}

	@Override
	public WorkDTO selectWorkCardCnt(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectWorkCardCnt", workDTO);
	}

	@Override
	public WorkDTO selectWorkDetail(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectWorkDetail", workDTO);
	}

	@Override
	public List<WorkDTO> selectWorkProcList(WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectWorkProcList", workDTO);
	}
	
	@Override
	public List<WorkDTO> selectProcWpList(WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectProcWpList", workDTO);
	}

	@Override
	public List<WorkDTO> selectProcEqList(WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectProcEqList", workDTO);
	}
	
	@Override
	public List<PlanDTO> selectWorkPlanList() {
		return session.selectList("mapper.P06_work.selectWorkPlanList");
	}

	@Override
	public List<WorkDTO> selectWorkerList(WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectWorkerList", workDTO);
	}
	
	
	// 작업 지시 등록, 수정
	// BOM 계산
	@Override
	public List<WorkBomDTO> selectBomListForWork (WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectBomListForWork", workDTO);
	}
	// 재고 예약
	@Override
	public int reserveStock (WorkBomDTO bomDTO) {
		return session.update("mapper.P06_work.reserveStock", bomDTO);
	}
	// 작업 등록
	@Override
	public int insertWork(WorkDTO workDTO) {
		return session.insert("mapper.P06_work.insertWork", workDTO);
	}
	
	// 작업 수정
	@Override
	public WorkDTO selectWorkModify(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectWorkModify", workDTO);
	}
	
	@Override
	public int updateWork(WorkDTO workDTO) {
		return session.update("mapper.P06_work.updateWork", workDTO);
	}

	
	// 작업 삭제, 결과 수정
	@Override
	public List<WorkBomDTO> selectBomListForWorkResult(WorkDTO workDTO) {
	    return session.selectList("mapper.P06_work.selectBomListForWorkResult", workDTO);
	}

	@Override
	public int settleReservedStock(WorkBomDTO bomDTO) {
	    return session.update("mapper.P06_work.settleReservedStock", bomDTO);
	}
	
	
	@Override
	public int deleteWork(WorkDTO workDTO) {
		return session.update("mapper.P06_work.deleteWork", workDTO);
	}
	

	@Override
	public int updateWorkResult(WorkDTO workDTO) {
		return session.update("mapper.P06_work.updateWorkResult", workDTO);
	}

	@Override
	public String selectAvailableSecId(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectAvailableSecId", workDTO);
	}

	@Override
	public int insertLot(WorkDTO workDTO) {
		return session.insert("mapper.P06_work.insertLot", workDTO);
	}

	@Override
	public int updateStock(WorkDTO workDTO) {
		return session.update("mapper.P06_work.updateStock", workDTO);
	}
	
	@Override
	public int selectUsableLotQty(WorkBomDTO bomDTO) {
	    Integer result = session.selectOne("mapper.P06_work.selectUsableLotQty", bomDTO);
	    return result == null ? 0 : result;
	}

	@Override
	public List<WorkLotDTO> selectUsableLotList(WorkBomDTO bomDTO) {
	    return session.selectList("mapper.P06_work.selectUsableLotList", bomDTO);
	}

	@Override
	public int insertLotUse(WorkLotDTO lotDTO) {
	    return session.insert("mapper.P06_work.insertLotUse", lotDTO);
	}

	@Override
	public int updateUsedLot(WorkLotDTO lotDTO) {
	    return session.update("mapper.P06_work.updateUsedLot", lotDTO);
	}
	
	
}
