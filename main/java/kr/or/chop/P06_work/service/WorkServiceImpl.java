package kr.or.chop.P06_work.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dao.WorkDAO;
import kr.or.chop.P06_work.dto.WorkDTO;
import kr.or.chop.common.pagination.PageInfo;

@Service
public class WorkServiceImpl implements WorkService {
	
	@Autowired
	WorkDAO workDAO;
	
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
		return workDAO.selectWorkDetail(workDTO);
	}

	@Override
	public List<WorkDTO> selectWorkProcList(WorkDTO workDTO) {
		return workDAO.selectWorkProcList(workDTO);
	}

	@Override
	public List<PlanDTO> selectWorkPlanList() {
		return workDAO.selectWorkPlanList();
	}

	@Override
	public List<WorkDTO> selectWorkerList(WorkDTO workDTO) {
		return workDAO.selectWorkerList(workDTO);
	}

	@Override
	public int insertWork(WorkDTO workDTO) {
		return workDAO.insertWork(workDTO);
	}

	@Override
	public WorkDTO selectWorkModify(WorkDTO workDTO) {
		return workDAO.selectWorkModify(workDTO);
	}

	@Override
	public int updateWork(WorkDTO workDTO) {
		return workDAO.updateWork(workDTO);
	}

	@Override
	public int deleteWork(WorkDTO workDTO) {
		return workDAO.deleteWork(workDTO);
	}

	@Override
	public int updateWorkResult(WorkDTO workDTO) {
		return workDAO.updateWorkResult(workDTO);
	}
	
}
