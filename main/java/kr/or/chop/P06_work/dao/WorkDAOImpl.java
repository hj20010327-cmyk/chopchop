package kr.or.chop.P06_work.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.or.chop.P05_plan.dto.PlanDTO;
import kr.or.chop.P06_work.dto.WorkDTO;
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
	public List<PlanDTO> selectWorkPlanList() {
		return session.selectList("mapper.P06_work.selectWorkPlanList");
	}

	@Override
	public List<WorkDTO> selectWorkerList(WorkDTO workDTO) {
		return session.selectList("mapper.P06_work.selectWorkerList", workDTO);
	}

	@Override
	public int insertWork(WorkDTO workDTO) {
		return session.insert("mapper.P06_work.insertWork", workDTO);
	}

	@Override
	public WorkDTO selectWorkModify(WorkDTO workDTO) {
		return session.selectOne("mapper.P06_work.selectWorkModify", workDTO);
	}

	@Override
	public int updateWork(WorkDTO workDTO) {
		return session.update("mapper.P06_work.updateWork", workDTO);
	}

	@Override
	public int deleteWork(WorkDTO workDTO) {
		return session.update("mapper.P06_work.deleteWork", workDTO);
	}

	@Override
	public int updateWorkResult(WorkDTO workDTO) {
		return session.update("mapper.P06_work.updateWorkResult", workDTO);
	}
	
}
